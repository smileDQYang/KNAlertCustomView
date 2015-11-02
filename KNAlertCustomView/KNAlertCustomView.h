//
//  KNAlertCustomView.h
//  alert
//
//  Created by LuKane on 15/11/1.
//  Copyright © 2015年 LuKane. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^OKBtnBlock)();
typedef void(^CancelBtnBlock)();

@interface KNAlertCustomView : UIWindow


/**
*  只有一个 确定 按钮的弹出框
*
*  @param message  消息
*  @param title    提示
*  @param okString 确定 文字
*  @param okBlock  确定的回调
*/
+ (void)showKNAlertMessage:(NSString *)message title:(NSString *)title okBtnString:(NSString *)okString OKBTNClick:(OKBtnBlock)okBlock;

/**
 *  取消  确定 的弹出框
 *
 *  @param message      消息
 *  @param title        提示
 *  @param cancelString 取消 文字
 *  @param okString     确定 文字
 *  @param cancelBlock  取消回调
 *  @param okBlock      确定回调
 */
+ (void)showKNAlertMessage:(NSString *)message title:(NSString *)title cancelBtnString:(NSString *)cancelString okBtnString:(NSString *)okString cancelBTNClick:(CancelBtnBlock)cancelBlock okBTNClick:(OKBtnBlock)okBlock;

/**
 *  取消 确定 的弹出框 -- 文字数组类型
 *
 *  @param messageArr   多条消息 (数组的形式)
 *  @param title        提示
 *  @param cancelString 取消 文字
 *  @param okString     确定 文字
 *  @param cancelBlock  取消 回调
 *  @param okBlock      确定 回调
 */
+ (void)showKNALertMessages:(NSArray *)messageArr title:(NSString *)title cancelBtnString:(NSString *)cancelString okBtnString:(NSString *)okString cancelBTNClick:(CancelBtnBlock)cancelBlock okBTNClick:(OKBtnBlock)okBlock;


/***************************华丽的分割线************************/

/**
 *  初始化 背景颜色
 *
 *  @param bgColor  背景颜色
 *  @param canColor 取消颜色
 *  @param okColor  确定颜色
 *  @param cancelHightColor  取消高亮颜色
 *  @param okColor  确定颜色
 */

+ (void)initializeKNAlertCustBgColor:(UIColor *)bgColor cancelBtnColor:(UIColor *)cancelNormalColor cancelHightColor:(UIColor *)cancelHightColor okBtnColor:(UIColor *)okNormalColor okHightColor:(UIColor *)okHightColor ;

/**
 *  初始化 消息 提示 取消 确定 的 文字颜色
 *
 *  @param messageColor 消息颜色
 *  @param titleColor   提示颜色
 *  @param canColor     取消颜色
 *  @param okColor      确定颜色
 *  @param cancelHightColor      取消高亮颜色
 *  @param okHightColor      确定高亮颜色
 */
+ (void)initializeKNAlertCustMessageColor:(UIColor *)messageColor titleColor:(UIColor *)titleColor cancelBtnColor:(UIColor *)cancelNormalColor cancelHightColor:(UIColor *)cancelHightColor okBtnColor:(UIColor *)okNormalColor okHightColor:(UIColor *)okHightColor;


/***************************华丽的分割线************************/
@property (nonatomic, copy) OKBtnBlock okBtnBlock;
@property (nonatomic, copy) CancelBtnBlock cancelBtnBlock;
/***************************华丽的分割线************************/

@end


@interface KNAlertVc : UIViewController


@end