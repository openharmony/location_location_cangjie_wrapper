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
import ohos.i18n.System

foreign {
    func FfiOHOSGeoLocationManagerGetCurrentLocation(errCode: CPointer<Int32>): CJLocation

    func FfiOHOSGeoLocationManagerGetCurrentLocationCurrent(request: CJCurrentLocationRequest, errCode: CPointer<Int32>): CJLocation

    func FfiOHOSGeoLocationManagerGetCurrentLocationSingle(request: CJSingleLocationRequest, errCode: CPointer<Int32>): CJLocation

    func FfiOHOSGeoLocationManagerGetLastLocation(errCode: CPointer<Int32>): CJLocation

    func FfiOHOSGeoLocationManagerIsLocationEnabled(errCode: CPointer<Int32>): Bool

    func FfiOHOSGeoLocationManagerIsGeocoderAvailable(errCode: CPointer<Int32>): Bool

    func FfiOHOSGeoLocationManagerSendCommand(command: CJLocationCommand, errCode: CPointer<Int32>): Unit

    func FfiOHOSGeoLocationManagerGetCountryCode(errCode: CPointer<Int32>): CJCountryCode

    func FfiOHOSGeoLocationManagerGetAddressesFromLocation(request: CJReverseGeoCodeRequest,
        errCode: CPointer<Int32>): CJGeoAddressArr

    func FfiOHOSGeoLocationManagerGetAddressesFromLocationName(request: CJGeoCodeRequest,
        errCode: CPointer<Int32>): CJGeoAddressArr

    func FfiOHOSGeoLocationManagerFreeCJGeoAddressArr(geoAddressArr: CJGeoAddressArr): Unit

    func FfiOHOSGeoLocationManagerFreeCJLocation(location: CJLocation): Unit

    func FfiOHOSGeoLocationManagerFreeCJCountryCode(countryCode: CJCountryCode): Unit

    func FfiGeoLocationManagerFreeCArrI32(arr: CArrI32): Unit

    func FfiGeoLocationManagerFreeCArrF64(arr: CArrF64): Unit

    func FfiGeoLocationManagerFreeCJSatelliteStatusInfo(info: CJSatelliteStatusInfo): Unit

    func FfiGeoLocationManagerOnLocationChange(request: CJLocationRequest, callbackId: Int64): Int32

    func FfiGeoLocationManagerOnContinuousLocationRequest(request: CJContinuousLocationRequest,
        callbackId: Int64): Int32

    func FfiGeoLocationManagerOffLocationChange(callbackId: Int64): Int32

    func FfiGeoLocationManagerOffLocationChangeAll(): Int32

    func FfiGeoLocationManagerOnLocationError(callbackId: Int64): Int32

    func FfiGeoLocationManagerOffLocationError(callbackId: Int64): Int32

    func FfiGeoLocationManagerOffLocationErrorAll(): Int32

    func FfiGeoLocationManagerOnLocationEnabledChange(callbackId: Int64): Int32

    func FfiGeoLocationManagerOffLocationEnabledChange(callbackId: Int64): Int32

    func FfiGeoLocationManagerOffLocationEnabledChangeAll(): Int32

    func FfiGeoLocationManagerOnCountryCodeChange(callbackId: Int64): Int32

    func FfiGeoLocationManagerOffCountryCodeChange(callbackId: Int64): Int32

    func FfiGeoLocationManagerOffCountryCodeChangeAll(): Int32

    func FfiGeoLocationManagerOnSatelliteStatusChange(callbackId: Int64): Int32

    func FfiGeoLocationManagerOffSatelliteStatusChange(callbackId: Int64): Int32

    func FfiGeoLocationManagerOffSatelliteStatusChangeAll(): Int32

    func FfiGeoLocationManagerOnNmeaMessage(callbackId: Int64): Int32

    func FfiGeoLocationManagerOffNmeaMessage(callbackId: Int64): Int32

    func FfiGeoLocationManagerOffNmeaMessageAll(): Int32

    func FfiGeoLocationManagerGetGeofenceSupportedCoordTypes(errCode: CPointer<Int32>): CArrI32

    func FfiOHOSGeoLocationManagerFreeGeofenceSupportedCoordTypes(arr: CArrI32): Unit

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
        try {
            return this.toLocation()
        } finally {
            this.free()
        }
    }

    func free(): Unit {
        unsafe { FfiOHOSGeoLocationManagerFreeCJLocation(this) }
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
struct CJLocationCommand {
    var scenario: Int32
    var command: CString = CString(CPointer<UInt8>())

    init(command: LocationCommand) {
        this.scenario = command.scenario.getValue()
        this.command = unsafe { LibC.mallocCString(command.command) }
    }

    func free(): Unit {
        unsafe { LibC.free(command) }
    }
}

@C
struct CJCountryCode {
    var country: CString = CString(CPointer<UInt8>())
    var `type`: Int32 = 0

    func toCountryCode(): CountryCode {
        return CountryCode(country.toString(), CountryCodeType.parse(`type`))
    }

    func toCountryCodeAndFree(): CountryCode {
        try {
            return this.toCountryCode()
        } finally {
            this.free()
        }
    }

    func free(): Unit {
        unsafe { FfiOHOSGeoLocationManagerFreeCJCountryCode(this) }
    }
}

@C
struct CJReverseGeoCodeRequest {
    var locale: CString = CString(CPointer<UInt8>())
    var country: CString = CString(CPointer<UInt8>())
    var latitude: Float64 = 0.0
    var longitude: Float64 = 0.0
    var maxItems: Int32 = 1

    init(request: ReverseGeoCodeRequest) {
        try {
            locale = unsafe { LibC.mallocCString(request.locale ?? System.getSystemLanguage()) }
            country = unsafe { LibC.mallocCString(request.country ?? System.getSystemRegion()) }
        } catch (e: Exception) {
            unsafe { LibC.free(locale) }
            unsafe { LibC.free(country) }
            throw e
        }
        latitude = request.latitude
        longitude = request.longitude
        maxItems = request.maxItems ?? 1
    }

    func free(): Unit {
        unsafe { LibC.free(locale) }
        unsafe { LibC.free(country) }
    }
}

@C
struct CJGeoCodeRequest {
    var locale: CString = CString(CPointer<UInt8>())
    var country: CString = CString(CPointer<UInt8>())
    var description: CString = CString(CPointer<UInt8>())
    var maxItems: Int32 = 1
    var minLatitude: Float64 = -90.0
    var minLongitude: Float64 = -180.0
    var maxLatitude: Float64 = 90.0
    var maxLongitude: Float64 = 180.0

    init(request: GeoCodeRequest) {
        try {
            locale = unsafe { LibC.mallocCString(request.locale ?? System.getSystemLanguage()) }
            country = unsafe { LibC.mallocCString(request.country ?? System.getSystemRegion()) }
            description = unsafe { LibC.mallocCString(request.description) }
        } catch (e: Exception) {
            unsafe { LibC.free(locale) }
            unsafe { LibC.free(country) }
            unsafe { LibC.free(description) }
            throw e
        }
        maxItems = request.maxItems ?? 1
        minLatitude = request.minLatitude ?? -90.0
        minLongitude = request.minLongitude ?? -180.0
        maxLatitude = request.maxLatitude ?? 90.0
        maxLongitude = request.maxLongitude ?? 180.0
    }

    func free(): Unit {
        unsafe { LibC.free(locale) }
        unsafe { LibC.free(country) }
        unsafe { LibC.free(description) }
    }
}

func cStringToOption(value: CString): ?String {
    if (!value.isNull()) {
        return Some(value.toString())
    }
    return None
}

@C
struct CJGeoAddress {
    var latitude: Float64 = 0.0
    var longitude: Float64 = 0.0
    var locale: CString = CString(CPointer<UInt8>())
    var placeName: CString = CString(CPointer<UInt8>())
    var countryCode: CString = CString(CPointer<UInt8>())
    var countryName: CString = CString(CPointer<UInt8>())
    var administrativeArea: CString = CString(CPointer<UInt8>())
    var subAdministrativeArea: CString = CString(CPointer<UInt8>())
    var locality: CString = CString(CPointer<UInt8>())
    var subLocality: CString = CString(CPointer<UInt8>())
    var roadName: CString = CString(CPointer<UInt8>())
    var subRoadName: CString = CString(CPointer<UInt8>())
    var premises: CString = CString(CPointer<UInt8>())
    var postalCode: CString = CString(CPointer<UInt8>())
    var phoneNumber: CString = CString(CPointer<UInt8>())
    var addressUrl: CString = CString(CPointer<UInt8>())
    var descriptions: CPointer<CString> = CPointer<CString>()
    var descriptionsSize: Int32 = 0

    func toGeoAddress(): GeoAddress {
        var descriptionsArr: ?Array<String> = None
        if (descriptions.isNotNull()) {
            descriptionsArr = Some(unsafe {
                Array<String>(Int64(descriptionsSize), {i => descriptions.read(i).toString()})
            })
        }
        let descriptionsSizeOpt: ?Int32 = if (descriptions.isNotNull()) {
            Some(descriptionsSize)
        } else {
            None
        }
        return GeoAddress(Some(latitude), Some(longitude), cStringToOption(locale), cStringToOption(placeName),
            cStringToOption(countryCode), cStringToOption(countryName), cStringToOption(administrativeArea),
            cStringToOption(subAdministrativeArea), cStringToOption(locality), cStringToOption(subLocality),
            cStringToOption(roadName), cStringToOption(subRoadName), cStringToOption(premises),
            cStringToOption(postalCode), cStringToOption(phoneNumber), cStringToOption(addressUrl), descriptionsArr,
            descriptionsSizeOpt)
    }
}

@C
struct CJGeoAddressArr {
    var head: CPointer<CJGeoAddress> = CPointer<CJGeoAddress>()
    var size: Int64 = 0

    func toArray(): Array<GeoAddress> {
        if (head.isNull()) {
            return Array<GeoAddress>()
        }
        return unsafe { Array<GeoAddress>(size, {i => head.read(i).toGeoAddress()}) }
    }

    func free(): Unit {
        unsafe { FfiOHOSGeoLocationManagerFreeCJGeoAddressArr(this) }
    }
}

@C
struct CJLocationRequest {
    var priority: Int32 = 0x203
    var scenario: Int32 = 0x300
    var timeInterval: Int32 = 1
    var distanceInterval: Float64 = 0.0
    var maxAccuracy: Float32 = 0.0

    init(request: LocationRequest) {
        this.priority = (request.priority ?? LocationRequestPriority.FirstFix).getValue()
        this.scenario = (request.scenario ?? LocationRequestScenario.Unset).getValue()
        this.timeInterval = request.timeInterval ?? 1
        this.distanceInterval = request.distanceInterval ?? 0.0
        this.maxAccuracy = request.maxAccuracy ?? 0.0
    }
}

@C
struct CJContinuousLocationRequest {
    var interval: Int32
    var locationScenario: Int32

    init(request: ContinuousLocationRequest) {
        this.interval = request.interval
        this.locationScenario = request.locationScenario.getValue()
    }
}

@C
struct CArrI32 {
    var head: CPointer<Int32> = CPointer<Int32>()
    var size: Int64 = 0

    func toArray(): Array<Int32> {
        if (head.isNotNull()) {
            unsafe { Array<Int32>(size, {i => head.read(i)}) }
        } else {
            Array<Int32>()
        }
    }

    func toOptionalArray(): ?Array<Int32> {
        if (head.isNotNull()) {
            Some(unsafe { Array<Int32>(size, {i => head.read(i)}) })
        } else {
            Option<Array<Int32>>.None
        }
    }

    func free(): Unit {
        unsafe { FfiGeoLocationManagerFreeCArrI32(this) }
    }
}

@C
struct CArrF64 {
    var head: CPointer<Float64> = CPointer<Float64>()
    var size: Int64 = 0

    func toArray(): Array<Float64> {
        if (head.isNotNull()) {
            unsafe { Array<Float64>(size, {i => head.read(i)}) }
        } else {
            Array<Float64>()
        }
    }

    func free(): Unit {
        unsafe { FfiGeoLocationManagerFreeCArrF64(this) }
    }
}

@C
struct CJSatelliteStatusInfo {
    var satellitesNumber: Int32 = 0
    var satelliteIds: CArrI32 = CArrI32()
    var carrierToNoiseDensitys: CArrF64 = CArrF64()
    var altitudes: CArrF64 = CArrF64()
    var azimuths: CArrF64 = CArrF64()
    var carrierFrequencies: CArrF64 = CArrF64()
    var constellationTypes: CArrI32 = CArrI32()
    var additionalInfoList: CArrI32 = CArrI32()

    func toSatelliteStatusInfo(): SatelliteStatusInfo {
        let satelliteConstellation: ?Array<SatelliteConstellationCategory> =
            if (constellationTypes.head.isNotNull()) {
                Some(unsafe {
                    Array<SatelliteConstellationCategory>(constellationTypes.size,
                        {i => SatelliteConstellationCategory.parse(constellationTypes.head.read(i))})
                })
            } else {
                Option<Array<SatelliteConstellationCategory>>.None
            }
        return SatelliteStatusInfo(satellitesNumber, satelliteIds.toArray(), carrierToNoiseDensitys.toArray(),
            altitudes.toArray(), azimuths.toArray(), carrierFrequencies.toArray(), satelliteConstellation,
            additionalInfoList.toOptionalArray())
    }

    func toSatelliteStatusInfoAndFree(): SatelliteStatusInfo {
        try {
            return this.toSatelliteStatusInfo()
        } finally {
            this.free()
        }
    }

    func free(): Unit {
        unsafe { FfiGeoLocationManagerFreeCJSatelliteStatusInfo(this) }
    }
}
