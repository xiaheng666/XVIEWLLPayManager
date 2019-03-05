//
//  XVIEWLLPayManager.h
//  XVIEWLLPayManager
//
//  Created by yyj on 2019/1/3.
//  Copyright © 2019 zd. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XVIEWLLPayManager : NSObject

/**
 *  单例
 */
+ (instancetype)sharedLLPayManager;

/**
 *  连连支付
 @param param     data:{@"url":统一网关路径}
 callback:回调方法
 */
- (void)llPay:(NSDictionary *)param;

/**
 *  连连签约
 @param param     data:{data:{@"url":统一网关路径}
 callback:回调方法
 */
- (void)llSign:(NSDictionary *)param;

@end
