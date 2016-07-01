//
//  BlereportModel.h
//  GaoHeng
//
//  Created by heyudongfang on 16/3/28.
//  Copyright © 2016年 heyudongfang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BlereportModel : NSObject
@property(nonatomic,strong)NSString *headerImage;
@property(nonatomic,strong)NSString *title;
@property(nonatomic,strong)NSString *kg;
@property(nonatomic,strong)NSString *type; // 0严重不足//1偏低//2标准//3偏高//4严重偏高
@property(nonatomic,strong)NSString *typeName;
@property(nonatomic,strong)NSString  * detailImage;
@property(nonatomic,strong)NSString *detailText;
@property(nonatomic,strong)NSString *imageType;
@property(nonatomic,strong)NSArray *weightArr;
@property(nonatomic,strong)NSString *colortype;
@end
