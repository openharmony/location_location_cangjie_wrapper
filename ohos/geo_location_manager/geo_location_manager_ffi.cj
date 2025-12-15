/*
 * Copyright (c) 2025 Huawei Device Co., Ltd.
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

// The Cangjie API is in Beta. For details on its capabilities and limitations, please refer to the README file.

package ohos.geo_location_manager

import std.collection.HashMap
import ohos.ffi.CArrI32

foreign {
    func FfiOHOSGeoLocationManagerGetCurrentLocation(errCode: CPointer<Int32>): CJLocation

    func FfiOHOSGeoLocationManagerGetCurrentLocationCurrent(request: CJCurrentLocationRequest, errCode: CPointer<Int32>): CJLocation

    func FfiOHOSGeoLocationManagerGetCurrentLocationSingle(request: CJSingleLocationRequest, errCode: CPointer<Int32>): CJLocation

    func FfiOHOSGeoLocationManagerIsLocationEnabled(errCode: CPointer<Int32>): Bool

    func FfiGeoLocationManagerOnContinuousLocationRequest(request: CJContinuousLocationRequest, callbackId: Int64): Int32

    func FfiGeoLocationManagerOnSatelliteStatusChange(callbackId: Int64): Int32

    func FfiGeoLocationManagerOffSatelliteStatusChange(callbackId: Int64): Int32

    func FfiGeoLocationManagerOnNmeaMessage(callbackId: Int64): Int32

    func FfiGeoLocationManagerOffNmeaMessage(callbackId: Int64): Int32

    func FfiGeoLocationManagerOffLocationChange(callbackId: Int64): Int32
}

@C
struct CJMapStringString {
    CJMapStringString(
        let keys: CPointer<CString>,
        let values: CPointer<CString>
    ) {}
}

@C
struct CJLocation {
    var latitude: Float64 = 0.0
    var longitude: Float64 = 0.0
    var altitude: Float64 = 0.0
    var accuracy: Float64 = 0.0
    var speed: Float64 = 0.0
    var direction: Float64 = 0.0
    var timeStamp: Int64 = 0
    var timeSinceBoot: Int64 = 0
    var additions: CPointer<CString> = CPointer<CString>()
    var additionSize: Int64 = 0
    var additionsMap: CJMapStringString = CJMapStringString(CPointer<CString>(), CPointer<CString>())
    var altitudeAccuracy: Float64 = 0.0
    var speedAccuracy: Float64 = 0.0
    var directionAccuracy: Float64 = 0.0
    var uncertaintyOfTimeSinceBoot: Int64 = 0
    var sourceType: Int32 = 0

    func toLocation(): Location {
        let cjAdditions = if (additions.isNotNull()) {
            unsafe { Array<String>(additionSize, {i => additions.read(i).toString()}) }
        } else {
            Array<String>()
        }
        let cjAdditionsMap = if (additionsMap.keys.isNotNull() && additionsMap.values.isNotNull()) {
            unsafe {
                HashMap<String, String>(additionSize,
                    {i => (additionsMap.keys.read(i).toString(), additionsMap.values.read(i).toString())})
            }
        } else {
            HashMap<String, String>()
        }
        return Location(this, additions: cjAdditions, additionsMap: cjAdditionsMap,
            sourceType: LocationSourceType.parse(sourceType))
    }

    func toLocationAndFree(): Location {
        let location = this.toLocation()
        this.free()
        return location
    }

    func free(): Unit {
        unsafe {
            if (additions.isNotNull()) {
                for (i in 0..additionSize) {
                    LibC.free(additions.read(i))
                }
                LibC.free(additions)
            }
            if (additionsMap.keys.isNotNull()) {
                for (i in 0..additionSize) {
                    LibC.free(additionsMap.keys.read(i))
                }
                LibC.free(additionsMap.keys)
            }
            if (additionsMap.values.isNotNull()) {
                for (i in 0..additionSize) {
                    LibC.free(additionsMap.values.read(i))
                }
                LibC.free(additionsMap.values)
            }
        }
    }
}

@C
struct CJCurrentLocationRequest {
    var priority: Int32
    var scenario: Int32
    var maxAccuracy: Float32
    var timeoutMs: Int32

    init(request: CurrentLocationRequest) {
        this.priority = request.priority.getValue()
        this.scenario = request.scenario.getValue()
        this.maxAccuracy = request.maxAccuracy
        this.timeoutMs = request.timeoutMs
    }
}

@C
struct CJSingleLocationRequest {
    var locatingPriority: Int32
    var locatingTimeoutMs: Int32

    init(request: SingleLocationRequest) {
        this.locatingPriority = request.locatingPriority.getValue()
        this.locatingTimeoutMs = request.locatingTimeoutMs
    }
}

@C
struct CJContinuousLocationRequest {
    var interval: Int32
    var locationScenario: Int32

    init(request: ContinuousLocationRequest) {
        this.interval = request.interval
        this.locationScenario = request.locationScenario
    }
}

@C
struct CArrF64 {
    var head: CPointer<Float64> = CPointer<Float64>()
    var size: Int64 = 0
}

@C
struct CJSatelliteStatusInfo {
    var satellitesNumber: Int32 = 0
    var satelliteIds: CArrI32 = CArrI32(CPointer<Int32>(), 0)
    var carrierToNoiseDensitys: CArrF64 = CArrF64()
    var altitudes: CArrF64 = CArrF64()
    var azimuths: CArrF64 = CArrF64()
    var carrierFrequencies: CArrF64 = CArrF64()
    var satelliteConstellation: CArrI32 = CArrI32(CPointer<Int32>(), 0)
    var satelliteAdditionalInfo: CArrI32 = CArrI32(CPointer<Int32>(), 0)

    func toSatelliteStatusInfo(): SatelliteStatusInfo {
        let cjSatelliteIds = if (satelliteIds.head.isNotNull()) {
            unsafe { Array<Int32>(satelliteIds.size, {i => satelliteIds.head.read(i)}) }
        } else {
            Array<Int32>()
        }
        let cjCarrierToNoiseDensitys = if (carrierToNoiseDensitys.head.isNotNull()) {
            unsafe { Array<Float64>(carrierToNoiseDensitys.size, {i => carrierToNoiseDensitys.head.read(i)}) }
        } else {
            Array<Float64>()
        }
        let cjAltitudes = if (altitudes.head.isNotNull()) {
            unsafe { Array<Float64>(altitudes.size, {i => altitudes.head.read(i)}) }
        } else {
            Array<Float64>()
        }
        let cjAzimuths = if (azimuths.head.isNotNull()) {
            unsafe { Array<Float64>(azimuths.size, {i => azimuths.head.read(i)}) }
        } else {
            Array<Float64>()
        }
        let cjCarrierFrequencies = if (carrierFrequencies.head.isNotNull()) {
            unsafe { Array<Float64>(carrierFrequencies.size, {i => carrierFrequencies.head.read(i)}) }
        } else {
            Array<Float64>()
        }
        let cjSatelliteConstellation = if (satelliteConstellation.head.isNotNull()) {
            unsafe {
                Array<SatelliteConstellationCategory>(satelliteConstellation.size,
                    {i => SatelliteConstellationCategory.parse(satelliteConstellation.head.read(i))})
            }
        } else {
            Array<SatelliteConstellationCategory>()
        }
        let cjSatelliteAdditionalInfo = if (satelliteAdditionalInfo.head.isNotNull()) {
            unsafe { Array<Int32>(satelliteAdditionalInfo.size, {i => satelliteAdditionalInfo.head.read(i)}) }
        } else {
            Array<Int32>()
        }
        return SatelliteStatusInfo(satellitesNumber, cjSatelliteIds, cjCarrierToNoiseDensitys, cjAltitudes, cjAzimuths,
            cjCarrierFrequencies, satelliteConstellation: cjSatelliteConstellation,
            satelliteAdditionalInfo: cjSatelliteAdditionalInfo)
    }

    func toSatelliteStatusInfoAndFree(): SatelliteStatusInfo {
        try {
            let res = this.toSatelliteStatusInfo()
            return res
        } finally {
            this.free()
        }
    }

    func free() {
        unsafe {
            LibC.free<Int32>(satelliteIds.head)
            LibC.free<Float64>(carrierToNoiseDensitys.head)
            LibC.free<Float64>(altitudes.head)
            LibC.free<Float64>(azimuths.head)
            LibC.free<Float64>(carrierFrequencies.head)
            LibC.free<Int32>(satelliteConstellation.head)
            LibC.free<Int32>(satelliteAdditionalInfo.head)
        }
    }
}