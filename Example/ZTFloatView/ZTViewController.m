//
//  ZTViewController.m
//  ZTFloatView
//
//  Created by zttina on 04/13/2019.
//  Copyright (c) 2019 zttina. All rights reserved.
//

#import "ZTViewController.h"

#import <ZTFloatingView.h>
@interface ZTViewController ()

@property (nonatomic,strong) ZTFloatingView *floatView;

@end

@implementation ZTViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.floatView = [[ZTFloatingView alloc] initWithFrame:CGRectMake(ZTSCREENW - ZTadapter(175) - 12, ZTSCREENH - ZTadapter(103) - ZTadapter(50) - (ZT_TAB_BAR_HEIGHT - 49), ZTadapter(175), ZTadapter(50)) image:[UIImage imageNamed:@"profilePhoto"] topText:@"上面显示的文字，可在此赋值" bottomText:@"下面显示的文字，可在此赋值" arrowImage:[UIImage imageNamed:@"rightArrow"]];
    [self.view addSubview:self.floatView];
    
    [self.floatView addGradientLayerFromLeftColor:ZTHEXCOLOR(0x00DBFF) toRightColor:ZTHEXCOLOR(0x0060FF)];
    
    //MARK:点击view的时候调用
    self.floatView.tapBlock = ^{
        
    };
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
