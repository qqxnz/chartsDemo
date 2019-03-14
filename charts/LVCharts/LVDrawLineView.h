//
//  LVDrawLineView.h
//  charts
//
//  Created by lv on 2019/2/18.
//  Copyright © 2019 lv. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LVLineChartsUIConfig.h"


NS_ASSUME_NONNULL_BEGIN
@protocol LVDrawLineViewDelegate
-(void)touchAtIndex:(NSInteger)index withConvertRectTWindow:(CGRect)rect;
@end


@interface LVDrawLineView : UIView

@property (nonatomic,assign) id<LVDrawLineViewDelegate> delegate;

-(void)setPoint:(NSArray *)array withConfig:(LVLineChartsUIConfig *)conf;
@end

NS_ASSUME_NONNULL_END
