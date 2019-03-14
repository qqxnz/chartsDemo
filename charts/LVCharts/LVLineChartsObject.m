//
//  LVLineChartsObject.m
//  charts
//
//  Created by lv on 2019/2/18.
//  Copyright © 2019 lv. All rights reserved.
//

#import "LVLineChartsObject.h"

@implementation LVLineChartsObject

-(float)max{
    NSNumber *max;
    for(int i = 0 ; i < self.dataSources.count ; i++){
        NSNumber *number = (NSNumber *)self.dataSources[i];
        if(i == 0){
            max = number;
        }
        if([number floatValue] > [max floatValue]){
            max = number;
        }
    }
    if([max floatValue] == 0.0){
        return _defaultMax;
    }
    
    NSNumber *maxTarget = [[NSNumber alloc]initWithFloat:-10000000.0];
    for (NSNumber *target in self.targetDataSources) {
        if([target floatValue] > [maxTarget floatValue]){
            maxTarget = target;
        }
    }

    if([maxTarget floatValue] > [max floatValue]){
        return [maxTarget floatValue] * 1.3;
    }
    
    return [max floatValue] * 1.3;
}

-(float)min{
    NSNumber *min;
    for(int i = 0 ; i <  self.dataSources.count ; i++){
        NSNumber *number = (NSNumber *) self.dataSources[i];
        if(i == 0){
            min = number;
        }
        if([number floatValue] < [min floatValue]){
            min = number;
        }
    }
    return [min floatValue];
}

@end
