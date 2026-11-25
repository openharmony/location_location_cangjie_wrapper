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

import ohos.business_exception.{BusinessException, AsyncCallback}
import ohos.callback_invoke.{CallbackObject, Callback1Argument}
import ohos.ffi.{Callback1Param, SUCCESS_CODE}
import ohos.labels.{APILevel, PermissionValue}
import std.collection.ArrayList
import std.sync.Mutex

/**
 * Provides interfaces for acquiring location information, managing location switches,
 * geocoding, reverse geocoding, country code, fencing and other functions.
 */
@!APILevel[
    since: "22",
    syscap: "SystemCapability.Location.Location.Core"
]
public class GeoLocationManager {
    init() {}
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
}

let LOCATION_CALLBACKS = ArrayList<(CallbackObject, Int64)>()
let LOCATION_ERROR_CALLBACKS = ArrayList<(CallbackObject, Int64)>()
let LOCATION_ENABLED_CALLBACKS = ArrayList<(CallbackObject, Int64)>()
let SATELLITE_STATUS_CALLBACKS = ArrayList<(CallbackObject, Int64)>()
let NMEA_MESSAGE_CALLBACKS = ArrayList<(CallbackObject, Int64)>()
let COUNTRY_CODE_CALLBACKS = ArrayList<(CallbackObject, Int64)>()
let ON_OFF_MUTEX = Mutex()

const MIN_LATITUDE: Float64 = -90.0
const MAX_LATITUDE: Float64 = 90.0
const MIN_LONGITUDE: Float64 = -180.0
const MAX_LONGITUDE: Float64 = 180.0

func isValidLatitude(latitude: Float64): Bool {
    return !(latitude < MIN_LATITUDE || latitude > MAX_LATITUDE)
}

func isValidLongitude(longitude: Float64): Bool {
    return !(longitude < MIN_LONGITUDE || longitude > MAX_LONGITUDE)
}

func checkReverseGeoCodeRequest(request: ReverseGeoCodeRequest): Unit {
    if (!isValidLatitude(request.latitude) || !isValidLongitude(request.longitude)) {
        throw BusinessException(401, getErrorMsg(401))
    }
}

func checkGeoCodeRequest(request: GeoCodeRequest): Unit {
    if (request.description == "") {
        throw BusinessException(401, getErrorMsg(401))
    }
    if (!isValidLatitude(request.minLatitude ?? MIN_LATITUDE) ||
        !isValidLongitude(request.minLongitude ?? MIN_LONGITUDE) ||
        !isValidLatitude(request.maxLatitude ?? MAX_LATITUDE) ||
        !isValidLongitude(request.maxLongitude ?? MAX_LONGITUDE)) {
        throw BusinessException(401, getErrorMsg(401))
    }
}

func checkRet(errCode: Int32): Unit {
    if (errCode != SUCCESS_CODE) {
        throw BusinessException(getErrorCode(errCode), getErrorMsg(errCode))
    }
}

func findCallbackObject(callbackList: ArrayList<(CallbackObject, Int64)>, callback: CallbackObject): Bool {
    for (item in callbackList) {
        if (refEq(item[0], callback)) {
            return true
        }
    }
    return false
}

func off(callbackList: ArrayList<(CallbackObject, Int64)>, callback: CallbackObject,
    offFunc: CFunc<(Int64) -> Int32>): Unit {
    synchronized(ON_OFF_MUTEX) {
        if (callbackList.size == 0) {
            GEO_LOCATION_MANAGER_LOG.error("GeoLocationManager Off failed: The event is not registered")
            return
        }
        for (idx in 0..callbackList.size) {
            if (refEq(callbackList[idx][0], callback)) {
                unsafe { checkRet(offFunc(callbackList[idx][1])) }
                callbackList.remove(at: idx)
                return
            }
        }
        GEO_LOCATION_MANAGER_LOG.error("GeoLocationManager Off failed: The callback is not registered")
    }
}

func offAll(callbackList: ArrayList<(CallbackObject, Int64)>, offAllFunc: CFunc<() -> Int32>): Unit {
    synchronized(ON_OFF_MUTEX) {
        if (callbackList.size == 0) {
            GEO_LOCATION_MANAGER_LOG.error("GeoLocationManager Off failed: The event is not registered")
            return
        }
        unsafe { checkRet(offAllFunc()) }
        callbackList.clear()
    }
}

/**
 * Subscribe location changed.
 *
 * @param { LocationRequest } request - Indicates the location request parameters.
 * @param { Callback1Argument<Location> } callback - Indicates the callback for reporting the location result.
 * @throws { BusinessException } 201 - Permission verification failed. The application does not have the
 *     permission required to call the API.
 * @throws { BusinessException } 801 - Capability not supported. Failed to call
 *     ${geoLocationManager.onLocationChange} due to limited device capabilities.
 * @throws { BusinessException } 3301000 - The location service is unavailable.
 * @throws { BusinessException } 3301100 - The location switch is off.
 */
@!APILevel[
    since: "26.1.0",
    permission: "ohos.permission.APPROXIMATELY_LOCATION",
    syscap: "SystemCapability.Location.Location.Core",
    throwexception: true
]
public func onLocationChange(request: LocationRequest, callback: Callback1Argument<Location>): Unit {
    synchronized(ON_OFF_MUTEX) {
        if (findCallbackObject(LOCATION_CALLBACKS, callback)) {
            GEO_LOCATION_MANAGER_LOG.error("GeoLocationManager On failed: This request already exists")
            return
        }
        unsafe {
            let wrapper = {value: CJLocation => callback.invoke(None, value.toLocationAndFree())}
            let lambdaData = Callback1Param<CJLocation, Unit>.create(wrapper)
            let errCode = FfiGeoLocationManagerOnLocationChange(CJLocationRequest(request), lambdaData.getID())
            if (errCode != SUCCESS_CODE) {
                lambdaData.destroySelf()
                checkRet(errCode)
            }
            LOCATION_CALLBACKS.add((callback, lambdaData.getID()))
        }
    }
}

/**
 * Subscribe location changed.
 *
 * @param { ContinuousLocationRequest } request - Indicates the location request parameters.
 * @param { Callback1Argument<Location> } callback - Indicates the callback for reporting the location result.
 * @throws { BusinessException } 201 - Permission verification failed. The application does not have the
 *     permission required to call the API.
 * @throws { BusinessException } 801 - Capability not supported. Failed to call
 *     ${geoLocationManager.onLocationChange} due to limited device capabilities.
 * @throws { BusinessException } 3301000 - The location service is unavailable.
 * @throws { BusinessException } 3301100 - The location switch is off.
 */
@!APILevel[
    since: "26.1.0",
    permission: "ohos.permission.APPROXIMATELY_LOCATION",
    syscap: "SystemCapability.Location.Location.Core",
    throwexception: true
]
public func onLocationChange(request: ContinuousLocationRequest, callback: Callback1Argument<Location>): Unit {
    synchronized(ON_OFF_MUTEX) {
        if (findCallbackObject(LOCATION_CALLBACKS, callback)) {
            GEO_LOCATION_MANAGER_LOG.error("GeoLocationManager On failed: This request already exists")
            return
        }
        unsafe {
            let wrapper = {value: CJLocation => callback.invoke(None, value.toLocationAndFree())}
            let lambdaData = Callback1Param<CJLocation, Unit>.create(wrapper)
            let errCode = FfiGeoLocationManagerOnContinuousLocationRequest(CJContinuousLocationRequest(request),
                lambdaData.getID())
            if (errCode != SUCCESS_CODE) {
                lambdaData.destroySelf()
                checkRet(errCode)
            }
            LOCATION_CALLBACKS.add((callback, lambdaData.getID()))
        }
    }
}

/**
 * Unsubscribe location changed.
 *
 * @param { ?Callback1Argument<Location> } [callback] - Indicates the callback for reporting the location result.
 * @throws { BusinessException } 801 - Capability not supported. Failed to call
 *     ${geoLocationManager.offLocationChange} due to limited device capabilities.
 * @throws { BusinessException } 3301000 - The location service is unavailable.
 */
@!APILevel[
    since: "26.1.0",
    syscap: "SystemCapability.Location.Location.Core",
    throwexception: true
]
public func offLocationChange(callback!: ?Callback1Argument<Location> = None): Unit {
    match (callback) {
        case Some(value) => off(LOCATION_CALLBACKS, value, FfiGeoLocationManagerOffLocationChange)
        case None => offAll(LOCATION_CALLBACKS, FfiGeoLocationManagerOffLocationChangeAll)
    }
}

/**
 * Subscribe continuous location error changed.
 *
 * @param { Callback1Argument<LocationError> } callback - Indicates the callback for reporting the continuous location error.
 * @throws { BusinessException } 201 - Permission verification failed. The application does not have the
 *     permission required to call the API.
 * @throws { BusinessException } 801 - Capability not supported. Failed to call
 *     ${geoLocationManager.onLocationError} due to limited device capabilities.
 * @throws { BusinessException } 3301000 - The location service is unavailable.
 */
@!APILevel[
    since: "26.1.0",
    permission: "ohos.permission.APPROXIMATELY_LOCATION",
    syscap: "SystemCapability.Location.Location.Core",
    throwexception: true
]
public func onLocationError(callback: Callback1Argument<LocationError>): Unit {
    synchronized(ON_OFF_MUTEX) {
        if (findCallbackObject(LOCATION_ERROR_CALLBACKS, callback)) {
            GEO_LOCATION_MANAGER_LOG.error("GeoLocationManager On failed: This request already exists")
            return
        }
        unsafe {
            let wrapper = {value: Int32 => callback.invoke(None, LocationError.parse(value))}
            let lambdaData = Callback1Param<Int32, Unit>.create(wrapper)
            let errCode = FfiGeoLocationManagerOnLocationError(lambdaData.getID())
            if (errCode != SUCCESS_CODE) {
                lambdaData.destroySelf()
                checkRet(errCode)
            }
            LOCATION_ERROR_CALLBACKS.add((callback, lambdaData.getID()))
        }
    }
}

/**
 * Unsubscribe continuous location error changed.
 *
 * @param { ?Callback1Argument<LocationError> } [callback] - Indicates the callback for reporting the
 *     continuous location error.
 * @throws { BusinessException } 201 - Permission verification failed. The application does not have the
 *     permission required to call the API.
 * @throws { BusinessException } 801 - Capability not supported. Failed to call
 *     ${geoLocationManager.offLocationError} due to limited device capabilities.
 * @throws { BusinessException } 3301000 - The location service is unavailable.
 */
@!APILevel[
    since: "26.1.0",
    permission: "ohos.permission.APPROXIMATELY_LOCATION",
    syscap: "SystemCapability.Location.Location.Core",
    throwexception: true
]
public func offLocationError(callback!: ?Callback1Argument<LocationError> = None): Unit {
    match (callback) {
        case Some(value) => off(LOCATION_ERROR_CALLBACKS, value, FfiGeoLocationManagerOffLocationError)
        case None => offAll(LOCATION_ERROR_CALLBACKS, FfiGeoLocationManagerOffLocationErrorAll)
    }
}

/**
 * Subscribe location switch changed.
 *
 * @param { Callback1Argument<Bool> } callback - Indicates the callback for reporting the location switch status.
 * @throws { BusinessException } 801 - Capability not supported. Failed to call
 *     ${geoLocationManager.onLocationEnabledChange} due to limited device capabilities.
 * @throws { BusinessException } 3301000 - The location service is unavailable.
 */
@!APILevel[
    since: "26.1.0",
    syscap: "SystemCapability.Location.Location.Core",
    throwexception: true
]
public func onLocationEnabledChange(callback: Callback1Argument<Bool>): Unit {
    synchronized(ON_OFF_MUTEX) {
        if (findCallbackObject(LOCATION_ENABLED_CALLBACKS, callback)) {
            GEO_LOCATION_MANAGER_LOG.error("GeoLocationManager On failed: This request already exists")
            return
        }
        unsafe {
            let wrapper = {value: Bool => callback.invoke(None, value)}
            let lambdaData = Callback1Param<Bool, Unit>.create(wrapper)
            let errCode = FfiGeoLocationManagerOnLocationEnabledChange(lambdaData.getID())
            if (errCode != SUCCESS_CODE) {
                lambdaData.destroySelf()
                checkRet(errCode)
            }
            LOCATION_ENABLED_CALLBACKS.add((callback, lambdaData.getID()))
        }
    }
}

/**
 * Unsubscribe location switch changed.
 *
 * @param { ?Callback1Argument<Bool> } [callback] - Indicates the callback for reporting the location switch status.
 * @throws { BusinessException } 801 - Capability not supported. Failed to call
 *     ${geoLocationManager.offLocationEnabledChange} due to limited device capabilities.
 * @throws { BusinessException } 3301000 - The location service is unavailable.
 */
@!APILevel[
    since: "26.1.0",
    syscap: "SystemCapability.Location.Location.Core",
    throwexception: true
]
public func offLocationEnabledChange(callback!: ?Callback1Argument<Bool> = None): Unit {
    match (callback) {
        case Some(value) => off(LOCATION_ENABLED_CALLBACKS, value, FfiGeoLocationManagerOffLocationEnabledChange)
        case None => offAll(LOCATION_ENABLED_CALLBACKS, FfiGeoLocationManagerOffLocationEnabledChangeAll)
    }
}

/**
 * Subscribe satellite status changed.
 *
 * @param { Callback1Argument<SatelliteStatusInfo> } callback - Indicates the callback for reporting the satellite status.
 * @throws { BusinessException } 201 - Permission verification failed. The application does not have the
 *     permission required to call the API.
 * @throws { BusinessException } 801 - Capability not supported. Failed to call
 *     ${geoLocationManager.onSatelliteStatusChange} due to limited device capabilities.
 * @throws { BusinessException } 3301000 - The location service is unavailable.
 * @throws { BusinessException } 3301100 - The location switch is off.
 */
@!APILevel[
    since: "26.1.0",
    permission: "ohos.permission.APPROXIMATELY_LOCATION",
    syscap: "SystemCapability.Location.Location.Gnss",
    throwexception: true
]
public func onSatelliteStatusChange(callback: Callback1Argument<SatelliteStatusInfo>): Unit {
    synchronized(ON_OFF_MUTEX) {
        if (findCallbackObject(SATELLITE_STATUS_CALLBACKS, callback)) {
            GEO_LOCATION_MANAGER_LOG.error("GeoLocationManager On failed: This request already exists")
            return
        }
        unsafe {
            let wrapper = {
                value: CJSatelliteStatusInfo => callback.invoke(None, value.toSatelliteStatusInfoAndFree())
            }
            let lambdaData = Callback1Param<CJSatelliteStatusInfo, Unit>.create(wrapper)
            let errCode = FfiGeoLocationManagerOnSatelliteStatusChange(lambdaData.getID())
            if (errCode != SUCCESS_CODE) {
                lambdaData.destroySelf()
                checkRet(errCode)
            }
            SATELLITE_STATUS_CALLBACKS.add((callback, lambdaData.getID()))
        }
    }
}

/**
 * Unsubscribe satellite status changed.
 *
 * @param { ?Callback1Argument<SatelliteStatusInfo> } [callback] - Indicates the callback for reporting the satellite status.
 * @throws { BusinessException } 201 - Permission verification failed. The application does not have the
 *     permission required to call the API.
 * @throws { BusinessException } 801 - Capability not supported. Failed to call
 *     ${geoLocationManager.offSatelliteStatusChange} due to limited device capabilities.
 * @throws { BusinessException } 3301000 - The location service is unavailable.
 * @throws { BusinessException } 3301100 - The location switch is off.
 */
@!APILevel[
    since: "26.1.0",
    permission: "ohos.permission.APPROXIMATELY_LOCATION",
    syscap: "SystemCapability.Location.Location.Gnss",
    throwexception: true
]
public func offSatelliteStatusChange(callback!: ?Callback1Argument<SatelliteStatusInfo> = None): Unit {
    match (callback) {
        case Some(value) => off(SATELLITE_STATUS_CALLBACKS, value, FfiGeoLocationManagerOffSatelliteStatusChange)
        case None => offAll(SATELLITE_STATUS_CALLBACKS, FfiGeoLocationManagerOffSatelliteStatusChangeAll)
    }
}

/**
 * Subscribe nmea message changed.
 *
 * @param { Callback1Argument<String> } callback - Indicates the callback for reporting the nmea message.
 * @throws { BusinessException } 201 - Permission verification failed. The application does not have the
 *     permission required to call the API.
 * @throws { BusinessException } 801 - Capability not supported. Failed to call
 *     ${geoLocationManager.onNmeaMessage} due to limited device capabilities.
 * @throws { BusinessException } 3301000 - The location service is unavailable.
 * @throws { BusinessException } 3301100 - The location switch is off.
 */
@!APILevel[
    since: "26.1.0",
    permission: "ohos.permission.LOCATION" & "ohos.permission.APPROXIMATELY_LOCATION",
    syscap: "SystemCapability.Location.Location.Gnss",
    throwexception: true
]
public func onNmeaMessage(callback: Callback1Argument<String>): Unit {
    synchronized(ON_OFF_MUTEX) {
        if (findCallbackObject(NMEA_MESSAGE_CALLBACKS, callback)) {
            GEO_LOCATION_MANAGER_LOG.error("GeoLocationManager On failed: This request already exists")
            return
        }
        unsafe {
            let wrapper = {
                value: CString =>
                    let message = try {
                        value.toString()
                    } finally {
                        LibC.free(value)
                    }
                    callback.invoke(None, message)
            }
            let lambdaData = Callback1Param<CString, Unit>.create(wrapper)
            let errCode = FfiGeoLocationManagerOnNmeaMessage(lambdaData.getID())
            if (errCode != SUCCESS_CODE) {
                lambdaData.destroySelf()
                checkRet(errCode)
            }
            NMEA_MESSAGE_CALLBACKS.add((callback, lambdaData.getID()))
        }
    }
}

/**
 * Unsubscribe nmea message changed.
 *
 * @param { ?Callback1Argument<String> } [callback] - Indicates the callback for reporting the nmea message.
 * @throws { BusinessException } 201 - Permission verification failed. The application does not have the
 *     permission required to call the API.
 * @throws { BusinessException } 801 - Capability not supported. Failed to call
 *     ${geoLocationManager.offNmeaMessage} due to limited device capabilities.
 * @throws { BusinessException } 3301000 - The location service is unavailable.
 * @throws { BusinessException } 3301100 - The location switch is off.
 */
@!APILevel[
    since: "26.1.0",
    permission: "ohos.permission.LOCATION" & "ohos.permission.APPROXIMATELY_LOCATION",
    syscap: "SystemCapability.Location.Location.Gnss",
    throwexception: true
]
public func offNmeaMessage(callback!: ?Callback1Argument<String> = None): Unit {
    match (callback) {
        case Some(value) => off(NMEA_MESSAGE_CALLBACKS, value, FfiGeoLocationManagerOffNmeaMessage)
        case None => offAll(NMEA_MESSAGE_CALLBACKS, FfiGeoLocationManagerOffNmeaMessageAll)
    }
}

/**
 * Registering the callback function for listening to country code changes.
 *
 * @param { Callback1Argument<CountryCode> } callback - Indicates the callback for reporting country code changes.
 * @throws { BusinessException } 801 - Capability not supported. Failed to call
 *     ${geoLocationManager.onCountryCodeChange} due to limited device capabilities.
 * @throws { BusinessException } 3301000 - The location service is unavailable.
 * @throws { BusinessException } 3301500 - Failed to query the area information.
 */
@!APILevel[
    since: "26.1.0",
    syscap: "SystemCapability.Location.Location.Core",
    throwexception: true
]
public func onCountryCodeChange(callback: Callback1Argument<CountryCode>): Unit {
    synchronized(ON_OFF_MUTEX) {
        if (findCallbackObject(COUNTRY_CODE_CALLBACKS, callback)) {
            GEO_LOCATION_MANAGER_LOG.error("GeoLocationManager On failed: This request already exists")
            return
        }
        unsafe {
            let wrapper = {value: CJCountryCode => callback.invoke(None, value.toCountryCodeAndFree())}
            let lambdaData = Callback1Param<CJCountryCode, Unit>.create(wrapper)
            let errCode = FfiGeoLocationManagerOnCountryCodeChange(lambdaData.getID())
            if (errCode != SUCCESS_CODE) {
                lambdaData.destroySelf()
                checkRet(errCode)
            }
            COUNTRY_CODE_CALLBACKS.add((callback, lambdaData.getID()))
        }
    }
}

/**
 * Unregistering the callback function for listening to country code changes.
 *
 * @param { ?Callback1Argument<CountryCode> } [callback] - Indicates the callback for reporting country code changes.
 * @throws { BusinessException } 801 - Capability not supported. Failed to call
 *     ${geoLocationManager.offCountryCodeChange} due to limited device capabilities.
 * @throws { BusinessException } 3301000 - The location service is unavailable.
 * @throws { BusinessException } 3301500 - Failed to query the area information.
 */
@!APILevel[
    since: "26.1.0",
    syscap: "SystemCapability.Location.Location.Core",
    throwexception: true
]
public func offCountryCodeChange(callback!: ?Callback1Argument<CountryCode> = None): Unit {
    match (callback) {
        case Some(value) => off(COUNTRY_CODE_CALLBACKS, value, FfiGeoLocationManagerOffCountryCodeChange)
        case None => offAll(COUNTRY_CODE_CALLBACKS, FfiGeoLocationManagerOffCountryCodeChangeAll)
    }
}

/**
 * Obtain last known location.
 *
 * @returns { Location } The last known location information.
 * @throws { BusinessException } 201 - Permission verification failed. The application does not have the
 *     permission required to call the API.
 * @throws { BusinessException } 801 - Capability not supported. Failed to call
 *     ${geoLocationManager.getLastLocation} due to limited device capabilities.
 * @throws { BusinessException } 3301000 - The location service is unavailable.
 * @throws { BusinessException } 3301100 - The location switch is off.
 * @throws { BusinessException } 3301200 - Failed to obtain the geographical location.
 */
@!APILevel[
    since: "26.1.0",
    permission: "ohos.permission.APPROXIMATELY_LOCATION",
    syscap: "SystemCapability.Location.Location.Core",
    throwexception: true
]
public func getLastLocation(): Location {
    var errCode: Int32 = 0
    let cLocation = unsafe { FfiOHOSGeoLocationManagerGetLastLocation(inout errCode) }
    if (errCode != SUCCESS_CODE) {
        throw BusinessException(getErrorCode(errCode), getErrorMsg(errCode))
    }
    return cLocation.toLocationAndFree()
}

/**
 * Obtain address info from location.
 *
 * @param { ReverseGeoCodeRequest } request - Indicates the reverse geocode query parameters.
 * @param { AsyncCallback<Array<GeoAddress>> } callback - Indicates the callback for reporting the address info.
 * @throws { BusinessException } 801 - Capability not supported. Failed to call
 *     ${geoLocationManager.getAddressesFromLocation} due to limited device capabilities.
 * @throws { BusinessException } 3301000 - The location service is unavailable.
 * @throws { BusinessException } 3301300 - Reverse geocoding query failed.
 */
@!APILevel[
    since: "26.1.0",
    syscap: "SystemCapability.Location.Location.Geocoder",
    throwexception: true
]
public func getAddressesFromLocation(request: ReverseGeoCodeRequest,
    callback: AsyncCallback<Array<GeoAddress>>): Unit {
    checkReverseGeoCodeRequest(request)
    spawn {
        var errCode: Int32 = 0
        let cRequest = CJReverseGeoCodeRequest(request)
        let cGeoAddressArr = unsafe { FfiOHOSGeoLocationManagerGetAddressesFromLocation(cRequest, inout errCode) }
        cRequest.free()
        if (errCode != SUCCESS_CODE) {
            cGeoAddressArr.free()
            callback(Some(BusinessException(getErrorCode(errCode), getErrorMsg(errCode))), None)
            return
        }
        let addresses = cGeoAddressArr.toArray()
        cGeoAddressArr.free()
        callback(None, Some(addresses))
    }
}

/**
 * Obtain latitude and longitude info from location address.
 *
 * @param { GeoCodeRequest } request - Indicates the geocode query parameters.
 * @param { AsyncCallback<Array<GeoAddress>> } callback - Indicates the callback for reporting the
 *     latitude and longitude result.
 * @throws { BusinessException } 801 - Capability not supported. Failed to call
 *     ${geoLocationManager.getAddressesFromLocationName} due to limited device capabilities.
 * @throws { BusinessException } 3301000 - The location service is unavailable.
 * @throws { BusinessException } 3301400 - Geocoding query failed.
 */
@!APILevel[
    since: "26.1.0",
    syscap: "SystemCapability.Location.Location.Geocoder",
    throwexception: true
]
public func getAddressesFromLocationName(request: GeoCodeRequest,
    callback: AsyncCallback<Array<GeoAddress>>): Unit {
    checkGeoCodeRequest(request)
    spawn {
        var errCode: Int32 = 0
        let cRequest = CJGeoCodeRequest(request)
        let cGeoAddressArr = unsafe { FfiOHOSGeoLocationManagerGetAddressesFromLocationName(cRequest, inout errCode) }
        cRequest.free()
        if (errCode != SUCCESS_CODE) {
            cGeoAddressArr.free()
            callback(Some(BusinessException(getErrorCode(errCode), getErrorMsg(errCode))), None)
            return
        }
        let addresses = cGeoAddressArr.toArray()
        cGeoAddressArr.free()
        callback(None, Some(addresses))
    }
}

/**
 * Obtain geocoding service status.
 *
 * @returns { Bool } Returns true if geocoding service is available, returns false otherwise.
 * @throws { BusinessException } 801 - Capability not supported. Failed to call
 *     ${geoLocationManager.isGeocoderAvailable} due to limited device capabilities.
 * @throws { BusinessException } 3301000 - The location service is unavailable.
 */
@!APILevel[
    since: "26.1.0",
    syscap: "SystemCapability.Location.Location.Geocoder",
    throwexception: true
]
public func isGeocoderAvailable(): Bool {
    var errCode: Int32 = 0
    let res = unsafe { FfiOHOSGeoLocationManagerIsGeocoderAvailable(inout errCode) }
    if (errCode != SUCCESS_CODE) {
        throw BusinessException(getErrorCode(errCode), getErrorMsg(errCode))
    }
    return res
}

/**
 * Send extended commands to location subsystem.
 *
 * @param { LocationCommand } command - Indicates the extended command message body.
 * @param { AsyncCallback<Unit> } callback - Indicates the callback for reporting the error message.
 *     If the function fails to execute, the error message will be carried in the first parameter err of
 *     AsyncCallback, If the function executes successfully, execute the callback function only, no data
 *     will be returned.
 * @throws { BusinessException } 801 - Capability not supported. Failed to call
 *     ${geoLocationManager.sendCommand} due to limited device capabilities.
 * @throws { BusinessException } 3301000 - The location service is unavailable.
 */
@!APILevel[
    since: "26.1.0",
    syscap: "SystemCapability.Location.Location.Core",
    throwexception: true
]
public func sendCommand(command: LocationCommand, callback: AsyncCallback<Unit>): Unit {
    spawn {
        var errCode: Int32 = 0
        var cCommand = CJLocationCommand(command)
        unsafe { FfiOHOSGeoLocationManagerSendCommand(cCommand, inout errCode) }
        cCommand.free()
        if (errCode != SUCCESS_CODE) {
            callback(Some(BusinessException(getErrorCode(errCode), getErrorMsg(errCode))), None)
        } else {
            callback(None, Some(()))
        }
    }
}

/**
 * Obtain the current country code.
 *
 * @param { AsyncCallback<CountryCode> } callback - Indicates the callback for reporting the country code.
 * @throws { BusinessException } 801 - Capability not supported. Failed to call
 *     ${geoLocationManager.getCountryCode} due to limited device capabilities.
 * @throws { BusinessException } 3301000 - The location service is unavailable.
 * @throws { BusinessException } 3301500 - Failed to query the area information.
 */
@!APILevel[
    since: "26.1.0",
    syscap: "SystemCapability.Location.Location.Core",
    throwexception: true
]
public func getCountryCode(callback: AsyncCallback<CountryCode>): Unit {
    spawn {
        var errCode: Int32 = 0
        let cCountryCode = unsafe { FfiOHOSGeoLocationManagerGetCountryCode(inout errCode) }
        if (errCode != SUCCESS_CODE) {
            cCountryCode.free()
            callback(Some(BusinessException(getErrorCode(errCode), getErrorMsg(errCode))), None)
            return
        }
        let countryCode = cCountryCode.toCountryCode()
        cCountryCode.free()
        callback(None, Some(countryCode))
    }
}

/**
 * Obtains the coordinate system types supported by geofence.
 *
 * @returns { Array<CoordinateSystemType> } Return the coordinate system types supported by geofence.
 * @throws { BusinessException } 801 - Capability not supported. Failed to call
 *     ${geoLocationManager.getGeofenceSupportedCoordTypes} due to limited device capabilities.
 * @throws { BusinessException } 3301000 - The location service is unavailable.
 */
@!APILevel[
    since: "26.1.0",
    syscap: "SystemCapability.Location.Location.Geofence",
    throwexception: true
]
public func getGeofenceSupportedCoordTypes(): Array<CoordinateSystemType> {
    var errCode: Int32 = 0
    let carr = unsafe { FfiGeoLocationManagerGetGeofenceSupportedCoordTypes(inout errCode) }
    if (errCode != SUCCESS_CODE) {
        unsafe { FfiOHOSGeoLocationManagerFreeGeofenceSupportedCoordTypes(carr) }
        throw BusinessException(getErrorCode(errCode), getErrorMsg(errCode))
    }
    let head = carr.head
    if (head.isNull()) {
        return Array<CoordinateSystemType>()
    }
    let res = unsafe {
        Array<CoordinateSystemType>(carr.size, {i => CoordinateSystemType.parse(head.read(i))})
    }
    unsafe { FfiOHOSGeoLocationManagerFreeGeofenceSupportedCoordTypes(carr) }
    return res
}
