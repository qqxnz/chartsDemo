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
    
//    UIBezierPath* path = [UIBezierPath bezierPath];
//    path.lineWidth = 4.0;
//
//    [path moveToPoint:CGPointMake(0, self.bounds.size.height)];
//    int pointInt = 0;
//    for(int i = 0 ; i < __pointsArray.count ; i++){
//        NSValue * value = (NSValue *)__pointsArray[i];
//        if([value CGPointValue].y != self.bounds.size.height){
//            [path addLineToPoint:[value CGPointValue]];
//            pointInt++;
//        }
//    }
//
//    [[UIColor redColor] set];
//    [path stroke];
//
//    ///路径回归
//    [path addLineToPoint:CGPointMake(self.bounds.size.width, self.bounds.size.height)];
//    [path closePath];
//    //回归颜色
//    [[UIColor clearColor] set];
//    [path stroke];
//
//    [[UIColor orangeColor] set];
//    [path fill];
    
    
    UIBezierPath* path = [UIBezierPath bezierPath];
    path.lineWidth = 1.0;

    NSMutableArray *array = [[NSMutableArray alloc]init];
    

    for(int i = 0 ; i < __pointsArray.count ; i++){
        NSValue * value = (NSValue *)__pointsArray[i];
        if([value CGPointValue].y != self.bounds.size.height){
            [array addObject:value];
        }
    }
    
    for (int i = 0 ; i < array.count; i++) {
        NSValue * value = (NSValue *) array[i];
        if(i == 0){
            [path moveToPoint:CGPointMake([value CGPointValue].x, self.bounds.size.height)];
            [path addLineToPoint:[value CGPointValue]];
        }else if(i == array.count - 1){
            [path addLineToPoint:[value CGPointValue]];
            [path addLineToPoint:CGPointMake([value CGPointValue].x,self.bounds.size.height)];
        }else{
            [path addLineToPoint:[value CGPointValue]];
        }
    }

    

    [[UIColor redColor] set];
    [path stroke];

    ///路径回归

    [path closePath];
    //回归颜色
    [[UIColor clearColor] set];
    [path stroke];

    [[UIColor orangeColor] set];
    [path fill];
    
    
    
    
    
    
}


@end
