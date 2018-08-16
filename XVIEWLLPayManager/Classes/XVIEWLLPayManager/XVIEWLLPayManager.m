//
//  XVIEWLLPayManager.m
//  XVIEW2.0
//
//  Created by njxh on 16/11/26.
//  Copyright © 2016年 南京 夏恒. All rights reserved.
//

#import "XVIEWLLPayManager.h"
#import "LLPaySdk.h"
#import "LLPayUtil.h"
@interface XVIEWLLPayManager () <LLPaySdkDelegate>
#pragma mark ==连连支付结果回调到支付界面==
@property (nonatomic, copy) void (^llpayCallbackBlock) (XVIEWSDKResonseStatusCode statusCode, NSDictionary *responseData);

@end

@implementation XVIEWLLPayManager
{
    NSDictionary *_llpayInfo;
    NSMutableDictionary *_orderDic;
    XVIEWSDKPlatfromType _type;//区分认证支付和快捷支付
}
- (instancetype)init
{
    if (self = [super init]) {
        
    }
    return self;
}
+ (instancetype)shareXVIEWLLPayManager
{
    static XVIEWLLPayManager *_instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (!_instance) {
            _instance = [[XVIEWLLPayManager alloc] init];
        }
    });
    return _instance;
}
#pragma mark ==连连支付
- (void)XVIEWSDKLLPay:(NSDictionary *)orderInfo style:(XVIEWSDKPlatfromType)payStyle callback:(void (^)(XVIEWSDKResonseStatusCode statusCode, NSDictionary *responseData))block {
    self.llpayCallbackBlock = block;
    dispatch_async(dispatch_get_main_queue(), ^{
        [self llPay:orderInfo style:payStyle];
    });
}
#pragma mark ==连连支付==
- (void)llPay:(NSDictionary *)orderInfo style:(XVIEWSDKPlatfromType)payStyle {
    _llpayInfo = [NSDictionary dictionaryWithDictionary:orderInfo];
    dispatch_async(dispatch_get_main_queue(), ^{
        [self payWithLLPay:payStyle];
    });
}
- (void)registerAppKey:(NSString *)appKey llPay:(NSDictionary *)orderInfo style:(XVIEWSDKPlatfromType)payStyle callback:(void (^)(XVIEWSDKResonseStatusCode statusCode, NSDictionary *responseData))block {
    self.llpayCallbackBlock = block;
    
    [self llPay:orderInfo style:payStyle];
}
#pragma mark -  连连支付   订单支付
- (void)payWithLLPay:(XVIEWSDKPlatfromType)llPayStyle {
    _orderDic = [self createOrder];         // 创建订单
    LLPayUtil *payUtil = [[LLPayUtil alloc] init];
    // 进行签名
    NSDictionary *signedOrder = [payUtil signedOrderDic:_orderDic
                                             andSignKey: _llpayInfo[@"sign"]];
    [LLPaySdk sharedSdk].sdkDelegate = self; // 设置回调
    _type = llPayStyle;
    if (llPayStyle == XVIEWSDKTypeLLpayQuickPay) {
        //     快捷支付
        [[LLPaySdk sharedSdk] presentLLPaySDKInViewController:[UIApplication sharedApplication].delegate.window.rootViewController withPayType:LLPayTypeQuick andTraderInfo:signedOrder];
    }
    else {
        // 认证支付
        [[LLPaySdk sharedSdk] presentLLPaySDKInViewController:[UIApplication sharedApplication].delegate.window.rootViewController withPayType:LLPayTypeVerify andTraderInfo:signedOrder];
    }
}

#pragma mark - 创建订单
- (NSMutableDictionary*)createOrder {
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    // TODO: 请开发人员修改下面订单的所有信息，以匹配实际需求
    [param setDictionary:@{
                           @"sign_type":_llpayInfo[@"sign_type"],
                           @"busi_partner":_llpayInfo[@"busi_partner"],
                           @"dt_order":_llpayInfo[@"dt_order"],
                           @"money_order" : _llpayInfo[@"money_order"],
                           @"no_order":_llpayInfo[@"no_order"],
                           @"name_goods":_llpayInfo[@"name_goods"],
                           @"info_order":_llpayInfo[@"info_order"],
                           @"valid_order":@"10080",
                           @"id_type": _llpayInfo[@"id_type"],
                           @"notify_url":_llpayInfo[@"notify_url"],
                           @"risk_item" :
                          [LLPayUtil jsonStringOfObj:
                          @{
                                @"user_info_dt_register":[self returnString:@"user_info_dt_register" withDictionary:_llpayInfo],
                                @"user_info_bind_phone":[self returnString:@"user_info_bind_phone" withDictionary:_llpayInfo],
                                @"frms_ware_category": [self returnString:@"frms_ware_category" withDictionary:_llpayInfo],
                                @"user_info_identify_type": [self returnString:@"user_info_identify_type" withDictionary:_llpayInfo],
                                @"user_info_identify_state":[self returnString:@"user_info_identify_state" withDictionary:_llpayInfo],
                                @"user_info_mercht_userno":[self returnString:@"user_info_mercht_userno" withDictionary:_llpayInfo],
                                @"user_info_full_name":[self returnString:@"user_info_full_name" withDictionary:_llpayInfo],
                                @"user_info_id_no":[self returnString:@"user_info_id_no" withDictionary:_llpayInfo],
                                }],
                            @"user_id": _llpayInfo[@"user_id"],
                            @"card_no": _llpayInfo[@"card_no"],
  }];
    BOOL isIsVerifyPay = YES;
    if (isIsVerifyPay) {
        [param addEntriesFromDictionary:@{
                                          @"id_no": _llpayInfo[@"id_no"],
                                          @"acct_name":_llpayInfo[@"acct_name"],
                                          }];
    }
    param[@"oid_partner"] = _llpayInfo[@"oid_partner"];
    return param;
}
- (NSString *)returnString:(NSString *)string withDictionary:(NSDictionary *)dict {
    if (dict[string]) {
        return dict[string];
    }
    return @"";
}
- (UIViewController *)activityViewController {
    UIViewController* activityViewController = nil;
    
    UIWindow *window = [[UIApplication sharedApplication] keyWindow];
    if(window.windowLevel != UIWindowLevelNormal) {
        NSArray *windows = [[UIApplication sharedApplication] windows];
        for(UIWindow *tmpWin in windows) {
            if(tmpWin.windowLevel == UIWindowLevelNormal) {
                window = tmpWin;
                break;
            }
        }
    }
    NSArray *viewsArray = [window subviews];
    if([viewsArray count] > 0) {
        UIView *frontView = [viewsArray objectAtIndex:0];
        
        id nextResponder = [frontView nextResponder];
        if([nextResponder isKindOfClass:[UIViewController class]]) {
            activityViewController = nextResponder;
        }
        else {
            activityViewController = window.rootViewController;
        }
    }
    return activityViewController;
}
#pragma -mark 支付结果 LLPaySdkDelegate
// 订单支付结果返回，主要是异常和成功的不同状态
- (void)paymentEnd:(LLPayResult)resultCode withResultDic:(NSDictionary *)dic {
    NSMutableDictionary *callbackDict = [[NSMutableDictionary alloc] initWithDictionary:dic];
    [callbackDict setObject:_type==XVIEWSDKTypeLLpayQuickPay ? @"lianlianQuickPay" : @"lianlianVerifyPay" forKey:@"type"];
    switch (resultCode) {
        case kLLPayResultSuccess: {
            NSString* result_pay = dic[@"result_pay"];
            if ([result_pay isEqualToString:@"SUCCESS"]) {
                if (self.llpayCallbackBlock) {
                    self.llpayCallbackBlock(XVIEWSDKCodeSuccess, @{@"code":@"0", @"data":callbackDict, @"message":@"支付成功"});
                }
            }
            else if ([result_pay isEqualToString:@"PROCESSING"]) {
                if (self.llpayCallbackBlock) {
                    self.llpayCallbackBlock(XVIEWSDKCodeInProcess, @{@"code":@"01", @"data":callbackDict, @"message":@"支付单处理中"});
                }
            }
            else if ([result_pay isEqualToString:@"FAILURE"]) {
                if (self.llpayCallbackBlock) {
                    self.llpayCallbackBlock(XVIEWSDKCodeFail, @{@"code":@"-1", @"data":callbackDict, @"message":@"支付单失败"});
                }
            }
            else if ([result_pay isEqualToString:@"REFUND"]) {
                if (self.llpayCallbackBlock) {
                    self.llpayCallbackBlock(XVIEWSDKCodePayRefund, @{@"code":@"-1", @"data":callbackDict, @"message":@"支付单已退款"});
                }
            }
        }
            break;
        case kLLPayResultFail: {
            if (self.llpayCallbackBlock) {
                self.llpayCallbackBlock(XVIEWSDKCodeFail, @{@"code":@"-1", @"data":callbackDict, @"message":@"支付失败"});
            }
        }
            break;
        case kLLPayResultCancel: {
            if (self.llpayCallbackBlock) {
                self.llpayCallbackBlock(XVIEWSDKCodeCancel, @{@"code":@"-1", @"data":callbackDict, @"message":@"支付取消"});
            }
        }
            break;
        case kLLPayResultInitError: {
            if (self.llpayCallbackBlock) {
                self.llpayCallbackBlock(XVIEWSDKCodeInitError, @{@"code":@"-1", @"data":callbackDict, @"message":@"支付初始化错误，订单信息有误，签名失败等"});
            }
        }
            break;
        case kLLPayResultInitParamError: {
            if (self.llpayCallbackBlock) {
                self.llpayCallbackBlock(XVIEWSDKCodeInitParamError, @{@"code":@"-1", @"data":callbackDict, @"message":@"支付订单参数有误，无法进行初始化，未传必要信息等"});
            }
        }
            break;
        case kLLPayResultUnknow: {
            if (self.llpayCallbackBlock) {
                self.llpayCallbackBlock(XVIEWSDKCodeUnknown, @{@"code":@"-1", @"data":callbackDict, @"message":@"其它问题"});
            }
        }
            break;
        default:
            if (self.llpayCallbackBlock) {
                self.llpayCallbackBlock(XVIEWSDKCodeUnknown, @{@"code":@"-1", @"data":callbackDict, @"message":@"支付异常"});
            }
            break;
    }
}
@end
