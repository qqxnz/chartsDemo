//
//  ChartsView.h
//  charts
//
//  Created by lv on 2019/1/17.
//  Copyright © 2019 lv. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class PointObject;

typedef void (^GriddingViewLeftNumberCallBack)(void);

@interface GriddingView : UIView

///折线颜色
@property (nonatomic) UIColor *lineColor;
///折线点颜色
@property (nonatomic) UIColor *pointColor;

///目标线数据
@property (nonatomic) NSNumber *targetNumber;
///目标线颜色
@property (nonatomic) UIColor *targetColor;

@property (nonatomic) NSMutableArray *dataArray;
@property (nonatomic) NSMutableArray *pointArray;
@property (nonatomic) NSMutableArray *leftDataArray;
@property (nonatomic) NSMutableArray *leftPointArray;
@property (nonatomic) GriddingViewLeftNumberCallBack callback;
@end

@interface PointObject : NSObject
@property (nonatomic) CGFloat pointX;
@property (nonatomic) CGFloat pointY;
@end

NS_ASSUME_NONNULL_END
