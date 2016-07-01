//
//  BlueToothInfoViewController.h
//  GaoHeng
//
//  Created by heyudongfang on 16/3/23.
//  Copyright © 2016年 heyudongfang. All rights reserved.
//

#import <UIKit/UIKit.h>
@class BleDeviceModel;
@interface BlueToothInfoViewController : UIViewController
@property(nonatomic,strong)BleDeviceModel *deviceModel;
@end
