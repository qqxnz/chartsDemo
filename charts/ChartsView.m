//
//  ChartsView.m
//  charts
//
//  Created by lv on 2019/1/17.
//  Copyright © 2019 lv. All rights reserved.
//

#import "ChartsView.h"

@interface ChartsView()<UIGestureRecognizerDelegate>
@property (nonatomic) UIColor *gradientStartColor;
@property (nonatomic) UIColor *gradientEndColor;
@property (nonatomic) NSMutableArray *dataArray;
@property (nonatomic) GriddingView *griddingView;
@property (nonatomic) GradientView *gradientView;
@property (nonatomic) UIView *selectLineView;
@end

@implementation ChartsView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        
        _selectLineView = [[UIView alloc]init];
        [self addSubview:_selectLineView];
        
        UITapGestureRecognizer* singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleSingleTap:)];
        [self addGestureRecognizer:singleTap];
        singleTap.delegate = self;
        singleTap.cancelsTouchesInView = NO;
        

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
    _sundayLab.textColor = self.downTextColor;
    
    [self addSubview:_sundayLab];
    
    _mondayLab = [[UILabel alloc]initWithFrame:CGRectMake(_sundayLab.frame.origin.x + width, self.frame.size.height - 40, width, 40)];
    _mondayLab.text = @"一";
    _mondayLab.textAlignment = NSTextAlignmentCenter;
    _mondayLab.textColor = self.downTextColor;
    [self addSubview:_mondayLab];
    
    _tuesdayLab = [[UILabel alloc]initWithFrame:CGRectMake(_mondayLab.frame.origin.x + width, self.frame.size.height - 40, width, 40)];
    _tuesdayLab.text = @"二";
    _tuesdayLab.textAlignment = NSTextAlignmentCenter;
    _tuesdayLab.textColor = self.downTextColor;
    [self addSubview:_tuesdayLab];
    
    _wednesdayLab =  [[UILabel alloc]initWithFrame:CGRectMake(_tuesdayLab.frame.origin.x + width, self.frame.size.height - 40, width, 40)];
    _wednesdayLab.text = @"三";
    _wednesdayLab.textAlignment = NSTextAlignmentCenter;
    _wednesdayLab.textColor = self.downTextColor;;
    [self addSubview:_wednesdayLab];
    
    
    _thursdayLab = [[UILabel alloc]initWithFrame:CGRectMake(_wednesdayLab.frame.origin.x + width, self.frame.size.height - 40, width, 40)];
    _thursdayLab.text = @"四";
    _thursdayLab.textAlignment = NSTextAlignmentCenter;
    _thursdayLab.textColor = self.downTextColor;
    [self addSubview:_thursdayLab];
    
    _fridayLab  = [[UILabel alloc]initWithFrame:CGRectMake(_thursdayLab.frame.origin.x + width, self.frame.size.height - 40, width, 40)];
    _fridayLab.text = @"五";
    _fridayLab.textAlignment = NSTextAlignmentCenter;
    _fridayLab.textColor = self.downTextColor;
    [self addSubview:_fridayLab];
    
    
    _saturdayLab = [[UILabel alloc]initWithFrame:CGRectMake(_fridayLab.frame.origin.x + width, self.frame.size.height - 40, width, 40)];
    _saturdayLab.text = @"六";
    _saturdayLab.textAlignment = NSTextAlignmentCenter;
    _saturdayLab.textColor = self.downTextColor;
    [self addSubview:_saturdayLab];
    
    if(self.downTextFont){
        _sundayLab.font = self.downTextFont;
        _mondayLab.font = self.downTextFont;
        _tuesdayLab.font = self.downTextFont;
        _wednesdayLab.font = self.downTextFont;
        _thursdayLab.font = self.downTextFont;
        _fridayLab.font = self.downTextFont;
        _saturdayLab.font = self.downTextFont;
    }
    
}


-(void)setLeftLab{
    
    for(int i = 0 ; i < _griddingView.leftDataArray.count ; i++){
        NSNumber *number = _griddingView.leftDataArray[i];
        PointObject *point = _griddingView.leftPointArray[i];
        NSLog(@"%f-----%f",[number floatValue],point.pointY);
        UILabel *lab = [[UILabel alloc]initWithFrame:CGRectMake(0, point.pointY - 15.0, 50, 30)];
        lab.textAlignment = NSTextAlignmentCenter;
        lab.text = [NSString stringWithFormat:@"%.0f",[number floatValue]];
        if(i == 0){
            lab.textColor = self.targetColor;
        }else{
            lab.textColor = self.leftTextColor;
        }
        if(self.leftTextFont){
            lab.font = self.leftTextFont;
        }
        [self addSubview:lab];
    }

}

-(void)showWithData:(NSMutableArray *)dataArray{
    
    _griddingView = [[GriddingView alloc]initWithFrame:CGRectMake(50, 0, self.frame.size.width - 50, self.frame.size.height - 40)];
    
    [_griddingView setLineColor:_lineColor];
    [_griddingView setPointColor:_pointColor];
    [_griddingView  setTargetNumber:_targetNumber];
    [_griddingView setTargetColor:_targetColor];
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


/** 手势代理方法 */
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer{
    return YES;
}
/** Lable的点击响应方法 */
-(void)handleSingleTap:(UITapGestureRecognizer *)sender{
    CGPoint point = [sender locationInView:self];
    NSLog(@" pointx:%f,y:%f",point.x,point.y);
    int selectIndex = 0;
    float betweenMin = 999999.0;

    for(int i = 0 ; i < _griddingView.pointArray.count ; i++){

        PointObject *pointObj = _griddingView.pointArray[i];
        float between = fabsf((float)pointObj.pointX - (float)point.x);
        if(between < betweenMin){
            betweenMin = between;
            selectIndex = i;
        }
//        NSLog(@"index:%i  差：%f 最小：%f  选项：%i pointX:%f",i,between,betweenMin,selectIndex,pointObj.pointX);

    }
    
    NSLog(@"最终选择%d",selectIndex);
    if(selectIndex < 2){
        selectIndex = 2;
    }
    
    PointObject *selectPoint = _griddingView.pointArray[selectIndex - 1];
    self.selectLineView.frame = CGRectMake(selectPoint.pointX + 50, 0, 2, _griddingView.frame.size.height);
    self.selectLineView.backgroundColor = [UIColor blackColor];

    
}



@end
