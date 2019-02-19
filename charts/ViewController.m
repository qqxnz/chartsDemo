//
//  ViewController.m
//  charts
//
//  Created by lv on 2019/1/17.
//  Copyright © 2019 lv. All rights reserved.
//

#import "ViewController.h"
#import "ChartsView.h"
#import "LVLineChartsView.h"
#import "LVLineChartsObject.h"
#import "LVLineChartsUIConfig.h"



@interface ViewController ()
@property (nonatomic) ChartsView * ChartsView;
@property (nonatomic) LVLineChartsView *lineChartsView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    _ChartsView = [[ChartsView alloc]initWithFrame:CGRectMake(0, 100, self.view.bounds.size.width - 10, 250)];
    
    [self.view addSubview:_ChartsView];
    
//    NSMutableArray *dataList = [NSMutableArray arrayWithObjects:[[NSNumber alloc]initWithFloat:78.0],[[NSNumber alloc]initWithFloat:62.6],[[NSNumber alloc]initWithFloat:66.6],[[NSNumber alloc]initWithFloat:65],[[NSNumber alloc]initWithFloat:54.2],[[NSNumber alloc]initWithFloat:71.794876],[[NSNumber alloc]initWithFloat:56.7],[[NSNumber alloc]initWithFloat:65],[[NSNumber alloc]initWithFloat:36.0], nil];
    
        NSMutableArray *dataList = [NSMutableArray arrayWithObjects:[[NSNumber alloc]initWithFloat:78.0],[[NSNumber alloc]initWithFloat:62.6],[[NSNumber alloc]initWithFloat:66.6],[[NSNumber alloc]initWithFloat:65],[[NSNumber alloc]initWithFloat:103.2],[[NSNumber alloc]initWithFloat:71.794876],[[NSNumber alloc]initWithFloat:56.7],[[NSNumber alloc]initWithFloat:65],[[NSNumber alloc]initWithFloat:36.0], nil];

    

    [_ChartsView setLineColor:[UIColor blueColor]];
    [_ChartsView setPointColor:[UIColor blueColor]];
    [_ChartsView setTargetNumber:[NSNumber numberWithFloat:65.0]];
    [_ChartsView setTargetColor:[UIColor redColor]];
    [_ChartsView setLeftTextColor:[UIColor grayColor]];
    [_ChartsView setDownTextColor:[UIColor orangeColor]];
    [_ChartsView setGradientColor:[UIColor orangeColor] withEndColor:[UIColor greenColor]];
    
    
    [_ChartsView setLeftTextFont:[UIFont systemFontOfSize:14]];
    [_ChartsView setDownTextFont:[UIFont systemFontOfSize:14]];
    
    [_ChartsView showWithData:dataList];


    _lineChartsView = [[LVLineChartsView alloc]initWithFrame:CGRectMake(0, 400.0, self.view.bounds.size.width, 220.0)];
    
    [self.view addSubview:_lineChartsView];
    
    
    LVLineChartsObject *object = [LVLineChartsObject new];
    
    object.dataSources = @[@(89.0),@(65.0),@(30.0),@(70.0),@(50.0),@(60.0),@(100.0),@(0.0),@(120.0),@(40.0),@(30.0),@(110.0),@(200.0),@(60.0),@(160.0),@(50.0),@(130.0)];
//    object.dataSources = @[@(3.5),@(2.1),@(8.8),@(5.6),@(1.7)];
//    object.dataSources = @[@(1190),@(1200),@(900),@(1300),@(1280),@(1280),@(1100)];
    object.descriptionDataSource = @[@"日",@"一",@"二",@"三",@"四",@"五",@"六",@"日",@"一",@"二"];
    
    object.targetDataSources = @[@(65.0),@(180.0)];
    
    LVLineChartsUIConfig *config = [LVLineChartsUIConfig new];
    config.intervalWidth = 35.0;
    config.lineWidth = 2.0;
    config.lineColor = [UIColor colorWithRed:70/255.0 green:210/255.0 blue:185/255.0 alpha:1.0];
    config.backgroundGradientStartColor = [UIColor colorWithRed:47/255.0 green:179/255.0 blue:173/255.0 alpha:1.0];
    config.backgroundGradientEndColor = [UIColor colorWithRed:75/255.0 green:217/255.0 blue:188/255.0 alpha:0.22];
    config.pointColor = [UIColor colorWithRed:70/255.0 green:210/255.0 blue:185/255.0 alpha:1.0];
    config.pointWidth = 4.0;
    config.bottomLabFont = [UIFont systemFontOfSize:10];
    config.bottomLabTextColor = [UIColor colorWithRed:70/255.0 green:210/255.0 blue:185/255.0 alpha:1.0];
    config.leftLabFont = [UIFont systemFontOfSize:10];
    config.leftLabTextColor = [UIColor colorWithRed:70/255.0 green:210/255.0 blue:185/255.0 alpha:1.0];
    
    config.targetLabFont = [UIFont systemFontOfSize:8];
    config.targetLabTextColor = UIColor.orangeColor;
    config.targetLineColor = UIColor.blueColor;
    
    [_lineChartsView setupDataSource:object withUIConfgi:config];
    
    
    
    
    
    
}


@end
