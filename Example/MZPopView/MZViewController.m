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

@property (weak, nonatomic) IBOutlet UISegmentedControl *segmentedControl;
@property (weak, nonatomic) IBOutlet UIView *ball;

@property (nonatomic, strong) MZPopView *selectedPopView;
@property (nonatomic, strong) MZPopView *popView;
@property (nonatomic, strong) MZPopLabel *popLabel;
@property (nonatomic, strong) MZPopButtonGroup *popButtonGroup;

@end

@implementation MZViewController

#pragma mark - life cycle
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.ball.layer.cornerRadius = 10.0;
    [self.view addSubview:self.popView];
    [self.view addSubview:self.popLabel];
    [self.view addSubview:self.popButtonGroup];
    self.selectedPopView = self.popView;
}


#pragma mark - actions
- (IBAction)segmentControlValueChanged:(id)sender {
    [self dismissAll];
    switch ([sender selectedSegmentIndex]) {
        case 0:
            self.selectedPopView = self.popView;
            break;
        case 1:
            self.selectedPopView = self.popLabel;
            break;
        case 2:
            self.selectedPopView = self.popButtonGroup;
            break;
        default:
            break;
    }
}


- (IBAction)popLeft:(id)sender
{
    [self.selectedPopView popLeftFromPoint:self.ball.center];
    if ([self.selectedPopView isKindOfClass:[MZPopLabel class]]) {
        self.popLabel.label.text = @"pop left";
    }
}

- (IBAction)popRight:(id)sender
{
    [self.selectedPopView popRightFromPoint:self.ball.center];
    if ([self.selectedPopView isKindOfClass:[MZPopLabel class]]) {
        self.popLabel.label.text = @"pop right";
    }
}

- (IBAction)popUp:(id)sender
{
    [self.selectedPopView popUpFromPoint:self.ball.center];
    if ([self.selectedPopView isKindOfClass:[MZPopLabel class]]) {
        self.popLabel.label.text = @"pop up";
    }
}

- (IBAction)popDown:(id)sender
{
    [self.selectedPopView popDownFromPoint:self.ball.center];
    if ([self.selectedPopView isKindOfClass:[MZPopLabel class]]) {
        self.popLabel.label.text = @"pop down";
    }
}

- (IBAction)popBack:(id)sender
{
    [self.selectedPopView popBack];
}

#pragma mark - private -
- (void)dismissAll
{
    [self.popView popBack];
    [self.popLabel popBack];
    [self.popButtonGroup popBack];
}

#pragma mark - getters
- (MZPopView *)popView
{
    if (!_popView) {
        _popView = [[MZPopView alloc] initWithFrame:CGRectMake(50, 100, 100, 50)];
        _popView.color = [UIColor yellowColor];
    }
    return _popView;
}

- (MZPopLabel *)popLabel
{
    if (!_popLabel) {
        _popLabel = [[MZPopLabel alloc] init];
        _popLabel.color = [UIColor redColor];
        _popLabel.label.textColor = [UIColor whiteColor];
    }
    return _popLabel;
}

- (MZPopButtonGroup *)popButtonGroup
{
    if (!_popButtonGroup) {
        _popButtonGroup = [[MZPopButtonGroup alloc] init];
        _popButtonGroup.topPad = 8.0;
        _popButtonGroup.color = [UIColor magentaColor];
        _popButtonGroup.hasSeparateLine = YES;
        _popButtonGroup.separateLineColor = [UIColor whiteColor];

        UIButton *firstButton = [UIButton buttonWithType:UIButtonTypeSystem];
        [firstButton setImage:[UIImage imageNamed:@"chat"] forState:UIControlStateNormal];
        [firstButton setTitle:@"chat" forState:UIControlStateNormal];
        [firstButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [firstButton setTintColor:[UIColor whiteColor]];

        UIButton *secondButton = [UIButton buttonWithType:UIButtonTypeSystem];
        [secondButton setImage:[UIImage imageNamed:@"camera"] forState:UIControlStateNormal];
        [secondButton setTitle:@"camera" forState:UIControlStateNormal];
        [secondButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [secondButton setTintColor:[UIColor whiteColor]];
        _popButtonGroup.buttons = @[firstButton, secondButton];
    }
    return _popButtonGroup;
}
@end
