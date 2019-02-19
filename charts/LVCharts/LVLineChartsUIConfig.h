//
//  LVLineChartsUIConfig.h
//  charts
//
//  Created by lv on 2019/2/18.
//  Copyright © 2019 lv. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface LVLineChartsUIConfig : NSObject
///数据区间宽度
@property (nonatomic) CGFloat intervalWidth;


///线条宽度
@property (nonatomic) CGFloat lineWidth;
///线条颜色
@property (nonatomic) UIColor *lineColor;

///拐点宽度
@property (nonatomic) CGFloat pointWidth;
///拐点颜色
@property (nonatomic) UIColor *pointColor;

///背景渐变开始颜色
@property (nonatomic) UIColor *backgroundGradientStartColor;
///背景渐变结束颜色
@property (nonatomic) UIColor *backgroundGradientEndColor;


///底部文字字体
@property (nonatomic) UIFont *bottomLabFont;
///底部文字颜色
@property (nonatomic) UIColor *bottomLabTextColor;


///左侧文字字体
@property (nonatomic) UIFont *leftLabFont;
///左侧文字颜色
@property (nonatomic) UIColor *leftLabTextColor;



///目标文字字体
@property (nonatomic) UIFont *targetLabFont;
///目标文字颜色
@property (nonatomic) UIColor *targetLabTextColor;
///目标线颜色
@property (nonatomic) UIColor *targetLineColor;

@end

NS_ASSUME_NONNULL_END
