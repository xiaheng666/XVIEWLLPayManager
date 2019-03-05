//
//  LLMPay.h
//  LLMPay
//
//  Created by Fynil on 2018/11/08.
//  Copyright (c) 2018年 LianLian Pay. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, LLMPayResult) {
    LLMPayResultSuccess,            /**< 支付成功 */
    LLMPayResultFail,               /**< 支付失败 */
    LLMPayResultCancel,             /**< 支付取消，用户行为 */
    LLMPayResultInitError,          /**< 支付初始化错误，订单信息有误，签名失败等 */
    LLMPayResultInitParamError,     /**< 支付订单参数有误，无法进行初始化，未传必要信息等 */
    LLMPayResultUnknow,             /**< 其他 */
    LLMPayResultRequestingCancel,   /**< 授权支付后取消(支付请求已发送) */
};

typedef void (^CompletionHandler)(LLMPayResult result, NSDictionary *dic);

@interface LLMPay : NSObject

/**
 *  单例
 *
 *  @return 返回LLTokenPaySDK的单例对象
 */
+ (LLMPay *)sharedSdk;


/**
 支付申请

 @param paymentInfo 交易信息
 @param complete 回调
 */
- (void)payApply:(NSString *)paymentInfo complete:(CompletionHandler)complete;

/**
 签约申请

 @param paymentInfo 交易信息
 @param complete 回调
 */
- (void)signApply:(NSString *)paymentInfo complete:(CompletionHandler)complete;

/**
 获取SDK当前版本

 @return 版本号
 */
+ (NSString *)getSDKVersion;

/**
 *  切换正式、测试服务器（默认不调用是正式环境，请不要随意使用该函数切换至测试环境）
 *
 *  @param isTestServer YES测试环境，NO正式环境
 */
+ (void)switchToTestServer:(BOOL)isTestServer;

@end

