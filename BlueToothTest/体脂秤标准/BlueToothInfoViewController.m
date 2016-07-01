//
//  BlueToothInfoViewController.m
//  GaoHeng
//
//  Created by heyudongfang on 16/3/23.
//  Copyright © 2016年 heyudongfang. All rights reserved.
//

#import "BlueToothInfoViewController.h"
#import "BlueToothMainCell.h"
#import "HeadtitleView.h"
#import "BleDeviceModel.h"
#import "BleInfoModel.h"
#import "BlereportModel.h"
#import "GPYMethod.h"
#import "GGXBLE.h"
#import "GGXTools.h"
#define CustomerColor(r,g,b) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:1.0]
 #define G_Iphone6(num) num
#define MainScreenHeight [UIScreen mainScreen ].bounds.size.height
#define MainScreenWidth  [UIScreen mainScreen ].bounds.size.width
#define KBarHeight 44
#define GHbgWhiteColor CustomerColor(241, 239, 245)
@interface BlueToothInfoViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,strong)UITableView *tableView;
//@property(nonatomic,strong)NSMutableArray *titleArr; //标题数组
@property(nonatomic,strong)NSIndexPath *selectedIndex;
@property (nonatomic,strong)NSMutableDictionary *dataDict;

@property(nonatomic,strong)NSMutableDictionary *dictArr;
@end

@implementation BlueToothInfoViewController
{
    UIView  *labelimage;
    UIView *headView;
    UILabel *lblTitlegx;
    //   UIView *  navationBar;
    UIButton *leftButtongx;
    UIButton *rightButtongx;
    
    BOOL isOpen;
    
    UIImageView *pointImage;
    UILabel *pointLabel;
    NSMutableArray *NostandarArr;
    NSMutableArray *YesstandarArr;
    UIView *cellView;
    UIImageView *detailImage;
    UILabel *deatillabel;
    UILabel *myScorelable;//得分
}



- (void)goToBack {
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - AppDelegate methods
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
 //  dditional setup after loading the view.
    self.dataDict = [ NSMutableDictionary dictionary];
    // Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor = [UIColor whiteColor];
    _dictArr = [ NSMutableDictionary dictionary];
    //_titleArr = [NSMutableArray arrayWithObjects:@"本次测试未达标项目共",@"本次测试达标项目共", nil];
    [self createNaviUI];
    [self setValueforInfo:_deviceModel];
    [self createTableView];
    [self getData];

}
#pragma mark 创建Navi
-(void)createNaviUI{
    
    headView = [[ UIView alloc] initWithFrame:CGRectMake(0,0, MainScreenWidth, G_Iphone6(203)-20)];
    headView.backgroundColor = [ UIColor purpleColor];
    UIImageView *backImage = [[ UIImageView alloc] initWithFrame:headView.frame];
    backImage.backgroundColor = [ UIColor redColor];
    backImage.image = [ UIImage imageNamed:@"Ble_backImage"];
    [headView addSubview:backImage];
//    CGFloat g60 = MainScreenWidth/ 6.25;
//    CGFloat g112 =MainScreenWidth/3.3482;

    
    
    
    myScorelable = [UILabel lableWithFrame: CGRectMake(0,0  ,MainScreenWidth,CGRectGetHeight(headView.frame)) title:@"98.0分" textFont:G_Iphone6(60) textColor:CustomerColor(251,185,44)];
//    myScorelable.backgroundColor = [UIColor redColor];
    myScorelable.textAlignment = NSTextAlignmentCenter;
    [headView addSubview:myScorelable];
    
}



-(void)setValueforInfo:(BleDeviceModel *)infoModel{
    
    NostandarArr = [ NSMutableArray array];
    YesstandarArr = [ NSMutableArray array];
    
    BleInfoModel *model = [GGXBLE setValueforInfo:infoModel];
    _dictArr  = model.dataDict;
    
    if (_dictArr[@"本次测试达标项目共"] == NULL) {
        NostandarArr = _dictArr[@"本次测试未达标项目共"];
    }else
        if (_dictArr[@"本次测试未达标项目共"] == NULL) {
            YesstandarArr =  _dictArr[@"本次测试达标项目共"];
        }else
        {
            NostandarArr = _dictArr[@"本次测试未达标项目共"];
            YesstandarArr =  _dictArr[@"本次测试达标项目共"];
        }
    
   
    NSAttributedString *Str = [[NSAttributedString alloc] initWithString:model.score];
    NSMutableAttributedString *text = [[ NSMutableAttributedString alloc] initWithAttributedString:Str];
    [text addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:G_Iphone6(80)] range:NSMakeRange(0, 3)];
    myScorelable.attributedText = text;
    [self.tableView reloadData];
    
}

-(void)createTableView{
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, MainScreenWidth, MainScreenHeight ) style:UITableViewStyleGrouped];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.backgroundColor =[UIColor whiteColor];
    _tableView.showsVerticalScrollIndicator = NO;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_tableView];
    _tableView.tableHeaderView = headView;
    
    CGFloat g15 = MainScreenWidth/25;
    NSString *str = @"注:所有建议是基于BIA(人体生物阻抗测试)测量指示给予良好生活习惯的指引,不作为医学方面的诊断,如需要医学上的诊断请咨询专业的医生.";
    UIView * footerView = [[ UIView alloc] initWithFrame:CGRectMake(0, 0, MainScreenWidth, 100+G_Iphone6(120+66))];
    footerView.backgroundColor = [UIColor whiteColor];
    //    UILabel *line1_1 = [[UILabel alloc] initWithFrame:CGRectMake(0, 15, MainScreenWidth, 1)];
    //    line1_1.backgroundColor = [UIColor orangeColor];
    
    UILabel *textLabel = [[ UILabel alloc] init];
    textLabel.frame = CGRectMake(15, 10, MainScreenWidth-30, 80 );
    textLabel.text = str;
    textLabel.textAlignment = NSTextAlignmentLeft;
    textLabel.numberOfLines = 0;
    textLabel.font = [UIFont systemFontOfSize: g15];
    textLabel.textColor  = CustomerColor(44, 48, 56);
    [textLabel sizeToFit];
    
    UILabel *label1_1 = [ UILabel lableWithFrame:CGRectMake(30, CGRectGetMaxY(textLabel.frame)+10, MainScreenWidth -60, 1) title:@"" textFont:14 textColor:[UIColor whiteColor]];
    label1_1.backgroundColor = CustomerColor(217,217,217);
    [footerView addSubview:label1_1];
    CGFloat gap = (MainScreenWidth -G_Iphone6(120)*2)/3;
    
    UIImageView *erweimaImage = [[ UIImageView alloc] initWithFrame:CGRectMake(gap, CGRectGetMaxY(label1_1.frame)+G_Iphone6(33), G_Iphone6(120),G_Iphone6(120))];
    erweimaImage.image = [UIImage imageNamed:@"GHBle_erweima"];
    [footerView addSubview:erweimaImage];
    
    
    UIImageView * titleImage =  [[UIImageView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(erweimaImage.frame)+gap, CGRectGetMaxY(label1_1.frame)+G_Iphone6(33), G_Iphone6(120), G_Iphone6(120) )];
    titleImage.image = [UIImage imageNamed:@"GHBle_goHeng"];
//     titleImage.backgroundColor = [ UIColor redColor];
    [footerView addSubview:titleImage];

    
//    UILabel *noticeLabel = [ UILabel lableWithFrame:CGRectMake(30, CGRectGetMaxY(erweimaImage.frame)+10, MainScreenWidth-60, 30) title:@"长按识别二维码下载" textFont:MainScreenWidth/23.4 textColor:CustomerColor(44, 48, 56)];
//    [footerView addSubview:noticeLabel];
    
    // 160 75
//    noticeLabel .textAlignment = NSTextAlignmentCenter;
    
    
    
    
    //  [footerView addSubview:line1_1];
    [footerView addSubview:textLabel];
    _tableView.tableFooterView = footerView;
    
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView1111
{
    return self.dictArr.allKeys.count;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        if (_dictArr[@"本次测试达标项目共"] == NULL) {
            return NostandarArr.count;
        }else
            if (_dictArr[@"本次测试未达标项目共"] == NULL) {
                return YesstandarArr.count;
            }
            else
            {
                return NostandarArr.count;
            }
    }else if (section == 1)
    {
        return  YesstandarArr.count;
    }else
    {
        return 0;
    }
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    
    HeadtitleView *titleView = [[HeadtitleView alloc] init];
    titleView.backgroundColor = GHbgWhiteColor;
    //  _titleArr = [NSMutableArray arrayWithObjects:@"本次测试未达标项目共",@"本次测试达标项目共", nil];
    if (NostandarArr.count == 0 ) {
        titleView.headerImageLabel.image = [ UIImage imageNamed:@"Ble_passNotice"];
        [titleView.titleLabel setTitle:[NSString stringWithFormat:@"本次测试达标项目共 %ld 项",YesstandarArr.count ] forState:UIControlStateNormal];
        
    }else if(YesstandarArr.count == 0)
    {
        titleView.headerImageLabel.image = [ UIImage imageNamed:@"Ble_noPassNotice"];
        [titleView.titleLabel setTitle:[NSString stringWithFormat:@"本次测试未达标项目共 %ld 项", NostandarArr.count ] forState:UIControlStateNormal];
    }else
    {
        if (section == 0) {
            titleView.headerImageLabel.image = [ UIImage imageNamed:@"Ble_noPassNotice"];
            [titleView.titleLabel setTitle:[NSString stringWithFormat:@"本次测试未达标项目共 %ld 项", NostandarArr.count ] forState:UIControlStateNormal];
        }else
        {
            titleView.headerImageLabel.image = [ UIImage imageNamed:@"Ble_passNotice"];
            [titleView.titleLabel setTitle:[NSString stringWithFormat:@"本次测试达标项目共 %ld 项",YesstandarArr.count ] forState:UIControlStateNormal];
        }
    }
    [ titleView.titleLabel addTarget:self action:@selector(breakButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    titleView.titleLabel.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    titleView.titleLabel.tag = 100+section;
    
    
    //[titleView.breakButton sizeToFit];
    UIView *view = [[UIView alloc] initWithFrame:[titleView frame]];
    titleView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    [view addSubview:titleView];
    
    
    return view;
    
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    [self.dataDict setObject:indexPath forKey:[NSString stringWithFormat:@"%ld",indexPath.section*4+indexPath.row*64]];
    BlueToothMainCell *blueToothMainCell = [BlueToothMainCell cellWithTableView:tableView];
    [blueToothMainCell.breakButton  addTarget:self action:@selector(Action:) forControlEvents:UIControlEventTouchUpInside];
    blueToothMainCell.breakButton.tag = indexPath.section*4+indexPath.row*64;
    
    BlereportModel *blereportModel;
    if (NostandarArr .count == 0 ) {
        blereportModel = YesstandarArr[indexPath.row];
    }else if(YesstandarArr .count == 0)    {
        blereportModel = NostandarArr[indexPath.row];
    }else {
        if (indexPath.section == 0) {
            blereportModel = NostandarArr[indexPath.row];
        } else if (indexPath.section == 1) {
            blereportModel = YesstandarArr[indexPath.row];
        }
    }
    blueToothMainCell.blereportModel = blereportModel;
    
    if (indexPath.section == _selectedIndex.section && indexPath.row == _selectedIndex.row && _selectedIndex != nil) {
        //如果是展开
        if (isOpen == YES) {
            [blueToothMainCell.breakButton setImage:[UIImage imageNamed:@"Factory_sub"] forState:UIControlStateNormal];
            BlereportModel *model;
            if (NostandarArr.count == 0 ) {
                model = YesstandarArr[indexPath.row];
            }else if(YesstandarArr .count == 0)    {
                model = NostandarArr[indexPath.row];
            }else {
                if (indexPath.section == 0) {
                    model = NostandarArr[indexPath.row];
                } else if (indexPath.section == 1) {
                    model = YesstandarArr[indexPath.row];
                }}
            
            NSInteger colortype = [model.colortype integerValue];
            NSInteger imagetype = [model.imageType integerValue];
            NSArray *arr = model.weightArr;
            
            detailImage.image = [UIImage imageNamed: model.detailImage];
            [detailImage sizeToFit];
            detailImage.frame = CGRectMake(MainScreenWidth/2-CGRectGetWidth(detailImage.frame)/2, 20, CGRectGetWidth(detailImage.frame), CGRectGetHeight(detailImage.frame));
            //detailImage.backgroundColor = [UIColor redColor];
            [detailImage sizeToFit];
            pointImage.frame=CGRectMake(CGRectGetMinX(detailImage.frame)+colortype*CGRectGetWidth(detailImage.frame)/(imagetype+1)+CGRectGetWidth(detailImage.frame)/(imagetype+1)/2, 5, 0, 0);
            pointImage.image = [self getBackImage:model.type];
            [pointImage sizeToFit];
            
            deatillabel.frame =CGRectMake(15, CGRectGetMaxY(detailImage.frame), MainScreenWidth-30, [GGXTools G_heightForString:model.detailText num:14]);
         
            deatillabel.text = model.detailText;
            cellView.frame = CGRectMake(0, 44, MainScreenWidth, CGRectGetMaxY(deatillabel.frame)+5);
            if (model.colortype ==nil) {
            }else {
                [cellView addSubview:pointImage];
            }
            for (int i = 0; i<imagetype; i++) {
                
                pointLabel = [ UILabel lableWithFrame:CGRectMake(CGRectGetMinX(detailImage.frame)+i*CGRectGetWidth(detailImage.frame)/(imagetype+1)+CGRectGetWidth(detailImage.frame)/(imagetype+1), 5, 0, 0) title:@"45.6kg" textFont:10 textColor:CustomerColor(44, 48, 56)];
                
                pointLabel.tag = i+1;
                pointLabel.text = arr[i];
                [pointLabel sizeToFit];
                pointLabel.frame = CGRectMake(CGRectGetMinX(detailImage.frame)+i*CGRectGetWidth(detailImage.frame)/(imagetype+1)+CGRectGetWidth(detailImage.frame)/(imagetype+1)-CGRectGetWidth(pointLabel.frame)/2, 5, 0, 0);
                [pointLabel sizeToFit];
                [cellView addSubview:pointLabel];
                
            }
            [blueToothMainCell addSubview:cellView];
        }else{
            [blueToothMainCell.breakButton setImage:[UIImage imageNamed:@"Factory_add"] forState:UIControlStateNormal];
            //收起
        }
        //不是自身
    } else {
        [blueToothMainCell.breakButton setImage:[UIImage imageNamed:@"Factory_add"] forState:UIControlStateNormal];     }
    
    return blueToothMainCell;
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    if (indexPath.section == _selectedIndex.section && indexPath.row == _selectedIndex.row && _selectedIndex != nil ) {
        if (isOpen == YES) {
            //cell上的label高度自适应
            return 44+CGRectGetHeight(cellView.frame);
            
        }else{
            return 44;
        }
    }else
    {        return 44;
    }
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    
    return 44;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    BlueToothMainCell *cell = [_tableView  cellForRowAtIndexPath:self.selectedIndex];
    NSLog(@"%@",cell);
    [cell.breakButton setImage:[UIImage imageNamed:@"Factory_add"] forState:UIControlStateNormal];
    
    NSArray *indexPaths = [NSArray arrayWithObject:indexPath];
    //判断选中不同row状态时候
    if (self.selectedIndex != nil && indexPath.row == _selectedIndex.row) {
        //将选中的和所有索引都加进数组中
        isOpen = !isOpen;
    }else{
        isOpen = YES;
    }
    
    //记下选中的索引
    self.selectedIndex = indexPath;
    
    for (UIView *v in  cellView.subviews) {
        
        if ([v isKindOfClass:[UILabel class]]) {
            if (v.tag  > 0 && v.tag <=4) {
                [v removeFromSuperview];
            }
        }
    }
    [pointImage removeFromSuperview];
    [cellView removeFromSuperview];
    deatillabel.text =nil;
    detailImage.image = nil;
    
    //刷新
    [_tableView reloadRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationFade];
}
-(void)breakButtonAction:(UIButton * )sender
{NSLog(@"breakButtonAction");
}
-(void)getData{
    cellView = [[UIView alloc] initWithFrame:CGRectMake(0, 44, MainScreenWidth, 170)];
//    UILabel *line1_1 = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, MainScreenWidth, 1)];
//    line1_1.backgroundColor = [UIColor wh];
//    [cellView addSubview:line1_1];
    
    detailImage = [[ UIImageView alloc] initWithFrame:CGRectMake(15, 20, MainScreenWidth-30, 41)];
    
    [cellView addSubview:detailImage];
    CGFloat g15 = MainScreenWidth/26.7857;
    deatillabel= [ UILabel lableWithFrame:CGRectMake(15, CGRectGetMaxY(detailImage.frame), MainScreenWidth-30, 110) title:@"" textFont:g15 textColor:CustomerColor(44,48,56)];
    // deatillabel.backgroundColor = [UIColor purpleColor];
    deatillabel.numberOfLines = 0;
    [cellView addSubview:deatillabel];
    
    pointImage = [[UIImageView alloc] init];
    [cellView addSubview:pointImage];
    cellView.backgroundColor = GHbgWhiteColor;
    
}
-(UIColor *)getBackColor:(NSString *)type{
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
-(UIImage *)getBackImage:(NSString *)type{
    switch ([type integerValue]) {
        case 0:
            return  [UIImage imageNamed:@"analysisReport_gradeMark_lightBlue"];
            break;
        case 1:
            return [UIImage imageNamed:@"analysisReport_gradeMark_purple"];
            break;
        case 2:
            return [UIImage imageNamed:@"analysisReport_gradeMark_green"];
            break;
        case 3:
            return [UIImage imageNamed:@"analysisReport_gradeMark_yellow"];
            break;
        case 4:
            return [UIImage imageNamed:@"analysisReport_gradeMark_red"];
            break;
            
        default:
            break;
    }
    return nil;
    
}


-(void)Action:(UIButton *)sender
{
     NSLog(@"AAAAA%d",sender.tag);
    NSIndexPath *indexPath =[self.dataDict objectForKey:[NSString stringWithFormat:@"%d",sender.tag]];
    BlueToothMainCell *cell = [_tableView  cellForRowAtIndexPath:self.selectedIndex];
     NSLog(@"AAAAA%@",cell);
    [cell.breakButton setImage:[UIImage imageNamed:@"Factory_add"] forState:UIControlStateNormal];
    NSArray *indexPaths = [NSArray arrayWithObject:indexPath];
    //判断选中不同row状态时候
    if (self.selectedIndex != nil && indexPath.row == _selectedIndex.row) {
        //将选中的和所有索引都加进数组中
        isOpen = !isOpen;
    }else{
        isOpen = YES;
    }
    //记下选中的索引
    self.selectedIndex = indexPath;
    for (UIView *v in  cellView.subviews) {
        
        if ([v isKindOfClass:[UILabel class]]) {
            if (v.tag  > 0 && v.tag <=4) {
                [v removeFromSuperview];
            }
        }
    }
    [pointImage removeFromSuperview];
    [cellView removeFromSuperview];
    deatillabel.text =nil;
    detailImage.image = nil;
    //刷新
    [_tableView reloadRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationFade];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
