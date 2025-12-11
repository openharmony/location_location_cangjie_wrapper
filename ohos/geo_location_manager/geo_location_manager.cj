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

import ohos.business_exception.{ BusinessException, UNIVERSAL_ERROR_MAP }
import ohos.ffi.*
import ohos.labels.APILevel
import ohos.callback_invoke.*
import std.collection.ArrayList
import std.sync.Mutex

let LOCATION_CALLBACKS = ArrayList<(CallbackObject, Int64)>()
let GNSS_STATUS_INFO_CALLBACKS = ArrayList<(CallbackObject, Int64)>()
let NMEA_CALLBACKS = ArrayList<(CallbackObject, Int64)>()
let ON_OFF_MUTEX = Mutex()

/**
 * Provides interfaces for acquiring location information, managing location switches,
 * geocoding, reverse geocoding, country code, fencing and other functions.
 */
@!APILevel[
    since: "22",
    syscap: "SystemCapability.Location.Location.Core"
]
public class GeoLocationManager {
    /**
      * Obtain current location.
      *
      * @returns { Location } Returns the current location information.
      * @throws { BusinessException } 201 - Permission verification failed. The application does not have the
      * permission required to call the API.
      * @throws { BusinessException } 801 - Capability not supported. Failed to call
      * ${geoLocationManager.getCurrentLocation} due to limited device capabilities.
      * @throws { BusinessException } 3301000 - The location service is unavailable.
      * @throws { BusinessException } 3301100 - The location switch is off.
      * @throws { BusinessException } 3301200 - Failed to obtain the geographical location.
      */
    @!APILevel[
        since: "22",
        permission: "ohos.permission.APPROXIMATELY_LOCATION",
        syscap: "SystemCapability.Location.Location.Core",
        throwexception: true,
        workerthread: true
    ]
    public static func getCurrentLocation(): Location {
        var errCode: Int32 = 0
        let cLocation = unsafe { FfiOHOSGeoLocationManagerGetCurrentLocation(inout errCode) }
        try {
            if (errCode != SUCCESS_CODE) {
                throw BusinessException(getErrorCode(errCode), getErrorMsg(errCode))
            }
            return cLocation.toLocation()
        } finally {
            cLocation.free()
        }
    }

    /**
      * Obtain current location.
      *
      * @param { CurrentLocationRequest } request - Indicates the location request parameters.
      * @returns { Location } Returns the current location information.
      * @throws { BusinessException } 201 - Permission verification failed. The application does not have the
      * permission required to call the API.
      * @throws { BusinessException } 801 - Capability not supported. Failed to call
      * ${geoLocationManager.getCurrentLocation} due to limited device capabilities.
      * @throws { BusinessException } 3301000 - The location service is unavailable.
      * @throws { BusinessException } 3301100 - The location switch is off.
      * @throws { BusinessException } 3301200 - Failed to obtain the geographical location.
      */
    @!APILevel[
        since: "22",
        permission: "ohos.permission.APPROXIMATELY_LOCATION",
        syscap: "SystemCapability.Location.Location.Core",
        throwexception: true,
        workerthread: true
    ]
    public static func getCurrentLocation(request: CurrentLocationRequest): Location {
        var errCode: Int32 = 0
        let cLocation = unsafe {
            FfiOHOSGeoLocationManagerGetCurrentLocationCurrent(CJCurrentLocationRequest(request), inout errCode)
        }
        try {
            if (errCode != SUCCESS_CODE) {
                throw BusinessException(getErrorCode(errCode), getErrorMsg(errCode))
            }
            return cLocation.toLocation()
        } finally {
            cLocation.free()
        }
    }

    /**
      * Obtain current location.
      *
      * @param { SingleLocationRequest } request - Indicates the location request parameters.
      * @returns { Location } Returns the current location information.
      * @throws { BusinessException } 201 - Permission verification failed. The application does not have the
      * permission required to call the API.
      * @throws { BusinessException } 801 - Capability not supported. Failed to call
      * ${geoLocationManager.getCurrentLocation} due to limited device capabilities.
      * @throws { BusinessException } 3301000 - The location service is unavailable.
      * @throws { BusinessException } 3301100 - The location switch is off.
      * @throws { BusinessException } 3301200 - Failed to obtain the geographical location.
      */
    @!APILevel[
        since: "22",
        permission: "ohos.permission.APPROXIMATELY_LOCATION",
        syscap: "SystemCapability.Location.Location.Core",
        throwexception: true,
        workerthread: true
    ]
    public static func getCurrentLocation(request: SingleLocationRequest): Location {
        var errCode: Int32 = 0
        let cLocation = unsafe {
            FfiOHOSGeoLocationManagerGetCurrentLocationSingle(CJSingleLocationRequest(request), inout errCode)
        }
        try {
            if (errCode != SUCCESS_CODE) {
                throw BusinessException(getErrorCode(errCode), getErrorMsg(errCode))
            }
            return cLocation.toLocation()
        } finally {
            cLocation.free()
        }
    }

    /**
      * Obtain current location switch status.
      *
      * @returns { Bool } Returns true if the location switch is on, returns false otherwise.
      * @throws { BusinessException } 801 - Capability not supported. Failed to call
      * ${geoLocationManager.isLocationEnabled} due to limited device capabilities.
      * @throws { BusinessException } 3301000 - The location service is unavailable.
      */
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Location.Location.Core",
        throwexception: true
    ]
    public static func isLocationEnabled(): Bool {
        var errCode: Int32 = 0
        let res = unsafe { FfiOHOSGeoLocationManagerIsLocationEnabled(inout errCode) }
        if (errCode != SUCCESS_CODE) {
            throw BusinessException(getErrorCode(errCode), getErrorMsg(errCode))
        }
        return res
    }

    static func findCallbackObject(list: ArrayList<(CallbackObject, Int64)>, callback: CallbackObject): Bool {
        for (item in list) {
            if (refEq(callback, item[0])) {
                return true
            }
        }
        return false
    }

    /**
     * Subscribe location changed.
     *
     * @param { ContinuousLocationRequest } request - Indicates the location request parameters.
     * @param { Callback1Argument<Location> } callback - Indicates the callback for reporting the location result.
     * @throws { BusinessException } 201 - Permission verification failed. 
     *     The application does not have the permission required to call the API.
     * @throws { BusinessException } 801 - Capability not supported. Failed to call 
     *     ${geoLocationManager.on('locationChange')} due to limited device capabilities.
     * @throws { BusinessException } 3301000 - The location service is unavailable.
     * @throws { BusinessException } 3301100 - The location switch is off.
     */
    @!APILevel[
        since: "24",
        permission: "ohos.permission.APPROXIMATELY_LOCATION",
        syscap: "SystemCapability.Location.Location.Core",
        throwexception: true
    ]
    public static func onLocationChange(request: ContinuousLocationRequest, callback: Callback1Argument<Location>): Unit {
        synchronized(ON_OFF_MUTEX) {
            let callbackList = LOCATION_CALLBACKS
            if (findCallbackObject(callbackList, callback)) {
                GEO_LOCATION_MANAGER_LOG.error("GeoLocationManager On failed: This request already exists")
                return
            }
            unsafe {
                let wrapper = {value: CJLocation => callback.invoke(None, value.toLocationAndFree())}
                let lambdaData = Callback1Param<CJLocation, Unit>(wrapper)
                let errCode = FfiGeoLocationManagerOnContinuousLocationRequest(
                    CJContinuousLocationRequest(request), lambdaData.getID())
                checkRet(errCode)
                callbackList.add((callback, lambdaData.getID()))
            }
        }
    }

    /**
     * Subscribe satellite status changed.
     *
     * @param { Callback1Argument<SatelliteStatusInfo> } callback - Indicates the callback for reporting the satellite status.
     * @throws { BusinessException } 201 - Permission verification failed. The application 
     *     does not have the permission required to call the API.
     * @throws { BusinessException } 801 - Capability not supported. Failed to call 
     *     ${geoLocationManager.on('satelliteStatusChange')} due to limited device capabilities.
     * @throws { BusinessException } 3301000 - The location service is unavailable.
     * @throws { BusinessException } 3301100 - The location switch is off.
     */
    @!APILevel[
        since: "24",
        permission: "ohos.permission.APPROXIMATELY_LOCATION",
        syscap: "SystemCapability.Location.Location.Gnss",
        throwexception: true
    ]
    public static func onSatelliteStatusChange(callback: Callback1Argument<SatelliteStatusInfo>): Unit {
        synchronized(ON_OFF_MUTEX) {
            let callbackList = GNSS_STATUS_INFO_CALLBACKS
            if (findCallbackObject(callbackList, callback)) {
                GEO_LOCATION_MANAGER_LOG.error("GeoLocationManager On failed: This request already exists")
                return
            }
            unsafe {
                let wrapper = {
                    value: CJSatelliteStatusInfo => 
                    callback.invoke(None, value.toSatelliteStatusInfoAndFree())
                }
                let lambdaData = Callback1Param<CJSatelliteStatusInfo, Unit>(wrapper)
                let errCode = FfiGeoLocationManagerOnSatelliteStatusChange(lambdaData.getID())
                checkRet(errCode)
                callbackList.add((callback, lambdaData.getID()))
            }
        }
    }

    /**
     * Unsubscribe satellite status changed.
     *
     * @param { Callback1Argument<SatelliteStatusInfo> } [callback] - Indicates the callback for reporting the satellite status.
     * @throws { BusinessException } 201 - Permission verification failed. The application does not have the permission  required to call the API.
     * @throws { BusinessException } 801 - Capability not supported. Failed to call ${geoLocationManager.off ('satelliteStatusChange')} due to limited device capabilities.
     * @throws { BusinessException } 3301000 - The location service is unavailable.
     * @throws { BusinessException } 3301100 - The location switch is off.
     */
    @!APILevel[
        since: "24",
        permission: "ohos.permission.APPROXIMATELY_LOCATION",
        syscap: "SystemCapability.Location.Location.Gnss"
    ]
    public static func offSatelliteStatusChange(callback!: ?Callback1Argument<SatelliteStatusInfo> = None): Unit {
        synchronized(ON_OFF_MUTEX) {
            if (let Some(v) <- callback) {
                off(GNSS_STATUS_INFO_CALLBACKS, v, FfiGeoLocationManagerOffSatelliteStatusChange)
            } else {
                off(GNSS_STATUS_INFO_CALLBACKS, FfiGeoLocationManagerOffSatelliteStatusChange)
            }
        }
    }

    /**
     * Subscribe nmea message changed.
     *
     * @param { Callback1Argument<String> } callback - Indicates the callback for reporting the nmea message.
     * @throws { BusinessException } 201 - Permission verification failed. The application 
     *     does not have the permission required to call the API.
     * @throws { BusinessException } 801 - Capability not supported. Failed to call 
     *     ${geoLocationManager.on('nmeaMessage')} due to limited device capabilities.
     * @throws { BusinessException } 3301000 - The location service is unavailable.
     * @throws { BusinessException } 3301100 - The location switch is off.
     */
    @!APILevel[
        since: "24",
        permission: "ohos.permission.APPROXIMATELY_LOCATION",
        syscap: "SystemCapability.Location.Location.Gnss"
    ]
    public static func onNmeaMessage(callback: Callback1Argument<String>): Unit {
        synchronized(ON_OFF_MUTEX) {
            let callbackList = NMEA_CALLBACKS
            if (findCallbackObject(callbackList, callback)) {
                GEO_LOCATION_MANAGER_LOG.error("GeoLocationManager On failed: This request already exists")
                return
            }
            unsafe {
                let wrapper = {
                    value: CString => callback.invoke(None, try {
                        value.toString()
                    } finally {
                        LibC.free(value)
                    })
                }
                let lambdaData = Callback1Param<CString, Unit>(wrapper)
                let errCode = FfiGeoLocationManagerOnNmeaMessage(lambdaData.getID())
                if (errCode != SUCCESS_CODE) {
                    throw BusinessException(getErrorCode(errCode), getErrorMsg(errCode))
                }
                callbackList.add((callback, lambdaData.getID()))
            }
        }
    }

    /**
     * Unsubscribe nmea message changed.
     *
     * @param { Callback1Argument<String> } [callback] - Indicates the callback for reporting the nmea message.
     * @throws { BusinessException } 201 - Permission verification failed. The application 
     *     does not have the permission required to call the API.
     * @throws { BusinessException } 801 - Capability not supported. Failed to call 
     *     ${geoLocationManager.off('nmeaMessage')} due to limited device capabilities.
     * @throws { BusinessException } 3301000 - The location service is unavailable.
     * @throws { BusinessException } 3301100 - The location switch is off.
     */
    @!APILevel[
        since: "24",
        permission: "ohos.permission.APPROXIMATELY_LOCATION & ohos.permission.LOCATION",
        syscap: "SystemCapability.Location.Location.Gnss",
        throwexception: true
    ]
    public static func offNmeaMessage(callback!: ?Callback1Argument<String> = None): Unit {
        synchronized(ON_OFF_MUTEX) {
            if (let Some(v) <- callback) {
                off(NMEA_CALLBACKS, v, FfiGeoLocationManagerOffNmeaMessage)
            } else {
                off(NMEA_CALLBACKS, FfiGeoLocationManagerOffNmeaMessage)
            }
        }
    }

    /**
     * Unsubscribe location changed.
     *
     * @param { Callback1Argument<Location> } [callback] - Indicates the callback for reporting the location.
     * @throws { BusinessException } 201 - Permission verification failed. The application 
     *     does not have the permission required to call the API.
     * @throws { BusinessException } 801 - Capability not supported. Failed to call 
     *     ${geoLocationManager.off('location')} due to limited device capabilities.
     * @throws { BusinessException } 3301000 - The location service is unavailable.
     * @throws { BusinessException } 3301100 - The location switch is off.
     */
    @!APILevel[
        since: "24",
        permission: "ohos.permission.APPROXIMATELY_LOCATION & ohos.permission.LOCATION",
        syscap: "SystemCapability.Location.Location.Gnss",
        throwexception: true
    ]
    public static func offLocationChange(callback!: ?Callback1Argument<Location> = None): Unit {
        synchronized(ON_OFF_MUTEX) {
            if (let Some(v) <- callback) {
                off(LOCATION_CALLBACKS, v, FfiGeoLocationManagerOffLocationChange)
            } else {
                off(LOCATION_CALLBACKS, FfiGeoLocationManagerOffLocationChange)
            }
        }
    }

    static func off(callbackList: ArrayList<(CallbackObject, Int64)>, callback: CallbackObject,
        offFunc: CFunc<(Int64) -> Int32>): Unit {
        synchronized(ON_OFF_MUTEX) {
            if (callbackList.size == 0) {
                GEO_LOCATION_MANAGER_LOG.error("GeoLocationManager Off failed: The event is not registered")
                return
            }
            unsafe {
                callbackList.removeIf(
                    {
                        item => if (refEq(item[0], callback)) {
                            let errCode = offFunc(item[1])
                            if (errCode != SUCCESS_CODE) {
                                throw BusinessException(getErrorCode(errCode), getErrorMsg(errCode))
                            }
                            true
                        } else {
                            GEO_LOCATION_MANAGER_LOG.error(
                                "GeoLocationManager Off failed: The callback is not registered")
                            false
                        }
                    })
            }
        }
    }

    static func off(callbackList: ArrayList<(CallbackObject, Int64)>, offFunc: CFunc<(Int64) -> Int32>): Unit {
        synchronized(ON_OFF_MUTEX) {
            if (callbackList.size == 0) {
                GEO_LOCATION_MANAGER_LOG.error("GeoLocationManager Off failed: The event is not registered")
                return
            }
            unsafe {
                callbackList.removeIf(
                    {
                        item =>
                            let errCode = offFunc(item[1])
                            if (errCode != SUCCESS_CODE) {
                                throw BusinessException(getErrorCode(errCode), getErrorMsg(errCode))
                            }
                            true
                    })
            }
        }
    }
}

func checkRet(errCode: Int32): Unit {
    if (errCode != SUCCESS_CODE) {
        throw BusinessException(getErrorCode(errCode), getErrorMsg(errCode))
    }
}