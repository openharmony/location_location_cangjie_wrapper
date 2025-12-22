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

import ohos.business_exception.{ BusinessException, getUniversalErrorMsg }
import ohos.hilog.HilogChannel
import ohos.labels.{APILevel, Hide}

import std.collection.{HashMap, Map}

const LOG_CORE: UInt32 = 3
const LOCATION_LOG_DOMAIN: UInt32 = 0xD002300
const ERROR_CODE_INNER: Int32 = 3301200
let GEO_LOCATION_MANAGER_LOG = HilogChannel(LOG_CORE, LOCATION_LOG_DOMAIN, "CJ-GeoLocationManager")

@!Hide
internal class PoiInfo {}

/**
 * Enum for the source of the location.
 */
@!APILevel[
    since: "22",
    syscap: "SystemCapability.Location.Location.Core"
]
public enum LocationSourceType {
    /**
     * The location is obtained from the GNSS.
     */
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Location.Location.Core"
    ]
    Gnss
    |
    /**
     * The location comes from the network positioning technology.
     */
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Location.Location.Core"
    ]
    Network
    |
    /**
     * The location comes from the indoor positioning technology.
     */
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Location.Location.Core"
    ]
    Indoor
    |
    /**
     * The location comes from the GNSS RTK technology.
     */
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Location.Location.Core"
    ]
    Rtk
    | ...

    /*
     * @throws { BusinessException } 3301000 - The type is not supported yet.
     */
    static func parse(value: Int32): LocationSourceType {
        match (value) {
            case 1 => Gnss
            case 2 => Network
            case 3 => Indoor
            case 4 => Rtk
            case _ => throw BusinessException(3301000, "The type is not supported yet.")
        }
    }

    func getValue(): Int32 {
        match (this) {
            case Gnss => 1
            case Network => 2
            case Indoor => 3
            case Rtk => 4
            case _ => throw BusinessException(3301000, "The type is not supported yet.")
        }
    }
}

/**
 * Provides information about geographic locations.
 */
@!APILevel[
    since: "22",
    syscap: "SystemCapability.Location.Location.Core"
]
public class Location {
    /**
     * Indicates latitude information.
     * A positive value indicates north latitude,
     * and a negative value indicates south latitude.
     */
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Location.Location.Core"
    ]
    public var latitude: Float64
    /**
     * Indicates Longitude information.
     * A positive value indicates east longitude ,
     * and a negative value indicates west longitude.
     */
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Location.Location.Core"
    ]
    public var longitude: Float64
    /**
     * Indicates location altitude, in meters.
     */
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Location.Location.Core"
    ]
    public var altitude: Float64
    /**
     * Indicates location accuracy, in meters.
     */
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Location.Location.Core"
    ]
    public var accuracy: Float64
    /**
     * Indicates speed, in m/s.
     */
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Location.Location.Core"
    ]
    public var speed: Float64
    /**
     * Indicates location timestamp in the UTC format.
     */
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Location.Location.Core"
    ]
    public var timestamp: Int64
    /**
     * Indicates direction information.
     */
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Location.Location.Core"
    ]
    public var direction: Float64
    /**
     * Indicates location timestamp since boot.
     */
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Location.Location.Core"
    ]
    public var timeSinceBoot: Int64
    /**
     * Indicates additional information.
     */
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Location.Location.Core"
    ]
    public var additions: ?Array<String>
    /**
     * Indicates additional information map.
     */
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Location.Location.Core"
    ]
    public var additionsMap: ?Map<String, String>
    /**
     * Indicates the amount of additional descriptive information.
     */
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Location.Location.Core"
    ]
    public var additionSize: ?Int64
    @!Hide
    internal var isFromMock: ?Bool = Option<Bool>.None
    /**
     * Indicates vertical position accuracy in meters.
     */
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Location.Location.Core"
    ]
    public var altitudeAccuracy: ?Float64
    /**
     * Indicates speed accuracy in meter per seconds.
     */
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Location.Location.Core"
    ]
    public var speedAccuracy: ?Float64
    /**
     * Indicates direction accuracy in degrees.
     */
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Location.Location.Core"
    ]
    public var directionAccuracy: ?Float64
    /**
     * Time uncertainty Of timeSinceBoot in nanosecond.
     */
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Location.Location.Core"
    ]
    public var uncertaintyOfTimeSinceBoot: ?Int64
    /**
     * Indicates the source of the location.
     */
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Location.Location.Core"
    ]
    public var sourceType: ?LocationSourceType
    @!Hide
    internal var poi: ?PoiInfo = Option<PoiInfo>.None

    init(cjLocation: CJLocation, additions!: Array<String> = Array<String>(),
        additionsMap!: HashMap<String, String> = HashMap<String, String>(),
        sourceType!: LocationSourceType = LocationSourceType.Gnss) {
        this.latitude = cjLocation.latitude
        this.longitude = cjLocation.longitude
        this.altitude = cjLocation.altitude
        this.accuracy = cjLocation.accuracy
        this.speed = cjLocation.speed
        this.timestamp = cjLocation.timeStamp
        this.direction = cjLocation.direction
        this.timeSinceBoot = cjLocation.timeSinceBoot
        this.additions = additions
        this.additionSize = cjLocation.additionSize
        this.additionsMap = additionsMap
        this.altitudeAccuracy = cjLocation.altitudeAccuracy
        this.speedAccuracy = cjLocation.speedAccuracy
        this.directionAccuracy = cjLocation.directionAccuracy
        this.uncertaintyOfTimeSinceBoot = cjLocation.uncertaintyOfTimeSinceBoot
        this.sourceType = sourceType
    }
}

/**
 * Enum for location priority.
 */
@!APILevel[
    since: "22",
    syscap: "SystemCapability.Location.Location.Core"
]
public enum LocationRequestPriority {
    /**
     * Default priority.
     */
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Location.Location.Core"
    ]
    Unset
    |
    /**
     * Preferentially ensure the locating accuracy.
     */
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Location.Location.Core"
    ]
    Accuracy
    |
    /**
     * Preferentially ensure low power consumption for locating.
     */
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Location.Location.Core"
    ]
    LowPower
    |
    /**
     * Preferentially ensure that the first location is time-consuming.
     */
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Location.Location.Core"
    ]
    FirstFix
    | ...

    func getValue(): Int32 {
        match (this) {
            case Unset => 0x200
            case Accuracy => 0x201
            case LowPower => 0x202
            case FirstFix => 0x203
            case _ => throw BusinessException(3301000, "The type is not supported yet.")
        }
    }
}

/**
 * Enum for location scenario.
 */
@!APILevel[
    since: "22",
    syscap: "SystemCapability.Location.Location.Core"
]
public enum LocationRequestScenario {
    /**
     * Default scenario.
     */
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Location.Location.Core"
    ]
    Unset
    |
    /**
     * Navigation scenario. High positioning precision and real-time performance are required.
     */
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Location.Location.Core"
    ]
    Navigation
    |
    /**
     * Trajectory tracking scenario. High positioning precision is required.
     */
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Location.Location.Core"
    ]
    TrajectoryTracking
    |
    /**
     * Car hailing scenario. High positioning precision and real-time performance are required.
     */
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Location.Location.Core"
    ]
    CarHailing
    |
    /**
     * Daily life scenarios. Low requirements on positioning precision and real-time performance.
     */
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Location.Location.Core"
    ]
    DailyLifeService
    |
    /**
     * Power saving scenarios.
     */
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Location.Location.Core"
    ]
    NoPower
    | ...

    func getValue(): Int32 {
        match (this) {
            case Unset => 0x300
            case Navigation => 0x301
            case TrajectoryTracking => 0x302
            case CarHailing => 0x303
            case DailyLifeService => 0x304
            case NoPower => 0x305
            case _ => throw BusinessException(3301000, "The type is not supported yet.")
        }
    }
}

/**
 * Configuring parameters in current location requests.
 */
@!APILevel[
    since: "22",
    syscap: "SystemCapability.Location.Location.Core"
]
public class CurrentLocationRequest {
    /**
     * Priority of the location request.
     */
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Location.Location.Core"
    ]
    public var priority: LocationRequestPriority
    /**
     * User scenario of the location request.
     */
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Location.Location.Core"
    ]
    public var scenario: LocationRequestScenario
    /**
     * Accuracy requirements for reporting locations.
     */
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Location.Location.Core"
    ]
    public var maxAccuracy: Float32
    /**
     * Timeout interval of a single location request.
     */
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Location.Location.Core"
    ]
    public var timeoutMs: Int32

    /**
     * CurrentLocationRequest Constructor.
     *
     * @param { LocationRequestPriority } [priority] - The priority of the location request. The default value is FirstFix.
     * @param { LocationRequestScenario } [scenario] - The user scenario of the location request. The default value is Unset.
     * @param { Float32 } [maxAccuracy] - The accuracy requirements for reporting locations. The default value is 0.0.
     * @param { Int32 } [timeoutMs] - The timeout interval of a single location request. The default value is 5000.
     */
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Location.Location.Core"
    ]
    public init(priority!: LocationRequestPriority = LocationRequestPriority.FirstFix,
        scenario!: LocationRequestScenario = LocationRequestScenario.Unset, maxAccuracy!: Float32 = 0.0,
        timeoutMs!: Int32 = 5000) {
        this.priority = priority
        this.scenario = scenario
        this.maxAccuracy = maxAccuracy
        this.timeoutMs = timeoutMs
    }
}

/**
 * Enum for locating priority.
 */
@!APILevel[
    since: "22",
    syscap: "SystemCapability.Location.Location.Core"
]
public enum LocatingPriority {
    /**
     * Preferentially ensure the highest locating accuracy.
     */
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Location.Location.Core"
    ]
    PriorityAccuracy
    |
    /**
     * Preferentially ensure the fastest locating speed.
     */
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Location.Location.Core"
    ]
    PriorityLocatingSpeed
    | ...

    func getValue(): Int32 {
        match (this) {
            case PriorityAccuracy => 0x501
            case PriorityLocatingSpeed => 0x502
            case _ => throw BusinessException(3301000, "The type is not supported yet.")
        }
    }
}

/**
 * Configuring parameters in single location requests.
 */
@!APILevel[
    since: "22",
    syscap: "SystemCapability.Location.Location.Core"
]
public class SingleLocationRequest {
    /**
     * Priority of the location request.
     */
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Location.Location.Core"
    ]
    public var locatingPriority: LocatingPriority
    /**
     * Timeout of a single location request, in milliseconds.
     */
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Location.Location.Core"
    ]
    public var locatingTimeoutMs: Int32

    @!Hide
    internal var needPoi: ?Bool = Option<Bool>.None
    /**
     * SingleLocationRequest Constructor.
     *
     * @param { LocatingPriority } locatingPriority - The priority of the location request.
     * @param { Int32 } locatingTimeoutMs - The timeout of a single location request, in milliseconds.
     */
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Location.Location.Core"
    ]
    public init(locatingPriority: LocatingPriority, locatingTimeoutMs: Int32) {
        this.locatingPriority = locatingPriority
        this.locatingTimeoutMs = locatingTimeoutMs
    }
}

/**
 * Configuring parameters in continuous location requests.
 */
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

    /**
     * Location scenario. You can select a user activity scenario or power consumption scenario.
     */
    @!APILevel[
        since: "24",
        syscap: "SystemCapability.Location.Location.Core"
    ]
    public var locationScenario: Int32

    /**
     * ContinuousLocationRequest constructor
     *
     * @param { Int32 } interval - Location report interval, in seconds.
     * @param { Int32 } locationScenario - Location scenario. You can select a user activity scenario or power consumption scenario.
     */
    @!APILevel[
        since: "24",
        syscap: "SystemCapability.Location.Location.Core"
    ]
    public init(interval: Int32, locationScenario: Int32) {
        this.interval = interval
        this.locationScenario = locationScenario
    }
}

/**
 * Class for power consumption scenario.
 */
@!APILevel[
    since: "24",
    syscap: "SystemCapability.Location.Location.Core"
]
public class PowerConsumptionScenario {
    /**
     * High power consumption mode.
     */
    @!APILevel[
        since: "24",
        syscap: "SystemCapability.Location.Location.Core"
    ]
    public static const HIGH_POWER_CONSUMPTION: Int32 = 0x601
    /**
     * Low power consumption mode.
     */
    @!APILevel[
        since: "24",
        syscap: "SystemCapability.Location.Location.Core"
    ]
    public static const LOW_POWER_CONSUMPTION: Int32 = 0x602
    /**
     * Power saving scenarios.
     */
    @!APILevel[
        since: "24",
        syscap: "SystemCapability.Location.Location.Core"
    ]
    public static const NO_POWER_CONSUMPTION: Int32 = 0x603

    init() {}
}

/**
 * Enum for satellite constellation category.
 */
@!APILevel[
    since: "24",
    syscap: "SystemCapability.Location.Location.Gnss"
]
public enum SatelliteConstellationCategory {
    /**
     * Unknown type. This is the default value.
     */
    @!APILevel[
        since: "24",
        syscap: "SystemCapability.Location.Location.Gnss"
    ]
    ConstellationCategoryUnknown
    |
    /**
     * Global positioning system (GPS), a high-precision radio navigation positioning system made up of artificial earth satellites launched by the United States.
     */
    @!APILevel[
        since: "24",
        syscap: "SystemCapability.Location.Location.Gnss"
    ]
    ConstellationCategoryGps
    |
    /**
     * Satellite-based augmentation system (SBAS), which supports wide-area or regional augmentation through the use of 
     * geostationary (GEO) satellites for broadcasting augmentation information, such as ephemeris error, satellite 
     * clock difference, and ionospheric delay, to users. It enhances the accuracy, integrity, and availability of basic global navigation satellite systems.
     */
    @!APILevel[
        since: "24",
        syscap: "SystemCapability.Location.Location.Gnss"
    ]
    ConstellationCategorySbas
    |
    /**
     * Global navigation satellite system (GLONASS), a Russia space-based satellite navigation system that provides a global coverage positioning service similar to the GPS.
     */
    @!APILevel[
        since: "24",
        syscap: "SystemCapability.Location.Location.Gnss"
    ]
    ConstellationCategoryGlonass
    |
    /**
     * Quasi-Zenith satellite system (QZSS), a regional navigation satellite system developed by Japan to enhance and augment GPS coverage over Japan's territory.
     */
    @!APILevel[
        since: "24",
        syscap: "SystemCapability.Location.Location.Gnss"
    ]
    ConstellationCategoryQzss
    |
    /**
     * Beidou navigation satellite system (BNSS), a global satellite navigation system developed by China.
     */
    @!APILevel[
        since: "24",
        syscap: "SystemCapability.Location.Location.Gnss"
    ]
    ConstellationCategoryBeidou
    |
    /**
     * Galileo satellite navigation system (GALILEO), a global satellite navigation and positioning system developed and established by the European Union.
     */
    @!APILevel[
        since: "24",
        syscap: "SystemCapability.Location.Location.Gnss"
    ]
    ConstellationCategoryGalileo
    |
    /**
     * Indian regional navigation satellite system (IRNSS), an independent regional satellite navigation system developed and operated by India.
     */
    @!APILevel[
        since: "24",
        syscap: "SystemCapability.Location.Location.Gnss"
    ]
    ConstellationCategoryIrnss
    | ...

    static func parse(value: Int32): SatelliteConstellationCategory {
        match (value) {
            case 0 => ConstellationCategoryUnknown
            case 1 => ConstellationCategoryGps
            case 2 => ConstellationCategorySbas
            case 3 => ConstellationCategoryGlonass
            case 4 => ConstellationCategoryQzss
            case 5 => ConstellationCategoryBeidou
            case 6 => ConstellationCategoryGalileo
            case 7 => ConstellationCategoryIrnss
            case _ => throw BusinessException(3301000, "The type is not supported yet.")
        }
    }

    func getValue(): Int32 {
        match (this) {
            case ConstellationCategoryUnknown => 0
            case ConstellationCategoryGps => 1
            case ConstellationCategorySbas => 2
            case ConstellationCategoryGlonass => 3
            case ConstellationCategoryQzss => 4
            case ConstellationCategoryBeidou => 5
            case ConstellationCategoryGalileo => 6
            case ConstellationCategoryIrnss => 7
            case _ => throw BusinessException(3301000, "The type is not supported yet.")
        }
    }
}

/**
 * Satellite status information.
 */
@!APILevel[
    since: "24",
    syscap: "SystemCapability.Location.Location.Gnss"
]
public class SatelliteStatusInfo {
    /**
     * Number of satellites.
     */
    @!APILevel[
        since: "24",
        syscap: "SystemCapability.Location.Location.Gnss"
    ]
    public var satellitesNumber: Int32
    /**
     * Satellite ID array.
     */
    @!APILevel[
        since: "24",
        syscap: "SystemCapability.Location.Location.Gnss"
    ]
    public var satelliteIds: Array<Int32>
    /**
     * Carrier to noise density array.
     */
    @!APILevel[
        since: "24",
        syscap: "SystemCapability.Location.Location.Gnss"
    ]
    public var carrierToNoiseDensitys: Array<Float64>
    /**
     * Satellite altitude array.
     */
    @!APILevel[
        since: "24",
        syscap: "SystemCapability.Location.Location.Gnss"
    ]
    public var altitudes: Array<Float64>
    /**
     * Satellite azimuth array.
     */
    @!APILevel[
        since: "24",
        syscap: "SystemCapability.Location.Location.Gnss"
    ]
    public var azimuths: Array<Float64>
    /**
     * Satellite carrier frequency array.
     */
    @!APILevel[
        since: "24",
        syscap: "SystemCapability.Location.Location.Gnss"
    ]
    public var carrierFrequencies: Array<Float64>
    /**
     * Satellite constellation type array.
     */
    @!APILevel[
        since: "24",
        syscap: "SystemCapability.Location.Location.Gnss"
    ]
    public var satelliteConstellation: Array<SatelliteConstellationCategory>
    /**
     * Satellite additional information array.
     */
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

/**
 * Class for user activity scenario.
 */
@!APILevel[
    since: "24",
    syscap: "SystemCapability.Location.Location.Core"
]
public class UserActivityScenario {
    /**
     * Navigation scenario. High positioning precision and real-time performance are required.
     */
    @!APILevel[
        since: "24",
        syscap: "SystemCapability.Location.Location.Core"
    ]
    public static const NAVIGATION: Int32 = 0x401
    /**
     * Sport scenario. High positioning precision is required.
     */
    @!APILevel[
        since: "24",
        syscap: "SystemCapability.Location.Location.Core"
    ]
    public static const SPORT: Int32 = 0x402
    /**
     * Transport scenario. High positioning precision and real-time performance are required.
     */
    @!APILevel[
        since: "24",
        syscap: "SystemCapability.Location.Location.Core"
    ]
    public static const TRANSPORT: Int32 = 0x403
    /**
     * Daily life scenarios. Low requirements on positioning precision.
     */
    @!APILevel[
        since: "24",
        syscap: "SystemCapability.Location.Location.Core"
    ]
    public static const DAILY_LIFE_SERVICE: Int32 = 0x404

    init() {}
}

func getErrorCode(code: Int32): Int32 {
    const MEMORY_ERROR: Int32 = -1
    if (code == MEMORY_ERROR) {
        3301000
    } else {
        code
    }
}

let ERROR_CODE_MAP = HashMap<Int32, String>(
    [
        (3301000, "The location service is unavailable."),
        (3301100, "The location switch is off."),
        (3301200, "Failed to obtain the geographical location."),
        (3301300, "Reverse geocoding query failed."),
        (3301400, "Geocoding query failed."),
        (3301500, "Failed to query the area information."),
        (3301600, "Failed to operate the geofence."),
        (3301601, "The number of geofences exceeds the maximum."),
        (3301602, "Failed to delete a geofence due to an incorrect ID."),
        (3301700, "No response to the request."),
        (3301800, "Failed to start WiFi or Bluetooth scanning.")
    ]
)

func getErrorMsg(code: Int32): String {
    let errorCode = getErrorCode(code)
    if (let Some(v) <- getUniversalErrorMsg(errorCode)) {
        return v
    } else if (ERROR_CODE_MAP.contains(errorCode)) {
        return ERROR_CODE_MAP[errorCode]
    } else {
        return "Unknown error code ${errorCode}"
    }
}
