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

@interface LVLineChartsView : UIView
-(void)setupDataSource:(LVLineChartsObject *)data withUIConfgi:(LVLineChartsUIConfig *)config;
@end

NS_ASSUME_NONNULL_END
