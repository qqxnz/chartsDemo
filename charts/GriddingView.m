//
//  ChartsView.m
//  charts
//
//  Created by lv on 2019/1/17.
//  Copyright © 2019 lv. All rights reserved.
//

#import "GriddingView.h"

@implementation GriddingView


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = UIColor.clearColor;
        self.pointArray = [[NSMutableArray alloc]init];
        self.leftDataArray = [[NSMutableArray alloc]init];
        self.leftPointArray = [[NSMutableArray alloc]init];
    }
    return self;
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
    
    CGFloat lineWith = self.bounds.size.width / 8.0;
    CGFloat lineHeight = (self.bounds.size.height - 20) / 4.0;
    
    float top = [self returnMax] * 2.0;
    float heightAdd  = 50.0; ///高度偏移
    float bl = self.bounds.size.height / top * 2.0;
    NSLog(@"top:%f",top);
    NSLog(@"bl:%f",bl);
    
    ///画竖线
    for(int i = 0 ; i < 8 ;i++){
        CGFloat x = i * lineWith + 0.5 * lineWith;
        [self setVerticalLine:CGPointMake(x, 0) withEndPoint:CGPointMake(x, self.bounds.size.height)];
    }

    ///画横线
    for(int i = 0 ; i < 5 ;i++){
        CGFloat y = self.bounds.size.height - i * lineHeight;
        [self setHorizontalLine:CGPointMake(0, y) withEndPoint:CGPointMake(self.bounds.size.width, y)];
        CGFloat h =  self.bounds.size.height + 50 - y;
        CGFloat lineNumber = h / bl;
        NSLog(@"lineNumber:%f",lineNumber);
        [self.leftDataArray addObject:[NSNumber numberWithFloat:(float) lineNumber]];
        PointObject *pointOBJ = [[PointObject alloc]init];
        pointOBJ.pointX = 0;
        pointOBJ.pointY = y;
        [self.leftPointArray addObject:pointOBJ];
    }
    ///回调左侧lab数据
    if(self.callback){
        self.callback();
    }
    
    UIBezierPath* path = [UIBezierPath bezierPath];
    path.lineWidth = 4.0;
    
    for(int i = 0 ; i < _dataArray.count ; i++){
        NSNumber *number = (NSNumber *)_dataArray[i];
        float height = [number floatValue] * bl;
        NSLog(@"number:%f   height:%f",[number floatValue],height);
        if(i == 0){
            [path moveToPoint:CGPointMake(i * lineWith, self.bounds.size.height + heightAdd - height)];
        }else{
            [path addLineToPoint:CGPointMake(i * lineWith, self.bounds.size.height + heightAdd - height)];
        }
    }
    
    if(self.lineColor){
        [self.lineColor set];
    }else{
        [[UIColor colorWithRed:252/255.0 green:68/255.0 blue:96/255.0 alpha:1.0]set];
    }
    [path stroke];
    

    [path addLineToPoint:CGPointMake(self.bounds.size.width, self.bounds.size.height)];
    [path addLineToPoint:CGPointMake(0, self.bounds.size.height)];
    [path closePath];

    [[UIColor clearColor] set];
    [path stroke];
    
    
    [[UIColor clearColor] set];
    [path fill];

    ///画点
    for(int i = 0 ; i < _dataArray.count ; i++){
        NSNumber *number = (NSNumber *)_dataArray[i];
        float height = [number floatValue] * bl;
//        NSLog(@"height:%f",height);
        CGPoint pp = CGPointMake(i * lineWith, self.bounds.size.height + heightAdd - height);
        PointObject *pointOBJ = [[PointObject alloc]init];
        pointOBJ.pointX = pp.x;
        pointOBJ.pointY = pp.y;
        [self.pointArray addObject:pointOBJ];
        [self setPoint:pp];
        
    }
    
    

    
}



-(void)setVerticalLine:(CGPoint )start withEndPoint:(CGPoint )end{

    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint: start];
    [path addLineToPoint: end];
    path.lineWidth = 1;

    CGFloat dashLineConfig[] = {4.0, 1.0};
    [path setLineDash: dashLineConfig count: 2 phase: 0];

    [[UIColor grayColor] set];
    [path stroke];
}

-(void)setHorizontalLine:(CGPoint )start withEndPoint:(CGPoint )end{
    
    UIBezierPath* path = [UIBezierPath bezierPath];
    path.lineWidth = 1.0;
    [path moveToPoint:start];
    [path addLineToPoint:end];
    [[UIColor grayColor] set];
    [path stroke];
}

///画点
-(void)setPoint:(CGPoint)point{
    UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:point radius:4 startAngle:0 endAngle:M_PI / 180.0 * 360.0 clockwise:YES];
    path.lineWidth = 4.0;
//    path.lineCapStyle = kCGLineCapButt;
//    path.lineJoinStyle = kCGLineJoinRound;
    
    [[UIColor whiteColor]set];
    [path stroke];
    ///点的颜色
    if(self.pointColor){
        [self.pointColor set];
    }else{
        [[UIColor colorWithRed:252/255.0 green:68/255.0 blue:96/255.0 alpha:1.0]set];
    }
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


@implementation PointObject

@end
