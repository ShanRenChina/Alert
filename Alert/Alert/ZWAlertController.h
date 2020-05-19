//
//  ZWAlertController.h
//  Alert
//
//  Created by zw on 2020/5/19.
//  Copyright © 2020 zw. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Masonry.h"
NS_ASSUME_NONNULL_BEGIN

@interface ZWAlertAction : NSObject

+ (instancetype)actionWithTitle:(nullable NSString *)title font:(UIFont *)font txetColor:(UIColor *)color handler:(void (^ __nullable)(ZWAlertAction *action))handler;


@end



@interface ZWAlertController : UIViewController


/// 初始化alert
/// @param title 标题
/// @param tColor 标题颜色 为nil时将执行默认color
/// @param tFont 标题font 为nil时将执行默认font
/// @param message 提示内容
/// @param mColor 内容颜色 为空时将执行默认color
/// @param mFont 内容font 为空时将执行默认font
+ (instancetype)alertControllerWithTitle:(NSString *)title titleColor:(nullable UIColor *)tColor titleFont:(nullable UIFont *)tFont message:(NSString *)message messageColor:(nullable UIColor *)mColor messageFont:(nullable UIFont *)mFont;
- (void)addAction:(ZWAlertAction *)action;

@end

NS_ASSUME_NONNULL_END
