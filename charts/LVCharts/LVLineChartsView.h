//
//  LVLineChartsView.h
//  charts
//
//  Created by lv on 2019/2/18.
//  Copyright © 2019 lv. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LVLineChartsObject.h"
#import "LVLineChartsUIConfig.h"


NS_ASSUME_NONNULL_BEGIN
@protocol LVLineChartsViewDelegate
-(void)touchAtIndex:(NSInteger)index withConvertRectTWindow:(CGRect)rect;
-(void)scrollDidAtStartIndex:(NSInteger)start withEndIndex:(NSInteger)end;
@end


@interface LVLineChartsView : UIView
@property (nonatomic,assign) id<LVLineChartsViewDelegate> delegate;
-(void)setupDataSource:(LVLineChartsObject *)data withUIConfgi:(LVLineChartsUIConfig *)config;
-(void)scrollAtIndex:(NSInteger)index;
@end

NS_ASSUME_NONNULL_END
