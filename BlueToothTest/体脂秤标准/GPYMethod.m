//
//  GPYMethod.m
//  SpaceTime
//
//  Created by hua on 15/11/17.
//  Copyright © 2015年 gpy. All rights reserved.
//

#import "GPYMethod.h"

//@implementation GPYMethod

@implementation UILabel (addMethod)
//标签
+(UILabel *)lableWithFrame:(CGRect)frame title:(NSString *)title textFont:(int)font textColor:(UIColor *)color {
    
    UILabel *name  = [[UILabel alloc]initWithFrame:frame];
    name.text = title;
    name.font = [UIFont systemFontOfSize:font];
    name.textColor = color;
//    name.numberOfLines = 0;
    name.backgroundColor = [UIColor clearColor];
    return name;
}
@end

@implementation UIButton(addMethod)
+(UIButton *)buttonWithFrame:(CGRect)frame title:(NSString *)title backgroundColor:(UIColor *)backgroundColor type:(UIButtonType)type target:(id)target action:(SEL)sel {
    UIButton *button = [UIButton buttonWithType:type];
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    button.backgroundColor = backgroundColor;
    button.frame = frame;
    [button addTarget:target action:sel forControlEvents:UIControlEventTouchUpInside];
//    button.titleLabel.font = [UIFont systemFontOfSize:font];
    return button;
}
//按钮
+(UIButton *)buttonWithFrame:(CGRect)frame title:(NSString *)title backgroundColor:(UIColor *)backgroundColor font:(CGFloat)font type:(UIButtonType)type target:(id)target action:(SEL)sel {
    UIButton *button = [UIButton buttonWithType:type];
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    button.backgroundColor = backgroundColor;
    button.frame = frame;
    [button addTarget:target action:sel forControlEvents:UIControlEventTouchUpInside];
    button.titleLabel.font = [UIFont systemFontOfSize:font];
    return button;
}
@end

@implementation UITextField(addMethod)
//文本框
+(UITextField *)textFielWithFrame:(CGRect)frame leftImageView:(UIImageView *)leftView titleOfPlaceholder:(NSString *)title font:(int)font    textColor:(UIColor *)textCorlor borderColor:(UIColor *)borderColor borderWidth:(CGFloat)borderWidth{
    UITextField *textFiled  = [[UITextField alloc]initWithFrame:frame];
    textFiled.leftView = leftView;
    textFiled.leftView.hidden = NO;
    textFiled.leftViewMode = UITextFieldViewModeAlways;
    textFiled.placeholder = title;
    textFiled.font = [UIFont systemFontOfSize:font];
    textFiled.textColor = textCorlor;
    textFiled.layer.borderColor = borderColor.CGColor;
    textFiled.layer.borderWidth = borderWidth;
    return textFiled;
    
}
@end
