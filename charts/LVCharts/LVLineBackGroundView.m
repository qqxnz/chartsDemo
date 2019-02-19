//
//  LVLineBackGroundView.m
//  charts
//
//  Created by lv on 2019/2/19.
//  Copyright © 2019 lv. All rights reserved.
//

#import "LVLineBackGroundView.h"

@interface LVLineBackGroundView()

@property (nonatomic,copy) NSArray *_pointsArray;
@end


@implementation LVLineBackGroundView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

-(void)setPoint:(NSArray *)array{
    __pointsArray = array.copy;
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
    
    UIBezierPath* path = [UIBezierPath bezierPath];
    path.lineWidth = 4.0;

    for(int i = 0 ; i < __pointsArray.count ; i++){
        NSValue * value = (NSValue *)__pointsArray[i];
        if(i == 0){
            [path moveToPoint:[value CGPointValue]];
        }
        [path addLineToPoint:[value CGPointValue]];
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


@end
