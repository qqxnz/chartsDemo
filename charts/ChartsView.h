//
//  ChartsView.h
//  charts
//
//  Created by lv on 2019/1/17.
//  Copyright © 2019 lv. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GriddingView.h"
#import "GradientView.h"

NS_ASSUME_NONNULL_BEGIN

@interface ChartsView : UIView
@property (nonatomic) UILabel *sundayLab;
@property (nonatomic) UILabel *mondayLab;
@property (nonatomic) UILabel *tuesdayLab;
@property (nonatomic) UILabel *wednesdayLab;
@property (nonatomic) UILabel *thursdayLab;
@property (nonatomic) UILabel *fridayLab;
@property (nonatomic) UILabel *saturdayLab;

@property (nonatomic) UIColor *lineColor;
@property (nonatomic) UIColor *pointColor;

///设置数据并绘制
-(void)showWithData:(NSMutableArray *)dataArray;

///设置渐变颜色
-(void)setGradientColor:(UIColor *)start withEndColor:(UIColor *)end;

@end

NS_ASSUME_NONNULL_END
