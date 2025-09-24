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

/**
 * Created on 2024/8/28
 */
package ohos_app_cangjie_entry

import ohos.base.*
import std.unittest.testmacro.*
import ohos.geo_location_manager.*
import ohos.ability_access_ctrl.*
import std.unittest.*
import std.unittest.common.*
import std.unittest.testmacro.*
import ohos.base.*
import std.collection.map
import std.collection.collectArray
import std.collection.forEach

@Test
class Test_location {
    override func beforeAll(): Unit {
        if (!GeoLocationManager.isLocationEnabled()) {
            swipe(from: Point(1146, 77), deltaY: 200)
            sleepFor(1.second)
            click(
                at: Screen
                    .getTheOnlyUiComponentWhoseIdEqualsTo("Ctrl.NewToggleBaseComponent_Image_location")
                    .centerPoint)
            pressBack()
            sleepFor(1.second)
        }
        ["ohos.permission.APPROXIMATELY_LOCATION", "ohos.permission.LOCATION"] |>
            forEach<Permissions> {
            permissionName: Permissions =>
            sleepFor(3.second)
            getRequiredPermissions([permissionName])
            try {
                sleepFor(3.second)
                click(at: Screen.getTheOnlyUiComponentWhoseTextEqualsTo("本次使用允许").centerPoint)
            } catch (e: Exception) {}
        }
    }

    override func afterAll(): Unit {
        if (GeoLocationManager.isLocationEnabled()) {
//            let b = Screen
//                .getTheOnlyUiComponentWhoseIdEqualsTo("sbgright")
//                .centerPoint
//            swipe(from: b, deltaY: 200)
            sleepFor(1.second)
            sleepFor(1.second)
            try {
                click(at: Screen
                        .getTheOnlyUiComponentWhoseIdEqualsTo("Ctrl.NewToggleBaseComponent_Image_location")
                        .centerPoint)
            } catch (e: Exception) {}
            pressBack()
        }
    }

    @TestCase
    @Tag[APILevel22, TestLevel0]
    func test_getCurrentLocation(): Unit {
        let location = GeoLocationManager.getCurrentLocation()
        @Expect(location.latitude > 30.0 && location.latitude < 35.0, true)
        @Expect(location.longitude > 100.0 && location.longitude < 140.0, true)
        @Expect(location.altitude >= 0.0, true)
        @Expect(location.accuracy > 0.0, true)
        @Expect(location.speed < 10.0 , true)
        @Expect(location.direction >= 0.0 && location.direction <= 360.0, true)
        if (let Some(v) <- location.directionAccuracy) {
            @Expect(v >= 0.0 && v <= 360.0 , true)
        }

        let curLocRequest_0 = CurrentLocationRequest(priority: LocationRequestPriority.FirstFix,
            scenario: LocationRequestScenario.Unset, maxAccuracy: 200.0)
        let curLocRet_0 = GeoLocationManager.getCurrentLocation(curLocRequest_0)
        @Expect(true)
        let curLocRequest_1 = CurrentLocationRequest(priority: LocationRequestPriority.LowPower,
            scenario: LocationRequestScenario.Navigation, maxAccuracy: 200.0)
        let curLocRet_1 = GeoLocationManager.getCurrentLocation(curLocRequest_1)
        @Expect(true)
        let curLocRequest_2 = CurrentLocationRequest(priority: LocationRequestPriority.Accuracy,
            scenario: LocationRequestScenario.TrajectoryTracking, maxAccuracy: 200.0)
        let curLocRet_2 = GeoLocationManager.getCurrentLocation(curLocRequest_2)
        @Expect(true)
        let curLocRequest_3 = CurrentLocationRequest(priority: LocationRequestPriority.FirstFix,
            scenario: LocationRequestScenario.CarHailing, maxAccuracy: 200.0)
        let curLocRet_3 = GeoLocationManager.getCurrentLocation(curLocRequest_3)
        @Expect(true)
        let curLocRequest_4 = CurrentLocationRequest(priority: LocationRequestPriority.FirstFix,
            scenario: LocationRequestScenario.DailyLifeService, maxAccuracy: 200.0)
        let curLocRet_4 = GeoLocationManager.getCurrentLocation(curLocRequest_4)
        @Expect(true)
        let curLocRequest_5 = CurrentLocationRequest(priority: LocationRequestPriority.FirstFix,
            scenario: LocationRequestScenario.NoPower, maxAccuracy: 200.0)
        let curLocRet_5 = GeoLocationManager.getCurrentLocation(curLocRequest_5)
        @Expect(true)
        let singleLocRequest = SingleLocationRequest(LocatingPriority.PriorityAccuracy, 10000)
        let singleLocRet = GeoLocationManager.getCurrentLocation(singleLocRequest)
        @Expect(true)
        let singleLocRequest_1 = SingleLocationRequest(LocatingPriority.PriorityLocatingSpeed, 10000)
        let singleLocRet_1 = GeoLocationManager.getCurrentLocation(singleLocRequest_1)
        @Expect(true)
    }

    @TestCase
    @Tag[APILevel22, TestLevel0]
    func test_isLocationEnabled(): Unit {
        let manager = GeoLocationManager()
        @Expect(GeoLocationManager.isLocationEnabled() , true)
    }

    @TestCase
    @Tag[APILevel22, TestLevel0]
    func test_LocationSourceType(): Unit {
        let arr: Array<LocationSourceType> = [Gnss, Network, Indoor, Rtk]
    }
}
