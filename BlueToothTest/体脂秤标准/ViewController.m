//
//  ViewController.m
//  体脂秤标准
//
//  Created by hua on 16/6/6.
//  Copyright © 2016年 gaoxing. All rights reserved.
//

#import "ViewController.h"
#import "BleDeviceModel.h"
#import "BlueToothInfoViewController.h"
#import "DatePickerView.h"
#import "UIAlertController+Blocks.h"
#import "AlertShow.h"
#import "TableViewVC.h"
#import "BleInfoModel.h"
#import "GGXBLE.h"
#define MainScreenHeight [UIScreen mainScreen ].bounds.size.height
#define MainScreenWidth  [UIScreen mainScreen ].bounds.size.width
@interface ViewController ()<DatePickerDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
     [self stopKeyBoard:_scrollviewbg];
    self.view.backgroundColor = [UIColor whiteColor];
    // Do any additional setup after loading the view, typically from a nib.
    _scrollviewbg.contentSize = CGSizeMake(MainScreenWidth, MainScreenHeight *1.3);
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardwillShow:) name:UIKeyboardWillShowNotification object:nil];
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHidden:) name:UIKeyboardWillHideNotification object:nil];
}
-(void)stopKeyBoard:(UIView *)view
{
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(keyboardHide:)];
    //设置成NO表示当前控件响应后会传播到其他控件上，默认为YES。
    tapGestureRecognizer.cancelsTouchesInView = NO;
    //将触摸事件添加到当前view
    [view addGestureRecognizer:tapGestureRecognizer];
}
-(void)keyboardHide:(UITapGestureRecognizer*)tap{
    [_heightkmText resignFirstResponder];
    [_weightText resignFirstResponder];
    [_subfatText resignFirstResponder];
    [_bmiText resignFirstResponder];
    [_visfatText resignFirstResponder];
    [_bodyfatText resignFirstResponder];
    [_waterText resignFirstResponder];
    [_bmrText resignFirstResponder];
    [_muscleText resignFirstResponder];
    [_boneText resignFirstResponder];
     [_proteinText resignFirstResponder];
}
- (void)keyboardwillShow:(NSNotification *)noti
{  CGFloat duration = [noti.userInfo[@"UIKeyboardAnimationDurationUserInfoKey"] floatValue];
    [UIView animateWithDuration:duration animations:^{
        self.view.transform = CGAffineTransformMakeTranslation(0, -219);
    }];
}
- (void)keyboardWillHidden:(NSNotification *)noti
{
    CGFloat duration = [noti.userInfo[@"UIKeyboardAnimationDurationUserInfoKey"] floatValue];
    
    [UIView animateWithDuration:duration animations:^{
        
        self.view.transform = CGAffineTransformMakeTranslation(0, 0);
    }];
}

- (IBAction)clickbutton:(id)sender {
     [self clickButton];
}
- (IBAction)genderbutton:(id)sender {
    [self chooseGender];
}
#pragma mark -选择性别
-(void)chooseGender
{
    [UIAlertController showAlertInViewController:self
                                       withTitle:@"提示" message:@"请选择性别" cancelButtonTitle:@"男" destructiveButtonTitle:@"女" otherButtonTitles:nil tapBlock:^(UIAlertController * _Nonnull controller, UIAlertAction * _Nonnull action, NSInteger buttonIndex) {
                                           if (buttonIndex == controller.cancelButtonIndex) {
                                               
                                               [self.genderButton setTitle:@"男" forState: UIControlStateNormal];
                                               
                                               
                                           } else if (buttonIndex == controller.destructiveButtonIndex) {
                                               
                                                [self.genderButton setTitle:@"女" forState: UIControlStateNormal];
                                               
                                               
                                           }
                                           
                                       }];
}

- (IBAction)birthdaybutton:(id)sender {
    NSLog(@"点击了生日");
    DatePickerView *datePickerView = [[DatePickerView alloc] initWithFrame:self.view.frame];
    datePickerView.delegate =self;
    datePickerView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:datePickerView];
}
#pragma mark - PersonPickDelegate 时间 的代理
-(void)getSelect:(NSString *)date
{
    
    [self.birthdayButton setTitle:date forState:UIControlStateNormal];
//    _ageNum = date;
//    _ageNum =  [_ageNum stringByReplacingOccurrencesOfString:@"" withString:@""];
    NSLog(@"birthdayNum:%@",date);
}





-(void)clickButton
{
    //性别(0:nan 1:nv)
    if ([_heightkmText.text isEqualToString:@""]) {
        [AlertShow alertShowWithContent:@"身高为必填项~" Seconds:10];
    }else if ([_weightText.text isEqualToString:@""])
    {
          [AlertShow alertShowWithContent:@"体重为必填项~" Seconds:10];
    }else if ([_subfatText.text isEqualToString:@""])
    {
         [AlertShow alertShowWithContent:@"皮下脂肪率为必填项~" Seconds:10];
    }else if ([_bmiText.text isEqualToString:@""])
    {
          [AlertShow alertShowWithContent:@"身体质量指数为必填项~" Seconds:10];
    }else if ([_visfatText.text isEqualToString:@""])
    {
         [AlertShow alertShowWithContent:@"内脏脂肪等级为必填项~" Seconds:10];
    }else if ([_bodyfatText.text isEqualToString:@""])
    {
         [AlertShow alertShowWithContent:@"体脂肪率为必填项~" Seconds:10];
    }
    else if ([_waterText.text isEqualToString:@""])
    {
          [AlertShow alertShowWithContent:@"水分为必填项~" Seconds:10];
    }
    else if ([_bmrText.text isEqualToString:@""])
    {
          [AlertShow alertShowWithContent:@"基础代谢量为必填项~" Seconds:10];
    }
    else if ([_muscleText.text isEqualToString:@""])
    {
          [AlertShow alertShowWithContent:@"骨骼肌率为必填项~" Seconds:10];
    }
    else if ([_boneText.text isEqualToString:@""])
    {
          [AlertShow alertShowWithContent:@"骨量为必填项~" Seconds:10];
    }
    else if ([_proteinText.text isEqualToString:@""])
    {
         [AlertShow alertShowWithContent:@"蛋白质为必填项~" Seconds:10];
    }
    else if ([[self.genderButton titleForState:UIControlStateNormal] isEqualToString:@"性别"])
    {
        [AlertShow alertShowWithContent:@"性别为必填项~" Seconds:10];
    }
    else if ([[self. birthdayButton titleForState:UIControlStateNormal] isEqualToString:@"出生日期"])
    {
        [AlertShow alertShowWithContent:@"出生日期为必填项~" Seconds:10];
    }else
    {
    
    
 
    NSString *genderStr ;
    if ([[self.genderButton titleForState:UIControlStateNormal] isEqualToString:@"男"]) {
       genderStr = @"0";
    }else  if ([[self.genderButton titleForState:UIControlStateNormal] isEqualToString:@"女"])
    {
        genderStr = @"1";
    }
    /*weight：体重 85.1
     bmi：身体质量指数 1
     bodyfat：体脂肪率 1
     subfat：皮下脂肪率 1
     visfat：内脏脂肪等级 1
     water：体水分
     bmr：基础代谢量 1
     muscle：骨骼肌率 1
     bone：骨量 1
     protein：蛋白质 1
     */
    NSDictionary *dict = [ NSDictionary dictionaryWithObjectsAndKeys:_bmiText.text,@"bmi",_bmrText.text,@"bmr",_bodyfatText.text,@"bodyfat",_boneText.text,@"bone",@"2016-03-23 15:11:12",@"measure_time",_muscleText.text,@"muscle",_proteinText.text,@"protein",_subfatText.text,@"subfat",@"279",@"user_id",_visfatText.text,@"visfat",_waterText.text,@"water",_weightText.text,@"weight",genderStr,@"gender",_heightkmText.text,@"height" ,[self.birthdayButton titleForState:UIControlStateNormal],@"birthday",nil];
    
    NSLog(@"_deviceModel:%@ ",dict);
    //
    BleDeviceModel *dictModel = [[BleDeviceModel alloc] init];
    [dictModel setValuesForKeysWithDictionary:dict];
    BlueToothInfoViewController *bleToothInfoVC =   [[BlueToothInfoViewController alloc] init];
    bleToothInfoVC.deviceModel = dictModel;
    
    
    [self.navigationController pushViewController:bleToothInfoVC animated:YES];
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)circleButton:(id)sender {
    
    //性别(0:nan 1:nv)
    if ([_heightkmText.text isEqualToString:@""]) {
        [AlertShow alertShowWithContent:@"身高为必填项~" Seconds:10];
    }else if ([_weightText.text isEqualToString:@""])
    {
        [AlertShow alertShowWithContent:@"体重为必填项~" Seconds:10];
    }else if ([_subfatText.text isEqualToString:@""])
    {
        [AlertShow alertShowWithContent:@"皮下脂肪率为必填项~" Seconds:10];
    }else if ([_bmiText.text isEqualToString:@""])
    {
        [AlertShow alertShowWithContent:@"身体质量指数为必填项~" Seconds:10];
    }else if ([_visfatText.text isEqualToString:@""])
    {
        [AlertShow alertShowWithContent:@"内脏脂肪等级为必填项~" Seconds:10];
    }else if ([_bodyfatText.text isEqualToString:@""])
    {
        [AlertShow alertShowWithContent:@"体脂肪率为必填项~" Seconds:10];
    }
    else if ([_waterText.text isEqualToString:@""])
    {
        [AlertShow alertShowWithContent:@"水分为必填项~" Seconds:10];
    }
    else if ([_bmrText.text isEqualToString:@""])
    {
        [AlertShow alertShowWithContent:@"基础代谢量为必填项~" Seconds:10];
    }
    else if ([_muscleText.text isEqualToString:@""])
    {
        [AlertShow alertShowWithContent:@"骨骼肌率为必填项~" Seconds:10];
    }
    else if ([_boneText.text isEqualToString:@""])
    {
        [AlertShow alertShowWithContent:@"骨量为必填项~" Seconds:10];
    }
    else if ([_proteinText.text isEqualToString:@""])
    {
        [AlertShow alertShowWithContent:@"蛋白质为必填项~" Seconds:10];
    }
    else if ([[self.genderButton titleForState:UIControlStateNormal] isEqualToString:@"性别"])
    {
        [AlertShow alertShowWithContent:@"性别为必填项~" Seconds:10];
    }
    else
        if ([[self. birthdayButton titleForState:UIControlStateNormal] isEqualToString:@"出生日期"])
    {
        [AlertShow alertShowWithContent:@"出生日期为必填项~" Seconds:10];
    }else
    {
        
        
        
        NSString *genderStr ;
        if ([[self.genderButton titleForState:UIControlStateNormal] isEqualToString:@"男"]) {
            genderStr = @"0";
        }else  if ([[self.genderButton titleForState:UIControlStateNormal] isEqualToString:@"女"])
        {
            genderStr = @"1";
        }
        /*weight：体重 85.1
         bmi：身体质量指数 1
         bodyfat：体脂肪率 1
         subfat：皮下脂肪率 1
         visfat：内脏脂肪等级 1
         water：体水分
         bmr：基础代谢量 1
         muscle：骨骼肌率 1
         bone：骨量 1
         protein：蛋白质 1
         */
        NSDictionary *dict = [ NSDictionary dictionaryWithObjectsAndKeys:_bmiText.text,@"bmi",_bmrText.text,@"bmr",_bodyfatText.text,@"bodyfat",_boneText.text,@"bone",@"2016-03-23 15:11:12",@"measure_time",_muscleText.text,@"muscle",_proteinText.text,@"protein",_subfatText.text,@"subfat",@"279",@"user_id",_visfatText.text,@"visfat",_waterText.text,@"water",_weightText.text,@"weight",genderStr,@"gender",_heightkmText.text,@"height" ,[self.birthdayButton titleForState:UIControlStateNormal],@"birthday",nil];
//        NSDictionary *dict = [ NSDictionary dictionaryWithObjectsAndKeys:@"25.7",@"bmi",@"1793.4",@"bmr",@"4",@"bodyfat",@"3.3",@"bone",@"2016-03-23 15:11:12",@"measure_time",@"50.0",@"muscle",@"17.7",@"protein",@"20.0",@"subfat",@"289",@"user_id",@"8",@"visfat",@"55.8",@"water",@"85.10",@"weight",@"0",@"gender",@"173",@"height" ,[self.birthdayButton titleForState:UIControlStateNormal],@"birthday",nil];
        NSLog(@"_deviceModel:%@ ",dict);
        //
        BleDeviceModel *dictModel = [[BleDeviceModel alloc] init];
        [dictModel setValuesForKeysWithDictionary:dict];
        TableViewVC *bleToothInfoVC = [[TableViewVC alloc]init];
            BleInfoModel *model = [GGXBLE setValueforInfo:dictModel];
        bleToothInfoVC.personDict =model.PersoncircleDict;
        
        
        [self.navigationController pushViewController:bleToothInfoVC animated:YES];
    }
    
}

@end
