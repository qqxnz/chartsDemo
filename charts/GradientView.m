//
//  gradientView.m
//  charts
//
//  Created by lv on 2019/1/17.
//  Copyright © 2019 lv. All rights reserved.
//

#import "GradientView.h"

@implementation GradientView
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
    CGFloat lineWith = self.bounds.size.width / 8.0;
    
    NSLog(@"%f",self.bounds.size.height);
    
    float top = [self returnMax] * 2.0;
    float heightAdd  = 0.0; ///高度偏移
    float bl = self.bounds.size.height / top * 2.0;
    NSLog(@"MAX:%f",top);
    NSLog(@"bl:%f",bl);
    
    UIBezierPath* path = [UIBezierPath bezierPath];
    path.lineWidth = 4.0;
    
    for(int i = 0 ; i < _dataArray.count ; i++){
        NSNumber *number = (NSNumber *)_dataArray[i];
        float height = [number floatValue] * bl;
        if(i == 0){
            [path moveToPoint:CGPointMake(i * lineWith, self.bounds.size.height + heightAdd - height)];
        }
        [path addLineToPoint:CGPointMake(i * lineWith, self.bounds.size.height + heightAdd - height)];
    }
    
    [[UIColor redColor] set];
    [path stroke];
    
    ///路径回归
    [path addLineToPoint:CGPointMake(self.bounds.size.width, self.bounds.size.height)];
    [path addLineToPoint:CGPointMake(0, self.bounds.size.height)];
    [path closePath];
    //回归颜色
    [[UIColor clearColor] set];
    [path stroke];
    
    [[UIColor orangeColor] set];
    [path fill];
    
}

///获取最大值
-(float)returnMax{
    NSNumber *max;
    for(int i = 0 ; i < _dataArray.count ; i++){
        NSNumber *number = (NSNumber *)_dataArray[i];
        if(i == 0){
            max = number;
        }
        if([number floatValue] > [max floatValue]){
            max = number;
        }
    }
    return [max floatValue];
}
///获取最小值
-(float)returnMin{
    NSNumber *min;
    for(int i = 0 ; i < _dataArray.count ; i++){
        NSNumber *number = (NSNumber *)_dataArray[i];
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
