//
//  LVLineChartsView.m
//  charts
//
//  Created by lv on 2019/2/18.
//  Copyright © 2019 lv. All rights reserved.
//

#import "LVLineChartsView.h"
#import "LVDrawLineView.h"
#import "LVLineBackGroundView.h"

@interface LVLineChartsView()<LVDrawLineViewDelegate,UIScrollViewDelegate>
@property (nonatomic) UIScrollView *scrollView;
@property (nonatomic) LVDrawLineView *drawLineView;
@property (nonatomic) LVLineBackGroundView *lineBackgroundView;
@property (nonatomic) LVLineChartsObject *data;
@property (nonatomic) LVLineChartsUIConfig *config;
@property (nonatomic) NSMutableArray *pointArray;
@property (nonatomic) NSInteger lineCount;
@property (nonatomic) CGFloat proportion;
@end

@implementation LVLineChartsView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if(self){
        self.backgroundColor = UIColor.whiteColor;
        _pointArray = [[NSMutableArray alloc]init];
        _scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(40, 0, self.frame.size.width - 40.0, self.frame.size.height)];
        [_scrollView setShowsVerticalScrollIndicator:NO];
        [_scrollView setShowsHorizontalScrollIndicator:NO];
        _scrollView.delegate = self;
        [self addSubview:_scrollView];
        _lineCount =  (NSInteger)self.frame.size.height / 50.0;

    }
    return self;
}

-(void)setupDataSource:(LVLineChartsObject *)data withUIConfgi:(LVLineChartsUIConfig *)config{
    _data = data;
    _config = config;
    
    for(int i = 1 ; i <= _lineCount ; i++){
        [self setHorizontalLine:i];
    }
    
//    JDLog(@"最大值:%f",_data.max);
//    JDLog(@"最小值:%f",_data.min);

    _proportion = (self.frame.size.height - 50.0) / _data.max;


    for(int i = 0 ; i < _data.dataSources.count ; i++){
        NSNumber *number = (NSNumber *) _data.dataSources[i];
        CGPoint point = CGPointMake(i * _config.intervalWidth + _config.intervalWidth * 0.5, self.frame.size.height - 50 - [number floatValue] * _proportion);
        [_pointArray addObject:@(point)];
        ///底部文字
        UILabel *lab = [[UILabel alloc]initWithFrame:CGRectMake(0, self.frame.size.height - 50, 40, 50)];
        if( i < _data.descriptionDataSource.count ){
            lab.text = _data.descriptionDataSource[i];
        }
        lab.textAlignment = NSTextAlignmentCenter;
        lab.center = CGPointMake(point.x, lab.center.y);
        lab.font = _config.bottomLabFont;
        lab.textColor = _config.bottomLabTextColor;
        [_scrollView addSubview:lab];
    }

    for(int i = 0 ; i < _data.targetDataSources.count ; i++){
        NSNumber *targetNumber = (NSNumber *) _data.targetDataSources[i];
        CGFloat y = self.frame.size.height - 50 - [targetNumber floatValue] * _proportion;
        ///目标线
        UIView *targetLine = [[UIView alloc]initWithFrame:CGRectMake(40, y , self.frame.size.width - 40, 1)];
        targetLine.backgroundColor = _config.targetLineColor;
        [self addSubview:targetLine];
        ///目标文字
        UILabel *lab = [[UILabel alloc]initWithFrame:CGRectMake(0, self.frame.size.height - 50.0, 40.0, 40.0)];
        lab.text = [NSString stringWithFormat: @"%.1f",[targetNumber floatValue]];
        lab.textAlignment = NSTextAlignmentCenter;
        lab.center = CGPointMake(lab.center.x, y);
        lab.font = _config.targetLabFont;
        lab.textColor = _config.targetLabTextColor;
        [self addSubview:lab];
    }
    
    _drawLineView = [[LVDrawLineView alloc] initWithFrame:CGRectMake(0, 0, _config.intervalWidth * _data.dataSources.count, self.frame.size.height - 50)];
//    JDLog(@"嗷嗷嗷:%f", (_lineCount * 50.0) / _data.max );
    [_drawLineView setPoint:_pointArray.copy withConfig:_config];
    _drawLineView.delegate = self;
    [_scrollView addSubview:_drawLineView];
    
    _scrollView.contentSize = CGSizeMake(_drawLineView.bounds.size.width, _scrollView.bounds.size.height);


    _lineBackgroundView = [[LVLineBackGroundView alloc] initWithFrame:_drawLineView.frame];
    
    [_lineBackgroundView setPoint:_pointArray.copy];
    [_scrollView addSubview:_lineBackgroundView];
    
    [self setGradientLayer];
    
    [_scrollView bringSubviewToFront:_drawLineView];
    
    
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code

    
    
}


-(void)setHorizontalLine:(CGPoint )start withEndPoint:(CGPoint )end{
    UIBezierPath* path = [UIBezierPath bezierPath];
    path.lineWidth = 1.0;
    [path moveToPoint:start];
    [path addLineToPoint:end];
    [[UIColor grayColor] set];
    [path stroke];
}
///画线
-(void)setHorizontalLine:(int)i{
    CGFloat bl = (self.frame.size.height - 50.0) / _data.max;
    UILabel *lab =  [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 40, 40)];
 
    CGFloat h = (i - 1) * 50.0;
    CGFloat lineNumber = h / bl;
    ///左侧文字
    lab.text = [NSString stringWithFormat:@"%.1f",lineNumber];
    lab.textAlignment = NSTextAlignmentCenter;
    lab.font = _config.leftLabFont;
    lab.textColor = _config.leftLabTextColor;
    [self addSubview:lab];
    
    ///水平线
    UIView * line = [[UIView alloc]initWithFrame:CGRectMake(40, self.frame.size.height - i * 50.0, self.bounds.size.width - 40, 1)];
    [line setBackgroundColor:[UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:0.1]];
    [self addSubview:line];
    
    [lab setCenter: CGPointMake(lab.center.x, line.center.y)];
}


-(void)setGradientLayer{
    ///渐变色背景
    CAGradientLayer *gl = [CAGradientLayer layer];
    gl.frame = CGRectMake(0,0,_lineBackgroundView.frame.size.width,_lineBackgroundView.frame.size.height);
    gl.startPoint = CGPointMake(0.5, 0);
    gl.endPoint = CGPointMake(0.5, 1);
    UIColor *startColor = [UIColor colorWithRed:234/255.0 green:51/255.0 blue:79/255.0 alpha:1.0];
    UIColor *endColor = [UIColor colorWithRed:252/255.0 green:98/255.0 blue:49/255.0 alpha:0.0];
    if(_config.backgroundGradientStartColor){
        startColor = _config.backgroundGradientStartColor;
    }
    if(_config.backgroundGradientEndColor){
        endColor = _config.backgroundGradientEndColor;
    }
    gl.colors = @[(__bridge id)startColor.CGColor,(__bridge id)endColor.CGColor];
    gl.locations = @[@(0), @(1.0f)];
    [_scrollView.layer insertSublayer:gl atIndex:0];
    gl.mask = _lineBackgroundView.layer;
}

- (void)touchAtIndex:(NSInteger)index withConvertRectTWindow:(CGRect)rect{
    
    [self.delegate touchAtIndex:index withConvertRectTWindow:rect];
    
}

-(void)scrollAtIndex:(NSInteger)index{
    if(index > _pointArray.count){
        return;
    }
    
    NSValue * value = (NSValue *)_pointArray[index - 1];
    
//    JDLog(@"滑动宽度： %f",_drawLineView.bounds.size.width);
//    JDLog(@"图表宽度： %f",_scrollView.bounds.size.width);
//    JDLog(@"滑动位置： %f",[value CGPointValue].x);
    if(_drawLineView.bounds.size.width -  _scrollView.bounds.size.width <  [value CGPointValue].x){
        [_scrollView setContentOffset:CGPointMake(_drawLineView.bounds.size.width -  _scrollView.bounds.size.width, 0) animated:YES];
    }else{
        [_scrollView setContentOffset:CGPointMake([value CGPointValue].x, 0) animated:YES];
    }
    
    
}


- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
//    JDLog(@"滑动监听：%f ",scrollView.contentOffset.x);
    
    int startIndex = 0;
    CGFloat betweenMin = _scrollView.bounds.size.width;
    for(int i = 0 ; i < _pointArray.count ; i++){
        NSValue *value = (NSValue *) _pointArray[i];
        float between = fabsf((float)[value CGPointValue].x - (float)(scrollView.contentOffset.x +_config.intervalWidth * 0.5));///增加偏移量
        if(between < betweenMin){
            betweenMin = between;
            startIndex = i;
        }
    }
    
//    JDLog(@"滑动监听数据StartIndex：%d ",startIndex);
    
    int endIndex = 0;
    betweenMin = _scrollView.bounds.size.width;
    for(int i = (int)(_pointArray.count - 1) ; i >= 0 ; i--){
        NSValue *value = (NSValue *) _pointArray[i];
        float between = fabsf((float)[value CGPointValue].x - (float)(scrollView.contentOffset.x + _scrollView.bounds.size.width - _config.intervalWidth * 0.5));///增加偏移量
        if(between < betweenMin){
            betweenMin = between;
            endIndex = i;
        }
    }
    
//    JDLog(@"滑动监听数据EndIndex：%d ",endIndex);
    [self.delegate scrollDidAtStartIndex:startIndex withEndIndex:endIndex];
}


@end
