//
//  GGXBLE.m
//  GGXTools
//
//  Created by hua on 16/5/20.
//  Copyright © 2016年 gaoxing. All rights reserved.
//

#import "GGXBLE.h"
#import "BleDeviceModel.h"
#import "BleInfoModel.h"
#import "BlereportModel.h"
@implementation GGXBLE
#pragma mark - 体脂称计算
#pragma mark - 体脂称计算
+(BleInfoModel *)setValueforInfo:(BleDeviceModel *)infoModel
{
    
    NSMutableDictionary *PersoncircleDict = [NSMutableDictionary dictionary];
    NSMutableDictionary *dataDict = [ NSMutableDictionary dictionary];
    NSMutableArray *  NostandarArr = [ NSMutableArray array];
    NSMutableArray *  YesstandarArr = [ NSMutableArray array];
    
    
    BleDeviceModel *cacheModel = [[BleDeviceModel alloc] init];
    
    
#pragma mark weight：体重
    if (infoModel.weight) {
        //标准体重
        NSInteger kmkg;
        //男
        if ([infoModel.gender  isEqualToString:@"0"]) {
            
            kmkg = [infoModel.height integerValue]-108;
            
        }else
        {
            kmkg = [infoModel.height integerValue]-116;
        }
        
        //Ble_weightseriousHighkgImage
        
        // 严重不足 seriousLowkg
        CGFloat  seriousLowkg =  kmkg *(1-0.2);
        //偏低 littleLowkg
        CGFloat  littleLowkg =  kmkg *(1-0.1);
        
        // 标准 standardkg
        
        // 偏高 littleHighkg
        CGFloat  littleHighkg =  kmkg *(1+0.1);
        
        // 严重超标 seriousHighkg
        CGFloat  seriousHighkg =  kmkg *(1+0.2);
        [PersoncircleDict setObject:[NSString stringWithFormat:@"%.2fkg - %.2fkg",littleLowkg,littleHighkg] forKey:@"weight：体重"];

        
        BlereportModel *reporeModel = [[ BlereportModel alloc] init];
        
        NSMutableArray *weightArr = [NSMutableArray array];
        [weightArr addObject:[NSString stringWithFormat:@"%.2fkg",seriousLowkg]];
        [weightArr addObject:[NSString stringWithFormat:@"%.2fkg",littleLowkg]];
        [weightArr addObject:[NSString stringWithFormat:@"%.2fkg",littleHighkg]];
        [weightArr addObject:[NSString stringWithFormat:@"%.2fkg",seriousHighkg]];
        
        if ([infoModel.weight floatValue] <seriousLowkg) {
            // 严重不足
            
            NSDictionary *  dict= [NSDictionary dictionaryWithObjectsAndKeys:@"Ble_weightImage",@"headerImage",@"体重",@"title", [NSString stringWithFormat:@"%@kg",infoModel.weight],@"kg",@"0",@"type",@"严重不足",@"typeName",@"analysisReport_gradeWeight",@"detailImage",@"长期体重过轻会导致一系统列问题，如脱发、厌食症等，身体机能会下降，需要加强营养，多吃高蛋白食物，摄入更多的热量以增加体重。",@"detailText",@"4",@"imageType",weightArr,@"weightArr",@"0",@"colortype", nil];
            [reporeModel setValuesForKeysWithDictionary:dict];
            [NostandarArr addObject:reporeModel];
            cacheModel.weight = @"4";
            
        }else if ([infoModel.weight floatValue] >= seriousLowkg && [infoModel.weight floatValue] <= littleLowkg)
        {
            //偏低
            NSDictionary * dict = [NSDictionary dictionaryWithObjectsAndKeys:@"Ble_weightImage",@"headerImage",@"体重",@"title",[NSString stringWithFormat:@"%@kg",infoModel.weight],@"kg",@"1",@"type",@"偏低",@"typeName",@"analysisReport_gradeWeight",@"detailImage",@"体重偏低，身体消瘦，建议加强营养，平衡饮食，多吃高蛋白食物，摄入更多的热量以增加体重。",@"detailText",@"4",@"imageType",weightArr,@"weightArr",@"1",@"colortype",   nil];
            [reporeModel setValuesForKeysWithDictionary:dict];
            [NostandarArr addObject:reporeModel];
            cacheModel.weight = @"6";
            
        }else if ([infoModel.weight floatValue] >littleLowkg && [infoModel.weight floatValue] <=littleHighkg)
        {
            //标准
            NSDictionary *  dict = [NSDictionary dictionaryWithObjectsAndKeys:@"Ble_weightImage",@"headerImage",@"体重",@"title",[NSString stringWithFormat:@"%@kg",infoModel.weight],@"kg",@"2",@"type",@"标准",@"typeName",@"analysisReport_gradeWeight",@"detailImage",@"恭喜您拥有理想的体重，保持合理健康的生活方式，适量参加运动，您就可以维持标准体重了",@"detailText",@"4",@"imageType",weightArr,@"weightArr",@"2",@"colortype",  nil];
            [reporeModel setValuesForKeysWithDictionary:dict];
            [YesstandarArr addObject:reporeModel];
            cacheModel.weight = @"10";
            
        }else if ([infoModel.weight floatValue] >littleHighkg && [infoModel.weight floatValue] <=seriousHighkg)
        {
            //偏高
            NSDictionary * dict = [NSDictionary dictionaryWithObjectsAndKeys:@"Ble_weightImage",@"headerImage",@"体重",@"title",[NSString stringWithFormat:@"%@kg",infoModel.weight],@"kg",@"3",@"type",@"偏高",@"typeName",@"analysisReport_gradeWeight",@"detailImage",@"体重偏重，略显肥胖，建议一周进行３-５次有氧运动，减少主食（米饭面食等）的摄入，增加高纤维粗粮比例。",@"detailText",@"4",@"imageType",weightArr,@"weightArr", @"3",@"colortype",  nil];
            [reporeModel setValuesForKeysWithDictionary:dict];
            [NostandarArr addObject:reporeModel];
            cacheModel.weight = @"6";
            
        }else if ([infoModel.weight floatValue] >seriousHighkg)
        {
            //严重超标
            NSDictionary *  dict = [NSDictionary dictionaryWithObjectsAndKeys:@"Ble_weightImage",@"headerImage",@"体重",@"title",[NSString stringWithFormat:@"%@kg",infoModel.weight],@"kg",@"4",@"type",@"严重超标",@"typeName",@"analysisReport_gradeWeight",@"detailImage",@"超重：提示营养过度或者肥胖，建议低脂、低胆固醇、高纤维膳食，补充多种维生素，增加运动量进行体重控制。",@"detailText",@"4",@"imageType",weightArr,@"weightArr",@"4",@"colortype",   nil];
            [reporeModel setValuesForKeysWithDictionary:dict];
            [NostandarArr addObject:reporeModel];
            cacheModel.weight = @"4";
        }
        
    }
    
#pragma mark bmi：身体质量指数
    if (infoModel.bmi) {
        //Ble_bmilittleLowkgImage
        //Ble_bmistandardkgImage
        //Ble_bmilittleHighkgImage
        //偏轻
        NSMutableArray *weightArr = [NSMutableArray array];
        [weightArr addObject:[NSString stringWithFormat:@"18.5"]];
        [weightArr addObject:[NSString stringWithFormat:@"25"]];
        [PersoncircleDict setObject:[NSString stringWithFormat:@"18.5 - 25"] forKey:@"bmi：身体质量指数"];
        
        BlereportModel *reporeModel = [[ BlereportModel alloc] init];
        if ([infoModel.bmi floatValue] <18.5) {
            
            NSDictionary *  dict = [NSDictionary dictionaryWithObjectsAndKeys:@"Ble_bmiImage",@"headerImage",@"BMI",@"title",[NSString stringWithFormat:@"%@",infoModel.bmi],@"kg",@"1",@"type",@"偏低",@"typeName",@"analysisReport_gradeThree",@"detailImage",@"BMI数值低于18.5，需要提升体能健康增重，适当多吃高热量、高蛋白、高脂肪饮食，多做力量运动如举重、俯卧撑、仰卧起坐、平板支撑等增加肌肉运动。\n\n身体质量指数，国际上常用的衡量人体群胖瘦程度以及是否健康的一个标准",@"detailText",@"2",@"imageType",weightArr,@"weightArr",@"0",@"colortype",  nil];
            [reporeModel setValuesForKeysWithDictionary:dict];
            [NostandarArr addObject:reporeModel];
            // DoLog(@"YesstandarArr:%@===NostandarArr:%@",YesstandarArr,NostandarArr);
            cacheModel.bmi = @"4";
        }else
            //标准
            if ([infoModel.bmi floatValue] >=18.5 && [infoModel.bmi floatValue] <=25) {
                NSDictionary *  dict = [NSDictionary dictionaryWithObjectsAndKeys:@"Ble_bmiImage",@"headerImage",@"BMI",@"title",[NSString stringWithFormat:@"%@",infoModel.bmi],@"kg",@"2",@"type",@"标准",@"typeName",@"analysisReport_gradeThree",@"detailImage",@"适中：BMI达标，\n\n身体质量指数，国际上常用的衡量人体群胖瘦程度以及是否健康的一个标准",@"detailText",@"2",@"imageType",weightArr,@"weightArr",@"1",@"colortype",  nil];
                [reporeModel setValuesForKeysWithDictionary:dict];
                [YesstandarArr addObject:reporeModel];
                cacheModel.bmi = @"9";
                // DoLog(@"YesstandarArr:%@===NostandarArr:%@",YesstandarArr,NostandarArr);
            }else
                //偏高
                if ([infoModel.bmi floatValue] > 25) {
                    NSDictionary *  dict = [NSDictionary dictionaryWithObjectsAndKeys:@"Ble_bmiImage",@"headerImage",@"BMI",@"title",[NSString stringWithFormat:@"%@",infoModel.bmi],@"kg",@"3",@"type",@"偏高",@"typeName",@"analysisReport_gradeThree",@"detailImage",@"BMI超标，建议选择比较健康的方法减重，如控制饮食、改变不良生活习惯和参加跑步、跳绳、打篮球、踢足球等消耗体能的运动。\n\n身体质量指数，国际上常用的衡量人体群胖瘦程度以及是否健康的一个标准",@"detailText",@"2",@"imageType",weightArr,@"weightArr",@"2",@"colortype",  nil];
                    [reporeModel setValuesForKeysWithDictionary:dict];
                    [NostandarArr addObject:reporeModel];
                    cacheModel.bmi = @"4";
                    //DoLog(@"YesstandarArr:%@===NostandarArr:%@",YesstandarArr,NostandarArr);
                }
    }
    
#pragma mark bodyfat：体脂肪率
    if (infoModel.bodyfat) {
        BlereportModel *reporeModel = [[ BlereportModel alloc] init];
        
        
        
        //男
        if ([infoModel.gender  isEqualToString:@"0"]) {
            
            NSMutableArray *weightArr = [NSMutableArray array];
            [weightArr addObject:[NSString stringWithFormat:@"11%%"]];
            [weightArr addObject:[NSString stringWithFormat:@"21%%"]];
            [weightArr addObject:[NSString stringWithFormat:@"26%%"]];
                  [PersoncircleDict setObject:[NSString stringWithFormat:@"11%% - 21%%"] forKey:@"bodyfat：体脂肪率"];
            if ([infoModel.bodyfat floatValue]<6) {
                // 瘦
                NSDictionary *  dict= [NSDictionary dictionaryWithObjectsAndKeys:@"Ble_bodyfatImage",@"headerImage",@"体脂肪率",@"title", [NSString stringWithFormat:@"%@\%%",infoModel.bodyfat],@"kg",@"0",@"type",@"瘦",@"typeName",@"analysisReport_gradeFatRate",@"detailImage",@"脂肪是生命体构建的重要部分，无法取代。长时间的低体脂肪率，生长激素、性激素、大脑细胞等都受到极大的损害，也会影响脂溶维生素的消化吸收。",@"detailText",@"3",@"imageType",weightArr,@"weightArr",@"0",@"colortype",   nil];
                [reporeModel setValuesForKeysWithDictionary:dict];
                [NostandarArr addObject:reporeModel];
                cacheModel.bodyfat = @"1";
                
            }else if (([infoModel.bodyfat floatValue]>6 ||[infoModel.bodyfat floatValue] == 6 )&& [infoModel.bodyfat floatValue]< 11)
            {
                // 偏瘦
                NSDictionary *  dict= [NSDictionary dictionaryWithObjectsAndKeys:@"Ble_bodyfatImage",@"headerImage",@"体脂肪率",@"title", [NSString stringWithFormat:@"%@\%%",infoModel.bodyfat],@"kg",@"1",@"type",@"偏瘦",@"typeName",@"analysisReport_gradeFatRate",@"detailImage",@"当身体摄取到优质营养，并且令到小肠绒毛正常运作，就可以达到正常的脂肪比例。为了增重，食物最好以易消化、高蛋白、高热量为原则。",@"detailText",@"3",@"imageType",weightArr,@"weightArr",@"0",@"colortype",  nil];
                [reporeModel setValuesForKeysWithDictionary:dict];
                [NostandarArr addObject:reporeModel];
                cacheModel.bodyfat = @"4";
                
            }else if (([infoModel.bodyfat floatValue]>11 ||[infoModel.bodyfat floatValue] == 11 )&& ([infoModel.bodyfat floatValue]< 21||[infoModel.bodyfat floatValue] ==21))
            {
                // 标准
                NSDictionary *  dict= [NSDictionary dictionaryWithObjectsAndKeys:@"Ble_bodyfatImage",@"headerImage",@"体脂肪率",@"title", [NSString stringWithFormat:@"%@\%%",infoModel.bodyfat],@"kg",@"2",@"type",@"标准",@"typeName",@"analysisReport_gradeFatRate",@"detailImage",@"目前您的体脂肪率处于标准范围，保持好的饮食方式和生活习惯是保持健康身材的最佳途径。",@"detailText",@"3",@"imageType",weightArr,@"weightArr",@"1",@"colortype",  nil];
                [reporeModel setValuesForKeysWithDictionary:dict];
                [YesstandarArr addObject:reporeModel];
                
                cacheModel.bodyfat = @"8";
                
            }else if ([infoModel.bodyfat floatValue]>21 && ([infoModel.bodyfat floatValue]< 26||[infoModel.bodyfat floatValue] ==26))
            {
                // 微胖
                NSDictionary *  dict= [NSDictionary dictionaryWithObjectsAndKeys:@"Ble_bodyfatImage",@"headerImage",@"体脂肪率",@"title", [NSString stringWithFormat:@"%@\%%",infoModel.bodyfat],@"kg",@"3",@"type",@"微胖",@"typeName",@"analysisReport_gradeFatRate",@"detailImage",@"要匀称不显胖，每日有氧运动要持续30分钟，体脂肪才会开始燃烧，快走、慢跑、游泳、爬楼梯、骑自行车都是很好的选择。",@"detailText",@"3",@"imageType",weightArr,@"weightArr",@"2",@"colortype", nil];
                [reporeModel setValuesForKeysWithDictionary:dict];
                [NostandarArr addObject:reporeModel];
                infoModel.bodyfat = @"4";
                
            }else if ([infoModel.bodyfat floatValue]>26  )
            {
                // 肥胖
                NSDictionary *  dict= [NSDictionary dictionaryWithObjectsAndKeys:@"Ble_bodyfatImage",@"headerImage",@"体脂肪率",@"title", [NSString stringWithFormat:@"%@\%%",infoModel.bodyfat],@"kg",@"4",@"type",@"肥胖",@"typeName",@"analysisReport_gradeFatRate",@"detailImage",@"您的体内囤积了太多脂肪，必须检测血压、血糖、肝功能等情况，是否潜藏危害。赶快开始您的减肥大战，坚持饮食控制、运动及改变生活方式。",@"detailText",@"3",@"imageType",weightArr,@"weightArr",@"3",@"colortype", nil];
                [reporeModel setValuesForKeysWithDictionary:dict];
                [NostandarArr addObject:reporeModel];
                
                cacheModel.bodyfat = @"1";
            }
            
        }else
        {
            NSMutableArray *weightArr = [NSMutableArray array];
            [weightArr addObject:[NSString stringWithFormat:@"21%%"]];
            [weightArr addObject:[NSString stringWithFormat:@"31%%"]];
            [weightArr addObject:[NSString stringWithFormat:@"36%%"]];
            [PersoncircleDict setObject:[NSString stringWithFormat:@"21%% - 31%%"] forKey:@"bodyfat：体脂肪率"];
            if ([infoModel.bodyfat floatValue]<16) {
                // 瘦
                NSDictionary *  dict= [NSDictionary dictionaryWithObjectsAndKeys:@"Ble_bodyfatImage",@"headerImage",@"体脂肪率",@"title", [NSString stringWithFormat:@"%@\%%",infoModel.bodyfat],@"kg",@"0",@"type",@"瘦",@"typeName",@"analysisReport_gradeFatRate",@"detailImage",@"脂肪是生命体构建的重要部分，无法取代。长时间的低体脂肪率，生长激素、性激素、大脑细胞等都受到极大的损害，也会影响脂溶维生素的消化吸收。",@"detailText",@"3",@"imageType",weightArr,@"weightArr",@"0",@"colortype", nil];
                [reporeModel setValuesForKeysWithDictionary:dict];
                [NostandarArr addObject:reporeModel];
                cacheModel.bodyfat = @"1";
                
            }else if (([infoModel.bodyfat floatValue]>16 ||[infoModel.bodyfat floatValue] == 16 )&& [infoModel.bodyfat floatValue]< 21)
            {
                // 偏瘦
                NSDictionary *  dict= [NSDictionary dictionaryWithObjectsAndKeys:@"Ble_bodyfatImage",@"headerImage",@"体脂肪率",@"title", [NSString stringWithFormat:@"%@\%%",infoModel.bodyfat],@"kg",@"1",@"type",@"偏瘦",@"typeName",@"analysisReport_gradeFatRate",@"detailImage",@"当身体摄取到优质营养，并且令到小肠绒毛正常运作，就可以达到正常的脂肪比例。为了增重，食物最好以易消化、高蛋白、高热量为原则。",@"detailText",@"3",@"imageType",weightArr,@"weightArr",@"0",@"colortype", nil];
                [reporeModel setValuesForKeysWithDictionary:dict];
                [NostandarArr addObject:reporeModel];
                cacheModel.bodyfat = @"4";
                
            }else if (([infoModel.bodyfat floatValue]>21 ||[infoModel.bodyfat floatValue] == 21 )&& ([infoModel.bodyfat floatValue]< 31||[infoModel.bodyfat floatValue] ==31))
            {
                // 标准
                NSDictionary *  dict= [NSDictionary dictionaryWithObjectsAndKeys:@"Ble_bodyfatImage",@"headerImage",@"体脂肪率",@"title", [NSString stringWithFormat:@"%@\%%",infoModel.bodyfat],@"kg",@"2",@"type",@"标准",@"typeName",@"analysisReport_gradeFatRate",@"detailImage",@"目前您的体脂肪率处于标准范围，保持好的饮食方式和生活习惯是保持健康身材的最佳途径。",@"detailText",@"3",@"imageType",weightArr,@"weightArr",@"1",@"colortype", nil];
                [reporeModel setValuesForKeysWithDictionary:dict];
                [YesstandarArr addObject:reporeModel];
                cacheModel.bodyfat = @"8";
                
            }else if ([infoModel.bodyfat floatValue]>31 && ([infoModel.bodyfat floatValue]< 36||[infoModel.bodyfat floatValue] ==36))
            {
                // 微胖
                NSDictionary *  dict= [NSDictionary dictionaryWithObjectsAndKeys:@"Ble_bodyfatImage",@"headerImage",@"体脂肪率",@"title", [NSString stringWithFormat:@"%@\%%",infoModel.bodyfat],@"kg",@"3",@"type",@"微胖",@"typeName",@"analysisReport_gradeFatRate",@"detailImage",@"要匀称不显胖，每日有氧运动要持续30分钟，体脂肪才会开始燃烧，快走、慢跑、游泳、爬楼梯、骑自行车都是很好的选择。",@"detailText",@"3",@"imageType",weightArr,@"weightArr",@"2",@"colortype", nil];
                [reporeModel setValuesForKeysWithDictionary:dict];
                [NostandarArr addObject:reporeModel];
                
                cacheModel.bodyfat = @"4";
            }else if ([infoModel.bodyfat floatValue]>36  )
            {
                // 肥胖
                NSDictionary *  dict= [NSDictionary dictionaryWithObjectsAndKeys:@"Ble_bodyfatImage",@"headerImage",@"体脂肪率",@"title", [NSString stringWithFormat:@"%@\%%",infoModel.bodyfat],@"kg",@"4",@"type",@"肥胖",@"typeName",@"analysisReport_gradeFatRate",@"detailImage",@"您的体内囤积了太多脂肪，必须检测血压、血糖、肝功能等情况，是否潜藏危害。赶快开始您的减肥大战，坚持饮食控制、运动及改变生活方式。",@"detailText",@"3",@"imageType",weightArr,@"weightArr",@"3",@"colortype", nil];
                [reporeModel setValuesForKeysWithDictionary:dict];
                [NostandarArr addObject:reporeModel];
                
                cacheModel.bodyfat = @"1";
            }
        }
        
    }
    
#pragma mark muscle：骨骼肌率
    if (infoModel.muscle) {
        
        //Ble_muscleImage
        //Ble_musclelittleLowkgImage
        //Ble_musclestandardkgImage
        //Ble_musclelittleHighkgImage
        
        BlereportModel *reporeModel = [[ BlereportModel alloc] init];
        //男
        if ([infoModel.gender  isEqualToString:@"0"]) {
            NSMutableArray *weightArr = [NSMutableArray array];
            [weightArr addObject:[NSString stringWithFormat:@"49%%"]];
            [weightArr addObject:[NSString stringWithFormat:@"59%%"]];
                  [PersoncircleDict setObject:[NSString stringWithFormat:@"49%% - 59%%"] forKey:@"muscle：骨骼肌率"];
            if ([infoModel.muscle floatValue]<49) {
                // 偏低
                NSDictionary *  dict= [NSDictionary dictionaryWithObjectsAndKeys:@"Ble_muscleImage",@"headerImage",@"骨骼肌率",@"title", [NSString stringWithFormat:@"%@\%%",infoModel.muscle],@"kg",@"1",@"type",@"偏低",@"typeName",@"analysisReport_gradeThree",@"detailImage",@"您的肌肉比例低于理想范围，跟多静态活动、不运动有关，会导致基础代谢率降低，腰酸背痛，力量下降，外在表现是发胖，也容易诱发心血管疾病。\n\n人体有多个肌肉组成，其中骨胳肌是可以通过锻炼增加的肌肉。",@"detailText",@"2",@"imageType",weightArr,@"weightArr",@"0",@"colortype", nil];
                [reporeModel setValuesForKeysWithDictionary:dict];
                [NostandarArr addObject:reporeModel];
                cacheModel.muscle = @"4";
                
            }else if ([infoModel.muscle floatValue] >=49 && [infoModel.muscle floatValue] <=59)
            {
                // 标准
                NSDictionary *  dict= [NSDictionary dictionaryWithObjectsAndKeys:@"Ble_muscleImage",@"headerImage",@"骨骼肌率",@"title", [NSString stringWithFormat:@"%@\%%",infoModel.muscle],@"kg",@"2",@"type",@"标准",@"typeName",@"analysisReport_gradeThree",@"detailImage",@"您的肌肉比例处于标准范围。运动量过少或者节食会导致肌肉流失，请保持适当的运动量和合理的饮食。\n\n人体有多个肌肉组成，其中骨胳肌是可以通过锻炼增加的肌肉。",@"detailText",@"2",@"imageType",weightArr,@"weightArr",@"1",@"colortype", nil];
                [reporeModel setValuesForKeysWithDictionary:dict];
                [YesstandarArr addObject:reporeModel];
                cacheModel.muscle = @"9";
            }else if ([infoModel.muscle floatValue] >59 )
            {
                // 偏高
                NSDictionary *  dict= [NSDictionary dictionaryWithObjectsAndKeys:@"Ble_muscleImage",@"headerImage",@"骨骼肌率",@"title", [NSString stringWithFormat:@"%@\%%",infoModel.muscle],@"kg",@"3",@"type",@"偏高",@"typeName",@"analysisReport_gradeThree",@"detailImage",@"如果脂肪比例正常，您是一个比较喜欢运动的人，适当的肌肉比例能够显示您健壮的体形，但过高的肌肉比例可能会影响您的灵活性。如果脂肪比例偏低，您的身材可能偏瘦，平衡身体各项参数，您就能拥有健康标准的身材。\n\n人体有多个肌肉组成，其中骨胳肌是可以通过锻炼增加的肌肉。",@"detailText",@"2",@"imageType",weightArr,@"weightArr",@"2",@"colortype", nil];
                [reporeModel setValuesForKeysWithDictionary:dict];
                [NostandarArr addObject:reporeModel];
                cacheModel.muscle = @"4";
            }
            
        }else
        {
            NSMutableArray *weightArr = [NSMutableArray array];
            [weightArr addObject:[NSString stringWithFormat:@"40%%"]];
            [weightArr addObject:[NSString stringWithFormat:@"50%%"]];
             [PersoncircleDict setObject:[NSString stringWithFormat:@"40%% - 50%%"] forKey:@"muscle：骨骼肌率"];
            if ([infoModel.muscle floatValue]<40) {
                // 偏低
                NSDictionary *  dict= [NSDictionary dictionaryWithObjectsAndKeys:@"Ble_muscleImage",@"headerImage",@"骨骼肌率",@"title", [NSString stringWithFormat:@"%@\%%",infoModel.muscle],@"kg",@"1",@"type",@"偏低",@"typeName",@"analysisReport_gradeThree",@"detailImage",@"您的肌肉比例低于理想范围，跟多静态活动、不运动有关，会导致基础代谢率降低，腰酸背痛，力量下降，外在表现是发胖，也容易诱发心血管疾病。\n\n人体有多个肌肉组成，其中骨胳肌是可以通过锻炼增加的肌肉。",@"detailText",@"2",@"imageType",weightArr,@"weightArr",@"0",@"colortype", nil];
                [reporeModel setValuesForKeysWithDictionary:dict];
                [NostandarArr addObject:reporeModel];
                cacheModel.muscle = @"4";
                
            }else if ([infoModel.muscle floatValue] >=40 && [infoModel.muscle floatValue] <=50)
            {
                // 标准
                NSDictionary *  dict= [NSDictionary dictionaryWithObjectsAndKeys:@"Ble_muscleImage",@"headerImage",@"骨骼肌率",@"title", [NSString stringWithFormat:@"%@\%%",infoModel.muscle],@"kg",@"2",@"type",@"标准",@"typeName",@"analysisReport_gradeThree",@"detailImage",@"您的肌肉比例处于标准范围。运动量过少或者节食会导致肌肉流失，请保持适当的运动量和合理的饮食。\n\n人体有多个肌肉组成，其中骨胳肌是可以通过锻炼增加的肌肉。",@"detailText",@"2",@"imageType",weightArr,@"weightArr",@"1",@"colortype", nil];
                [reporeModel setValuesForKeysWithDictionary:dict];
                [YesstandarArr addObject:reporeModel];
                cacheModel.muscle = @"9";
            }else if ([infoModel.muscle floatValue] >50 )
            {
                // 偏高
                NSDictionary *  dict= [NSDictionary dictionaryWithObjectsAndKeys:@"Ble_muscleImage",@"headerImage",@"骨骼肌率",@"title", [NSString stringWithFormat:@"%@\%%",infoModel.muscle],@"kg",@"3",@"type",@"偏高",@"typeName",@"analysisReport_gradeThree",@"detailImage",@"如果脂肪比例正常，您是一个比较喜欢运动的人，适当的肌肉比例能够显示您健壮的体形，但过高的肌肉比例可能会影响您的灵活性。如果脂肪比例偏低，您的身材可能偏瘦，平衡身体各项参数，您就能拥有健康标准的身材。\n\n人体有多个肌肉组成，其中骨胳肌是可以通过锻炼增加的肌肉。",@"detailText",@"2",@"imageType",weightArr,@"weightArr",@"2",@"colortype", nil];
                [reporeModel setValuesForKeysWithDictionary:dict];
                [NostandarArr addObject:reporeModel];
                cacheModel.muscle = @"4";
            }
            
        }
    }
    
#pragma mark visfat：内脏脂肪等级
    if (infoModel.visfat) {
        
        //Ble_visfatImage
        
        //Ble_visfatstandardkgImage
        //Ble_visfatlittleHighkgImage
        // Ble_visfatseriousHighkgImage
        NSMutableArray *weightArr = [NSMutableArray array];
        [weightArr addObject:[NSString stringWithFormat:@"9"]];
        [weightArr addObject:[NSString stringWithFormat:@"14"]];
              [PersoncircleDict setObject:[NSString stringWithFormat:@"0 - 9"] forKey:@"visfat：内脏脂肪等级"];
        BlereportModel *reporeModel = [[ BlereportModel alloc] init];
        if ([infoModel.visfat integerValue]< 8) {
            // 标准
            NSDictionary *  dict= [NSDictionary dictionaryWithObjectsAndKeys:@"Ble_visfatImage",@"headerImage",@"内脏脂肪等级",@"title", [NSString stringWithFormat:@"%@",infoModel.visfat],@"kg",@"2",@"type",@"标准",@"typeName",@"analysisReport_gradeVisceralFat",@"detailImage",@"内脏脂肪指数标准，暂时没有太大风险\n\n内脏脂肪等级反映内脏脂肪堆积的程度。内脏脂肪越多，高血压、冠心病、高血脂、动脉硬化、心脏病等慢性疾病的几率就会越高。",@"detailText",@"2",@"imageType",weightArr,@"weightArr",@"0",@"colortype", nil];
            [reporeModel setValuesForKeysWithDictionary:dict];
            [YesstandarArr addObject:reporeModel];
            cacheModel.visfat = @"9";
            
        }else if ([infoModel.visfat integerValue] >=8 &&[infoModel.visfat integerValue] < 10)
        {
            // 标准
            NSDictionary *  dict= [NSDictionary dictionaryWithObjectsAndKeys:@"Ble_visfatImage",@"headerImage",@"内脏脂肪等级",@"title", [NSString stringWithFormat:@"%@",infoModel.visfat],@"kg",@"2",@"type",@"标准",@"typeName",@"analysisReport_gradeVisceralFat",@"detailImage",@"虽然处于标准范围，但内脏脂肪已经开始堆积，请积极运动，改变久做不动、饮食不均衡等不良习惯。\n\n内脏脂肪等级反映内脏脂肪堆积的程度。内脏脂肪越多，高血压、冠心病、高血脂、动脉硬化、心脏病等慢性疾病的几率就会越高。",@"detailText",@"2",@"imageType",weightArr,@"weightArr",@"0",@"colortype",nil];
            [reporeModel setValuesForKeysWithDictionary:dict];
            [YesstandarArr addObject:reporeModel];
            cacheModel.visfat = @"9";
        }
        else if ([infoModel.visfat integerValue] >=10 &&[infoModel.visfat integerValue] <= 15)
        {
            // 偏高
            NSDictionary *  dict= [NSDictionary dictionaryWithObjectsAndKeys:@"Ble_visfatImage",@"headerImage",@"内脏脂肪等级",@"title", [NSString stringWithFormat:@"%@",infoModel.visfat],@"kg",@"3",@"type",@"偏高",@"typeName",@"analysisReport_gradeVisceralFat",@"detailImage",@"内脏脂肪指数偏高，持续保持均衡的饮食和适当的运动，以标准程度为目标，进行适当运动和限制卡路里。\n\n内脏脂肪等级反映内脏脂肪堆积的程度。内脏脂肪越多，高血压、冠心病、高血脂、动脉硬化、心脏病等慢性疾病的几率就会越高。",@"detailText",@"2",@"imageType",weightArr,@"weightArr",@"1",@"colortype", nil];
            [reporeModel setValuesForKeysWithDictionary:dict];
            [NostandarArr addObject:reporeModel];
            cacheModel.visfat = @"4";
            
        } else if ([infoModel.visfat integerValue] >15)
        {
            // 严重超标
            NSDictionary *  dict= [NSDictionary dictionaryWithObjectsAndKeys:@"Ble_visfatImage",@"headerImage",@"内脏脂肪等级",@"title", [NSString stringWithFormat:@"%@",infoModel.visfat],@"kg",@"4",@"type",@"严重超标",@"typeName",@"analysisReport_gradeVisceralFat",@"detailImage",@"内脏脂肪指数危险，罹患心脏病、高血压、高血脂和Ⅱ型糖尿病风险大，您迫切需要控制体重、积极运动和限制饮食。\n\n内脏脂肪等级反映内脏脂肪堆积的程度。内脏脂肪越多，高血压、冠心病、高血脂、动脉硬化、心脏病等慢性疾病的几率就会越高。",@"detailText",@"2",@"imageType",weightArr,@"weightArr",@"2",@"colortype", nil];
            [reporeModel setValuesForKeysWithDictionary:dict];
            [NostandarArr addObject:reporeModel];
            cacheModel.visfat = @"1";
        }
        
    }
    
#pragma mark bmr：基础代谢量
    if (infoModel.bmr) {
        
        CGFloat kcal ;
        BlereportModel *reporeModel = [[ BlereportModel alloc] init];
        NSLog(@"基础代谢量:%ld",[GGXBLE setDataStr:infoModel.birthday time:infoModel.measure_time]);
        //男
        if ([infoModel.gender  isEqualToString:@"0"]) {
            //kcal = 15.3*[infoModel.weight doubleValue]+679;
            kcal = 9.99*[infoModel.weight doubleValue]+6.25*[infoModel.height floatValue]-4.92*[GGXBLE setDataStr:infoModel.birthday time:infoModel.measure_time] +5;
            // kcal = kcal *0.9055;
            NSLog(@"%f===%f",kcal*0.90,kcal*1.1);
            
        }else
        {
            //            kcal = 14.7*[infoModel.weight floatValue]+496;
            kcal = 9.99*[infoModel.weight doubleValue]+6.25*[infoModel.height floatValue]-4.92*[GGXBLE setDataStr:infoModel.birthday time:infoModel.measure_time] -161;
            NSLog(@"%f===%f",kcal*0.90,kcal*1.1);
        }
        [PersoncircleDict setObject:[NSString stringWithFormat:@"%.2fkcal - %.2fkcal",kcal*0.90,kcal*1.1] forKey:@"bmr：基础代谢量"];

        
        if ([infoModel.bmr doubleValue] >= kcal*0.90 && [infoModel.bmr doubleValue] <= kcal*1.1) {
            
            // 达标
            NSDictionary *  dict= [NSDictionary dictionaryWithObjectsAndKeys:@"Ble_bmrImage",@"headerImage",@"基础代谢量",@"title", [NSString stringWithFormat:@"%@kcal",infoModel.bmr],@"kg",@"2",@"type",@"达标",@"typeName", [NSString stringWithFormat:@"您的标准基础代谢量为%@kcal，目前您的基础代谢量已达标。保持基础代谢量最有效的方式是每天都进行适量的运动。\n\n基础代谢量是指人体在非活动状态下，维持生命所需必须消耗的能量。",infoModel.bmr],@"detailText",@"",@"detailImage", nil];
            [reporeModel setValuesForKeysWithDictionary:dict];
            [YesstandarArr addObject:reporeModel];
            cacheModel.bmr = @"9";
        }else
        {
            
            // 不达标
            NSDictionary *  dict= [NSDictionary dictionaryWithObjectsAndKeys:@"Ble_bmrImage",@"headerImage",@"基础代谢量",@"title", [NSString stringWithFormat:@"%@kcal",infoModel.bmr],@"kg",@"3",@"type",@"不达标",@"typeName",[NSString stringWithFormat:@"您的标准基础代谢量为%@kcal，目前您的基础代谢量不达标。持续轻量运动能够提高身体的基础代谢量，而节食基础代谢会大幅下降。\n\n基础代谢量是指人体在非活动状态下，维持生命所需必须消耗的能量。",infoModel.bmr],@"detailText",@"",@"detailImage", nil];
            [reporeModel setValuesForKeysWithDictionary:dict];
            [NostandarArr addObject:reporeModel];
            cacheModel.bmr = @"3";
        }
        
        
        
    }
    
#pragma mark water：体水分
    if (infoModel.water) {
        //Ble_waterlittleLowkgImage
        //Ble_waterstandardkgImage
        //Ble_waterlittleHighkgImage
        BlereportModel *reporeModel = [[ BlereportModel alloc] init];
        
        //男
        if ([infoModel.gender  isEqualToString:@"0"]) {
            NSMutableArray *weightArr = [NSMutableArray array];
            [weightArr addObject:[NSString stringWithFormat:@"55%%"]];
            [weightArr addObject:[NSString stringWithFormat:@"65%%"]];
              [PersoncircleDict setObject:[NSString stringWithFormat:@"55%% - 65%%"] forKey:@"water：体水分"];
            if ([infoModel.water floatValue] <55) {
                // 偏低
                NSDictionary *  dict= [NSDictionary dictionaryWithObjectsAndKeys:@"Ble_waterImage",@"headerImage",@"体水分",@"title", [NSString stringWithFormat:@"%@\%%",infoModel.water],@"kg",@"1",@"type",@"偏低",@"typeName",@"体水分率偏低，规律的饮食习惯和每天喝足8杯水可以维持正常的体水分水平，充足的水分可以促进代谢，带走废物和身体毒素。\n\n水分在身体中占有很大比例，对水分率的测量也可以反映身体胖瘦水平。减肥期间水分率的变化还反映减肥方向是否正确，减肥过程中一味减低身体水分率，反而会令身体脂肪率上升。",@"detailText",@"analysisReport_gradeThree",@"detailImage",@"2",@"imageType",weightArr,@"weightArr",@"0",@"colortype", nil];
                [reporeModel setValuesForKeysWithDictionary:dict];
                [NostandarArr addObject:reporeModel];
                cacheModel.water = @"4";
                
            }else if  ([infoModel.water floatValue] >=55 && [infoModel.water floatValue] <=65)
            {
                // 标准
                NSDictionary *  dict= [NSDictionary dictionaryWithObjectsAndKeys:@"Ble_waterImage",@"headerImage",@"体水分",@"title", [NSString stringWithFormat:@"%@\%%",infoModel.water],@"kg",@"2",@"type",@"标准",@"typeName", @"身体水分率处于标准值，适量饮水，适当运动，均衡饮食，保持身体水分的平衡，每天需要保证摄入8杯水。\n\n水分在身体中占有很大比例，对水分率的测量也可以反映身体胖瘦水平。减肥期间水分率的变化还反映减肥方向是否正确，减肥过程中一味减低身体水分率，反而会令身体脂肪率上升。",@"detailText",@"analysisReport_gradeThree",@"detailImage",@"2",@"imageType",weightArr,@"weightArr",@"1",@"colortype", nil];
                [reporeModel setValuesForKeysWithDictionary:dict];
                [YesstandarArr addObject:reporeModel];
                cacheModel.water = @"9";
                
            }else  if ([infoModel.water floatValue] >65) {
                // 偏高
                NSDictionary *  dict= [NSDictionary dictionaryWithObjectsAndKeys:@"Ble_waterImage",@"headerImage",@"体水分",@"title", [NSString stringWithFormat:@"%@\%%",infoModel.water],@"kg",@"2",@"type",@"标准",@"typeName",@"身体水分含量高，细胞活性高。充足的水分能帮助您更好地消化食物和吸收养分，并促进代谢，带走废物和毒素。\n\n水分在身体中占有很大比例，对水分率的测量也可以反映身体胖瘦水平。减肥期间水分率的变化还反映减肥方向是否正确，减肥过程中一味减低身体水分率，反而会令身体脂肪率上升。",@"detailText",@"analysisReport_gradeThree",@"detailImage",@"2",@"imageType",weightArr,@"weightArr",@"2",@"colortype", nil];
                [reporeModel setValuesForKeysWithDictionary:dict];
                [YesstandarArr addObject:reporeModel];
                cacheModel.water = @"6";
            }
            
            
        }else{
            NSMutableArray *weightArr = [NSMutableArray array];
            [weightArr addObject:[NSString stringWithFormat:@"45%%"]];
            [weightArr addObject:[NSString stringWithFormat:@"60%%"]];
            [PersoncircleDict setObject:[NSString stringWithFormat:@"45%% - 60%%"] forKey:@"water：体水分"];
            if ([infoModel.water floatValue] <45) {
                
                // 偏低
                NSDictionary *  dict= [NSDictionary dictionaryWithObjectsAndKeys:@"Ble_waterImage",@"headerImage",@"体水分",@"title", [NSString stringWithFormat:@"%@\%%",infoModel.water],@"kg",@"1",@"type",@"偏低",@"typeName",@"体水分率偏低，规律的饮食习惯和每天喝足8杯水可以维持正常的体水分水平，充足的水分可以促进代谢，带走废物和身体毒素。\n\n水分在身体中占有很大比例，对水分率的测量也可以反映身体胖瘦水平。减肥期间水分率的变化还反映减肥方向是否正确，减肥过程中一味减低身体水分率，反而会令身体脂肪率上升。",@"detailText",@"analysisReport_gradeThree",@"detailImage", @"2",@"imageType",weightArr,@"weightArr",@"0",@"colortype",nil];
                [reporeModel setValuesForKeysWithDictionary:dict];
                [NostandarArr addObject:reporeModel];
                cacheModel.water = @"4";
            }else if  ([infoModel.water floatValue] >=45 && [infoModel.water floatValue] <=60)
            {
                // 标准
                NSDictionary *  dict= [NSDictionary dictionaryWithObjectsAndKeys:@"Ble_waterImage",@"headerImage",@"体水分",@"title", [NSString stringWithFormat:@"%@\%%",infoModel.water],@"kg",@"2",@"type",@"标准",@"typeName", @"身体水分率处于标准值，适量饮水，适当运动，均衡饮食，保持身体水分的平衡，每天需要保证摄入8杯水。\n\n水分在身体中占有很大比例，对水分率的测量也可以反映身体胖瘦水平。减肥期间水分率的变化还反映减肥方向是否正确，减肥过程中一味减低身体水分率，反而会令身体脂肪率上升。",@"detailText",@"analysisReport_gradeThree",@"detailImage",@"2",@"imageType",weightArr,@"weightArr",@"1",@"colortype", nil];
                [reporeModel setValuesForKeysWithDictionary:dict];
                [YesstandarArr addObject:reporeModel];
                cacheModel.water = @"9";
            }else  if ([infoModel.water floatValue] >60) {
                // 偏高
                NSDictionary *  dict= [NSDictionary dictionaryWithObjectsAndKeys:@"Ble_waterImage",@"headerImage",@"体水分",@"title", [NSString stringWithFormat:@"%@\%%",infoModel.water],@"kg",@"2",@"type",@"标准",@"typeName",@"身体水分含量高，细胞活性高。充足的水分能帮助您更好地消化食物和吸收养分，并促进代谢，带走废物和毒素。\n\n水分在身体中占有很大比例，对水分率的测量也可以反映身体胖瘦水平。减肥期间水分率的变化还反映减肥方向是否正确，减肥过程中一味减低身体水分率，反而会令身体脂肪率上升。",@"detailText",@"analysisReport_gradeThree",@"detailImage",@"2",@"imageType",weightArr,@"weightArr",@"2",@"colortype", nil];
                [reporeModel setValuesForKeysWithDictionary:dict];
                [YesstandarArr addObject:reporeModel];
                cacheModel.water = @"6";
            }
        }
        
    }
    
#pragma mark bone：骨量
    if (infoModel.bone) {
        //Ble_bonelittleLowkgImage
        //Ble_bonestandardkgImage
        //Ble_bonelittleHighkgImage
        BlereportModel *reporeModel = [[ BlereportModel alloc] init];
        
        //男
        if ([infoModel.gender  isEqualToString:@"0"]) {
            
            
            if ([infoModel.weight floatValue] <60 ||[infoModel.weight floatValue]  ==60) {
                NSMutableArray *weightArr = [NSMutableArray array];
                [weightArr addObject:[NSString stringWithFormat:@"%.1fkg",(2.5*0.95)]];
                [weightArr addObject:[NSString stringWithFormat:@"%.1fkg",(2.5*1.05)]];
                [PersoncircleDict setObject:[NSString stringWithFormat:@"%.1fkg - %.1fkg",(2.5*0.95),(2.5*1.05)] forKey:@"bone：骨量"];
                
                if ([infoModel.bone floatValue] <(2.5*(1-0.05))) {
                    // 偏低
                    NSDictionary *  dict= [NSDictionary dictionaryWithObjectsAndKeys:@"Ble_boneImage",@"headerImage",@"骨量",@"title", [NSString stringWithFormat:@"%@kg",infoModel.bone],@"kg",@"1",@"type",@"偏低",@"typeName",@"您的骨量水平偏低。长期低钙饮食、缺乏运动、过度减肥等都可能引起骨量偏低，多吃含钙高的食物，多晒太阳，多运动及时补钙。\n\n骨量是指单位体积内，骨组织包括骨矿物质（钙、磷等）和骨基质（骨胶原、蛋白质、无机盐等）含量，骨量代表骨骼健康的情况。",@"detailText",@"analysisReport_gradeThree",@"detailImage",@"2",@"imageType",weightArr,@"weightArr",@"0",@"colortype", nil];
                    [reporeModel setValuesForKeysWithDictionary:dict];
                    [NostandarArr addObject:reporeModel];
                    cacheModel.bone = @"6";
                    
                }else if([infoModel.bone floatValue] >=(2.5*0.95) && [infoModel.bone floatValue] <=(2.5*1.05) )
                { // 标准
                    NSDictionary *  dict= [NSDictionary dictionaryWithObjectsAndKeys:@"Ble_boneImage",@"headerImage",@"骨量",@"title", [NSString stringWithFormat:@"%@kg",infoModel.bone],@"kg",@"2",@"type",@"标准",@"typeName",@"您的骨量水平标准。骨量在短期内不会出现明显的变化，您只要保证健康的饮食和适当的锻炼，就可以维持稳定健康的骨量水平。\n\n骨量是指单位体积内，骨组织包括骨矿物质（钙、磷等）和骨基质（骨胶原、蛋白质、无机盐等）含量，骨量代表骨骼健康的情况。",@"detailText",@"analysisReport_gradeThree",@"detailImage",@"2",@"imageType",weightArr,@"weightArr",@"1",@"colortype", nil];
                    [reporeModel setValuesForKeysWithDictionary:dict];
                    [YesstandarArr addObject:reporeModel];
                    cacheModel.bone = @"9";
                    
                }else if([infoModel.bone floatValue] >(2.5*1.05))
                {// 偏高
                    NSDictionary *  dict= [NSDictionary dictionaryWithObjectsAndKeys:@"Ble_boneImage",@"headerImage",@"骨量",@"title", [NSString stringWithFormat:@"%@kg",infoModel.bone],@"kg",@"3",@"type",@"偏高",@"typeName",@"您的骨量水平偏高。说明骨骼中包含的钙等无机盐的含量非常充分，但要注意防范肾结石、低血压的风险，尽量避免高钙摄入。\n\n骨量是指单位体积内，骨组织包括骨矿物质（钙、磷等）和骨基质（骨胶原、蛋白质、无机盐等）含量，骨量代表骨骼健康的情况。",@"detailText",@"analysisReport_gradeThree",@"detailImage", @"2",@"imageType",weightArr,@"weightArr",@"2",@"colortype",nil];
                    NSLog(@"%@",dict);
                    [reporeModel setValuesForKeysWithDictionary:dict];
                    [NostandarArr addObject:reporeModel];
                    cacheModel.bone = @"6";
                }
                //
            }else if  ([infoModel.weight floatValue]  >60 && [infoModel.weight floatValue]  <75)
            {
                NSMutableArray *weightArr = [NSMutableArray array];
                [weightArr addObject:[NSString stringWithFormat:@"%.1fkg",(2.9*0.95)]];
                [weightArr addObject:[NSString stringWithFormat:@"%.1fkg",(2.9*1.05)]];
                 [PersoncircleDict setObject:[NSString stringWithFormat:@"%.1fkg - %.1fkg",(2.9*0.95),(2.9*1.05)] forKey:@"bone：骨量"];
                if ([infoModel.bone floatValue] <(2.9*0.95)) {
                    // 偏低
                    NSDictionary *  dict= [NSDictionary dictionaryWithObjectsAndKeys:@"Ble_boneImage",@"headerImage",@"骨量",@"title", [NSString stringWithFormat:@"%@kg",infoModel.bone],@"kg",@"1",@"type",@"偏低",@"typeName",@"您的骨量水平偏低。长期低钙饮食、缺乏运动、过度减肥等都可能引起骨量偏低，多吃含钙高的食物，多晒太阳，多运动及时补钙。\n\n骨量是指单位体积内，骨组织包括骨矿物质（钙、磷等）和骨基质（骨胶原、蛋白质、无机盐等）含量，骨量代表骨骼健康的情况。",@"detailText",@"analysisReport_gradeThree",@"detailImage",@"2",@"imageType",weightArr,@"weightArr",@"0",@"colortype", nil];
                    [reporeModel setValuesForKeysWithDictionary:dict];
                    [NostandarArr addObject:reporeModel];
                    cacheModel.bone = @"6";
                    
                }else if([infoModel.bone floatValue] >=(2.9*0.95) && [infoModel.bone floatValue] <=(2.9*1.05))
                { // 标准
                    NSDictionary *  dict= [NSDictionary dictionaryWithObjectsAndKeys:@"Ble_boneImage",@"headerImage",@"骨量",@"title", [NSString stringWithFormat:@"%@kg",infoModel.bone],@"kg",@"2",@"type",@"标准",@"typeName",@"您的骨量水平标准。骨量在短期内不会出现明显的变化，您只要保证健康的饮食和适当的锻炼，就可以维持稳定健康的骨量水平。\n\n骨量是指单位体积内，骨组织包括骨矿物质（钙、磷等）和骨基质（骨胶原、蛋白质、无机盐等）含量，骨量代表骨骼健康的情况。",@"detailText",@"analysisReport_gradeThree",@"detailImage",@"2",@"imageType",weightArr,@"weightArr",@"1",@"colortype", nil];
                    [reporeModel setValuesForKeysWithDictionary:dict];
                    [YesstandarArr addObject:reporeModel];
                    cacheModel.bone = @"9";
                }else if([infoModel.bone floatValue] >(2.9*1.05))
                {// 偏高
                    NSDictionary *  dict= [NSDictionary dictionaryWithObjectsAndKeys:@"Ble_boneImage",@"headerImage",@"骨量",@"title", [NSString stringWithFormat:@"%@kg",infoModel.bone],@"kg",@"3",@"type",@"偏高",@"typeName",@"您的骨量水平偏高。说明骨骼中包含的钙等无机盐的含量非常充分，但要注意防范肾结石、低血压的风险，尽量避免高钙摄入。\n\n骨量是指单位体积内，骨组织包括骨矿物质（钙、磷等）和骨基质（骨胶原、蛋白质、无机盐等）含量，骨量代表骨骼健康的情况。",@"detailText",@"analysisReport_gradeThree",@"detailImage", @"2",@"imageType",weightArr,@"weightArr",@"2",@"colortype",nil];
                    NSLog(@"%@",dict);
                    [reporeModel setValuesForKeysWithDictionary:dict];
                    [NostandarArr addObject:reporeModel];
                    cacheModel.bone = @"6";
                }
                
                
                
            }else  if ([infoModel.weight floatValue]  >75 ||[infoModel.weight floatValue]  ==75)
            {
                NSMutableArray *weightArr = [NSMutableArray array];
                [weightArr addObject:[NSString stringWithFormat:@"%.1fkg",(3.2*0.95)]];
                [weightArr addObject:[NSString stringWithFormat:@"%.1fkg",(3.2*1.05)]];
                 [PersoncircleDict setObject:[NSString stringWithFormat:@"%.1fkg - %.1fkg",(3.2*0.95),(3.2*1.05)] forKey:@"bone：骨量"];
                if ([infoModel.bone floatValue] <(3.2*0.95)) {
                    // 偏低
                    NSDictionary *  dict= [NSDictionary dictionaryWithObjectsAndKeys:@"Ble_boneImage",@"headerImage",@"骨量",@"title", [NSString stringWithFormat:@"%@kg",infoModel.bone],@"kg",@"1",@"type",@"偏低",@"typeName",@"您的骨量水平偏低。长期低钙饮食、缺乏运动、过度减肥等都可能引起骨量偏低，多吃含钙高的食物，多晒太阳，多运动及时补钙。\n\n骨量是指单位体积内，骨组织包括骨矿物质（钙、磷等）和骨基质（骨胶原、蛋白质、无机盐等）含量，骨量代表骨骼健康的情况。",@"detailText",@"analysisReport_gradeThree",@"detailImage",@"2",@"imageType",weightArr,@"weightArr",@"0",@"colortype", nil];
                    [reporeModel setValuesForKeysWithDictionary:dict];
                    [NostandarArr addObject:reporeModel];
                    cacheModel.bone = @"6";
                    
                }else if([infoModel.bone floatValue] >=(3.2*0.95) && [infoModel.bone floatValue] <=(3.2*1.05))
                { // 标准
                    NSDictionary *  dict= [NSDictionary dictionaryWithObjectsAndKeys:@"Ble_boneImage",@"headerImage",@"骨量",@"title", [NSString stringWithFormat:@"%@kg",infoModel.bone],@"kg",@"2",@"type",@"标准",@"typeName",@"您的骨量水平标准。骨量在短期内不会出现明显的变化，您只要保证健康的饮食和适当的锻炼，就可以维持稳定健康的骨量水平。\n\n骨量是指单位体积内，骨组织包括骨矿物质（钙、磷等）和骨基质（骨胶原、蛋白质、无机盐等）含量，骨量代表骨骼健康的情况。",@"detailText",@"analysisReport_gradeThree",@"detailImage", @"2",@"imageType",weightArr,@"weightArr",@"1",@"colortype",nil];
                    [reporeModel setValuesForKeysWithDictionary:dict];
                    [YesstandarArr addObject:reporeModel];
                    cacheModel.bone = @"9";
                }else if([infoModel.bone floatValue] >(3.2*1.05))
                {// 偏高
                    NSDictionary *  dict= [NSDictionary dictionaryWithObjectsAndKeys:@"Ble_boneImage",@"headerImage",@"骨量",@"title", [NSString stringWithFormat:@"%@kg",infoModel.bone],@"kg",@"3",@"type",@"偏高",@"typeName",@"您的骨量水平偏高。说明骨骼中包含的钙等无机盐的含量非常充分，但要注意防范肾结石、低血压的风险，尽量避免高钙摄入。\n\n骨量是指单位体积内，骨组织包括骨矿物质（钙、磷等）和骨基质（骨胶原、蛋白质、无机盐等）含量，骨量代表骨骼健康的情况。",@"detailText",@"analysisReport_gradeThree",@"detailImage", @"2",@"imageType",weightArr,@"weightArr",@"2",@"colortype",nil];
                    NSLog(@"%@",dict);
                    [reporeModel setValuesForKeysWithDictionary:dict];
                    [NostandarArr addObject:reporeModel];
                    cacheModel.bone = @"6";
                }
                
            }
            
            
        }else
        {
            
            if ([infoModel.weight floatValue] <45 ||[infoModel.weight floatValue]  ==45) {
                NSMutableArray *weightArr = [NSMutableArray array];
                [weightArr addObject:[NSString stringWithFormat:@"%.1fkg",(1.8*0.95)]];
                [weightArr addObject:[NSString stringWithFormat:@"%.1fkg",(1.8*1.05)]];
               [PersoncircleDict setObject:[NSString stringWithFormat:@"%.1fkg - %.1fkg",(1.8*0.95),(1.8*1.05)] forKey:@"bone：骨量"];
                
                if ([infoModel.bone floatValue] <(1.8*0.95)) {
                    // 偏低
                    NSDictionary *  dict= [NSDictionary dictionaryWithObjectsAndKeys:@"Ble_boneImage",@"headerImage",@"骨量",@"title", [NSString stringWithFormat:@"%@kg",infoModel.bone],@"kg",@"1",@"type",@"偏低",@"typeName",@"您的骨量水平偏低。长期低钙饮食、缺乏运动、过度减肥等都可能引起骨量偏低，多吃含钙高的食物，多晒太阳，多运动及时补钙。\n\n骨量是指单位体积内，骨组织包括骨矿物质（钙、磷等）和骨基质（骨胶原、蛋白质、无机盐等）含量，骨量代表骨骼健康的情况。",@"detailText",@"analysisReport_gradeThree",@"detailImage",@"2",@"imageType",weightArr,@"weightArr",@"0",@"colortype", nil];
                    [reporeModel setValuesForKeysWithDictionary:dict];
                    [NostandarArr addObject:reporeModel];
                    cacheModel.bone = @"6";
                    
                }else if([infoModel.bone floatValue] >=(1.8*0.95) && [infoModel.bone floatValue] <=(1.8*1.05))
                { // 标准
                    NSDictionary *  dict= [NSDictionary dictionaryWithObjectsAndKeys:@"Ble_boneImage",@"headerImage",@"骨量",@"title", [NSString stringWithFormat:@"%@kg",infoModel.bone],@"kg",@"2",@"type",@"标准",@"typeName",@"您的骨量水平标准。骨量在短期内不会出现明显的变化，您只要保证健康的饮食和适当的锻炼，就可以维持稳定健康的骨量水平。\n\n骨量是指单位体积内，骨组织包括骨矿物质（钙、磷等）和骨基质（骨胶原、蛋白质、无机盐等）含量，骨量代表骨骼健康的情况。",@"detailText",@"analysisReport_gradeThree",@"detailImage",@"2",@"imageType",weightArr,@"weightArr",@"1",@"colortype", nil];
                    [reporeModel setValuesForKeysWithDictionary:dict];
                    [YesstandarArr addObject:reporeModel];
                    cacheModel.bone = @"9";
                    
                }else if([infoModel.bone floatValue] >(1.8*1.05))
                {// 偏高
                    NSDictionary *  dict= [NSDictionary dictionaryWithObjectsAndKeys:@"Ble_boneImage",@"headerImage",@"骨量",@"title", [NSString stringWithFormat:@"%@kg",infoModel.bone],@"kg",@"3",@"type",@"偏高",@"typeName",@"您的骨量水平偏高。说明骨骼中包含的钙等无机盐的含量非常充分，但要注意防范肾结石、低血压的风险，尽量避免高钙摄入。\n\n骨量是指单位体积内，骨组织包括骨矿物质（钙、磷等）和骨基质（骨胶原、蛋白质、无机盐等）含量，骨量代表骨骼健康的情况。",@"detailText",@"analysisReport_gradeThree",@"detailImage", @"2",@"imageType",weightArr,@"weightArr",@"2",@"colortype",nil];
                    NSLog(@"%@",dict);
                    [reporeModel setValuesForKeysWithDictionary:dict];
                    [NostandarArr addObject:reporeModel];
                    cacheModel.bone = @"6";
                }
                
                
            }
            else if  ([infoModel.weight floatValue]  >45 && [infoModel.weight floatValue]  <60)
            { NSMutableArray *weightArr = [NSMutableArray array];
                [weightArr addObject:[NSString stringWithFormat:@"%.1fkg",(2.2*0.95)]];
                [weightArr addObject:[NSString stringWithFormat:@"%.1fkg",(2.2*1.05)]];
                 [PersoncircleDict setObject:[NSString stringWithFormat:@"%.1fkg - %.1fkg",(2.2*0.95),(2.2*1.05)] forKey:@"bone：骨量"];
                // 标准
                if ([infoModel.bone floatValue] <(2.2*0.95)) {
                    // 偏低
                    NSDictionary *  dict= [NSDictionary dictionaryWithObjectsAndKeys:@"Ble_boneImage",@"headerImage",@"骨量",@"title", [NSString stringWithFormat:@"%@kg",infoModel.bone],@"kg",@"1",@"type",@"偏低",@"typeName",@"您的骨量水平偏低。长期低钙饮食、缺乏运动、过度减肥等都可能引起骨量偏低，多吃含钙高的食物，多晒太阳，多运动及时补钙。\n\n骨量是指单位体积内，骨组织包括骨矿物质（钙、磷等）和骨基质（骨胶原、蛋白质、无机盐等）含量，骨量代表骨骼健康的情况。",@"detailText",@"analysisReport_gradeThree",@"detailImage",@"2",@"imageType",weightArr,@"weightArr",@"0",@"colortype", nil];
                    [reporeModel setValuesForKeysWithDictionary:dict];
                    [NostandarArr addObject:reporeModel];
                    cacheModel.bone = @"6";
                    
                }else if([infoModel.bone floatValue] >=(2.2*0.95) && [infoModel.bone floatValue] <=(2.2*1.05))
                { // 标准
                    NSDictionary *  dict= [NSDictionary dictionaryWithObjectsAndKeys:@"Ble_boneImage",@"headerImage",@"骨量",@"title", [NSString stringWithFormat:@"%@kg",infoModel.bone],@"kg",@"2",@"type",@"标准",@"typeName",@"您的骨量水平标准。骨量在短期内不会出现明显的变化，您只要保证健康的饮食和适当的锻炼，就可以维持稳定健康的骨量水平。\n\n骨量是指单位体积内，骨组织包括骨矿物质（钙、磷等）和骨基质（骨胶原、蛋白质、无机盐等）含量，骨量代表骨骼健康的情况。",@"detailText",@"analysisReport_gradeThree",@"detailImage", @"2",@"imageType",weightArr,@"weightArr",@"1",@"colortype",nil];
                    [reporeModel setValuesForKeysWithDictionary:dict];
                    [YesstandarArr addObject:reporeModel];
                    cacheModel.bone = @"9";
                    
                }else if([infoModel.bone floatValue] >(2.2*1.05))
                {// 偏高
                    NSDictionary *  dict= [NSDictionary dictionaryWithObjectsAndKeys:@"Ble_boneImage",@"headerImage",@"骨量",@"title", [NSString stringWithFormat:@"%@kg",infoModel.bone],@"kg",@"3",@"type",@"偏高",@"typeName",@"您的骨量水平偏高。说明骨骼中包含的钙等无机盐的含量非常充分，但要注意防范肾结石、低血压的风险，尽量避免高钙摄入。\n\n骨量是指单位体积内，骨组织包括骨矿物质（钙、磷等）和骨基质（骨胶原、蛋白质、无机盐等）含量，骨量代表骨骼健康的情况。",@"detailText",@"analysisReport_gradeThree",@"detailImage", @"2",@"imageType",weightArr,@"weightArr",@"2",@"colortype",nil];
                    NSLog(@"%@",dict);
                    [reporeModel setValuesForKeysWithDictionary:dict];
                    [NostandarArr addObject:reporeModel];
                    cacheModel.bone = @"6";
                }
                
                
            }else  if ([infoModel.weight floatValue]  >60 ||[infoModel.weight floatValue]  ==60)
            {
                // 偏高
                NSMutableArray *weightArr = [NSMutableArray array];
                [weightArr addObject:[NSString stringWithFormat:@"%.1fkg",(2.5*0.95)]];
                [weightArr addObject:[NSString stringWithFormat:@"%.1fkg",(2.5*1.05)]];
                 [PersoncircleDict setObject:[NSString stringWithFormat:@"%.1fkg - %.1fkg",(2.5*0.95),(2.5*1.05)] forKey:@"bone：骨量"];
                // 标准
                if ([infoModel.bone floatValue] <(2.5 *0.95)) {
                    // 偏低
                    NSDictionary *  dict= [NSDictionary dictionaryWithObjectsAndKeys:@"Ble_boneImage",@"headerImage",@"骨量",@"title", [NSString stringWithFormat:@"%@kg",infoModel.bone],@"kg",@"1",@"type",@"偏低",@"typeName",@"您的骨量水平偏低。长期低钙饮食、缺乏运动、过度减肥等都可能引起骨量偏低，多吃含钙高的食物，多晒太阳，多运动及时补钙。\n\n骨量是指单位体积内，骨组织包括骨矿物质（钙、磷等）和骨基质（骨胶原、蛋白质、无机盐等）含量，骨量代表骨骼健康的情况。",@"detailText",@"analysisReport_gradeThree",@"detailImage",@"2",@"imageType",weightArr,@"weightArr",@"0",@"colortype", nil];
                    [reporeModel setValuesForKeysWithDictionary:dict];
                    [NostandarArr addObject:reporeModel];
                    cacheModel.bone = @"6";
                    
                }else if([infoModel.bone floatValue] >=(2.5*0.95) && [infoModel.bone floatValue] <=(2.5*1.05))
                { // 标准
                    NSDictionary *  dict= [NSDictionary dictionaryWithObjectsAndKeys:@"Ble_boneImage",@"headerImage",@"骨量",@"title", [NSString stringWithFormat:@"%@kg",infoModel.bone],@"kg",@"2",@"type",@"标准",@"typeName",@"您的骨量水平标准。骨量在短期内不会出现明显的变化，您只要保证健康的饮食和适当的锻炼，就可以维持稳定健康的骨量水平。\n\n骨量是指单位体积内，骨组织包括骨矿物质（钙、磷等）和骨基质（骨胶原、蛋白质、无机盐等）含量，骨量代表骨骼健康的情况。",@"detailText",@"analysisReport_gradeThree",@"detailImage",@"2",@"imageType",weightArr,@"weightArr",@"1",@"colortype", nil];
                    [reporeModel setValuesForKeysWithDictionary:dict];
                    [YesstandarArr addObject:reporeModel];
                    cacheModel.bone = @"9";
                    
                }else if([infoModel.bone floatValue] >(2.5*1.05))
                {// 偏高
                    NSDictionary *  dict= [NSDictionary dictionaryWithObjectsAndKeys:@"Ble_boneImage",@"headerImage",@"骨量",@"title", [NSString stringWithFormat:@"%@kg",infoModel.bone],@"kg",@"3",@"type",@"偏高",@"typeName",@"您的骨量水平偏高。说明骨骼中包含的钙等无机盐的含量非常充分，但要注意防范肾结石、低血压的风险，尽量避免高钙摄入。\n\n骨量是指单位体积内，骨组织包括骨矿物质（钙、磷等）和骨基质（骨胶原、蛋白质、无机盐等）含量，骨量代表骨骼健康的情况。",@"detailText",@"analysisReport_gradeThree",@"detailImage", @"2",@"imageType",weightArr,@"weightArr",@"2",@"colortype",nil];
                    NSLog(@"%@",dict);
                    [reporeModel setValuesForKeysWithDictionary:dict];
                    [NostandarArr addObject:reporeModel];
                    cacheModel.bone = @"6";
                }
                
            }
            
            
            
        }
        
    }
    
    
#pragma mark   subfat：皮下脂肪率
    if (infoModel.subfat) {
        //Ble_subfatlittleLowkgImage
        //Ble_subfatstandardkgImage
        //Ble_subfatlittleHighkgImage
        BlereportModel *reporeModel = [[ BlereportModel alloc] init];
        
        
        //男
        if ([infoModel.gender  isEqualToString:@"0"]) {
            NSMutableArray *weightArr = [NSMutableArray array];
            [weightArr addObject:[NSString stringWithFormat:@"8.6%%"]];
            [weightArr addObject:[NSString stringWithFormat:@"16.7%%"]];
              [PersoncircleDict setObject:[NSString stringWithFormat:@"8.6%% - 16.7%%"] forKey:@"subfat：皮下脂肪率"];
            if ([infoModel.subfat floatValue] <8.6 ) {
                // 偏低
                NSDictionary *  dict= [NSDictionary dictionaryWithObjectsAndKeys:@"Ble_subfatImage",@"headerImage",@"皮下脂肪率",@"title", [NSString stringWithFormat:@"%@\%%",infoModel.subfat],@"kg",@"1",@"type",@"偏瘦",@"typeName",@"适量的皮下脂肪能够保护内脏和抵御寒冷，适量增加高蛋白、高热量食物可以增加脂肪。\n\n皮脂就是贮存于皮下的脂肪组织，人体的脂肪大约有2/3贮存在皮下组织",@"detailText",@"analysisReport_gradeThree",@"detailImage",@"2",@"imageType",weightArr,@"weightArr",@"0",@"colortype", nil];
                [reporeModel setValuesForKeysWithDictionary:dict];
                [NostandarArr addObject:reporeModel];
                cacheModel.subfat = @"6";
                
                
            }else if  (([infoModel.subfat floatValue]  >8.6 ||[infoModel.subfat floatValue]  ==8.6 ) && [infoModel.subfat floatValue]  <16.7)
            {
                // 标准
                NSDictionary *  dict= [NSDictionary dictionaryWithObjectsAndKeys:@"Ble_subfatImage",@"headerImage",@"皮下脂肪率",@"title", [NSString stringWithFormat:@"%@\%%",infoModel.subfat],@"kg",@"2",@"type",@"标准",@"typeName",@"您的皮下脂肪率处于标准范围。适当的运动量和合理的饮食就能保持适量的皮下脂肪。\n\n皮脂就是贮存于皮下的脂肪组织，人体的脂肪大约有2/3贮存在皮下组织",@"detailText",@"analysisReport_gradeThree",@"detailImage",@"2",@"imageType",weightArr,@"weightArr",@"1",@"colortype", nil];
                [reporeModel setValuesForKeysWithDictionary:dict];
                [YesstandarArr addObject:reporeModel];
                
                cacheModel.subfat = @"9";
                
            }else  if (([infoModel.subfat floatValue]  >16.7 ||[infoModel.subfat floatValue]  ==16.7 ) && [infoModel.subfat floatValue]  <20.7) {
                // 偏高
                NSDictionary *  dict= [NSDictionary dictionaryWithObjectsAndKeys:@"Ble_subfatImage",@"headerImage",@"皮下脂肪率",@"title", [NSString stringWithFormat:@"%@\%%",infoModel.subfat],@"kg",@"3",@"type",@"偏高",@"typeName",@" 皮下脂肪过多是外表肥胖的表现主要原因，除了有氧减脂以外，多进行增肌训练，肌肉的增加可以让您拥有更完美的体形。\n\n皮脂就是贮存于皮下的脂肪组织，人体的脂肪大约有2/3贮存在皮下组织",@"detailText",@"analysisReport_gradeThree",@"detailImage",@"2",@"imageType",weightArr,@"weightArr",@"2",@"colortype", nil];
                [reporeModel setValuesForKeysWithDictionary:dict];
                [NostandarArr addObject:reporeModel];
                
                cacheModel.subfat = @"6";
            }else if( [infoModel.subfat floatValue]  >=20.7)
            {
                // 严重偏高
                NSDictionary *  dict= [NSDictionary dictionaryWithObjectsAndKeys:@"Ble_subfatImage",@"headerImage",@"皮下脂肪率",@"title", [NSString stringWithFormat:@"%@\%%",infoModel.subfat],@"kg",@"3",@"type",@"严重偏高偏高",@"typeName",@" 皮下脂肪过多是外表肥胖的表现主要原因，除了有氧减脂以外，多进行增肌训练，肌肉的增加可以让您拥有更完美的体形。\n\n皮脂就是贮存于皮下的脂肪组织，人体的脂肪大约有2/3贮存在皮下组织",@"detailText",@"analysisReport_gradeThree",@"detailImage",@"2",@"imageType",weightArr,@"weightArr",@"2",@"colortype", nil];
                [reporeModel setValuesForKeysWithDictionary:dict];
                [NostandarArr addObject:reporeModel];
                
                cacheModel.subfat = @"4";
            }
            
            
        }else
        {
            NSMutableArray *weightArr = [NSMutableArray array];
            [weightArr addObject:[NSString stringWithFormat:@"18.5%%"]];
            [weightArr addObject:[NSString stringWithFormat:@"26.7%%"]];
             [PersoncircleDict setObject:[NSString stringWithFormat:@"18.5%% - 26.7%%"] forKey:@"subfat：皮下脂肪率"];
            if ([infoModel.subfat floatValue] <18.5 ) {
                // 偏低
                NSDictionary *  dict= [NSDictionary dictionaryWithObjectsAndKeys:@"Ble_subfatImage",@"headerImage",@"皮下脂肪率",@"title", [NSString stringWithFormat:@"%@\%%",infoModel.subfat],@"kg",@"1",@"type",@"偏瘦",@"typeName",@"适量的皮下脂肪能够保护内脏和抵御寒冷，适量增加高蛋白、高热量食物可以增加脂肪。\n\n皮脂就是贮存于皮下的脂肪组织，人体的脂肪大约有2/3贮存在皮下组织",@"detailText",@"analysisReport_gradeThree",@"detailImage",@"2",@"imageType",weightArr,@"weightArr",@"0",@"colortype", nil];
                [reporeModel setValuesForKeysWithDictionary:dict];
                [NostandarArr addObject:reporeModel];
                
                cacheModel.subfat = @"4";
                
            }else if  (([infoModel.subfat floatValue]  >18.5 ||[infoModel.subfat floatValue]  ==18.5 ) && [infoModel.subfat floatValue]  <26.7)
            {
                // 标准
                NSDictionary *  dict= [NSDictionary dictionaryWithObjectsAndKeys:@"Ble_subfatImage",@"headerImage",@"皮下脂肪率",@"title", [NSString stringWithFormat:@"%@\%%",infoModel.subfat],@"kg",@"2",@"type",@"标准",@"typeName",@"您的皮下脂肪率处于标准范围。适当的运动量和合理的饮食就能保持适量的皮下脂肪。\n\n皮脂就是贮存于皮下的脂肪组织，人体的脂肪大约有2/3贮存在皮下组织",@"detailText",@"analysisReport_gradeThree",@"detailImage",@"2",@"imageType",weightArr,@"weightArr",@"1",@"colortype", nil];
                [reporeModel setValuesForKeysWithDictionary:dict];
                [YesstandarArr addObject:reporeModel];
                cacheModel.subfat = @"9";
                
                
            }else  if (([infoModel.subfat floatValue]  >26.7 ||[infoModel.subfat floatValue]  ==26.7 ) && [infoModel.subfat floatValue]  <30.7) {
                // 偏高
                NSDictionary *  dict= [NSDictionary dictionaryWithObjectsAndKeys:@"Ble_subfatImage",@"headerImage",@"皮下脂肪率",@"title", [NSString stringWithFormat:@"%@\%%",infoModel.subfat],@"kg",@"3",@"type",@"偏高",@"typeName",@" 皮下脂肪过多是外表肥胖的表现主要原因，除了有氧减脂以外，多进行增肌训练，肌肉的增加可以让您拥有更完美的体形。\n\n皮脂就是贮存于皮下的脂肪组织，人体的脂肪大约有2/3贮存在皮下组织",@"detailText",@"analysisReport_gradeThree",@"detailImage",@"2",@"imageType",weightArr,@"weightArr",@"2",@"colortype", nil];
                [reporeModel setValuesForKeysWithDictionary:dict];
                [NostandarArr addObject:reporeModel];
                cacheModel.subfat = @"4";
                
            }else if( [infoModel.subfat floatValue]  >=30.7)
            {
                // 严重偏高
                NSDictionary *  dict= [NSDictionary dictionaryWithObjectsAndKeys:@"Ble_subfatImage",@"headerImage",@"皮下脂肪率",@"title", [NSString stringWithFormat:@"%@\%%",infoModel.subfat],@"kg",@"3",@"type",@"严重偏高偏高",@"typeName",@" 皮下脂肪过多是外表肥胖的表现主要原因，除了有氧减脂以外，多进行增肌训练，肌肉的增加可以让您拥有更完美的体形。\n\n皮脂就是贮存于皮下的脂肪组织，人体的脂肪大约有2/3贮存在皮下组织",@"detailText",@"analysisReport_gradeThree",@"detailImage",@"2",@"imageType",weightArr,@"weightArr",@"2",@"colortype", nil];
                [reporeModel setValuesForKeysWithDictionary:dict];
                [NostandarArr addObject:reporeModel];
                
                cacheModel.subfat = @"3";
            }
            
            
            
        }
        
    }
    
    //protein：蛋白质
#pragma mark   protein：蛋白质
    if (infoModel.protein) {
        //Ble_proteinlittleLowkgImage
        //Ble_proteinstandardkgImage
        //Ble_proteinlittleHighkgImage
        BlereportModel *reporeModel = [[ BlereportModel alloc] init];
        //  CGFloat proteinnum  = 100 -[infoModel.bodyfat doubleValue] - ([infoModel.bone doubleValue]/[infoModel.weight doubleValue]*100) - [infoModel.water doubleValue];
        //男
        if ([infoModel.gender  isEqualToString:@"0"]) {
            //蛋白质比例=100%-脂肪比例-骨头比例（骨量/体重*100%）-水份比例。
            NSMutableArray *weightArr = [NSMutableArray array];
            [weightArr addObject:[NSString stringWithFormat:@"16%%"]];
            [weightArr addObject:[NSString stringWithFormat:@"18%%"]];
              [PersoncircleDict setObject:[NSString stringWithFormat:@"16%% - 18%%"] forKey:@"protein：蛋白质"];
            if ([infoModel.protein floatValue] <16 ) {
                // 偏低
                NSDictionary *  dict= [NSDictionary dictionaryWithObjectsAndKeys:@"Ble_proteinImage",@"headerImage",@"蛋白质",@"title", [NSString stringWithFormat:@"%@\%%",infoModel.protein],@"kg",@"1",@"type",@"偏低",@"typeName",@"蛋白质不足会引起基础代谢减少，也会引起肌肉的数量减少。保持健康的饮食可以平衡蛋白质水平。\n\n蛋白质是人体重要组成部分，蛋白质过量，就会转化为脂肪储存，人体发胖；严重时，增加肝脏和肾的负担，对身体造成损害。",@"detailText",@"analysisReport_gradeThree",@"detailImage",@"2",@"imageType",weightArr,@"weightArr",@"0",@"colortype",  nil];
                [reporeModel setValuesForKeysWithDictionary:dict];
                [NostandarArr addObject:reporeModel];
                cacheModel.protein = @"4";
                
                
            }else if  (([infoModel.protein floatValue]  >16 ||[infoModel.protein floatValue]  ==16 ) && ([infoModel.protein floatValue]  <18 ||[infoModel.protein floatValue]  ==18))
            {
                // 标准
                NSDictionary *  dict= [NSDictionary dictionaryWithObjectsAndKeys:@"Ble_proteinImage",@"headerImage",@"蛋白质",@"title", [NSString stringWithFormat:@"%@\%%",infoModel.protein],@"kg",@"2",@"type",@"标准",@"typeName",@"您的蛋白质处于标准水平。\n\n蛋白质是人体重要组成部分，蛋白质过量，就会转化为脂肪储存，人体发胖；严重时，增加肝脏和肾的负担，对身体造成损害。",@"detailText",@"analysisReport_gradeThree",@"detailImage",@"2",@"imageType",weightArr,@"weightArr",@"1",@"colortype",  nil];
                [reporeModel setValuesForKeysWithDictionary:dict];
                [YesstandarArr addObject:reporeModel];
                cacheModel.protein = @"9";
                
                
            }else  if ([infoModel.protein floatValue]  >18 ) {
                // 偏高
                NSDictionary *  dict= [NSDictionary dictionaryWithObjectsAndKeys:@"Ble_proteinImage",@"headerImage",@"蛋白质",@"title", [NSString stringWithFormat:@"%@\%%",infoModel.protein],@"kg",@"2",@"type",@"标准",@"typeName",@"蛋白质充足，您的营养摄入很充分，建议您多食用高纤维蔬菜。\n\n蛋白质是人体重要组成部分，蛋白质过量，就会转化为脂肪储存，人体发胖；严重时，增加肝脏和肾的负担，对身体造成损害。",@"detailText",@"analysisReport_gradeThree",@"detailImage",@"2",@"imageType",weightArr,@"weightArr",@"2",@"colortype",  nil];
                [reporeModel setValuesForKeysWithDictionary:dict];
                [YesstandarArr addObject:reporeModel];
                cacheModel.protein = @"9";
                
            }
            
            
            
            
        }else{
            NSMutableArray *weightArr = [NSMutableArray array];
            [weightArr addObject:[NSString stringWithFormat:@"14%%"]];
            [weightArr addObject:[NSString stringWithFormat:@"16%%"]];
            [PersoncircleDict setObject:[NSString stringWithFormat:@"14%% - 16%%"] forKey:@"protein：蛋白质"];
            if ([infoModel.protein floatValue] <14 ) {
                // 偏低
                NSDictionary *  dict= [NSDictionary dictionaryWithObjectsAndKeys:@"Ble_proteinImage",@"headerImage",@"蛋白质",@"title", [NSString stringWithFormat:@"%@\%%",infoModel.protein],@"kg",@"1",@"type",@"偏低",@"typeName",@"蛋白质不足会引起基础代谢减少，也会引起肌肉的数量减少。保持健康的饮食可以平衡蛋白质水平。\n\n蛋白质是人体重要组成部分，蛋白质过量，就会转化为脂肪储存，人体发胖；严重时，增加肝脏和肾的负担，对身体造成损害。",@"detailText",@"analysisReport_gradeThree",@"detailImage",@"2",@"imageType",weightArr,@"weightArr",@"0",@"colortype",  nil];
                [reporeModel setValuesForKeysWithDictionary:dict];
                [NostandarArr addObject:reporeModel];
                cacheModel.protein = @"4";
                
                
            }else if  (([infoModel.protein floatValue]  >14 ||[infoModel.protein floatValue]  ==14 ) && ([infoModel.protein floatValue]  <16 ||[infoModel.protein floatValue]  ==16))
            {
                // 标准
                NSDictionary *  dict= [NSDictionary dictionaryWithObjectsAndKeys:@"Ble_proteinImage",@"headerImage",@"蛋白质",@"title", [NSString stringWithFormat:@"%@\%%",infoModel.protein],@"kg",@"2",@"type",@"标准",@"typeName",@"您的蛋白质处于标准水平。\n\n蛋白质是人体重要组成部分，蛋白质过量，就会转化为脂肪储存，人体发胖；严重时，增加肝脏和肾的负担，对身体造成损害。",@"detailText",@"analysisReport_gradeThree",@"detailImage",@"2",@"imageType",weightArr,@"weightArr",@"1",@"colortype",  nil];
                [reporeModel setValuesForKeysWithDictionary:dict];
                [YesstandarArr addObject:reporeModel];
                
                cacheModel.protein = @"9";
                
            }else  if ([infoModel.protein floatValue]  >16 ) {
                // 偏高
                NSDictionary *  dict= [NSDictionary dictionaryWithObjectsAndKeys:@"Ble_proteinImage",@"headerImage",@"蛋白质",@"title", [NSString stringWithFormat:@"%@\%%",infoModel.protein],@"kg",@"2",@"type",@"标准",@"typeName",@"蛋白质充足，您的营养摄入很充分，建议您多食用高纤维蔬菜。\n\n蛋白质是人体重要组成部分，蛋白质过量，就会转化为脂肪储存，人体发胖；严重时，增加肝脏和肾的负担，对身体造成损害。",@"detailText",@"analysisReport_gradeThree",@"detailImage",@"2",@"imageType",weightArr,@"weightArr",@"2",@"colortype",  nil];
                [reporeModel setValuesForKeysWithDictionary:dict];
                [YesstandarArr addObject:reporeModel];
                cacheModel.protein = @"9";
                
            }
            
        }
        
        
    }
    
#pragma mark rouNum: 肌肉量
    if (infoModel.height) {
        //Ble_rouNumlittleLowkgImage
        //Ble_rouNumstandardkgImage
        
        BlereportModel *reporeModel = [[ BlereportModel alloc] init];
        CGFloat rowNum = [infoModel.weight doubleValue]-[infoModel.weight doubleValue]*[infoModel.bodyfat doubleValue]*0.01-[infoModel.bone doubleValue];
        
        //男
        if ([infoModel.gender  isEqualToString:@"0"]) {
            
            [PersoncircleDict setObject:[NSString stringWithFormat:@"%.1fkg - %.1fkg",(42.5-4.0) ,(42.5+4.0)] forKey:@"rouNum: 肌肉量"];

            if ([infoModel.height floatValue] <160 ) {
                NSMutableArray *weightArr = [NSMutableArray array];
                [weightArr addObject:[NSString stringWithFormat:@"42.5kg"]];
                
                
                if (rowNum <(42.5-4.0)) {
                    // 偏低
                    NSDictionary *  dict= [NSDictionary dictionaryWithObjectsAndKeys:@"Ble_rouNumImage",@"headerImage",@"肌肉量",@"title", [NSString stringWithFormat:@"%.1fkg",rowNum],@"kg",@"3",@"type",@"不达标",@"typeName",@"您缺少足够的肌肉，需要加强运动，增加肌肉。\n\n全身肌肉占的重量（包括骨胳肌、心肌、内脏肌肉）",@"detailText",@"analysisReport_gradeTwo",@"detailImage",@"1",@"imageType",weightArr,@"weightArr",@"0",@"colortype",  nil];
                    [reporeModel setValuesForKeysWithDictionary:dict];
                    [NostandarArr addObject:reporeModel];
                    cacheModel.height = @"4";
                    
                }else if(rowNum >=(42.5-4.0)  && rowNum <=(42.5+4.0) )
                { // 标准
                    NSDictionary *  dict= [NSDictionary dictionaryWithObjectsAndKeys:@"Ble_rouNumImage",@"headerImage",@"肌肉量",@"title", [NSString stringWithFormat:@"%.1fkg",rowNum],@"kg",@"2",@"type",@"标准",@"typeName",@"您的肌肉量已达标，适当的肌肉能让您展示更好的体形。\n\n全身肌肉占的重量（包括骨胳肌、心肌、内脏肌肉）",@"detailText",@"analysisReport_gradeTwo",@"detailImage",@"1",@"imageType",weightArr,@"weightArr",@"1",@"colortype",  nil];
                    [reporeModel setValuesForKeysWithDictionary:dict];
                    [YesstandarArr addObject:reporeModel];
                    cacheModel.height = @"9";
                    
                }else if(rowNum >(42.5+4.0))
                {// 偏高
                    NSDictionary *  dict= [NSDictionary dictionaryWithObjectsAndKeys:@"Ble_rouNumImage",@"headerImage",@"肌肉量",@"title", [NSString stringWithFormat:@"%.1fkg",rowNum],@"kg",@"2",@"type",@"标准",@"typeName",@"您的肌肉量已达标，适当的肌肉能让您展示更好的体形。\n\n全身肌肉占的重量（包括骨胳肌、心肌、内脏肌肉）",@"detailText",@"analysisReport_gradeTwo",@"detailImage",@"1",@"imageType",weightArr,@"weightArr",@"1",@"colortype",  nil];
                    [reporeModel setValuesForKeysWithDictionary:dict];
                    [YesstandarArr addObject:reporeModel];
                    cacheModel.height = @"6";
                }
                //
            }
            else if  ([infoModel.height floatValue]  >=160 && [infoModel.height floatValue]  <=170) {
                NSMutableArray *weightArr = [NSMutableArray array];
                [weightArr addObject:[NSString stringWithFormat:@"48.2kg"]];
                if (rowNum <(48.2-4.2)) {
                    // 偏低
                    NSDictionary *  dict= [NSDictionary dictionaryWithObjectsAndKeys:@"Ble_rouNumImage",@"headerImage",@"肌肉量",@"title", [NSString stringWithFormat:@"%.1fkg",rowNum],@"kg",@"3",@"type",@"不达标",@"typeName",@"您缺少足够的肌肉，需要加强运动，增加肌肉。\n\n全身肌肉占的重量（包括骨胳肌、心肌、内脏肌肉）",@"detailText",@"analysisReport_gradeTwo",@"detailImage",@"1",@"imageType",weightArr,@"weightArr",@"0",@"colortype",  nil];
                    [reporeModel setValuesForKeysWithDictionary:dict];
                    [NostandarArr addObject:reporeModel];
                    cacheModel.height = @"4";
                    
                }else if(rowNum >=(48.2-4.2)  && rowNum <=(48.2+4.2) )
                { // 标准
                    NSDictionary *  dict= [NSDictionary dictionaryWithObjectsAndKeys:@"Ble_rouNumImage",@"headerImage",@"肌肉量",@"title", [NSString stringWithFormat:@"%.1fkg",rowNum],@"kg",@"2",@"type",@"标准",@"typeName",@"您的肌肉量已达标，适当的肌肉能让您展示更好的体形。\n\n全身肌肉占的重量（包括骨胳肌、心肌、内脏肌肉）",@"detailText",@"analysisReport_gradeTwo",@"detailImage",@"1",@"imageType",weightArr,@"weightArr",@"1",@"colortype",  nil];
                    [reporeModel setValuesForKeysWithDictionary:dict];
                    [YesstandarArr addObject:reporeModel];
                    cacheModel.height = @"9";
                    
                }else if(rowNum >(48.2+4.2))
                {// 偏高
                    NSDictionary *  dict= [NSDictionary dictionaryWithObjectsAndKeys:@"Ble_rouNumImage",@"headerImage",@"肌肉量",@"title", [NSString stringWithFormat:@"%.1fkg",rowNum],@"kg",@"2",@"type",@"标准",@"typeName",@"您的肌肉量已达标，适当的肌肉能让您展示更好的体形。\n\n全身肌肉占的重量（包括骨胳肌、心肌、内脏肌肉）",@"detailText",@"analysisReport_gradeTwo",@"detailImage",@"1",@"imageType",weightArr,@"weightArr",@"1",@"colortype",  nil];
                    [reporeModel setValuesForKeysWithDictionary:dict];
                    [YesstandarArr addObject:reporeModel];
                    cacheModel.height = @"6";
                }
                
                
            }
            else  if ([infoModel.height floatValue]  >170 ) {
                NSMutableArray *weightArr = [NSMutableArray array];
                [weightArr addObject:[NSString stringWithFormat:@"54.4kg"]];
                if (rowNum <(54.4-5.0)) {
                    // 偏低
                    NSDictionary *  dict= [NSDictionary dictionaryWithObjectsAndKeys:@"Ble_rouNumImage",@"headerImage",@"肌肉量",@"title", [NSString stringWithFormat:@"%.1fkg",rowNum],@"kg",@"3",@"type",@"不达标",@"typeName",@"您缺少足够的肌肉，需要加强运动，增加肌肉。\n\n全身肌肉占的重量（包括骨胳肌、心肌、内脏肌肉）",@"detailText",@"analysisReport_gradeTwo",@"detailImage",@"1",@"imageType",weightArr,@"weightArr",@"0",@"colortype",  nil];
                    [reporeModel setValuesForKeysWithDictionary:dict];
                    [NostandarArr addObject:reporeModel];
                    cacheModel.height = @"4";
                    
                }else if(rowNum >=(54.4-5.0)  && rowNum <=(54.4+5.0) )
                { // 标准
                    NSDictionary *  dict= [NSDictionary dictionaryWithObjectsAndKeys:@"Ble_rouNumImage",@"headerImage",@"肌肉量",@"title", [NSString stringWithFormat:@"%.1fkg",rowNum],@"kg",@"2",@"type",@"标准",@"typeName",@"您的肌肉量已达标，适当的肌肉能让您展示更好的体形。\n\n全身肌肉占的重量（包括骨胳肌、心肌、内脏肌肉）",@"detailText",@"analysisReport_gradeTwo",@"detailImage", @"1",@"imageType",weightArr,@"weightArr",@"1",@"colortype", nil];
                    [reporeModel setValuesForKeysWithDictionary:dict];
                    [YesstandarArr addObject:reporeModel];
                    cacheModel.height = @"9";
                    
                }else if(rowNum >(54.4+5.0))
                {// 偏高
                    NSDictionary *  dict= [NSDictionary dictionaryWithObjectsAndKeys:@"Ble_rouNumImage",@"headerImage",@"肌肉量",@"title", [NSString stringWithFormat:@"%.1fkg",rowNum],@"kg",@"2",@"type",@"标准",@"typeName",@"您的肌肉量已达标，适当的肌肉能让您展示更好的体形。\n\n全身肌肉占的重量（包括骨胳肌、心肌、内脏肌肉）",@"detailText",@"analysisReport_gradeTwo",@"detailImage",@"1",@"imageType",weightArr,@"weightArr",@"1",@"colortype",  nil];
                    [reporeModel setValuesForKeysWithDictionary:dict];
                    [YesstandarArr addObject:reporeModel];
                    cacheModel.height = @"6";
                }
                
                
            }        }
        else
        {
             [PersoncircleDict setObject:[NSString stringWithFormat:@"%.1fkg - %.1fkg",(31.9-2.8) ,(31.9+2.8)] forKey:@"rouNum: 肌肉量"];
            if ([infoModel.height floatValue] <160 ) {
                
                NSMutableArray *weightArr = [NSMutableArray array];
                [weightArr addObject:[NSString stringWithFormat:@"31.9kg"]];
                if (rowNum <(31.9-2.8)) {
                    // 偏低
                    NSDictionary *  dict= [NSDictionary dictionaryWithObjectsAndKeys:@"Ble_rouNumImage",@"headerImage",@"肌肉量",@"title", [NSString stringWithFormat:@"%.1fkg",rowNum],@"kg",@"3",@"type",@"不达标",@"typeName",@"您缺少足够的肌肉，需要加强运动，增加肌肉。\n\n全身肌肉占的重量（包括骨胳肌、心肌、内脏肌肉）",@"detailText",@"analysisReport_gradeTwo",@"detailImage",@"1",@"imageType",weightArr,@"weightArr",@"0",@"colortype",  nil];
                    [reporeModel setValuesForKeysWithDictionary:dict];
                    [NostandarArr addObject:reporeModel];
                    cacheModel.height = @"4";
                    
                }else if(rowNum >=(31.9-2.8)  && rowNum <=(31.9+2.8) )
                { // 标准
                    NSDictionary *  dict= [NSDictionary dictionaryWithObjectsAndKeys:@"Ble_rouNumImage",@"headerImage",@"肌肉量",@"title", [NSString stringWithFormat:@"%.1fkg",rowNum],@"kg",@"2",@"type",@"标准",@"typeName",@"您的肌肉量已达标，适当的肌肉能让您展示更好的体形。\n\n全身肌肉占的重量（包括骨胳肌、心肌、内脏肌肉）",@"detailText",@"analysisReport_gradeTwo",@"detailImage",@"1",@"imageType",weightArr,@"weightArr",@"1",@"colortype",  nil];
                    [reporeModel setValuesForKeysWithDictionary:dict];
                    [YesstandarArr addObject:reporeModel];
                    cacheModel.height = @"9";
                    
                }else if(rowNum >(31.9+2.8))
                {// 偏高
                    NSDictionary *  dict= [NSDictionary dictionaryWithObjectsAndKeys:@"Ble_rouNumImage",@"headerImage",@"肌肉量",@"title", [NSString stringWithFormat:@"%.1fkg",rowNum],@"kg",@"2",@"type",@"标准",@"typeName",@"您的肌肉量已达标，适当的肌肉能让您展示更好的体形。\n\n全身肌肉占的重量（包括骨胳肌、心肌、内脏肌肉）",@"detailText",@"analysisReport_gradeTwo",@"detailImage",@"1",@"imageType",weightArr,@"weightArr",@"1",@"colortype",  nil];
                    [reporeModel setValuesForKeysWithDictionary:dict];
                    [YesstandarArr addObject:reporeModel];
                    cacheModel.height = @"6";
                }
                //
            }
            else if  ([infoModel.height floatValue]  >=160 && [infoModel.height floatValue]  <=170){   NSMutableArray *weightArr = [NSMutableArray array];
                [weightArr addObject:[NSString stringWithFormat:@"35.2kg"]];
                if (rowNum <(35.2-2.3)) {
                    // 偏低
                    NSDictionary *  dict= [NSDictionary dictionaryWithObjectsAndKeys:@"Ble_rouNumImage",@"headerImage",@"肌肉量",@"title", [NSString stringWithFormat:@"%.1fkg",rowNum],@"kg",@"3",@"type",@"不达标",@"typeName",@"您缺少足够的肌肉，需要加强运动，增加肌肉。\n\n全身肌肉占的重量（包括骨胳肌、心肌、内脏肌肉）",@"detailText",@"analysisReport_gradeTwo",@"detailImage",@"1",@"imageType",weightArr,@"weightArr",@"0",@"colortype",  nil];
                    [reporeModel setValuesForKeysWithDictionary:dict];
                    [NostandarArr addObject:reporeModel];
                    cacheModel.height = @"4";
                    
                }else if(rowNum >=(35.2-2.3)  && rowNum <=(35.2+2.3) )
                { // 标准
                    NSDictionary *  dict= [NSDictionary dictionaryWithObjectsAndKeys:@"Ble_rouNumImage",@"headerImage",@"肌肉量",@"title", [NSString stringWithFormat:@"%.1fkg",rowNum],@"kg",@"2",@"type",@"标准",@"typeName",@"您的肌肉量已达标，适当的肌肉能让您展示更好的体形。\n\n全身肌肉占的重量（包括骨胳肌、心肌、内脏肌肉）",@"detailText",@"analysisReport_gradeTwo",@"detailImage",@"1",@"imageType",weightArr,@"weightArr",@"1",@"colortype",  nil];
                    [reporeModel setValuesForKeysWithDictionary:dict];
                    [YesstandarArr addObject:reporeModel];
                    cacheModel.height = @"9";
                    
                }else if(rowNum >(35.2+2.3))
                {// 偏高
                    NSDictionary *  dict= [NSDictionary dictionaryWithObjectsAndKeys:@"Ble_rouNumImage",@"headerImage",@"肌肉量",@"title", [NSString stringWithFormat:@"%.1fkg",rowNum],@"kg",@"2",@"type",@"标准",@"typeName",@"您的肌肉量已达标，适当的肌肉能让您展示更好的体形。\n\n全身肌肉占的重量（包括骨胳肌、心肌、内脏肌肉）",@"detailText",@"analysisReport_gradeTwo",@"detailImage",@"1",@"imageType",weightArr,@"weightArr",@"1",@"colortype",  nil];
                    [reporeModel setValuesForKeysWithDictionary:dict];
                    [YesstandarArr addObject:reporeModel];
                    cacheModel.height = @"6";
                }
                
                
            }
            else  if ([infoModel.height floatValue]  >170 ) {
                NSMutableArray *weightArr = [NSMutableArray array];
                [weightArr addObject:[NSString stringWithFormat:@"39.5kg"]];
                if (rowNum <(39.5-3.0)) {
                    // 偏低
                    NSDictionary *  dict= [NSDictionary dictionaryWithObjectsAndKeys:@"Ble_rouNumImage",@"headerImage",@"肌肉量",@"title", [NSString stringWithFormat:@"%.1fkg",rowNum],@"kg",@"3",@"type",@"不达标",@"typeName",@"您缺少足够的肌肉，需要加强运动，增加肌肉。\n\n全身肌肉占的重量（包括骨胳肌、心肌、内脏肌肉）",@"detailText",@"analysisReport_gradeTwo",@"detailImage",@"1",@"imageType",weightArr,@"weightArr",@"0",@"colortype",  nil];
                    [reporeModel setValuesForKeysWithDictionary:dict];
                    [NostandarArr addObject:reporeModel];
                    cacheModel.height = @"4";
                    
                }else if(rowNum >=(39.5-3.0)  && rowNum <=(39.5+3.0) )
                { // 标准
                    NSDictionary *  dict= [NSDictionary dictionaryWithObjectsAndKeys:@"Ble_rouNumImage",@"headerImage",@"肌肉量",@"title", [NSString stringWithFormat:@"%.1fkg",rowNum],@"kg",@"2",@"type",@"标准",@"typeName",@"您的肌肉量已达标，适当的肌肉能让您展示更好的体形。\n\n全身肌肉占的重量（包括骨胳肌、心肌、内脏肌肉）",@"detailText",@"analysisReport_gradeTwo",@"detailImage",@"1",@"imageType",weightArr,@"weightArr",@"1",@"colortype",  nil];
                    [reporeModel setValuesForKeysWithDictionary:dict];
                    [YesstandarArr addObject:reporeModel];
                    cacheModel.height = @"9";
                    
                }else if(rowNum >(39.5+3.0))
                {// 偏高
                    NSDictionary *  dict= [NSDictionary dictionaryWithObjectsAndKeys:@"Ble_rouNumImage",@"headerImage",@"肌肉量",@"title", [NSString stringWithFormat:@"%.1fkg",rowNum],@"kg",@"2",@"type",@"标准",@"typeName",@"您的肌肉量已达标，适当的肌肉能让您展示更好的体形。\n\n全身肌肉占的重量（包括骨胳肌、心肌、内脏肌肉）",@"detailText",@"analysisReport_gradeTwo",@"detailImage",@"1",@"imageType",weightArr,@"weightArr",@"1",@"colortype",  nil];
                    
                    [reporeModel setValuesForKeysWithDictionary:dict];
                    [YesstandarArr addObject:reporeModel];
                    cacheModel.height = @"6";
                }
                
            }
            
            
        }
    }
    
    
    
    
    NSString *ScoreStr = [NSString stringWithFormat:@"%ld.0分", [cacheModel.weight integerValue]+[cacheModel.bmi integerValue]+[cacheModel.bodyfat integerValue]+[cacheModel.muscle integerValue]+[cacheModel.visfat integerValue]+[cacheModel.bmr integerValue]+[cacheModel.water integerValue]+[cacheModel.bone integerValue]+[cacheModel.subfat integerValue]+[cacheModel.protein integerValue]+[cacheModel.height integerValue]];
    
    
    if (NostandarArr.count != 0) {
        [dataDict setObject:NostandarArr forKey:@"本次测试未达标项目共"];
    } if (YesstandarArr.count != 0) {
        [dataDict setObject:YesstandarArr forKey:@"本次测试达标项目共"];
        
    }
    NSLog(@"本次测试达标项目共:%@",dataDict[@"本次测试达标项目共"]);
    
    NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:dataDict,@"dataDict",ScoreStr,@"score",PersoncircleDict,@"PersoncircleDict", nil];
    NSLog(@"dict:%@",dict);
    BleInfoModel *model = [[BleInfoModel alloc] init];
    [model setValuesForKeysWithDictionary:dict];
    
    return model;
}


/**
 *     根据生日和日期得到年龄
 */
+(NSInteger)setDataStr:(NSString *)birthday time:(NSString *)time
{
    // NSString * time = @"2016-03-23 15:11:12";
    time =   [time substringToIndex:4];
    NSString * bir = birthday;
    bir = [bir substringToIndex:4];
    
    NSInteger age = [time integerValue]-[bir integerValue];
    
    return  age;
    
}
@end
