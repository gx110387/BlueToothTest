//
//  DatePickerView.m
//  SpaceTime
//
//  Created by hua on 15/12/3.
//  Copyright © 2015年 gpy. All rights reserved.
//入驻日期  pickerView 展示
#import "GGXTools.h"
#import "DatePickerView.h"
#import "GPYMethod.h"
#import "AlertShow.h"
#define GHbgWhiteColor CustomerColor(241, 239, 245)
#define CustomerColor(r,g,b) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:1.0]
#define G_Iphone6(num) num
#define MainScreenHeight [UIScreen mainScreen ].bounds.size.height
#define MainScreenWidth  [UIScreen mainScreen ].bounds.size.width
@interface DatePickerView ()
//@property (nonatomic, strong) NSMutableArray *pickerArr;
//@property (nonatomic, strong) UIPickerView *pickerView;
//@property (nonatomic, strong) NSString *numStr;
@property (nonatomic, strong) UIDatePicker *pickerView;
@property (nonatomic, strong) NSString *selectDate;

@end

@implementation DatePickerView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self rentDateBg];
        [self setupViews];
    }
    return self;
}
//- (NSMutableArray *)pickerArr {
//    if (!_pickerArr) {
//        _pickerArr = [NSMutableArray array];
//    }
//    return _pickerArr;
//}


- (void)rentDateBg {
 
    
    //背景
    bagButton = [UIButton buttonWithFrame: self.frame title:@"" backgroundColor:[UIColor clearColor] type:UIButtonTypeCustom target:self action:@selector(buttonClick:)];
    bagButton.tag = 90;
    [self addSubview:bagButton];
    
    
    bgView = [[UIView alloc] initWithFrame:CGRectMake(0, MainScreenHeight-G_Iphone6(260), MainScreenWidth, G_Iphone6(260))];
    bgView.backgroundColor = GHbgWhiteColor;
    [ bagButton addSubview:bgView];
 
    
    //取消
    UIButton *cancelBtn = [UIButton buttonWithFrame:CGRectMake(G_Iphone6(15) , 0,  50, G_Iphone6(40)) title:@"取消" backgroundColor:nil type:0 target:self action:@selector(buttonClick:)];
    cancelBtn.tag = 90;
    
    cancelBtn.titleLabel.font = [UIFont systemFontOfSize:G_Iphone6(18)];
    [cancelBtn setTitleColor:CustomerColor(21, 126, 251) forState:UIControlStateNormal];
    [bgView addSubview:cancelBtn];
  
    //确定
    UIButton *AddlBtn = [UIButton buttonWithFrame:CGRectMake(MainScreenWidth -90,0, 90,G_Iphone6(40)) title:@"确定设置" backgroundColor:nil type:0 target:self action:@selector(buttonClick:)];
    AddlBtn.tag = 100;
    
    [AddlBtn setTitleColor:CustomerColor(21, 126, 251) forState:UIControlStateNormal];
    AddlBtn.titleLabel.font = [UIFont systemFontOfSize:G_Iphone6(18)];
    [bgView addSubview:AddlBtn];
   
}

- (void)setupViews {
//    self.backgroundColor = CustomerColor(250, 250, 250);
    
    
    [bgView  addSubview:self.pickerView];
    
    self.pickerView = [[UIDatePicker alloc]init];
    self.pickerView.autoresizingMask = UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleWidth;
    self.pickerView.backgroundColor = [ UIColor whiteColor];
    self.pickerView.frame = CGRectMake(0,G_Iphone6(40), MainScreenWidth, G_Iphone6(220));
    //  self.pickerView.showsSelectionIndicator = YES;
    
    self.pickerView.backgroundColor = [UIColor whiteColor];
    self.pickerView.datePickerMode = UIDatePickerModeDate;
    NSLocale *locale =[[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"] ;
    self.pickerView.locale =locale;
    //    self.pickerView.delegate = self;
    //    self.pickerView.dataSource = self;
    //    [self.pickerView selectRow:125 inComponent:0 animated:NO];//直接定位当前行
    [bgView  addSubview:self.pickerView];

    
}
- (NSString *)timeFormat
{
    NSDate *selected = [self.pickerView date];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSString *currentOlderOneDateStr = [dateFormatter stringFromDate:selected];
    
    
    
        
    return currentOlderOneDateStr;
}



- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component
{
    return 100; //设置每列的宽度
}

- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component
{
    return 50; //设置每行的高度
}



- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    
}




-  (void)buttonClick:(UIButton *)button {
    switch (button.tag) {
        case 90:
            //取消
            
            [self removeBtnClick:button];
            break;
        case 100:
            [self sureBtnClick:button];
            break;
            
        default:
            break;
    }
}
//取消
- (void)removeBtnClick:(UIButton *)sender {
    // 开始动画
    [self animationbegin:sender];
    [UIView animateWithDuration:0.3 animations:^{
        self.alpha = 0;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}
/**
 *  确定按钮点击,会触发代理事件
 */
- (void)sureBtnClick:(UIButton *)sender {
    // 开始动画
    [self animationbegin:sender];
    self.selectDate = [self timeFormat];
   
     NSLog(@"s:%ld", [GGXTools setDataStr:self.self.selectDate time:[GGXTools getCancleDate:@"YEAR"]]);
    if ([GGXTools setDataStr:self.self.selectDate time:[GGXTools getCancleDate:@"YEAR"]] <10) {
        [AlertShow alertShowWithContent:@"年龄小于10岁的儿童无法测量体脂肪率等指标!" Seconds:10];
    }else if ([GGXTools setDataStr:self.self.selectDate time:[GGXTools getCancleDate:@"YEAR"]] <18)
    {
        [AlertShow alertShowWithContent:@"年龄小于18岁无法测量肌肉量~骨量~体年龄~内脏脂肪指标" Seconds:10];
    }else if ([GGXTools setDataStr:self.self.selectDate time:[GGXTools getCancleDate:@"YEAR"]] >80){
        [AlertShow alertShowWithContent:@"年龄大于80岁的老年人无法测量体脂肪率等指标!" Seconds:10];
    }else{
        
    
    //    [self.delegate getSelectDate:self.selectDate type:self.type];
    [self.delegate getSelect:self.selectDate];
    [self removeBtnClick:nil];
    }}

- (void)animationbegin:(UIView *)view
{
    // 设定为缩放
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    // 动画选项设定
    animation.duration = 0.1; // 动画持续时间
    animation.repeatCount = -1; // 重复次数
    animation.autoreverses = YES; // 动画结束时执行逆动画
    
    // 缩放倍数
    animation.fromValue = [NSNumber numberWithFloat:1.0]; // 开始时的倍率
    animation.toValue = [NSNumber numberWithFloat:0.9]; // 结束时的倍率
    
    // 添加动画
    [view.layer addAnimation:animation forKey:@"scale-layer"];
}



@end
