//
//  LVLineChartsUIConfig.m
//  charts
//
//  Created by lv on 2019/2/18.
//  Copyright © 2019 lv. All rights reserved.
//

#import "LVLineChartsUIConfig.h"

@implementation LVLineChartsUIConfig

- (instancetype)init
{
    self = [super init];
    if (self) {
        _intervalWidth = 20.0;
        _lineWidth = 1.0;
        _pointWidth = 1.0;
    }
    return self;
}

@end
