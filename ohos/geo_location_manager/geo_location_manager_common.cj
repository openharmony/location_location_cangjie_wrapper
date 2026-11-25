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
import std.deriving.Derive

const LOG_CORE: UInt32 = 3
const LOCATION_LOG_DOMAIN: UInt32 = 0xD002300
let GEO_LOCATION_MANAGER_LOG = HilogChannel(LOG_CORE, LOCATION_LOG_DOMAIN, "CJ-GeoLocationManager")

@!Hide[isChecked: true]
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
    @!Hide[isChecked: true]
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
    @!Hide[isChecked: true]
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

    @!Hide[isChecked: true]
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
 * Satellite status information.
 */
@!APILevel[
    since: "26.1.0",
    syscap: "SystemCapability.Location.Location.Gnss"
]
public class SatelliteStatusInfo {
    private let satelliteStatusInfoImpl: SatelliteStatusInfoImpl

    /**
     * Number of satellites.
     */
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.Location.Location.Gnss"
    ]
    public mut prop satellitesNumber: Int32 {
        get() {
            satelliteStatusInfoImpl.satellitesNumber
        }
        set(v) {
            satelliteStatusInfoImpl.satellitesNumber = v
        }
    }
    /**
     * Satellite ID array.
     */
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.Location.Location.Gnss"
    ]
    public mut prop satelliteIds: Array<Int32> {
        get() {
            satelliteStatusInfoImpl.satelliteIds
        }
        set(v) {
            satelliteStatusInfoImpl.satelliteIds = v
        }
    }
    /**
     * Carrier to noise density array.
     */
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.Location.Location.Gnss"
    ]
    public mut prop carrierToNoiseDensitys: Array<Float64> {
        get() {
            satelliteStatusInfoImpl.carrierToNoiseDensitys
        }
        set(v) {
            satelliteStatusInfoImpl.carrierToNoiseDensitys = v
        }
    }
    /**
     * Satellite altitude array.
     */
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.Location.Location.Gnss"
    ]
    public mut prop altitudes: Array<Float64> {
        get() {
            satelliteStatusInfoImpl.altitudes
        }
        set(v) {
            satelliteStatusInfoImpl.altitudes = v
        }
    }
    /**
     * Satellite azimuth array.
     */
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.Location.Location.Gnss"
    ]
    public mut prop azimuths: Array<Float64> {
        get() {
            satelliteStatusInfoImpl.azimuths
        }
        set(v) {
            satelliteStatusInfoImpl.azimuths = v
        }
    }
    /**
     * Satellite carrier frequency array.
     */
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.Location.Location.Gnss"
    ]
    public mut prop carrierFrequencies: Array<Float64> {
        get() {
            satelliteStatusInfoImpl.carrierFrequencies
        }
        set(v) {
            satelliteStatusInfoImpl.carrierFrequencies = v
        }
    }
    /**
     * Satellite constellation type array.
     */
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.Location.Location.Gnss"
    ]
    public mut prop satelliteConstellation: ?Array<SatelliteConstellationCategory> {
        get() {
            satelliteStatusInfoImpl.satelliteConstellation
        }
        set(v) {
            satelliteStatusInfoImpl.satelliteConstellation = v
        }
    }
    /**
     * Satellite additional information array.
     */
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.Location.Location.Gnss"
    ]
    public mut prop satelliteAdditionalInfo: ?Array<Int32> {
        get() {
            satelliteStatusInfoImpl.satelliteAdditionalInfo
        }
        set(v) {
            satelliteStatusInfoImpl.satelliteAdditionalInfo = v
        }
    }

    init(satellitesNumber: Int32, satelliteIds: Array<Int32>, carrierToNoiseDensitys: Array<Float64>,
        altitudes: Array<Float64>, azimuths: Array<Float64>, carrierFrequencies: Array<Float64>,
        satelliteConstellation: ?Array<SatelliteConstellationCategory>, satelliteAdditionalInfo: ?Array<Int32>) {
        satelliteStatusInfoImpl = SatelliteStatusInfoImpl(satellitesNumber, satelliteIds, carrierToNoiseDensitys,
            altitudes, azimuths, carrierFrequencies, satelliteConstellation, satelliteAdditionalInfo)
    }
}

class SatelliteStatusInfoImpl {
    var satellitesNumber: Int32
    var satelliteIds: Array<Int32>
    var carrierToNoiseDensitys: Array<Float64>
    var altitudes: Array<Float64>
    var azimuths: Array<Float64>
    var carrierFrequencies: Array<Float64>
    var satelliteConstellation: ?Array<SatelliteConstellationCategory>
    var satelliteAdditionalInfo: ?Array<Int32>

    init(satellitesNumber: Int32, satelliteIds: Array<Int32>, carrierToNoiseDensitys: Array<Float64>,
        altitudes: Array<Float64>, azimuths: Array<Float64>, carrierFrequencies: Array<Float64>,
        satelliteConstellation: ?Array<SatelliteConstellationCategory>, satelliteAdditionalInfo: ?Array<Int32>) {
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
 * Enum for satellite constellation category.
 */
@Derive[ToString, Equatable]
@!APILevel[
    since: "26.1.0",
    syscap: "SystemCapability.Location.Location.Gnss"
]
public enum SatelliteConstellationCategory {
    /**
     * Invalid value.
     */
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.Location.Location.Gnss"
    ]
    ConstellationCategoryUnknown
    |
    /**
     * GPS.
     */
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.Location.Location.Gnss"
    ]
    ConstellationCategoryGps
    |
    /**
     * SBAS.
     */
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.Location.Location.Gnss"
    ]
    ConstellationCategorySbas
    |
    /**
     * GLONASS.
     */
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.Location.Location.Gnss"
    ]
    ConstellationCategoryGlonass
    |
    /**
     * QZSS.
     */
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.Location.Location.Gnss"
    ]
    ConstellationCategoryQzss
    |
    /**
     * BEIDOU.
     */
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.Location.Location.Gnss"
    ]
    ConstellationCategoryBeidou
    |
    /**
     * GALILEO.
     */
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.Location.Location.Gnss"
    ]
    ConstellationCategoryGalileo
    |
    /**
     * IRNSS.
     */
    @!APILevel[
        since: "26.1.0",
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

/**
 * Configuring parameters in reverse geocode requests.
 */
@!APILevel[
    since: "26.1.0",
    syscap: "SystemCapability.Location.Location.Geocoder"
]
public class ReverseGeoCodeRequest {
    private let reverseGeoCodeRequestImpl: ReverseGeoCodeRequestImpl

    /**
     * Indicates the language area information.
     */
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.Location.Location.Geocoder"
    ]
    public mut prop locale: ?String {
        get() {
            reverseGeoCodeRequestImpl.locale
        }
        set(v) {
            reverseGeoCodeRequestImpl.locale = v
        }
    }
    /**
     * Indicates the country information.
     */
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.Location.Location.Geocoder"
    ]
    public mut prop country: ?String {
        get() {
            reverseGeoCodeRequestImpl.country
        }
        set(v) {
            reverseGeoCodeRequestImpl.country = v
        }
    }
    /**
     * Latitude for reverse geocoding query.
     */
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.Location.Location.Geocoder"
    ]
    public mut prop latitude: Float64 {
        get() {
            reverseGeoCodeRequestImpl.latitude
        }
        set(v) {
            reverseGeoCodeRequestImpl.latitude = v
        }
    }
    /**
     * Longitude for reverse geocoding query.
     */
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.Location.Location.Geocoder"
    ]
    public mut prop longitude: Float64 {
        get() {
            reverseGeoCodeRequestImpl.longitude
        }
        set(v) {
            reverseGeoCodeRequestImpl.longitude = v
        }
    }
    /**
     * Indicates the maximum number of addresses returned by reverse geocoding query.
     */
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.Location.Location.Geocoder"
    ]
    public mut prop maxItems: ?Int32 {
        get() {
            reverseGeoCodeRequestImpl.maxItems
        }
        set(v) {
            reverseGeoCodeRequestImpl.maxItems = v
        }
    }

    /**
     * ReverseGeoCodeRequest Constructor.
     *
     * @param { Float64 } latitude - Latitude for reverse geocoding query.
     * @param { Float64 } longitude - Longitude for reverse geocoding query.
     * @param { ?String } [locale] - Indicates the language area information. If this parameter is not specified,
     *     the system language is used.
     * @param { ?String } [country] - Indicates the country information. If this parameter is not specified,
     *     the system region is used.
     * @param { ?Int32 } [maxItems] - The maximum number of addresses returned by reverse geocoding query.
     *     The default value is 1.
     */
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.Location.Location.Geocoder"
    ]
    public init(latitude: Float64, longitude: Float64, locale!: ?String = None, country!: ?String = None,
        maxItems!: ?Int32 = None) {
        reverseGeoCodeRequestImpl = ReverseGeoCodeRequestImpl(latitude, longitude, locale: locale,
            country: country, maxItems: maxItems)
    }
}

class ReverseGeoCodeRequestImpl {
    var locale: ?String
    var country: ?String
    var latitude: Float64
    var longitude: Float64
    var maxItems: ?Int32

    init(latitude: Float64, longitude: Float64, locale!: ?String = None, country!: ?String = None,
        maxItems!: ?Int32 = None) {
        this.latitude = latitude
        this.longitude = longitude
        this.locale = locale
        this.country = country
        this.maxItems = maxItems
    }
}

/**
 * Configuring parameters in geocode requests.
 */
@!APILevel[
    since: "26.1.0",
    syscap: "SystemCapability.Location.Location.Geocoder"
]
public class GeoCodeRequest {
    private let geoCodeRequestImpl: GeoCodeRequestImpl

    /**
     * Indicates the language area information.
     */
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.Location.Location.Geocoder"
    ]
    public mut prop locale: ?String {
        get() {
            geoCodeRequestImpl.locale
        }
        set(v) {
            geoCodeRequestImpl.locale = v
        }
    }
    /**
     * Indicates the country information.
     */
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.Location.Location.Geocoder"
    ]
    public mut prop country: ?String {
        get() {
            geoCodeRequestImpl.country
        }
        set(v) {
            geoCodeRequestImpl.country = v
        }
    }
    /**
     * Address information.
     */
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.Location.Location.Geocoder"
    ]
    public mut prop description: String {
        get() {
            geoCodeRequestImpl.description
        }
        set(v) {
            geoCodeRequestImpl.description = v
        }
    }
    /**
     * Indicates the maximum number of geocode query results.
     */
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.Location.Location.Geocoder"
    ]
    public mut prop maxItems: ?Int32 {
        get() {
            geoCodeRequestImpl.maxItems
        }
        set(v) {
            geoCodeRequestImpl.maxItems = v
        }
    }
    /**
     * Indicates the minimum latitude for geocoding query results.
     */
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.Location.Location.Geocoder"
    ]
    public mut prop minLatitude: ?Float64 {
        get() {
            geoCodeRequestImpl.minLatitude
        }
        set(v) {
            geoCodeRequestImpl.minLatitude = v
        }
    }
    /**
     * Indicates the minimum longitude for geocoding query results.
     */
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.Location.Location.Geocoder"
    ]
    public mut prop minLongitude: ?Float64 {
        get() {
            geoCodeRequestImpl.minLongitude
        }
        set(v) {
            geoCodeRequestImpl.minLongitude = v
        }
    }
    /**
     * Indicates the maximum latitude for geocoding query results.
     */
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.Location.Location.Geocoder"
    ]
    public mut prop maxLatitude: ?Float64 {
        get() {
            geoCodeRequestImpl.maxLatitude
        }
        set(v) {
            geoCodeRequestImpl.maxLatitude = v
        }
    }
    /**
     * Indicates the maximum longitude for geocoding query results.
     */
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.Location.Location.Geocoder"
    ]
    public mut prop maxLongitude: ?Float64 {
        get() {
            geoCodeRequestImpl.maxLongitude
        }
        set(v) {
            geoCodeRequestImpl.maxLongitude = v
        }
    }

    /**
     * GeoCodeRequest Constructor.
     *
     * @param { String } description - Address information.
     * @param { ?String } [locale] - Indicates the language area information. If this parameter is not specified,
     *     the system language is used.
     * @param { ?String } [country] - Indicates the country information. If this parameter is not specified,
     *     the system region is used.
     * @param { ?Int32 } [maxItems] - The maximum number of geocode query results. The default value is 1.
     * @param { ?Float64 } [minLatitude] - The minimum latitude for geocoding query results. The default value is -90.0.
     * @param { ?Float64 } [minLongitude] - The minimum longitude for geocoding query results. The default value is -180.0.
     * @param { ?Float64 } [maxLatitude] - The maximum latitude for geocoding query results. The default value is 90.0.
     * @param { ?Float64 } [maxLongitude] - The maximum longitude for geocoding query results. The default value is 180.0.
     */
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.Location.Location.Geocoder"
    ]
    public init(description: String, locale!: ?String = None, country!: ?String = None, maxItems!: ?Int32 = None,
        minLatitude!: ?Float64 = None, minLongitude!: ?Float64 = None, maxLatitude!: ?Float64 = None,
        maxLongitude!: ?Float64 = None) {
        geoCodeRequestImpl = GeoCodeRequestImpl(description, locale: locale, country: country,
            maxItems: maxItems, minLatitude: minLatitude, minLongitude: minLongitude,
            maxLatitude: maxLatitude, maxLongitude: maxLongitude)
    }
}

class GeoCodeRequestImpl {
    var locale: ?String
    var country: ?String
    var description: String
    var maxItems: ?Int32
    var minLatitude: ?Float64
    var minLongitude: ?Float64
    var maxLatitude: ?Float64
    var maxLongitude: ?Float64

    init(description: String, locale!: ?String = None, country!: ?String = None, maxItems!: ?Int32 = None,
        minLatitude!: ?Float64 = None, minLongitude!: ?Float64 = None, maxLatitude!: ?Float64 = None,
        maxLongitude!: ?Float64 = None) {
        this.description = description
        this.locale = locale
        this.country = country
        this.maxItems = maxItems
        this.minLatitude = minLatitude
        this.minLongitude = minLongitude
        this.maxLatitude = maxLatitude
        this.maxLongitude = maxLongitude
    }
}

/**
 * Data struct describes geographic locations.
 */
@!APILevel[
    since: "26.1.0",
    syscap: "SystemCapability.Location.Location.Geocoder"
]
public class GeoAddress {
    private let geoAddressImpl: GeoAddressImpl

    /**
     * Indicates latitude information.
     */
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.Location.Location.Geocoder"
    ]
    public mut prop latitude: ?Float64 {
        get() {
            geoAddressImpl.latitude
        }
        set(v) {
            geoAddressImpl.latitude = v
        }
    }
    /**
     * Indicates longitude information.
     */
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.Location.Location.Geocoder"
    ]
    public mut prop longitude: ?Float64 {
        get() {
            geoAddressImpl.longitude
        }
        set(v) {
            geoAddressImpl.longitude = v
        }
    }
    /**
     * Indicates language used for the location description.
     */
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.Location.Location.Geocoder"
    ]
    public mut prop locale: ?String {
        get() {
            geoAddressImpl.locale
        }
        set(v) {
            geoAddressImpl.locale = v
        }
    }
    /**
     * Indicates detailed address information.
     */
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.Location.Location.Geocoder"
    ]
    public mut prop placeName: ?String {
        get() {
            geoAddressImpl.placeName
        }
        set(v) {
            geoAddressImpl.placeName = v
        }
    }
    /**
     * Indicates country code.
     */
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.Location.Location.Geocoder"
    ]
    public mut prop countryCode: ?String {
        get() {
            geoAddressImpl.countryCode
        }
        set(v) {
            geoAddressImpl.countryCode = v
        }
    }
    /**
     * Indicates country name.
     */
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.Location.Location.Geocoder"
    ]
    public mut prop countryName: ?String {
        get() {
            geoAddressImpl.countryName
        }
        set(v) {
            geoAddressImpl.countryName = v
        }
    }
    /**
     * Indicates administrative region name.
     */
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.Location.Location.Geocoder"
    ]
    public mut prop administrativeArea: ?String {
        get() {
            geoAddressImpl.administrativeArea
        }
        set(v) {
            geoAddressImpl.administrativeArea = v
        }
    }
    /**
     * Indicates sub-administrative region name.
     */
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.Location.Location.Geocoder"
    ]
    public mut prop subAdministrativeArea: ?String {
        get() {
            geoAddressImpl.subAdministrativeArea
        }
        set(v) {
            geoAddressImpl.subAdministrativeArea = v
        }
    }
    /**
     * Indicates locality information.
     */
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.Location.Location.Geocoder"
    ]
    public mut prop locality: ?String {
        get() {
            geoAddressImpl.locality
        }
        set(v) {
            geoAddressImpl.locality = v
        }
    }
    /**
     * Indicates sub-locality information.
     */
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.Location.Location.Geocoder"
    ]
    public mut prop subLocality: ?String {
        get() {
            geoAddressImpl.subLocality
        }
        set(v) {
            geoAddressImpl.subLocality = v
        }
    }
    /**
     * Indicates road name.
     */
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.Location.Location.Geocoder"
    ]
    public mut prop roadName: ?String {
        get() {
            geoAddressImpl.roadName
        }
        set(v) {
            geoAddressImpl.roadName = v
        }
    }
    /**
     * Indicates auxiliary road information.
     */
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.Location.Location.Geocoder"
    ]
    public mut prop subRoadName: ?String {
        get() {
            geoAddressImpl.subRoadName
        }
        set(v) {
            geoAddressImpl.subRoadName = v
        }
    }
    /**
     * Indicates house information.
     */
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.Location.Location.Geocoder"
    ]
    public mut prop premises: ?String {
        get() {
            geoAddressImpl.premises
        }
        set(v) {
            geoAddressImpl.premises = v
        }
    }
    /**
     * Indicates postal code.
     */
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.Location.Location.Geocoder"
    ]
    public mut prop postalCode: ?String {
        get() {
            geoAddressImpl.postalCode
        }
        set(v) {
            geoAddressImpl.postalCode = v
        }
    }
    /**
     * Indicates phone number.
     */
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.Location.Location.Geocoder"
    ]
    public mut prop phoneNumber: ?String {
        get() {
            geoAddressImpl.phoneNumber
        }
        set(v) {
            geoAddressImpl.phoneNumber = v
        }
    }
    /**
     * Indicates website URL.
     */
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.Location.Location.Geocoder"
    ]
    public mut prop addressUrl: ?String {
        get() {
            geoAddressImpl.addressUrl
        }
        set(v) {
            geoAddressImpl.addressUrl = v
        }
    }
    /**
     * Indicates additional information.
     */
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.Location.Location.Geocoder"
    ]
    public mut prop descriptions: ?Array<String> {
        get() {
            geoAddressImpl.descriptions
        }
        set(v) {
            geoAddressImpl.descriptions = v
        }
    }
    /**
     * Indicates the amount of additional descriptive information.
     */
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.Location.Location.Geocoder"
    ]
    public mut prop descriptionsSize: ?Int32 {
        get() {
            geoAddressImpl.descriptionsSize
        }
        set(v) {
            geoAddressImpl.descriptionsSize = v
        }
    }

    init(latitude: ?Float64, longitude: ?Float64, locale: ?String, placeName: ?String, countryCode: ?String,
        countryName: ?String, administrativeArea: ?String, subAdministrativeArea: ?String, locality: ?String,
        subLocality: ?String, roadName: ?String, subRoadName: ?String, premises: ?String, postalCode: ?String,
        phoneNumber: ?String, addressUrl: ?String, descriptions: ?Array<String>, descriptionsSize: ?Int32) {
        geoAddressImpl = GeoAddressImpl(latitude, longitude, locale, placeName, countryCode, countryName,
            administrativeArea, subAdministrativeArea, locality, subLocality, roadName, subRoadName, premises,
            postalCode, phoneNumber, addressUrl, descriptions, descriptionsSize)
    }
}

class GeoAddressImpl {
    var latitude: ?Float64
    var longitude: ?Float64
    var locale: ?String
    var placeName: ?String
    var countryCode: ?String
    var countryName: ?String
    var administrativeArea: ?String
    var subAdministrativeArea: ?String
    var locality: ?String
    var subLocality: ?String
    var roadName: ?String
    var subRoadName: ?String
    var premises: ?String
    var postalCode: ?String
    var phoneNumber: ?String
    var addressUrl: ?String
    var descriptions: ?Array<String>
    var descriptionsSize: ?Int32

    init(latitude: ?Float64, longitude: ?Float64, locale: ?String, placeName: ?String, countryCode: ?String,
        countryName: ?String, administrativeArea: ?String, subAdministrativeArea: ?String, locality: ?String,
        subLocality: ?String, roadName: ?String, subRoadName: ?String, premises: ?String, postalCode: ?String,
        phoneNumber: ?String, addressUrl: ?String, descriptions: ?Array<String>, descriptionsSize: ?Int32) {
        this.latitude = latitude
        this.longitude = longitude
        this.locale = locale
        this.placeName = placeName
        this.countryCode = countryCode
        this.countryName = countryName
        this.administrativeArea = administrativeArea
        this.subAdministrativeArea = subAdministrativeArea
        this.locality = locality
        this.subLocality = subLocality
        this.roadName = roadName
        this.subRoadName = subRoadName
        this.premises = premises
        this.postalCode = postalCode
        this.phoneNumber = phoneNumber
        this.addressUrl = addressUrl
        this.descriptions = descriptions
        this.descriptionsSize = descriptionsSize
    }
}

/**
 * Configuring parameters in location requests.
 */
@!APILevel[
    since: "26.1.0",
    syscap: "SystemCapability.Location.Location.Core"
]
public class LocationRequest {
    private let locationRequestImpl: LocationRequestImpl

    /**
     * Priority of the location request.
     */
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.Location.Location.Core"
    ]
    public mut prop priority: ?LocationRequestPriority {
        get() {
            locationRequestImpl.priority
        }
        set(v) {
            locationRequestImpl.priority = v
        }
    }
    /**
     * User scenario of the location request.
     */
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.Location.Location.Core"
    ]
    public mut prop scenario: ?LocationRequestScenario {
        get() {
            locationRequestImpl.scenario
        }
        set(v) {
            locationRequestImpl.scenario = v
        }
    }
    /**
     * Location report interval.
     */
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.Location.Location.Core"
    ]
    public mut prop timeInterval: ?Int32 {
        get() {
            locationRequestImpl.timeInterval
        }
        set(v) {
            locationRequestImpl.timeInterval = v
        }
    }
    /**
     * Location report distance interval.
     */
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.Location.Location.Core"
    ]
    public mut prop distanceInterval: ?Float64 {
        get() {
            locationRequestImpl.distanceInterval
        }
        set(v) {
            locationRequestImpl.distanceInterval = v
        }
    }
    /**
     * Accuracy requirements for reporting locations.
     */
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.Location.Location.Core"
    ]
    public mut prop maxAccuracy: ?Float32 {
        get() {
            locationRequestImpl.maxAccuracy
        }
        set(v) {
            locationRequestImpl.maxAccuracy = v
        }
    }

    /**
     * LocationRequest Constructor.
     *
     * @param { ?LocationRequestPriority } [priority] - The priority of the location request. The default value is FirstFix.
     * @param { ?LocationRequestScenario } [scenario] - The user scenario of the location request. The default value is Unset.
     * @param { ?Int32 } [timeInterval] - The location report interval, in seconds. The default value is 1.
     * @param { ?Float64 } [distanceInterval] - The location report distance interval. The default value is 0.0.
     * @param { ?Float32 } [maxAccuracy] - The accuracy requirements for reporting locations. The default value is 0.0.
     */
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.Location.Location.Core"
    ]
    public init(priority!: ?LocationRequestPriority = None,
        scenario!: ?LocationRequestScenario = None, timeInterval!: ?Int32 = None,
        distanceInterval!: ?Float64 = None, maxAccuracy!: ?Float32 = None) {
        locationRequestImpl = LocationRequestImpl(priority: priority, scenario: scenario,
            timeInterval: timeInterval, distanceInterval: distanceInterval, maxAccuracy: maxAccuracy)
    }
}

class LocationRequestImpl {
    var priority: ?LocationRequestPriority
    var scenario: ?LocationRequestScenario
    var timeInterval: ?Int32
    var distanceInterval: ?Float64
    var maxAccuracy: ?Float32

    init(priority!: ?LocationRequestPriority = None,
        scenario!: ?LocationRequestScenario = None, timeInterval!: ?Int32 = None,
        distanceInterval!: ?Float64 = None, maxAccuracy!: ?Float32 = None) {
        this.priority = priority
        this.scenario = scenario
        this.timeInterval = timeInterval
        this.distanceInterval = distanceInterval
        this.maxAccuracy = maxAccuracy
    }
}

/**
 * Configuring parameters in continuous location requests.
 */
@!APILevel[
    since: "26.1.0",
    syscap: "SystemCapability.Location.Location.Core"
]
public class ContinuousLocationRequest {
    private let continuousLocationRequestImpl: ContinuousLocationRequestImpl

    /**
     * Location report interval, in seconds.
     */
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.Location.Location.Core"
    ]
    public mut prop interval: Int32 {
        get() {
            continuousLocationRequestImpl.interval
        }
        set(v) {
            continuousLocationRequestImpl.interval = v
        }
    }
    /**
     * Location scenario. You can select a user activity scenario or power consumption scenario.
     */
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.Location.Location.Core"
    ]
    public mut prop locationScenario: ScenarioValueType {
        get() {
            continuousLocationRequestImpl.locationScenario
        }
        set(v) {
            continuousLocationRequestImpl.locationScenario = v
        }
    }

    /**
     * ContinuousLocationRequest Constructor.
     *
     * @param { Int32 } interval - The location report interval, in seconds.
     * @param { ScenarioValueType } locationScenario - The location scenario, which is a user activity
     *     scenario or a power consumption scenario.
     */
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.Location.Location.Core"
    ]
    public init(interval: Int32, locationScenario: ScenarioValueType) {
        continuousLocationRequestImpl = ContinuousLocationRequestImpl(interval, locationScenario)
    }
}

class ContinuousLocationRequestImpl {
    var interval: Int32
    var locationScenario: ScenarioValueType

    init(interval: Int32, locationScenario: ScenarioValueType) {
        this.interval = interval
        this.locationScenario = locationScenario
    }
}

/**
 * Indicates the location scenario type.
 *
 * It is used as the locationScenario parameter of ContinuousLocationRequest. You can select a user
 *     activity scenario or a power consumption scenario.
 */
@Derive[ToString, Equatable]
@!APILevel[
    since: "26.1.0",
    syscap: "SystemCapability.Location.Location.Core"
]
public enum ScenarioValueType {
    /**
     * Represents the user activity scenario.
     */
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.Location.Location.Core"
    ]
    UserActivityScenarioValue(UserActivityScenario)
    |
    /**
     * Represents the power consumption scenario.
     */
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.Location.Location.Core"
    ]
    PowerConsumptionScenarioValue(PowerConsumptionScenario)
    | ...

    func getValue(): Int32 {
        match (this) {
            case UserActivityScenarioValue(value) => value.getValue()
            case PowerConsumptionScenarioValue(value) => value.getValue()
            case _ => throw BusinessException(3301000, "The type is not supported yet.")
        }
    }
}

/**
 * Enum for coordinate system type.
 */
@Derive[ToString, Equatable]
@!APILevel[
    since: "26.1.0",
    syscap: "SystemCapability.Location.Location.Geofence"
]
public enum CoordinateSystemType {
    /**
     * WGS84 coordinates system.
     */
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.Location.Location.Geofence"
    ]
    Wgs84
    |
    /**
     * GCJ-02 coordinates system.
     */
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.Location.Location.Geofence"
    ]
    Gcj02
    | ...

    static func parse(value: Int32): CoordinateSystemType {
        match (value) {
            case 1 => Wgs84
            case 2 => Gcj02
            case _ => throw BusinessException(3301000, "The type is not supported yet.")
        }
    }

    func getValue(): Int32 {
        match (this) {
            case Wgs84 => 1
            case Gcj02 => 2
            case _ => throw BusinessException(3301000, "The type is not supported yet.")
        }
    }
}

/**
 * Enum for location error code.
 */
@Derive[ToString, Equatable]
@!APILevel[
    since: "26.1.0",
    syscap: "SystemCapability.Location.Location.Core"
]
public enum LocationError {
    /**
     * Default cause for location failure.
     */
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.Location.Location.Core"
    ]
    LocatingFailedDefault
    |
    /**
     * Locating failed because the location permission fails to be verified.
     */
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.Location.Location.Core"
    ]
    LocatingFailedLocationPermissionDenied
    |
    /**
     * Locating failed because the app is in the background and the background location permission
     * verification failed.
     */
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.Location.Location.Core"
    ]
    LocatingFailedBackgroundPermissionDenied
    |
    /**
     * Locating failed because the location switch is turned off.
     */
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.Location.Location.Core"
    ]
    LocatingFailedLocationSwitchOff
    |
    /**
     * Locating failed because internet access failure.
     */
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.Location.Location.Core"
    ]
    LocatingFailedInternetAccessFailure
    | ...

    static func parse(value: Int32): LocationError {
        match (value) {
            case -1 => LocatingFailedDefault
            case -2 => LocatingFailedLocationPermissionDenied
            case -3 => LocatingFailedBackgroundPermissionDenied
            case -4 => LocatingFailedLocationSwitchOff
            case -5 => LocatingFailedInternetAccessFailure
            case _ => throw BusinessException(3301000, "The type is not supported yet.")
        }
    }

    func getValue(): Int32 {
        match (this) {
            case LocatingFailedDefault => -1
            case LocatingFailedLocationPermissionDenied => -2
            case LocatingFailedBackgroundPermissionDenied => -3
            case LocatingFailedLocationSwitchOff => -4
            case LocatingFailedInternetAccessFailure => -5
            case _ => throw BusinessException(3301000, "The type is not supported yet.")
        }
    }
}

/**
 * Enum for user activity scenario.
 */
@Derive[ToString, Equatable]
@!APILevel[
    since: "26.1.0",
    syscap: "SystemCapability.Location.Location.Core"
]
public enum UserActivityScenario {
    /**
     * Navigation scenario. High positioning precision and real-time performance are required.
     */
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.Location.Location.Core"
    ]
    Navigation
    |
    /**
     * Sport scenario. High positioning precision is required.
     */
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.Location.Location.Core"
    ]
    Sport
    |
    /**
     * Transport scenario. High positioning precision and real-time performance are required.
     */
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.Location.Location.Core"
    ]
    Transport
    |
    /**
     * Daily life scenarios. Low requirements on positioning precision.
     */
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.Location.Location.Core"
    ]
    DailyLifeService
    | ...

    func getValue(): Int32 {
        match (this) {
            case Navigation => 0x401
            case Sport => 0x402
            case Transport => 0x403
            case DailyLifeService => 0x404
            case _ => throw BusinessException(3301000, "The type is not supported yet.")
        }
    }
}

/**
 * Enum for power consumption scenario.
 */
@Derive[ToString, Equatable]
@!APILevel[
    since: "26.1.0",
    syscap: "SystemCapability.Location.Location.Core"
]
public enum PowerConsumptionScenario {
    /**
     * High power consumption mode.
     */
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.Location.Location.Core"
    ]
    HighPowerConsumption
    |
    /**
     * Low power consumption mode.
     */
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.Location.Location.Core"
    ]
    LowPowerConsumption
    |
    /**
     * Power saving scenarios.
     */
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.Location.Location.Core"
    ]
    NoPowerConsumption
    | ...

    func getValue(): Int32 {
        match (this) {
            case HighPowerConsumption => 0x601
            case LowPowerConsumption => 0x602
            case NoPowerConsumption => 0x603
            case _ => throw BusinessException(3301000, "The type is not supported yet.")
        }
    }
}

/**
 * Location subsystem command structure.
 */
@!APILevel[
    since: "26.1.0",
    syscap: "SystemCapability.Location.Location.Core"
]
public class LocationCommand {
    private let locationCommandImpl: LocationCommandImpl

    /**
     * Information about the scenario where the command is sent.
     */
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.Location.Location.Core"
    ]
    public mut prop scenario: LocationRequestScenario {
        get() {
            locationCommandImpl.scenario
        }
        set(v) {
            locationCommandImpl.scenario = v
        }
    }
    /**
     * Sent command content.
     */
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.Location.Location.Core"
    ]
    public mut prop command: String {
        get() {
            locationCommandImpl.command
        }
        set(v) {
            locationCommandImpl.command = v
        }
    }

    /**
     * LocationCommand constructor.
     *
     * @param { LocationRequestScenario } scenario - Information about the scenario where the command is sent.
     * @param { String } command - Sent command content.
     */
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.Location.Location.Core"
    ]
    public init(scenario: LocationRequestScenario, command: String) {
        locationCommandImpl = LocationCommandImpl(scenario, command)
    }
}

class LocationCommandImpl {
    var scenario: LocationRequestScenario
    var command: String

    init(scenario: LocationRequestScenario, command: String) {
        this.scenario = scenario
        this.command = command
    }
}

/**
 * Country code structure.
 */
@!APILevel[
    since: "26.1.0",
    syscap: "SystemCapability.Location.Location.Core"
]
public class CountryCode {
    private let countryCodeImpl: CountryCodeImpl

    /**
     * Country code character string.
     */
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.Location.Location.Core"
    ]
    public mut prop country: String {
        get() {
            countryCodeImpl.country
        }
        set(v) {
            countryCodeImpl.country = v
        }
    }
    /**
     * Country code source.
     */
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.Location.Location.Core"
    ]
    public mut prop countryCodeType: CountryCodeType {
        get() {
            countryCodeImpl.countryCodeType
        }
        set(v) {
            countryCodeImpl.countryCodeType = v
        }
    }

    init(country: String, countryCodeType: CountryCodeType) {
        countryCodeImpl = CountryCodeImpl(country, countryCodeType)
    }
}

class CountryCodeImpl {
    var country: String
    var countryCodeType: CountryCodeType

    init(country: String, countryCodeType: CountryCodeType) {
        this.country = country
        this.countryCodeType = countryCodeType
    }
}

/**
 * Enum for country code type.
 */
@Derive[ToString, Equatable]
@!APILevel[
    since: "26.1.0",
    syscap: "SystemCapability.Location.Location.Core"
]
public enum CountryCodeType {
    /**
     * Country code obtained from the locale setting.
     */
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.Location.Location.Core"
    ]
    CountryCodeFromLocale
    |
    /**
     * Country code obtained from the SIM information.
     */
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.Location.Location.Core"
    ]
    CountryCodeFromSim
    |
    /**
     * Query the country code information from the reverse geocoding result.
     */
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.Location.Location.Core"
    ]
    CountryCodeFromLocation
    |
    /**
     * Obtain the country code from the cell registration information.
     */
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.Location.Location.Core"
    ]
    CountryCodeFromNetwork
    | ...

    static func parse(value: Int32): CountryCodeType {
        match (value) {
            case 1 => CountryCodeFromLocale
            case 2 => CountryCodeFromSim
            case 3 => CountryCodeFromLocation
            case 4 => CountryCodeFromNetwork
            case _ => throw BusinessException(3301000, "The type is not supported yet.")
        }
    }

    func getValue(): Int32 {
        match (this) {
            case CountryCodeFromLocale => 1
            case CountryCodeFromSim => 2
            case CountryCodeFromLocation => 3
            case CountryCodeFromNetwork => 4
            case _ => throw BusinessException(3301000, "The type is not supported yet.")
        }
    }
}
