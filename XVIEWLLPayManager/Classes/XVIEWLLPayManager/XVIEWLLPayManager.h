//
//  XVIEWLLPayManager.h
//  XVIEW2.0
//
//  Created by njxh on 16/11/26.
//  Copyright © 2016年 南京 夏恒. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XVIEWSDKObject.h"

@interface XVIEWLLPayManager : NSObject
/* 支持 连连支付SDK2.6.4版本
 添加下列系统库
 SystemConfiguration
 CoreLocation
 MobileCoreServices
 CoreTelephony
 
 - Target->Build Setting ，Other Linker Flags 设置为 -all_load
 - 可能添加-all_load以后和其他库冲突，可以尝试使用 -force_load 单独load库, force_load后面跟的是 lib库的完整路径
 - -force_load $(SRCROOT)/.../libPaySdkColor.a (****需要按照你的库放置的路径决定)
 */
/**
 *  LLpayApiManager的单例类
 *
 *  @return 您可以通过此方法，获取LLpayApiManager的单例，访问对象中的属性和方法
 */
+ (instancetype)shareXVIEWLLPayManager;

@end
