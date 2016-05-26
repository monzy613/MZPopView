//
//  MZPopLabel.m
//  Pods
//
//  Created by Monzy Zhang on 5/26/16.
//
//

#import "MZPopLabel.h"
@interface MZPopLabel ()

@property (nonatomic, strong, readwrite) UILabel *label;

@end

@implementation MZPopLabel
@synthesize label = _label;

#pragma mark - life cycle -
- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self.contentView addSubview:self.label];
        self.leftPad = 5.0;
        self.topPad = 5.0;
        [self.label addObserver:self forKeyPath:@"text" options:NSKeyValueObservingOptionNew context:nil];
    }
    return self;
}

- (void)dealloc
{
    if (_label) {
        [_label removeObserver:self forKeyPath:@"text"];
    }
}

#pragma mark - kvo observer
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if (object == self.label && [keyPath isEqualToString:@"text"]) {
        CGRect newContentViewBounds = CGRectInset([self.label textRectForBounds:[UIScreen mainScreen].bounds limitedToNumberOfLines:1], -self.leftPad, -self.topPad);
        self.label.frame = [self.label textRectForBounds:[UIScreen mainScreen].bounds limitedToNumberOfLines:1];
        self.contentView.bounds = newContentViewBounds;
        return;
    } else {
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
}

#pragma mark - getter & setter
- (UILabel *)label
{
    if (!_label) {
        _label = [[UILabel alloc] init];
        _label.textColor = [UIColor blackColor];
        _label.backgroundColor = [UIColor clearColor];
    }
    return _label;
}

- (void)setLeftPad:(CGFloat)leftPad
{
    if (leftPad < 0) {
        _leftPad = 0;
    } else {
        _leftPad = leftPad;
    }
}

- (void)setTopPad:(CGFloat)topPad
{
    if (topPad < 0) {
        _topPad = 0;
    } else {
        _topPad = topPad;
    }
}
@end
