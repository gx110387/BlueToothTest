//
//  GGXBLE.h
//  GGXTools
//
//  Created by hua on 16/5/20.
//  Copyright © 2016年 gaoxing. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@class BleInfoModel;
@class BleDeviceModel;
@interface GGXBLE : NSObject
#pragma mark - 体脂称计算
+(BleInfoModel *)setValueforInfo:(BleDeviceModel *)infoModel;
//
 +(NSInteger)setDataStr:(NSString *)birthday time:(NSString *)time;
@end
