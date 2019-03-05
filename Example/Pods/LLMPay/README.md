# [LLMPay](https://gitee.com/LLPayiOS/LLMPay)

[![Version](https://img.shields.io/cocoapods/v/LLMPay.svg?style=flat)](https://cocoapods.org/pods/LLMPay)
[![License](https://img.shields.io/cocoapods/l/LLMPay.svg?style=flat)](https://cocoapods.org/pods/LLMPay)
[![Platform](https://img.shields.io/cocoapods/p/LLMPay.svg?style=flat)](https://cocoapods.org/pods/LLMPay)

# 连连支付统一网关iOS SDK 接入指南

> 本指南为连连支付统一网关iOS SDK 模式接入指南， 阅读对象为接入 LLMPay SDK 的开发者。
>若接入的是银行APP支付SDK，请查看[连连支付统一网关 银行APP支付iOS SDK接入指南](./LLMPay/EBank)

## 一. SDK 文件说明

|文件名|                       说明|
|------------------                     |-------------------                        |
|libLLPaySDKCore.a              |     SDK base模块                        |
|libLLMobilePay.a                         |连连支付统一网关iOS SDK        |
|LLMPay.h                               |SDK 头文件                                |
|LLMPayResources.bundle      |  资源文件， 包含自定义 css 以及图片资源|
|README.md                        |连连支付统一网关iOS SDK接入指南   |
|CHANGELOG.md                 |    更新日志                             |

## 二. 集成 SDK

> CocoaPods 方式  

在 podfile 中加入以下代码：

`pod 'LLMPay'`

执行 pod install 即可安装 LLMPay SDK

>  直接导入工程的方式  

1. 导入连连支付 iOS SDK，将包含有连连支付 SDK 的文件夹拖入到 Xcode 工程中
2. 确认工程中的 Target – Build Phases – Link Binary With Libraries有对应的静态库（.a 或者 framework）， 以及Copy Bundle Resources中有对应的 Bundle 文件， 如果没有， 请将静态库和Bundle包拖入对应位置即可
3. other linker flag 加入 -ObjC   防止出现 unrecognized selector sent to instance的错误
4. 确认Library Search Paths中有 SDK 所在文件夹的路径

## 三. 调用 SDK

* 从服务端获取gateway_url
* 调用支付SDK

```objc
[[LLMPaySDK sharedSdk] payApply:gateway_url complete:^(LLMPayResult result, NSDictionary *dic) {
//根据服务result 与 dic 中的 ret_code 与 ret_msg 做出相应处理
}];
```
* 调用签约SDK

```objc
[[LLMPaySDK sharedSdk] signApply:gateway_url complete:^(LLMPayResult result, NSDictionary *dic) {
//根据服务result 与 dic 中的 ret_code 与 ret_msg 做出相应处理
}];
```

## 四. LLMPay SDK 自定义说明

>  LLMPay iOS SDK可以通过修改 bundle 中的 css 配置与图片进行定制。  

1. 图片的替换，在内部的图片可以替换修改为自己的样式
2. 颜色等的修改，可以修改default.css文件，连连的主色调是 #00a0e9 , 如需更换可替换成商户自己的主色调
3. 修改值
* 导航栏颜色：替换ll_nav_bg3.png文件，以及修改css文件中NavBar字段（后面只表示字段，都是在default.css文件中）中的background-color
* 标题：CusTitle字段， 暂时只能定义首次支付界面与Alert标题

## Author

LLPayiOSDev, iosdev@yintong.com.cn

## License

© 2003-2018 Lianlian Yintong Electronic Payment Co., Ltd. All rights reserved.
