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

import ohos.labels.APILevel
import std.collection.{HashMap, Map}

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
