//
//  HeadtitleView.m
//  ZouZou
//
//  Created by lanou3g on 15/10/16.
//  Copyright (c) 2015年 lanou3g. All rights reserved.
//

#import "HeadtitleView.h"
#define CustomerColor(r,g,b) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:1.0]
#define  bgBlack CustomerColor(19, 20, 21);
@implementation HeadtitleView
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self G_setupView];
    }
    return self;
}


-(void)G_setupView
{
    
    self.backgroundColor = CustomerColor(51, 51, 51);
    self.headerImageLabel = [[UIImageView alloc] init];
    _headerImageLabel.frame = CGRectMake(15, 5, 30, 30);
//        _headerImageLabel.backgroundColor = [UIColor cyanColor];
   
    [self addSubview:_headerImageLabel];
    
    
    self.titleLabel = [UIButton buttonWithType:UIButtonTypeSystem];
    _titleLabel.frame = CGRectMake(CGRectGetMaxX(_headerImageLabel.frame)+5,CGRectGetMinY(_headerImageLabel.frame), CGRectGetWidth(self.frame)-80, CGRectGetHeight(_headerImageLabel.frame));
    self.titleLabel.titleLabel. font = [ UIFont systemFontOfSize:15];
    [self.titleLabel setTitleColor:CustomerColor(44, 48, 56) forState:UIControlStateNormal];
   
    [self addSubview:_titleLabel];
    
    
    self.breakButton = [UIButton buttonWithType:UIButtonTypeCustom];
 
    
    _breakButton.frame = CGRectMake(CGRectGetWidth(self. frame)-10-10-20, -60, 95, 20);
      [self addSubview:_breakButton];
    

    
    
}
-(void)layoutSubviews
{
     [super layoutSubviews];
   _headerImageLabel.frame = CGRectMake(15, 5, 30, 30);
    
    _titleLabel.frame = CGRectMake(CGRectGetMaxX(_headerImageLabel.frame)+5,CGRectGetMinY(_headerImageLabel.frame), CGRectGetWidth(self.frame)-80, CGRectGetHeight(_headerImageLabel.frame));
 _breakButton.frame = CGRectMake(CGRectGetWidth(self. frame)-10-20, CGRectGetMinY(_titleLabel.frame)+7, 10, 15);
    
}
@end
