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
 @param param     data:{@"type":支付方式  quick快捷支付/verify认证支付 , 其他参数}
                  callback:回调方法
 其他参数：
 必须参数:sign,sign_type,busi_partner,dt_order,money_order,
         no_order,name_goods,info_order,id_type,notify_url,
         oid_partner,card_no,user_id,
         id_no,acct_name(认证比快捷多这俩参数)
 可配置参数:[user_info_id_no,user_info_full_name,user_info_mercht_userno,user_info_identify_state,
          user_info_identify_type,frms_ware_category,user_info_bind_phone,user_info_dt_register]
 */
- (void)llPay:(NSDictionary *)param;

@end
