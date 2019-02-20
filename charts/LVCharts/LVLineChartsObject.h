//
//  LVLineChartsObject.h
//  charts
//
//  Created by lv on 2019/2/18.
//  Copyright © 2019 lv. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface LVLineChartsObject : NSObject
@property (nonatomic,assign) float defaultMax;
@property (nonatomic,assign) float max;
@property (nonatomic,assign) float min;
@property (nonatomic,retain) NSArray *dataSources;
@property (nonatomic,retain) NSArray *targetDataSources;
@property (nonatomic,retain) NSArray *descriptionDataSource;
@end

NS_ASSUME_NONNULL_END
