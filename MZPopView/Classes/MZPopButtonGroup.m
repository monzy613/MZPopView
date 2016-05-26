//
//  MZPopButtonGroup.m
//  Pods
//
//  Created by Monzy Zhang on 5/26/16.
//
//

#import "MZPopButtonGroup.h"

static CGFloat buttonSpace = 8.0;

@interface MZPopButtonGroup ()

@property (nonatomic, strong) NSMutableArray<CALayer *> *separators;

@end

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
        CGSize buttonTitleSize = [obj.titleLabel textRectForBounds:[UIScreen mainScreen].bounds limitedToNumberOfLines:1.0].size;
        CGFloat buttonWidth = buttonTitleSize.width;
        CGFloat buttonHeight = buttonTitleSize.height;
        if (!obj.imageView.hidden) {
            buttonWidth += obj.imageView.image.size.width;
            obj.imageView.contentMode = UIViewContentModeScaleAspectFit;
        }
        obj.frame = CGRectMake(width, 0, buttonWidth, buttonHeight);
        if (self.hasSeparateLine && idx != (self.buttons.count - 1)) {
            CALayer *line = [CALayer layer];
            line.backgroundColor = self.separateLineColor.CGColor;
            line.frame = CGRectMake(width + buttonWidth + (buttonSpace - self.separateLineWidth) / 2 , 0, self.separateLineWidth, buttonHeight);
            [self.contentView.layer addSublayer:line];
        }
        height = buttonHeight;
        width += (idx == (self.buttons.count - 1)? buttonWidth: buttonWidth + buttonSpace);
        [self.contentView addSubview:obj];
    }];
    self.contentView.bounds = CGRectInset(CGRectMake(0, 0, width, height), -self.leftPad, -self.topPad);
}

#pragma mark - getter & setters
- (NSMutableArray<CALayer *> *)separators
{
    if (!_separators) {
        _separators = [[NSMutableArray alloc] init];
    }
    return _separators;
}

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