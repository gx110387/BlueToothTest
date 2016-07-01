//
//  BleDeviceModel.h
//  GaoHeng
//
//  Created by heyudongfang on 16/3/25.
//  Copyright © 2016年 heyudongfang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BleDeviceModel : NSObject
@property(nonatomic,strong)NSString *bmi;
@property(nonatomic,strong)NSString *bmr;
@property(nonatomic,strong)NSString *bodyfat;
@property(nonatomic,strong)NSString *bone;
@property(nonatomic,strong)NSString *measure_time;
@property(nonatomic,strong)NSString *muscle;
@property(nonatomic,strong)NSString *protein;
@property(nonatomic,strong)NSString *subfat;
@property(nonatomic,strong)NSString *user_id;
@property(nonatomic,strong)NSString *visfat;
@property(nonatomic,strong)NSString *water;

@property(nonatomic,strong)NSString *weight;
@property(nonatomic,strong)NSString *gender;
@property(nonatomic,strong)NSString *height;
@property (nonatomic,strong)NSString *birthday;
@end
