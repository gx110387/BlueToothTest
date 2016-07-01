//
//  BlueToothMainCell.m
//  GaoHeng
//
//  Created by heyudongfang on 15/12/31.
//  Copyright © 2015年 heyudongfang. All rights reserved.
//

#import "BlueToothMainCell.h"
#import "GPYMethod.h"
#import "BlereportModel.h"
#define CustomerColor(r,g,b) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:1.0]
 #define G_Iphone6(num) num
#define MainScreenHeight [UIScreen mainScreen ].bounds.size.height
#define MainScreenWidth  [UIScreen mainScreen ].bounds.size.width
@implementation BlueToothMainCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self)
    {
        
        // 初始化子控件
        [self setupView];
        self.selectionStyle = UITableViewCellSelectionStyleNone;//设置cell无选中状态无
    }
    
    return self;
    
}

- (void)setupView {
    CGFloat g15 = G_Iphone6(15);
    
    self.backgroundColor = [UIColor whiteColor];
   // 图片
    self.headerImage = [[UIImageView alloc] init];
    _headerImage.frame = CGRectMake(15, CGRectGetHeight(self.frame)/2-15, 30, 30);
    _headerImage.image = [UIImage imageNamed:@"heathl"];
    [self.contentView addSubview:_headerImage];
    
    //测试项
    self.titleLabel = [[UILabel  alloc] init];
    _titleLabel.frame = CGRectMake(CGRectGetMaxX(_headerImage.frame)+10,CGRectGetMinY(_headerImage.frame), (MainScreenWidth-90)/3, CGRectGetHeight(_headerImage.frame));
   //self.titleLabel.backgroundColor = [ UIColor purpleColor];
    self.titleLabel.font = [UIFont systemFontOfSize:g15];
    self.titleLabel.text=@"体重";
    
    self.titleLabel.textColor = CustomerColor(44, 48, 56);
    self.titleLabel.textAlignment = NSTextAlignmentLeft;
    
    [self.contentView addSubview:_titleLabel];
    
    //测试项的值
    _kgLabel = [UILabel lableWithFrame:CGRectMake(CGRectGetMaxX(_titleLabel.frame), CGRectGetMinY(_titleLabel.frame), (MainScreenWidth-110)/3, CGRectGetHeight(_titleLabel.frame)) title:@"63.4kg" textFont:g15 textColor:CustomerColor(44, 48, 56)];
    [self.contentView addSubview:_kgLabel];
    // _kgLabel.backgroundColor = [UIColor cyanColor];
    _kgLabel.textAlignment = NSTextAlignmentCenter;
    
    //是否达标
    _standardLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_kgLabel.frame)+5, 44/2-CGRectGetHeight(_kgLabel.frame)/1.5/2, (MainScreenWidth-130)/3, CGRectGetHeight(_kgLabel.frame)/1.5)];
   _standardLabel.backgroundColor = [UIColor redColor];
//    _standardLabel.layer.borderColor = [UIColor orangeColor].CGColor;
//    _standardLabel.layer.borderWidth = 1;
    _standardLabel.layer.cornerRadius = CGRectGetHeight(_kgLabel.frame)/1.5/2;
    _standardLabel.layer.masksToBounds = YES;
    _standardLabel.text = @"严重达标";
    _standardLabel.font = [UIFont systemFontOfSize:g15];
    _standardLabel.textColor = [UIColor whiteColor];
    _standardLabel.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:_standardLabel];
 //
    
    self.breakButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _breakButton.frame = CGRectMake(MainScreenWidth -40, CGRectGetMinY(_titleLabel.frame), 30, 30);
    [self.breakButton setImage:[UIImage imageNamed:@"Factory_add"] forState:UIControlStateNormal];
    //self.breakButton.backgroundColor = [UIColor yellowColor];
    self.breakButton.layer.cornerRadius = 15;
    self.breakButton.layer.masksToBounds = YES;
    [self.contentView addSubview:_breakButton];
    
}

 
-(void)setBlereportModel:(BlereportModel *)blereportModel
{
    _blereportModel = blereportModel;
    
    _headerImage.image = [ UIImage imageNamed:blereportModel.headerImage];
    _titleLabel.text  = blereportModel.title;
    _standardLabel.text = blereportModel.typeName;
    _standardLabel.backgroundColor = [self getBackColor:blereportModel.type];
    _kgLabel.text = blereportModel.kg;

    
}
-(UIColor *)getBackColor:(NSString *)type
{
    switch ([type integerValue]) {
        case 0:
            return  CustomerColor(166, 185, 224);
            break;
        case 1:
            return CustomerColor(151, 88, 160);
            break;
        case 2:
            return CustomerColor(89, 184, 23);
            break;
        case 3:
            return CustomerColor(255, 189, 40);
            break;
        case 4:
            return CustomerColor(194, 34, 42);
            break;
            
        default:
            break;
    }
    return [UIColor blackColor];
    
}
+(BlueToothMainCell *)cellWithTableView:(UITableView *)tableView {
    
    static NSString *ident = @"blueToothMainCell";
    
    BlueToothMainCell *cell = [tableView dequeueReusableCellWithIdentifier:ident];
    
    if (!cell) {
        
        cell = [[BlueToothMainCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ident];
        
    }
    return cell;
    
}


@end
