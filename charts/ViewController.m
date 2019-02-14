//
//  ViewController.m
//  charts
//
//  Created by lv on 2019/1/17.
//  Copyright © 2019 lv. All rights reserved.
//

#import "ViewController.h"
#import "ChartsView.h"

@interface ViewController ()
@property (nonatomic) ChartsView * ChartsView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    _ChartsView = [[ChartsView alloc]initWithFrame:CGRectMake(0, 100, self.view.bounds.size.width - 10, 250)];
    
//    NSMutableArray *dataList = [NSMutableArray arrayWithObjects:[[NSNumber alloc]initWithFloat:78.0],[[NSNumber alloc]initWithFloat:62.6],[[NSNumber alloc]initWithFloat:66.6],[[NSNumber alloc]initWithFloat:65],[[NSNumber alloc]initWithFloat:54.2],[[NSNumber alloc]initWithFloat:71.794876],[[NSNumber alloc]initWithFloat:56.7],[[NSNumber alloc]initWithFloat:65],[[NSNumber alloc]initWithFloat:36.0], nil];
    
        NSMutableArray *dataList = [NSMutableArray arrayWithObjects:[[NSNumber alloc]initWithFloat:78.0],[[NSNumber alloc]initWithFloat:62.6],[[NSNumber alloc]initWithFloat:66.6],[[NSNumber alloc]initWithFloat:65],[[NSNumber alloc]initWithFloat:54.2],[[NSNumber alloc]initWithFloat:71.794876],[[NSNumber alloc]initWithFloat:56.7],[[NSNumber alloc]initWithFloat:65],[[NSNumber alloc]initWithFloat:36.0], nil];

    
//
//    [_ChartsView setLineColor:[UIColor blueColor]];
//    [_ChartsView setPointColor:[UIColor blueColor]];
//    
//    [_ChartsView setGradientColor:[UIColor orangeColor] withEndColor:[UIColor greenColor]];
    
    
    [_ChartsView showWithData:dataList];

    [self.view addSubview:_ChartsView];
    
    
    
    
    
    
}


@end
