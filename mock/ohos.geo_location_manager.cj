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
import std.collection.{HashMap, Map}
import ohos.callback_invoke.Callback1Argument

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

    @!APILevel[
        since: "24",
        permission: "ohos.permission.APPROXIMATELY_LOCATION",
        syscap: "SystemCapability.Location.Location.Core",
        throwexception: true
    ]
    public static func onLocationChange(request: ContinuousLocationRequest, callback: Callback1Argument<Location>): Unit {
        return ()
    }

    @!APILevel[
        since: "24",
        permission: "ohos.permission.APPROXIMATELY_LOCATION",
        syscap: "SystemCapability.Location.Location.Gnss",
        throwexception: true
    ]
    public static func onSatelliteStatusChange(callback: Callback1Argument<SatelliteStatusInfo>): Unit {
        return ()
    }

    @!APILevel[
        since: "24",
        permission: "ohos.permission.APPROXIMATELY_LOCATION",
        syscap: "SystemCapability.Location.Location.Gnss",
        throwexception: true
    ]
    public static func offSatelliteStatusChange(callback!: ?Callback1Argument<SatelliteStatusInfo> = None): Unit {
        return ()
    }

    @!APILevel[
        since: "24",
        permission: "ohos.permission.LOCATION" & "ohos.permission.APPROXIMATELY_LOCATION",
        syscap: "SystemCapability.Location.Location.Gnss",
        throwexception: true
    ]
    public static func onNmeaMessage(callback: Callback1Argument<String>): Unit {
        return ()
    }

    @!APILevel[
        since: "24",
        permission: "ohos.permission.LOCATION" & "ohos.permission.APPROXIMATELY_LOCATION",
        syscap: "SystemCapability.Location.Location.Gnss",
        throwexception: true
    ]
    public static func offNmeaMessage(callback!: ?Callback1Argument<String> = None): Unit {
        return ()
    }

    @!APILevel[
        since: "24",
        permission: "ohos.permission.APPROXIMATELY_LOCATION",
        syscap: "SystemCapability.Location.Location.Core",
        throwexception: true
    ]
    public static func offLocationChange(callback!: ?Callback1Argument<Location> = None): Unit {
        return ()
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
    since: "24",
    syscap: "SystemCapability.Location.Location.Core"
]
public class ContinuousLocationRequest {
    /**
     * Location report interval, in seconds.
     */
    @!APILevel[
        since: "24",
        syscap: "SystemCapability.Location.Location.Core"
    ]
    public var interval: Int32

    @!APILevel[
        since: "24",
        syscap: "SystemCapability.Location.Location.Core"
    ]
    public var locationScenario: Int32

    @!APILevel[
        since: "24",
        syscap: "SystemCapability.Location.Location.Core"
    ]
    public init(interval: Int32, locationScenario: Int32) {
        super()
        this.interval = interval
        this.locationScenario = locationScenario
    }
}

@!APILevel[
    since: "24",
    syscap: "SystemCapability.Location.Location.Core"
]
public class PowerConsumptionScenario {
    @!APILevel[
        since: "24",
        syscap: "SystemCapability.Location.Location.Core"
    ]
    public static const HIGH_POWER_CONSUMPTION: Int32 = 0x601
    @!APILevel[
        since: "24",
        syscap: "SystemCapability.Location.Location.Core"
    ]
    public static const LOW_POWER_CONSUMPTION: Int32 = 0x602
    @!APILevel[
        since: "24",
        syscap: "SystemCapability.Location.Location.Core"
    ]
    public static const NO_POWER_CONSUMPTION: Int32 = 0x603

    init() {
        super()
    }
}

@!APILevel[
    since: "24",
    syscap: "SystemCapability.Location.Location.Gnss"
]
public enum SatelliteConstellationCategory {
    @!APILevel[
        since: "24",
        syscap: "SystemCapability.Location.Location.Gnss"
    ]
    ConstellationCategoryUnknown
    |
    @!APILevel[
        since: "24",
        syscap: "SystemCapability.Location.Location.Gnss"
    ]
    ConstellationCategoryGps
    |
    @!APILevel[
        since: "24",
        syscap: "SystemCapability.Location.Location.Gnss"
    ]
    ConstellationCategorySbas
    |
    @!APILevel[
        since: "24",
        syscap: "SystemCapability.Location.Location.Gnss"
    ]
    ConstellationCategoryGlonass
    |
    @!APILevel[
        since: "24",
        syscap: "SystemCapability.Location.Location.Gnss"
    ]
    ConstellationCategoryQzss
    |
    @!APILevel[
        since: "24",
        syscap: "SystemCapability.Location.Location.Gnss"
    ]
    ConstellationCategoryBeidou
    |
    @!APILevel[
        since: "24",
        syscap: "SystemCapability.Location.Location.Gnss"
    ]
    ConstellationCategoryGalileo
    |
    @!APILevel[
        since: "24",
        syscap: "SystemCapability.Location.Location.Gnss"
    ]
    ConstellationCategoryIrnss
    | ...
}

@!APILevel[
    since: "24",
    syscap: "SystemCapability.Location.Location.Gnss"
]
public class SatelliteStatusInfo {
    @!APILevel[
        since: "24",
        syscap: "SystemCapability.Location.Location.Gnss"
    ]
    public var satellitesNumber: Int32
    @!APILevel[
        since: "24",
        syscap: "SystemCapability.Location.Location.Gnss"
    ]
    public var satelliteIds: Array<Int32>
    @!APILevel[
        since: "24",
        syscap: "SystemCapability.Location.Location.Gnss"
    ]
    public var carrierToNoiseDensitys: Array<Float64>
    @!APILevel[
        since: "24",
        syscap: "SystemCapability.Location.Location.Gnss"
    ]
    public var altitudes: Array<Float64>
    @!APILevel[
        since: "24",
        syscap: "SystemCapability.Location.Location.Gnss"
    ]
    public var azimuths: Array<Float64>
    @!APILevel[
        since: "24",
        syscap: "SystemCapability.Location.Location.Gnss"
    ]
    public var carrierFrequencies: Array<Float64>
    @!APILevel[
        since: "24",
        syscap: "SystemCapability.Location.Location.Gnss"
    ]
    public var satelliteConstellation: Array<SatelliteConstellationCategory>
    @!APILevel[
        since: "24",
        syscap: "SystemCapability.Location.Location.Gnss"
    ]
    public var satelliteAdditionalInfo: Array<Int32>

    protected init(satellitesNumber: Int32, satelliteIds: Array<Int32>, carrierToNoiseDensitys: Array<Float64>,
        altitudes: Array<Float64>, azimuths: Array<Float64>, carrierFrequencies: Array<Float64>,
        satelliteConstellation!: Array<SatelliteConstellationCategory> = Array<SatelliteConstellationCategory>(),
        satelliteAdditionalInfo!: Array<Int32> = Array<Int32>()) {
        this.satellitesNumber = satellitesNumber
        this.satelliteIds = satelliteIds
        this.carrierToNoiseDensitys = carrierToNoiseDensitys
        this.altitudes = altitudes
        this.azimuths = azimuths
        this.carrierFrequencies = carrierFrequencies
        this.satelliteConstellation = satelliteConstellation
        this.satelliteAdditionalInfo = satelliteAdditionalInfo
    }
}

@!APILevel[
    since: "24",
    syscap: "SystemCapability.Location.Location.Core"
]
public class UserActivityScenario {
    @!APILevel[
        since: "24",
        syscap: "SystemCapability.Location.Location.Core"
    ]
    public static const NAVIGATION: Int32 = 0x401
    @!APILevel[
        since: "24",
        syscap: "SystemCapability.Location.Location.Core"
    ]
    public static const SPORT: Int32 = 0x402
    @!APILevel[
        since: "24",
        syscap: "SystemCapability.Location.Location.Core"
    ]
    public static const TRANSPORT: Int32 = 0x403
    @!APILevel[
        since: "24",
        syscap: "SystemCapability.Location.Location.Core"
    ]
    public static const DAILY_LIFE_SERVICE: Int32 = 0x404

    init() {
        super()
    }
}
