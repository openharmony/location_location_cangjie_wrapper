/*
 * Copyright (c) 2026 Huawei Device Co., Ltd.
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

package ohos.geo_location_manager

import ohos.labels.{APILevel, PermissionValue}
import ohos.callback_invoke.Callback1Argument
import ohos.business_exception.AsyncCallback
import std.collection.{HashMap, Map}
import std.deriving.Derive

@!APILevel[
    since: "22",
    syscap: "SystemCapability.Location.Location.Core"
]
public class GeoLocationManager {
    @!APILevel[
        since: "22",
        permission: "ohos.permission.APPROXIMATELY_LOCATION",
        syscap: "SystemCapability.Location.Location.Core",
        throwexception: true,
        workerthread: true
    ]
    public static func getCurrentLocation(): Location {
        return Location()
    }

    @!APILevel[
        since: "22",
        permission: "ohos.permission.APPROXIMATELY_LOCATION",
        syscap: "SystemCapability.Location.Location.Core",
        throwexception: true,
        workerthread: true
    ]
    public static func getCurrentLocation(request: CurrentLocationRequest): Location {
        return Location()
    }

    @!APILevel[
        since: "22",
        permission: "ohos.permission.APPROXIMATELY_LOCATION",
        syscap: "SystemCapability.Location.Location.Core",
        throwexception: true,
        workerthread: true
    ]
    public static func getCurrentLocation(request: SingleLocationRequest): Location {
        return Location()
    }

    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Location.Location.Core",
        throwexception: true
    ]
    public static func isLocationEnabled(): Bool {
        return true
    }
    
    public init() {
        super()
    }
}

@!APILevel[
    since: "22",
    syscap: "SystemCapability.Location.Location.Core"
]
public enum LocationSourceType {
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Location.Location.Core"
    ]
    Gnss
    |
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Location.Location.Core"
    ]
    Network
    |
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Location.Location.Core"
    ]
    Indoor
    |
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Location.Location.Core"
    ]
    Rtk
    | ...
}

@!APILevel[
    since: "22",
    syscap: "SystemCapability.Location.Location.Core"
]
public class Location {
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Location.Location.Core"
    ]
    public var latitude: Float64

    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Location.Location.Core"
    ]
    public var longitude: Float64

    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Location.Location.Core"
    ]
    public var altitude: Float64

    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Location.Location.Core"
    ]
    public var accuracy: Float64

    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Location.Location.Core"
    ]
    public var speed: Float64

    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Location.Location.Core"
    ]
    public var timestamp: Int64

    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Location.Location.Core"
    ]
    public var direction: Float64

    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Location.Location.Core"
    ]
    public var timeSinceBoot: Int64

    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Location.Location.Core"
    ]
    public var additions: ?Array<String>

    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Location.Location.Core"
    ]
    public var additionsMap: ?Map<String, String>

    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Location.Location.Core"
    ]
    public var additionSize: ?Int64

    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Location.Location.Core"
    ]
    public var altitudeAccuracy: ?Float64

    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Location.Location.Core"
    ]
    public var speedAccuracy: ?Float64

    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Location.Location.Core"
    ]
    public var directionAccuracy: ?Float64

    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Location.Location.Core"
    ]
    public var uncertaintyOfTimeSinceBoot: ?Int64

    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Location.Location.Core"
    ]
    public var sourceType: ?LocationSourceType
    
    public init() {
        super()
        this.latitude = 0.0
        this.longitude = 0.0
        this.altitude = 0.0
        this.accuracy = 0.0
        this.speed = 0.0
        this.timestamp = 0
        this.direction = 0.0
        this.timeSinceBoot = 0
        this.additions = None
        this.additionsMap = HashMap<String, String>()
        this.additionSize = None
        this.altitudeAccuracy = None
        this.speedAccuracy = None
        this.directionAccuracy = None
        this.uncertaintyOfTimeSinceBoot = None
        this.sourceType = None
    }
}

@!APILevel[
    since: "22",
    syscap: "SystemCapability.Location.Location.Core"
]
public enum LocationRequestPriority {
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Location.Location.Core"
    ]
    Unset
    |
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Location.Location.Core"
    ]
    Accuracy
    |
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Location.Location.Core"
    ]
    LowPower
    |
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Location.Location.Core"
    ]
    FirstFix
    | ...
}

@!APILevel[
    since: "22",
    syscap: "SystemCapability.Location.Location.Core"
]
public enum LocationRequestScenario {
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Location.Location.Core"
    ]
    Unset
    |
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Location.Location.Core"
    ]
    Navigation
    |
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Location.Location.Core"
    ]
    TrajectoryTracking
    |
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Location.Location.Core"
    ]
    CarHailing
    |
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Location.Location.Core"
    ]
    DailyLifeService
    |
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Location.Location.Core"
    ]
    NoPower
    | ...
}

@!APILevel[
    since: "22",
    syscap: "SystemCapability.Location.Location.Core"
]
public class CurrentLocationRequest {
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Location.Location.Core"
    ]
    public var priority: LocationRequestPriority

    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Location.Location.Core"
    ]
    public var scenario: LocationRequestScenario

    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Location.Location.Core"
    ]
    public var maxAccuracy: Float32

    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Location.Location.Core"
    ]
    public var timeoutMs: Int32

    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Location.Location.Core"
    ]
    public init(priority!: LocationRequestPriority = LocationRequestPriority.FirstFix,
        scenario!: LocationRequestScenario = LocationRequestScenario.Unset, maxAccuracy!: Float32 = 0.0,
        timeoutMs!: Int32 = 5000) {
        super()
        this.priority = LocationRequestPriority.Unset
        this.scenario = LocationRequestScenario.Unset
        this.maxAccuracy = 0.0
        this.timeoutMs = 0
    }
}

@!APILevel[
    since: "22",
    syscap: "SystemCapability.Location.Location.Core"
]
public enum LocatingPriority {
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Location.Location.Core"
    ]
    PriorityAccuracy
    |
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Location.Location.Core"
    ]
    PriorityLocatingSpeed
    | ...
}

@!APILevel[
    since: "22",
    syscap: "SystemCapability.Location.Location.Core"
]
public class SingleLocationRequest {
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Location.Location.Core"
    ]
    public var locatingPriority: LocatingPriority

    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Location.Location.Core"
    ]
    public var locatingTimeoutMs: Int32

    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Location.Location.Core"
    ]
    public init(locatingPriority: LocatingPriority, locatingTimeoutMs: Int32) {
        super()
        this.locatingPriority = LocatingPriority.PriorityAccuracy
        this.locatingTimeoutMs = 0
    }
}


@!APILevel[
    since: "26.1.0",
    syscap: "SystemCapability.Location.Location.Geocoder"
]
public class ReverseGeoCodeRequest {
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.Location.Location.Geocoder"
    ]
    public mut prop locale: ?String {
        get() {
            None
        }
        set(v) {
        }
    }
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.Location.Location.Geocoder"
    ]
    public mut prop country: ?String {
        get() {
            None
        }
        set(v) {
        }
    }
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.Location.Location.Geocoder"
    ]
    public mut prop latitude: Float64 {
        get() {
            0.0
        }
        set(v) {
        }
    }
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.Location.Location.Geocoder"
    ]
    public mut prop longitude: Float64 {
        get() {
            0.0
        }
        set(v) {
        }
    }
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.Location.Location.Geocoder"
    ]
    public mut prop maxItems: ?Int32 {
        get() {
            None
        }
        set(v) {
        }
    }

    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.Location.Location.Geocoder"
    ]
    public init(latitude: Float64, longitude: Float64, locale!: ?String = None, country!: ?String = None,
        maxItems!: ?Int32 = None) {
    }
}

@!APILevel[
    since: "26.1.0",
    syscap: "SystemCapability.Location.Location.Geocoder"
]
public class GeoCodeRequest {
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.Location.Location.Geocoder"
    ]
    public mut prop locale: ?String {
        get() {
            None
        }
        set(v) {
        }
    }
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.Location.Location.Geocoder"
    ]
    public mut prop country: ?String {
        get() {
            None
        }
        set(v) {
        }
    }
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.Location.Location.Geocoder"
    ]
    public mut prop description: String {
        get() {
            ""
        }
        set(v) {
        }
    }
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.Location.Location.Geocoder"
    ]
    public mut prop maxItems: ?Int32 {
        get() {
            None
        }
        set(v) {
        }
    }
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.Location.Location.Geocoder"
    ]
    public mut prop minLatitude: ?Float64 {
        get() {
            None
        }
        set(v) {
        }
    }
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.Location.Location.Geocoder"
    ]
    public mut prop minLongitude: ?Float64 {
        get() {
            None
        }
        set(v) {
        }
    }
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.Location.Location.Geocoder"
    ]
    public mut prop maxLatitude: ?Float64 {
        get() {
            None
        }
        set(v) {
        }
    }
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.Location.Location.Geocoder"
    ]
    public mut prop maxLongitude: ?Float64 {
        get() {
            None
        }
        set(v) {
        }
    }

    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.Location.Location.Geocoder"
    ]
    public init(description: String, locale!: ?String = None, country!: ?String = None, maxItems!: ?Int32 = None,
        minLatitude!: ?Float64 = None, minLongitude!: ?Float64 = None, maxLatitude!: ?Float64 = None,
        maxLongitude!: ?Float64 = None) {
    }
}

@!APILevel[
    since: "26.1.0",
    syscap: "SystemCapability.Location.Location.Geocoder"
]
public class GeoAddress {
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.Location.Location.Geocoder"
    ]
    public mut prop latitude: ?Float64 {
        get() {
            None
        }
        set(v) {
        }
    }
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.Location.Location.Geocoder"
    ]
    public mut prop longitude: ?Float64 {
        get() {
            None
        }
        set(v) {
        }
    }
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.Location.Location.Geocoder"
    ]
    public mut prop locale: ?String {
        get() {
            None
        }
        set(v) {
        }
    }
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.Location.Location.Geocoder"
    ]
    public mut prop placeName: ?String {
        get() {
            None
        }
        set(v) {
        }
    }
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.Location.Location.Geocoder"
    ]
    public mut prop countryCode: ?String {
        get() {
            None
        }
        set(v) {
        }
    }
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.Location.Location.Geocoder"
    ]
    public mut prop countryName: ?String {
        get() {
            None
        }
        set(v) {
        }
    }
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.Location.Location.Geocoder"
    ]
    public mut prop administrativeArea: ?String {
        get() {
            None
        }
        set(v) {
        }
    }
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.Location.Location.Geocoder"
    ]
    public mut prop subAdministrativeArea: ?String {
        get() {
            None
        }
        set(v) {
        }
    }
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.Location.Location.Geocoder"
    ]
    public mut prop locality: ?String {
        get() {
            None
        }
        set(v) {
        }
    }
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.Location.Location.Geocoder"
    ]
    public mut prop subLocality: ?String {
        get() {
            None
        }
        set(v) {
        }
    }
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.Location.Location.Geocoder"
    ]
    public mut prop roadName: ?String {
        get() {
            None
        }
        set(v) {
        }
    }
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.Location.Location.Geocoder"
    ]
    public mut prop subRoadName: ?String {
        get() {
            None
        }
        set(v) {
        }
    }
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.Location.Location.Geocoder"
    ]
    public mut prop premises: ?String {
        get() {
            None
        }
        set(v) {
        }
    }
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.Location.Location.Geocoder"
    ]
    public mut prop postalCode: ?String {
        get() {
            None
        }
        set(v) {
        }
    }
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.Location.Location.Geocoder"
    ]
    public mut prop phoneNumber: ?String {
        get() {
            None
        }
        set(v) {
        }
    }
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.Location.Location.Geocoder"
    ]
    public mut prop addressUrl: ?String {
        get() {
            None
        }
        set(v) {
        }
    }
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.Location.Location.Geocoder"
    ]
    public mut prop descriptions: ?Array<String> {
        get() {
            None
        }
        set(v) {
        }
    }
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.Location.Location.Geocoder"
    ]
    public mut prop descriptionsSize: ?Int32 {
        get() {
            None
        }
        set(v) {
        }
    }

    private init(latitude: ?Float64, longitude: ?Float64, locale: ?String, placeName: ?String, countryCode: ?String,
        countryName: ?String, administrativeArea: ?String, subAdministrativeArea: ?String, locality: ?String,
        subLocality: ?String, roadName: ?String, subRoadName: ?String, premises: ?String, postalCode: ?String,
        phoneNumber: ?String, addressUrl: ?String, descriptions: ?Array<String>, descriptionsSize: ?Int32) {
    }
}

@!APILevel[
    since: "26.1.0",
    syscap: "SystemCapability.Location.Location.Core"
]
public class LocationRequest {
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.Location.Location.Core"
    ]
    public mut prop priority: ?LocationRequestPriority {
        get() {
            None
        }
        set(v) {
        }
    }
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.Location.Location.Core"
    ]
    public mut prop scenario: ?LocationRequestScenario {
        get() {
            None
        }
        set(v) {
        }
    }
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.Location.Location.Core"
    ]
    public mut prop timeInterval: ?Int32 {
        get() {
            None
        }
        set(v) {
        }
    }
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.Location.Location.Core"
    ]
    public mut prop distanceInterval: ?Float64 {
        get() {
            None
        }
        set(v) {
        }
    }
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.Location.Location.Core"
    ]
    public mut prop maxAccuracy: ?Float32 {
        get() {
            None
        }
        set(v) {
        }
    }

    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.Location.Location.Core"
    ]
    public init(priority!: ?LocationRequestPriority = None,
        scenario!: ?LocationRequestScenario = None, timeInterval!: ?Int32 = None,
        distanceInterval!: ?Float64 = None, maxAccuracy!: ?Float32 = None) {
    }
}

@!APILevel[
    since: "26.1.0",
    syscap: "SystemCapability.Location.Location.Core"
]
public class ContinuousLocationRequest {
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.Location.Location.Core"
    ]
    public mut prop interval: Int32 {
        get() {
            0
        }
        set(v) {
        }
    }
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.Location.Location.Core"
    ]
    public mut prop locationScenario: ScenarioValueType {
        get() {
            ScenarioValueType.UserActivityScenarioValue(UserActivityScenario.Navigation)
        }
        set(v) {
        }
    }

    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.Location.Location.Core"
    ]
    public init(interval: Int32, locationScenario: ScenarioValueType) {
    }
}

@Derive[ToString, Equatable]
@!APILevel[
    since: "26.1.0",
    syscap: "SystemCapability.Location.Location.Core"
]
public enum ScenarioValueType {
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.Location.Location.Core"
    ]
    UserActivityScenarioValue(UserActivityScenario)
    |
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.Location.Location.Core"
    ]
    PowerConsumptionScenarioValue(PowerConsumptionScenario)
    | ...
}

@Derive[ToString, Equatable]
@!APILevel[
    since: "26.1.0",
    syscap: "SystemCapability.Location.Location.Geofence"
]
public enum CoordinateSystemType {
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.Location.Location.Geofence"
    ]
    Wgs84
    |
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.Location.Location.Geofence"
    ]
    Gcj02
    | ...
}

@Derive[ToString, Equatable]
@!APILevel[
    since: "26.1.0",
    syscap: "SystemCapability.Location.Location.Core"
]
public enum LocationError {
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.Location.Location.Core"
    ]
    LocatingFailedDefault
    |
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.Location.Location.Core"
    ]
    LocatingFailedLocationPermissionDenied
    |
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.Location.Location.Core"
    ]
    LocatingFailedBackgroundPermissionDenied
    |
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.Location.Location.Core"
    ]
    LocatingFailedLocationSwitchOff
    |
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.Location.Location.Core"
    ]
    LocatingFailedInternetAccessFailure
    | ...
}

@Derive[ToString, Equatable]
@!APILevel[
    since: "26.1.0",
    syscap: "SystemCapability.Location.Location.Core"
]
public enum UserActivityScenario {
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.Location.Location.Core"
    ]
    Navigation
    |
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.Location.Location.Core"
    ]
    Sport
    |
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.Location.Location.Core"
    ]
    Transport
    |
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.Location.Location.Core"
    ]
    DailyLifeService
    | ...
}

@Derive[ToString, Equatable]
@!APILevel[
    since: "26.1.0",
    syscap: "SystemCapability.Location.Location.Core"
]
public enum PowerConsumptionScenario {
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.Location.Location.Core"
    ]
    HighPowerConsumption
    |
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.Location.Location.Core"
    ]
    LowPowerConsumption
    |
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.Location.Location.Core"
    ]
    NoPowerConsumption
    | ...
}

@!APILevel[
    since: "26.1.0",
    syscap: "SystemCapability.Location.Location.Core"
]
public class LocationCommand {
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.Location.Location.Core"
    ]
    public mut prop scenario: LocationRequestScenario {
        get() {
            LocationRequestScenario.Unset
        }
        set(v) {
        }
    }
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.Location.Location.Core"
    ]
    public mut prop command: String {
        get() {
            ""
        }
        set(v) {
        }
    }

    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.Location.Location.Core"
    ]
    public init(scenario: LocationRequestScenario, command: String) {
    }
}

@!APILevel[
    since: "26.1.0",
    syscap: "SystemCapability.Location.Location.Core"
]
public class CountryCode {
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.Location.Location.Core"
    ]
    public mut prop country: String {
        get() {
            ""
        }
        set(v) {
        }
    }
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.Location.Location.Core"
    ]
    public mut prop countryCodeType: CountryCodeType {
        get() {
            CountryCodeType.CountryCodeFromLocale
        }
        set(v) {
        }
    }

    private init(country: String, countryCodeType: CountryCodeType) {
    }
}

@Derive[ToString, Equatable]
@!APILevel[
    since: "26.1.0",
    syscap: "SystemCapability.Location.Location.Core"
]
public enum CountryCodeType {
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.Location.Location.Core"
    ]
    CountryCodeFromLocale
    |
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.Location.Location.Core"
    ]
    CountryCodeFromSim
    |
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.Location.Location.Core"
    ]
    CountryCodeFromLocation
    |
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.Location.Location.Core"
    ]
    CountryCodeFromNetwork
    | ...
}

@!APILevel[
    since: "26.1.0",
    permission: "ohos.permission.APPROXIMATELY_LOCATION",
    syscap: "SystemCapability.Location.Location.Core",
    throwexception: true
]
public func onLocationChange(request: LocationRequest, callback: Callback1Argument<Location>): Unit {}

@!APILevel[
    since: "26.1.0",
    permission: "ohos.permission.APPROXIMATELY_LOCATION",
    syscap: "SystemCapability.Location.Location.Core",
    throwexception: true
]
public func onLocationChange(request: ContinuousLocationRequest, callback: Callback1Argument<Location>): Unit {}

@!APILevel[
    since: "26.1.0",
    syscap: "SystemCapability.Location.Location.Core",
    throwexception: true
]
public func offLocationChange(callback!: ?Callback1Argument<Location> = None): Unit {}

@!APILevel[
    since: "26.1.0",
    permission: "ohos.permission.APPROXIMATELY_LOCATION",
    syscap: "SystemCapability.Location.Location.Core",
    throwexception: true
]
public func onLocationError(callback: Callback1Argument<LocationError>): Unit {}

@!APILevel[
    since: "26.1.0",
    permission: "ohos.permission.APPROXIMATELY_LOCATION",
    syscap: "SystemCapability.Location.Location.Core",
    throwexception: true
]
public func offLocationError(callback!: ?Callback1Argument<LocationError> = None): Unit {}

@!APILevel[
    since: "26.1.0",
    syscap: "SystemCapability.Location.Location.Core",
    throwexception: true
]
public func onLocationEnabledChange(callback: Callback1Argument<Bool>): Unit {}

@!APILevel[
    since: "26.1.0",
    syscap: "SystemCapability.Location.Location.Core",
    throwexception: true
]
public func offLocationEnabledChange(callback!: ?Callback1Argument<Bool> = None): Unit {}

@!APILevel[
    since: "26.1.0",
    syscap: "SystemCapability.Location.Location.Core",
    throwexception: true
]
public func onCountryCodeChange(callback: Callback1Argument<CountryCode>): Unit {}

@!APILevel[
    since: "26.1.0",
    syscap: "SystemCapability.Location.Location.Core",
    throwexception: true
]
public func offCountryCodeChange(callback!: ?Callback1Argument<CountryCode> = None): Unit {}

@!APILevel[
    since: "26.1.0",
    permission: "ohos.permission.APPROXIMATELY_LOCATION",
    syscap: "SystemCapability.Location.Location.Core",
    throwexception: true
]
public func getLastLocation(): Location {
    return Location()
}

@!APILevel[
    since: "26.1.0",
    syscap: "SystemCapability.Location.Location.Geocoder",
    throwexception: true
]
public func getAddressesFromLocation(request: ReverseGeoCodeRequest,
    callback: AsyncCallback<Array<GeoAddress>>): Unit {}

@!APILevel[
    since: "26.1.0",
    syscap: "SystemCapability.Location.Location.Geocoder",
    throwexception: true
]
public func getAddressesFromLocationName(request: GeoCodeRequest,
    callback: AsyncCallback<Array<GeoAddress>>): Unit {}

@!APILevel[
    since: "26.1.0",
    syscap: "SystemCapability.Location.Location.Geocoder",
    throwexception: true
]
public func isGeocoderAvailable(): Bool {
    return true
}

@!APILevel[
    since: "26.1.0",
    syscap: "SystemCapability.Location.Location.Core",
    throwexception: true
]
public func sendCommand(command: LocationCommand, callback: AsyncCallback<Unit>): Unit {}

@!APILevel[
    since: "26.1.0",
    syscap: "SystemCapability.Location.Location.Core",
    throwexception: true
]
public func getCountryCode(callback: AsyncCallback<CountryCode>): Unit {}

@!APILevel[
    since: "26.1.0",
    syscap: "SystemCapability.Location.Location.Geofence",
    throwexception: true
]
public func getGeofenceSupportedCoordTypes(): Array<CoordinateSystemType> {
    return []
}

@!APILevel[
    since: "26.1.0",
    permission: "ohos.permission.APPROXIMATELY_LOCATION",
    syscap: "SystemCapability.Location.Location.Gnss",
    throwexception: true
]
public func onSatelliteStatusChange(callback: Callback1Argument<SatelliteStatusInfo>): Unit {}

@!APILevel[
    since: "26.1.0",
    permission: "ohos.permission.APPROXIMATELY_LOCATION",
    syscap: "SystemCapability.Location.Location.Gnss",
    throwexception: true
]
public func offSatelliteStatusChange(callback!: ?Callback1Argument<SatelliteStatusInfo> = None): Unit {}

@!APILevel[
    since: "26.1.0",
    permission: "ohos.permission.LOCATION" & "ohos.permission.APPROXIMATELY_LOCATION",
    syscap: "SystemCapability.Location.Location.Gnss",
    throwexception: true
]
public func onNmeaMessage(callback: Callback1Argument<String>): Unit {}

@!APILevel[
    since: "26.1.0",
    permission: "ohos.permission.LOCATION" & "ohos.permission.APPROXIMATELY_LOCATION",
    syscap: "SystemCapability.Location.Location.Gnss",
    throwexception: true
]
public func offNmeaMessage(callback!: ?Callback1Argument<String> = None): Unit {}

@!APILevel[
    since: "26.1.0",
    syscap: "SystemCapability.Location.Location.Gnss"
]
public class SatelliteStatusInfo {
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.Location.Location.Gnss"
    ]
    public mut prop satellitesNumber: Int32 {
        get() {
            0
        }
        set(v) {
        }
    }
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.Location.Location.Gnss"
    ]
    public mut prop satelliteIds: Array<Int32> {
        get() {
            Array<Int32>()
        }
        set(v) {
        }
    }
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.Location.Location.Gnss"
    ]
    public mut prop carrierToNoiseDensitys: Array<Float64> {
        get() {
            Array<Float64>()
        }
        set(v) {
        }
    }
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.Location.Location.Gnss"
    ]
    public mut prop altitudes: Array<Float64> {
        get() {
            Array<Float64>()
        }
        set(v) {
        }
    }
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.Location.Location.Gnss"
    ]
    public mut prop azimuths: Array<Float64> {
        get() {
            Array<Float64>()
        }
        set(v) {
        }
    }
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.Location.Location.Gnss"
    ]
    public mut prop carrierFrequencies: Array<Float64> {
        get() {
            Array<Float64>()
        }
        set(v) {
        }
    }
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.Location.Location.Gnss"
    ]
    public mut prop satelliteConstellation: ?Array<SatelliteConstellationCategory> {
        get() {
            None
        }
        set(v) {
        }
    }
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.Location.Location.Gnss"
    ]
    public mut prop satelliteAdditionalInfo: ?Array<Int32> {
        get() {
            None
        }
        set(v) {
        }
    }

    private init() {}
}

@Derive[ToString, Equatable]
@!APILevel[
    since: "26.1.0",
    syscap: "SystemCapability.Location.Location.Gnss"
]
public enum SatelliteConstellationCategory {
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.Location.Location.Gnss"
    ]
    ConstellationCategoryUnknown
    |
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.Location.Location.Gnss"
    ]
    ConstellationCategoryGps
    |
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.Location.Location.Gnss"
    ]
    ConstellationCategorySbas
    |
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.Location.Location.Gnss"
    ]
    ConstellationCategoryGlonass
    |
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.Location.Location.Gnss"
    ]
    ConstellationCategoryQzss
    |
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.Location.Location.Gnss"
    ]
    ConstellationCategoryBeidou
    |
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.Location.Location.Gnss"
    ]
    ConstellationCategoryGalileo
    |
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.Location.Location.Gnss"
    ]
    ConstellationCategoryIrnss
    | ...
}
