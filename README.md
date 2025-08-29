# location_cangjie_wrapper

## Introduction

The location_cangjie_wrapper is a Cangjie API encapsulated on OpenHarmony based on the capabilities of the Location Subsystem. People take their mobile devices wherever they go. Mobile devices have become a necessity in people's daily routines, whether it be for looking at the weather forecast, browsing news, hailing a taxi, navigating, or recording data from a workout. All these activities are so much associated with the location services on mobile devices.

With the location awareness capability offered by OpenHarmony, mobile devices will be able to obtain real-time, accurate location data. Building location awareness into your application can also lead to a better contextual experience for application users.

Your application can call location-specific APIs to obtain the location information of a mobile device for offering location-based services such as drive navigation and motion track recording.

**Basic Concepts**

Location awareness helps determine where a mobile device locates. The system identifies the location of a mobile device with its coordinates, and uses location technologies such as Global Navigation Satellite System (GNSS) and network positioning (for example, base station positioning or WLAN/Bluetooth positioning) to provide diverse location-based services. These advanced location technologies make it possible to obtain the accurate location of the mobile device, regardless of whether it is indoors or outdoors.

-   **Coordinate**

    A coordinate describes a location on the earth using the longitude and latitude in reference to the World Geodetic Coordinate System 1984.

-   **GNSS positioning**

    GNSS positioning locates a mobile device by using the location algorithm offered by the device chip to compute the location information provided by the Global Navigation Satellite System, for example, GPS, GLONASS, BeiDou, and Galileo. Whichever positioning system will be used during the location process depends on a hardware capability of the device.

-   **Base station positioning**

    Base station positioning estimates the current location of a mobile device based on the location of the resident base station in reference to the neighboring base stations. This technology provides only a low accuracy and requires access to the cellular network.

-   **WLAN or Bluetooth positioning**

    WLAN or Bluetooth positioning estimates the current location of a mobile device based on the locations of WLANs and Bluetooth devices that can be discovered by the device. The location accuracy of this technology depends on the distribution of fixed WLAN access points (APs) and Bluetooth devices around the device. A high density of WLAN APs and Bluetooth devices can produce a more accurate location result than base station positioning. This technology also requires access to the network.

**Figure 1** location_cangjie_wrapper architecture**  

![](figures/location_cangjie_wrapper_architecture_en.png)

## Directory Structure

```
base/location/location_cangjie_wrapper
├── ohos             # Cangjie Location code
├── kit              # Cangjie kit code
├── figures          # architecture pictures
```

## Constraints

The currently open position service Cangjie interface supports only standard devices.

Your application can use the location function only after the user has granted the permission and turned on the function. If the location function is off, the system will not provide the location service for any application.

Since the location information is considered sensitive, your application still needs to obtain the location access permission from the user even if the user has turned on the location function. The system will provide the location service for your application only after it has been granted the permission to access the device location information.

## Usage

The following location service functions have been provided:

- Obtains the current location.
- Checks whether the location service is enabled.

Compared to arkts, the following functionalities are currently not supported:

- Registers a listener for location changes with a location request initiated.
- Unregisters the listener for location changes with the corresponding location request deleted.
- Registers a listener for location service status change events.
- Unregisters the listener for location service status change events.
- Registers a listener for cached GNSS location reports.
- Unregisters the listener for cached GNSS location reports.
- Registers a listener for satellite status change events.
- Unregisters the listener for satellite status change events.
- Registers a listener for GNSS NMEA message change events.
- Unregisters the listener for GNSS NMEA message change events.
- Registers a listener for status change events of the specified geofence.
- Unregisters the listener for status change events of the specified geofence.
- Obtains the previous location.
- Requests to enable the location service. 
- Enables the location service.
- Disables the location service. 
- Obtains the number of cached GNSS locations.
- Obtains all cached GNSS locations and clears the GNSS cache queue. 
- Sends extended commands to the location subsystem. 
- Checks whether a user agrees with the privacy statement of the location service. 
- Sets the user confirmation status for the privacy statement of the location service.

For APIs related to location, please refer to [ohos.geo_location_manager](https://gitcode.com/openharmony-sig/arkcompiler_cangjie_ark_interop/tree/master/doc/API_Reference/source_en/apis/LocationKit).Please refer to [Location dev guide](https://gitcode.com/openharmony-sig/arkcompiler_cangjie_ark_interop/tree/master/doc/Dev_Guide/source_en/location) for related guidance.

## Code Contribution

Developers are welcome to contribute code, documentation, etc. For specific contribution processes and methods, please refer to [Code Contribution](https://gitcode.com/openharmony/docs/blob/master/en/contribute/code-contribution.md).

## Repositories Involved

[base_location](https://gitee.com/openharmony/base_location/blob/master/README.en.md)
