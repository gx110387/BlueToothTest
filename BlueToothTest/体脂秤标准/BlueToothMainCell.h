//
//  BlueToothMainCell.h
//  GaoHeng
//
//  Created by heyudongfang on 15/12/31.
//  Copyright © 2015年 heyudongfang. All rights reserved.
//

#import <UIKit/UIKit.h>
@class BlereportModel;
@interface BlueToothMainCell : UITableViewCell


@property(nonatomic,strong)UIImageView *headerImage; // 图片
@property(nonatomic,strong)UILabel * titleLabel;   //测试项
@property(nonatomic,strong)UILabel * kgLabel;  //测试项的值
@property(nonatomic,strong)UILabel *standardLabel; //是否达标
@property(nonatomic,strong)UIButton *breakButton;   //详情

@property(nonatomic,strong)UIButton *bgButton;
+(BlueToothMainCell *)cellWithTableView:(UITableView *)tableView;
@property(nonatomic,strong)BlereportModel *blereportModel;
@end
