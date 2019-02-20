//
//  LVDrawLineView.m
//  charts
//
//  Created by lv on 2019/2/18.
//  Copyright © 2019 lv. All rights reserved.
//

#import "LVDrawLineView.h"


@interface LVDrawLineView()<UIGestureRecognizerDelegate>{
    NSArray *_pointsArray;
    LVLineChartsUIConfig *_config;
    UIView *_lineView;
}
@end

@implementation LVDrawLineView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        UITapGestureRecognizer* singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleSingleTap:)];
        [self addGestureRecognizer:singleTap];
        singleTap.delegate = self;
        singleTap.cancelsTouchesInView = NO;
        _lineView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 2, self.frame.size.height)];
        _lineView.backgroundColor = UIColor.clearColor;
        [self addSubview:_lineView];
        
    }
    return self;
}

-(void)setPoint:(NSArray *)array withConfig:(LVLineChartsUIConfig *)conf{
    _pointsArray = array;
    _config = conf;
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
    UIBezierPath* path = [UIBezierPath bezierPath];
    path.lineWidth = _config.lineWidth;
    

    int pointInt = 0;
    for(int i = 0 ; i < _pointsArray.count ; i++){
        NSValue *value = (NSValue *)_pointsArray[i];
        if([value CGPointValue].y != self.bounds.size.height){
            if(pointInt == 0){
                [path moveToPoint:[value CGPointValue]];
            }
            [path addLineToPoint:[value CGPointValue]];
            pointInt++;
        }
        [self setVerticalLine:CGPointMake([value CGPointValue].x, 0) withEndPoint:CGPointMake([value CGPointValue].x, self.bounds.size.height)];
    }
    

    if(_config.lineColor){
        [_config.lineColor set];
    }else{
        [[UIColor colorWithRed:252/255.0 green:68/255.0 blue:96/255.0 alpha:1.0]set];
    }

    [path stroke];

    
    [[UIColor clearColor] set];
    [path fill];

    
    ///画点
    for(int i = 0 ; i < _pointsArray.count ; i++){
        NSValue *value = (NSValue *)_pointsArray[i];
        if([value CGPointValue].y != self.bounds.size.height){
            [self setPoint:[value CGPointValue]];
        }
    }
    
}


///画点
-(void)setPoint:(CGPoint)point{
    UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:point radius:_config.pointWidth startAngle:0 endAngle:M_PI / 180.0 * 360.0 clockwise:YES];
    path.lineWidth = _config.pointWidth;
    [[UIColor whiteColor]set];
    [path stroke];
    if(_config.pointColor){
        [_config.pointColor set];
    }else{
        [[UIColor colorWithRed:252/255.0 green:68/255.0 blue:96/255.0 alpha:1.0]set];
    }
    [path fill];
}


-(void)setVerticalLine:(CGPoint )start withEndPoint:(CGPoint )end{
    
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint: start];
    [path addLineToPoint: end];
    path.lineWidth = 1;
    
    CGFloat dashLineConfig[] = {4.0, 1.0};
    [path setLineDash: dashLineConfig count: 2 phase: 0];
    
    [[UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:0.1] set];
    [path stroke];
}

/** 手势代理方法 */
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer{
    return YES;
}
/** 点击响应方法 */
-(void)handleSingleTap:(UITapGestureRecognizer *)sender{
    CGPoint tapPoint = [sender locationInView:self];
//    NSLog(@"点击 pointx:%f,y:%f",tapPoint.x,tapPoint.y);
    int selectIndex = 0;
    CGFloat betweenMin = self.bounds.size.width;
    for(int i = 0 ; i < _pointsArray.count ; i++){
        NSValue *value = (NSValue *) _pointsArray[i];
        float between = fabsf((float)[value CGPointValue].x - (float)tapPoint.x);
        if(between < betweenMin){
            betweenMin = between;
            selectIndex = i;
        }
    }
    [self.delegate touchAtIndex:selectIndex];
//    NSLog(@"点击的是第%d",selectIndex);
    NSValue *value = (NSValue *) _pointsArray[selectIndex];
    _lineView.center = CGPointMake([value CGPointValue].x, _lineView.center.y);
    _lineView.backgroundColor = [UIColor redColor];

}

@end
