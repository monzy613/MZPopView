//
//  MZViewController.m
//  MZPopView
//
//  Created by monzy613 on 05/26/2016.
//  Copyright (c) 2016 monzy613. All rights reserved.
//

#import "MZViewController.h"
#import "MZPopView/MZPopLabel.h"
#import "MZPopView/MZPopView.h"
#import "MZPopView/MZPopButtonGroup.h"

@interface MZViewController ()

@property (nonatomic, strong) MZPopButtonGroup *popView;

@end

@implementation MZViewController

#pragma mark - life cycle
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.popView = [[MZPopButtonGroup alloc] initWithFrame:CGRectMake(50, 100, 100, 50)];
    self.popView.color = [UIColor yellowColor];

    UIButton *leftBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    leftBtn.frame = CGRectMake(200, 240, 100, 50);
    [leftBtn setTitle:@"pop left" forState:UIControlStateNormal];
    [leftBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [leftBtn addTarget:self action:@selector(popLeft:) forControlEvents:UIControlEventTouchUpInside];
    leftBtn.backgroundColor = [UIColor blackColor];

    UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    rightBtn.frame = CGRectMake(200, 300, 100, 50);
    [rightBtn setTitle:@"pop right" forState:UIControlStateNormal];
    [rightBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [rightBtn addTarget:self action:@selector(popRight:) forControlEvents:UIControlEventTouchUpInside];
    rightBtn.backgroundColor = [UIColor blackColor];

    UIButton *upBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    upBtn.frame = CGRectMake(200, 360, 100, 50);
    [upBtn setTitle:@"pop up" forState:UIControlStateNormal];
    [upBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [upBtn addTarget:self action:@selector(popUp:) forControlEvents:UIControlEventTouchUpInside];
    upBtn.backgroundColor = [UIColor blackColor];

    UIButton *downBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    downBtn.frame = CGRectMake(200, 420, 100, 50);
    [downBtn setTitle:@"pop down" forState:UIControlStateNormal];
    [downBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [downBtn addTarget:self action:@selector(popDown:) forControlEvents:UIControlEventTouchUpInside];
    downBtn.backgroundColor = [UIColor blackColor];

    UIButton *dismissBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    dismissBtn.frame = CGRectMake(200, 480, 100, 50);
    [dismissBtn setTitle:@"pop back" forState:UIControlStateNormal];
    [dismissBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [dismissBtn addTarget:self action:@selector(popBack:) forControlEvents:UIControlEventTouchUpInside];
    dismissBtn.backgroundColor = [UIColor magentaColor];

    UIView *ball = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 20, 20)];
    ball.backgroundColor = [UIColor redColor];
    ball.layer.cornerRadius = 10.0;
    ball.center = CGPointMake(100, 100);

    UIButton *firstButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [firstButton setTitle:@"chat" forState:UIControlStateNormal];
    [firstButton setImage:[UIImage imageNamed:@"chat"] forState:UIControlStateNormal];
    [firstButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];

    UIButton *secondButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [secondButton setImage:[UIImage imageNamed:@"camera"] forState:UIControlStateNormal];
    [secondButton setTitle:@"camera" forState:UIControlStateNormal];
    [secondButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];

    self.popView.buttons = @[firstButton, secondButton];

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
    //self.popView.label.text = @"pop left";
}

- (void)popRight:(id)sender
{
    [self.popView popRightFromPoint:CGPointMake(100, 100)];
    //self.popView.label.text = @"pop right";
}

- (void)popUp:(id)sender
{
    [self.popView popUpFromPoint:CGPointMake(100, 100)];
    //self.popView.label.text = @"pop up";
}

- (void)popDown:(id)sender
{
    [self.popView popDownFromPoint:CGPointMake(100, 100)];
    //self.popView.label.text = @"pop down";
}

- (void)popBack:(id)sender
{
    [self.popView popBack];
}

@end
