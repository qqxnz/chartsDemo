//
//  ChartsView.m
//  charts
//
//  Created by lv on 2019/1/17.
//  Copyright © 2019 lv. All rights reserved.
//

#import "ChartsView.h"

@interface ChartsView()
@property (nonatomic) UIColor *gradientStartColor;
@property (nonatomic) UIColor *gradientEndColor;
@property (nonatomic) NSMutableArray *dataArray;
@property (nonatomic) GriddingView *griddingView;
@property (nonatomic) GradientView *gradientView;
@end

@implementation ChartsView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];


    }
    return self;
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
    
}
///每日标签
-(void)setLab{

    CGFloat width = (self.frame.size.width - 50.0) / 8.0;
    
    _sundayLab = [[UILabel alloc]initWithFrame:CGRectMake(50 + 0.5 * width, self.frame.size.height - 40, width, 40)];
    _sundayLab.text = @"日";
    _sundayLab.textAlignment = NSTextAlignmentCenter;
    [self addSubview:_sundayLab];
    
    _mondayLab = [[UILabel alloc]initWithFrame:CGRectMake(_sundayLab.frame.origin.x + width, self.frame.size.height - 40, width, 40)];
    _mondayLab.text = @"一";
    _mondayLab.textAlignment = NSTextAlignmentCenter;
    [self addSubview:_mondayLab];
    
    _tuesdayLab = [[UILabel alloc]initWithFrame:CGRectMake(_mondayLab.frame.origin.x + width, self.frame.size.height - 40, width, 40)];
    _tuesdayLab.text = @"二";
    _tuesdayLab.textAlignment = NSTextAlignmentCenter;
    [self addSubview:_tuesdayLab];
    
    _wednesdayLab =  [[UILabel alloc]initWithFrame:CGRectMake(_tuesdayLab.frame.origin.x + width, self.frame.size.height - 40, width, 40)];
    _wednesdayLab.text = @"三";
    _wednesdayLab.textAlignment = NSTextAlignmentCenter;
    [self addSubview:_wednesdayLab];
    
    
    _thursdayLab = [[UILabel alloc]initWithFrame:CGRectMake(_wednesdayLab.frame.origin.x + width, self.frame.size.height - 40, width, 40)];
    _thursdayLab.text = @"四";
    _thursdayLab.textAlignment = NSTextAlignmentCenter;
    [self addSubview:_thursdayLab];
    
    _fridayLab  = [[UILabel alloc]initWithFrame:CGRectMake(_thursdayLab.frame.origin.x + width, self.frame.size.height - 40, width, 40)];
    _fridayLab.text = @"五";
    _fridayLab.textAlignment = NSTextAlignmentCenter;
    [self addSubview:_fridayLab];
    
    
    _saturdayLab = [[UILabel alloc]initWithFrame:CGRectMake(_fridayLab.frame.origin.x + width, self.frame.size.height - 40, width, 40)];
    _saturdayLab.text = @"六";
    _saturdayLab.textAlignment = NSTextAlignmentCenter;
    [self addSubview:_saturdayLab];
    

}


-(void)setLeftLab{
    
    for(int i = 0 ; i < _griddingView.leftDataArray.count ; i++){
        NSNumber *number = _griddingView.leftDataArray[i];
        PointObject *point = _griddingView.leftPointArray[i];
        NSLog(@"%f-----%f",[number floatValue],point.pointY);
        UILabel *lab = [[UILabel alloc]initWithFrame:CGRectMake(0, point.pointY - 15.0, 50, 30)];
        lab.textAlignment = NSTextAlignmentCenter;
        lab.text = [NSString stringWithFormat:@"%.0f",[number floatValue]];
        [self addSubview:lab];
    }

}

-(void)showWithData:(NSMutableArray *)dataArray{
    
    _griddingView = [[GriddingView alloc]initWithFrame:CGRectMake(50, 0, self.frame.size.width - 50, self.frame.size.height - 40)];
    
    [_griddingView setLineColor:_lineColor];
    [_griddingView setPointColor:_pointColor];
    
    [_griddingView setDataArray:dataArray];
    __weak typeof(self) weakSelf = self;
    self.griddingView.callback = ^{
        __strong typeof(weakSelf) strongSelf = weakSelf;
        [strongSelf setLeftLab];
    };
    
    
    [self addSubview:_griddingView];
    
    
    ///渐变色背影视图
    _gradientView  = [[GradientView alloc]initWithFrame:_griddingView.frame];
    [_gradientView setDataArray:_griddingView.dataArray];
    [self addSubview:_gradientView];
    
    ///渐变色背景
    CAGradientLayer *gl = [CAGradientLayer layer];
    gl.frame = CGRectMake(0,0,self.frame.size.width,self.frame.size.height);
    gl.startPoint = CGPointMake(0.5, 0);
    gl.endPoint = CGPointMake(0.5, 1);
    UIColor *startColor = [UIColor colorWithRed:234/255.0 green:51/255.0 blue:79/255.0 alpha:1.0];
    UIColor *endColor = [UIColor colorWithRed:252/255.0 green:98/255.0 blue:49/255.0 alpha:0.0];
    if(self.gradientStartColor){
        startColor = self.gradientStartColor;
    }
    if(self.gradientEndColor){
        endColor = self.gradientEndColor;
    }
    gl.colors = @[(__bridge id)startColor.CGColor,(__bridge id)endColor.CGColor];
    gl.locations = @[@(0), @(1.0f)];
    [self.layer insertSublayer:gl atIndex:0];
    gl.mask = _gradientView.layer;
    
    ///设置标签
    [self setLab];
}


-(void)setGradientColor:(UIColor *)start withEndColor:(UIColor *)end{
    _gradientStartColor = start;
    _gradientEndColor = end;
}

@end
