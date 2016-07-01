//
//  DatePickerView.h
//  SpaceTime
//
//  Created by hua on 15/12/3.
//  Copyright © 2015年 gpy. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol DatePickerDelegate <NSObject>

- (void)getSelect:(NSString *)date ;

@end
@interface DatePickerView : UIView
{
    UIButton *bagButton;
    UIView *bgView ;
}
@property (nonatomic, weak) id<DatePickerDelegate> delegate;
@end
