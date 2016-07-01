//
//  GPYMethod.h
//  SpaceTime
//
//  Created by hua on 15/11/17.
//  Copyright © 2015年 gpy. All rights reserved.
//

#import <UIKit/UIKit.h>

//@interface GPYMethod : UIView

@interface UILabel (addMethod)
//标签
+(UILabel *)lableWithFrame:(CGRect)frame title:(NSString *)title textFont:(int)font textColor:(UIColor *)color;
@end

@interface UIButton(addMethod)
//按钮
+(UIButton *)buttonWithFrame:(CGRect)frame title:(NSString *)title backgroundColor:(UIColor *)backgroundColor type:(UIButtonType)type target:(id)target action:(SEL)sel;

+(UIButton *)buttonWithFrame:(CGRect)frame title:(NSString *)title backgroundColor:(UIColor *)backgroundColor font:(CGFloat)font type:(UIButtonType)type target:(id)target action:(SEL)sel;
@end
@interface UITextField(addMethod)
//文本框
+(UITextField *)textFielWithFrame:(CGRect)frame leftImageView:(UIImageView *)leftView titleOfPlaceholder:(NSString *)title font:(int)font    textColor:(UIColor *)textCorlor borderColor:(UIColor *)borderColor borderWidth:(CGFloat)borderWidth;
@end
//@end
