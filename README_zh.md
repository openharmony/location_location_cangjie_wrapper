# 位置服务仓颉封装

## 简介

位置服务仓颉封装在 OpenHarmony 上面向开发者提供位置服务能力封装的仓颉API。系统的位置能力可以提供实时准确的位置数据，对于开发者，设计基于位置体验的服务，也可以使应用的使用体验更贴近每个用户。当前开放的位置服务仓颉接口仅支持standard设备。

**基本概念**

位置能力用于确定用户设备在哪里，系统使用位置坐标标示设备的位置，并用GNSS定位技术提供服务。通过这些定位技术，无论用户设备在室内或是户外，都可以准确地确定设备位置。

-   **坐标**

    系统以1984年世界大地坐标系统为参考，使用经度、纬度数据描述地球上的一个位置。

-   **GNSS定位**

    基于全球导航卫星系统，包含：GPS、GLONASS、北斗、Galileo等，通过导航卫星，设备芯片提供的定位算法，来确定设备准确位置。定位过程具体使用哪些定位系统，取决于用户设备的硬件能力。


## 系统架构

**图 1** **子系统架构图**  

![](figures/location_cangjie_wrapper_architecture.png)

如架构图所示：

接口层说明：

- 位置服务接口：提供获取当前位置、提供判断位置服务是否开启的仓颉公开接口声明，使用位置服务API时请打开设备“位置”开关。

框架层说明：

- 位置服务封装：提供获取当前位置、提供判断位置服务是否开启的仓颉封装方法实现。该封装层是基于位置服务组件对位置服务功能进行的仓颉封装实现。

仓颉位置服务依赖部件引入说明：

- 位置服务组件：通过调用底层GNSS驱动接口，提供GNSS定位、网络定位（蜂窝基站、WLAN、蓝牙定位技术）、地理编码、国家码和地理围栏等基本功能。
- cangjie_ark_interop：封装C语言互操作公共接口，并提供仓颉标签类实现用于对仓颉API进行标注，以及提供抛向用户的BusinessException异常类定义。
- hiviewdfx_cangjie_wrapper：负责提供日志接口，提供可被位置服务仓颉接口调用的在关键路径处打印日志能力的仓颉接口。
  
## 目录

```
base/location/location_cangjie_wrapper
├── figures                           # 存放README中的架构图
├── kit                               # 仓颉位置服务kit化代码
│   └── LocationKit                   # LocationKit代码目录
├── ohos                              # 仓颉位置服务接口实现
│   └── geo_location_manager          # geo_location_manager仓颉接口代码目录
└── test                              # 测试用例代码
    └── geolocationmanager            # 位置管理测试
```

## 使用说明

提供了以下位置服务功能：
- 获取当前位置功能
- 判断位置服务是否已经打开功能

Location相关API使用请参见[Location API 参考](https://gitcode.com/openharmony-sig/arkcompiler_cangjie_ark_interop/tree/master/doc/API_Reference/source_zh_cn/apis/LocationKit)，相关接口使用指导请参见[Location开发指南](https://gitcode.com/openharmony-sig/arkcompiler_cangjie_ark_interop/tree/master/doc/Dev_Guide/source_zh_cn/location/cj-location-guidelines.md)。

## 约束

- 使用设备的位置能力，需要用户进行确认并主动开启位置开关。如果位置开关没有开启，系统不会向任何应用提供位置服务。

- 设备位置信息属于用户敏感数据，所以即使用户已经开启位置开关，应用在获取设备位置前仍需向用户申请位置访问权限。在用户确认允许后，系统才会向应用提供位置服务。

与ArkTS提供的API能力相比，暂不支持以下功能：
- 网络定位：包括蜂窝基站定位、WLAN定位和蓝牙定位技术。
- 获取历史位置：获取最近一次缓存的位置信息。
- 地理围栏服务：地理围栏是一种虚拟地理边界功能，当设备进入或离开特定地理区域时，可以接收自动通知和警告。
- 地理编码服务：地理编码功能提供地址信息与地理坐标之间的转换。
- 位置监听服务：支持注册位置变化监听器，持续接收位置更新。
- 位置状态管理：判断地理编码服务是否可用，获取国家码信息。

## 参与贡献

欢迎广大开发者贡献代码、文档等，具体的贡献流程和方式请参见[参与贡献](https://gitcode.com/openharmony/docs/blob/master/zh-cn/contribute/%E5%8F%82%E4%B8%8E%E8%B4%A1%E7%8C%AE.md)。

## 相关仓

**位置服务仓颉**

[base_location](https://gitcode.com/openharmony/base_location/blob/master/README.md)

[arkcompiler_cangjie_ark_interop](https://gitcode.com/openharmony-sig/arkcompiler_cangjie_ark_interop/blob/master/README_zh.md)

[hiviewdfx_hiviewdfx_cangjie_wrapper](https://gitcode.com/openharmony-sig/hiviewdfx_hiviewdfx_cangjie_wrapper/blob/master/README_zh.md)