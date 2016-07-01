//
//  TableViewVC.m
//  体脂秤标准
//
//  Created by hua on 16/6/6.
//  Copyright © 2016年 gaoxing. All rights reserved.
//

#import "TableViewVC.h"
#define CustomerColor(r,g,b) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:1.0]
#define G_Iphone6(num) num
#define MainScreenHeight [UIScreen mainScreen ].bounds.size.height
#define MainScreenWidth  [UIScreen mainScreen ].bounds.size.width
#define KBarHeight 44
#define GHbgWhiteColor CustomerColor(241, 239, 245)
@interface TableViewVC ()<UITableViewDataSource,UITableViewDelegate>

@property(nonatomic,strong)UITableView *tableView;


@end

@implementation TableViewVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    // Do any additional setup after loading the view.
    NSLog(@"%@",_personDict);
    [self createMyClassUI];
}
-(void)createMyClassUI
{
       self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0,  0, MainScreenWidth, MainScreenHeight)   style:UITableViewStyleGrouped];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.backgroundColor = [UIColor clearColor];
    // self.tableTrip.backgroundColor =     [UIColor colorWithRed:251/255.0 green:247/255.0 blue:237/255.0 alpha:1];
//    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.tableView];
    
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return _personDict.allKeys.count;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *ident = @"blueToothMainCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ident];
    
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ident];
        }
    cell.textLabel.text = _personDict.allKeys[indexPath.section];
    NSLog(@"%@", _personDict[cell.textLabel.text]);
    cell.detailTextLabel.text = _personDict[cell.textLabel.text];
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSLog(@"%ld====%ld",(long)indexPath.section,(long)indexPath.row);
}



/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
