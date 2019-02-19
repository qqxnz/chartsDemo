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
@protocol LVDrawLineViewDelgate
-(void)touchAtIndex:(NSInteger)index;
@end


@interface LVDrawLineView : UIView

@property (nonatomic,assign) id<LVDrawLineViewDelgate> delegate;

-(void)setPoint:(NSArray *)array withConfig:(LVLineChartsUIConfig *)conf;
@end

NS_ASSUME_NONNULL_END
