//
//  GGXTools.h
//  GGXTools
//
//  Created by hua on 16/5/20.
//  Copyright © 2016年 gaoxing. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface GGXTools : NSObject
/**
 *  根据输入的类型得到不同的日期
 *
 *  @param type  YEAR->YYYY-MM-dd  TIME->YYYY-MM-dd HH:mm MESSAGE->MM-dd
 *
 *  @return <#return value description#>
 */
+(NSString *)getCancleDate:(NSString *)type;

/**
 *	@brief	浏览头像
 *
 *	@param 	oldImageView 	头像所在的imageView
 */
+(void)showImage:(UIImageView*)avatarImageView;

///UIView截图
+(UIImage*)captureView:(UIView *)theView;

///UIScrollview截图
+ (UIImage *)captureScrollView:(UIScrollView *)scrollView;

///合并多张图片
+(UIImage *)composeWithHeader:(UIImage *)header content:(UIImage *)content footer:(UIImage *)footer;

///合并2张图片
+(UIImage *)composeWithHeader:(UIImage *)content footer:(UIImage *)footer;

 
///获得文件路径
+(NSString *)dataFilePath;

///得到字符串的高度
+(CGFloat)G_heightForString:(NSString *)aString num:(CGFloat)font width:(NSInteger)width;
/// -得到字符串的高度
+(CGFloat)G_heightForString:(NSString *)aString num:(CGFloat)font;

//利用正则表达式验证邮箱格式
+(BOOL)isValidateEmail:(NSString *)email;

//判断是否为浮点形：
+ (BOOL)isPureFloat:(NSString*)string;

//身份证号验证
+(BOOL)isValidateIdentityCard:(NSString *)identityCard;

//手机号码验证
+ (BOOL) isValidateMobile:(NSString *)mobile;

//密码验证码验证
+ (BOOL) isValidatePassword :(NSString *)password;

/**检查银行卡号格式是否正确*/
+ (BOOL) checkBankCardNo:(NSString*) cardNo;

/**
 *     根据生日和日期得到年龄
 */
+(NSInteger)setDataStr:(NSString *)birthday time:(NSString *)time;


@end
