//
//  MZViewController.m
//  MZPopView
//
//  Created by monzy613 on 05/26/2016.
//  Copyright (c) 2016 monzy613. All rights reserved.
//

#import "MZViewController.h"
#import "MZPopView/MZPopView.h"

@interface MZViewController ()

@property (nonatomic, strong) MZPopView *popView;

@end

@implementation MZViewController

#pragma mark - life cycle
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.popView = [[MZPopView alloc] initWithFrame:CGRectMake(50, 100, 100, 50)];

    UIButton *leftBtn = [[UIButton alloc] initWithFrame:CGRectMake(200, 240, 100, 50)];
    [leftBtn addTarget:self action:@selector(popLeft:) forControlEvents:UIControlEventTouchUpInside];
    leftBtn.backgroundColor = [UIColor blackColor];

    UIButton *rightBtn = [[UIButton alloc] initWithFrame:CGRectMake(200, 300, 100, 50)];
    [rightBtn addTarget:self action:@selector(popRight:) forControlEvents:UIControlEventTouchUpInside];
    rightBtn.backgroundColor = [UIColor blackColor];

    UIButton *upBtn = [[UIButton alloc] initWithFrame:CGRectMake(200, 360, 100, 50)];
    [upBtn addTarget:self action:@selector(popUp:) forControlEvents:UIControlEventTouchUpInside];
    upBtn.backgroundColor = [UIColor blackColor];

    UIButton *downBtn = [[UIButton alloc] initWithFrame:CGRectMake(200, 420, 100, 50)];
    [downBtn addTarget:self action:@selector(popDown:) forControlEvents:UIControlEventTouchUpInside];
    downBtn.backgroundColor = [UIColor blackColor];

    UIButton *dismissBtn = [[UIButton alloc] initWithFrame:CGRectMake(200, 480, 100, 50)];
    [dismissBtn addTarget:self action:@selector(popBack:) forControlEvents:UIControlEventTouchUpInside];
    dismissBtn.backgroundColor = [UIColor magentaColor];

    UIView *ball = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 20, 20)];
    ball.backgroundColor = [UIColor redColor];
    ball.layer.cornerRadius = 10.0;
    ball.center = CGPointMake(100, 100);

    [self.view addSubview:ball];
    [self.view addSubview:self.popView];
    [self.view addSubview:leftBtn];
    [self.view addSubview:rightBtn];
    [self.view addSubview:upBtn];
    [self.view addSubview:downBtn];
    [self.view addSubview:dismissBtn];
}

- (void)popLeft:(id)sender
{
    [self.popView popLeftFromPoint:CGPointMake(100, 100)];
}

- (void)popRight:(id)sender
{
    [self.popView popRightFromPoint:CGPointMake(100, 100)];
}

- (void)popUp:(id)sender
{
    [self.popView popUpFromPoint:CGPointMake(100, 100)];
}

- (void)popDown:(id)sender
{
    [self.popView popDownFromPoint:CGPointMake(100, 100)];
}

- (void)popBack:(id)sender
{
    [self.popView popBack];
}

@end
