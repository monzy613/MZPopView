//
//  MZPopButtonGroup.m
//  Pods
//
//  Created by Monzy Zhang on 5/26/16.
//
//

#import "MZPopButtonGroup.h"

static CGFloat buttonSpace = 8.0;

@implementation MZPopButtonGroup
@synthesize buttons = _buttons;

#pragma mark - init
- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.hasSeparateLine = YES;
        self.separateLineWidth = 1.0;
        self.separateLineColor = [UIColor grayColor];
        self.leftPad = 8.0;
        self.topPad = 5.0;
    }
    return self;
}

#pragma mark - private -
- (void)rearrange
{
    __block CGFloat width = 0.0;
    __block CGFloat height = 0.0;
    [self.buttons enumerateObjectsUsingBlock:^(UIButton * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        CGSize buttonContentSize = [obj.titleLabel textRectForBounds:[UIScreen mainScreen].bounds limitedToNumberOfLines:1.0].size;
        obj.frame = CGRectMake(width, 0, buttonContentSize.width, buttonContentSize.height);
        width += (idx == (self.buttons.count - 1)? buttonContentSize.width: buttonContentSize.width + buttonSpace);
        height = (height < buttonContentSize.height? buttonContentSize.height: height);
        [self.contentView addSubview:obj];
    }];
    self.contentView.bounds = CGRectInset(CGRectMake(0, 0, width, height), -self.leftPad, -self.topPad);
}

#pragma mark - getter & setters

- (NSArray<UIButton *> *)buttons
{
    if (!_buttons) {
        _buttons = [[NSArray alloc] init];
    }
    return _buttons;
}

#pragma mark - setters
- (void)setButtons:(NSArray<UIButton *> *)buttons
{
    for (UIButton *button in _buttons) {
        [button removeFromSuperview];
    }
    _buttons = buttons;
    [self rearrange];
}
@end