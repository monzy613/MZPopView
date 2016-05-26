//
//  MZPopView.m
//  Pods
//
//  Created by Monzy Zhang on 5/26/16.
//
//

#import "MZPopView.h"

#define defaultWidth 8.0;

static CGFloat offset = 5.0;
static NSTimeInterval duration = 0.25;

@interface MZPopView ()

@property (nonatomic, strong) CAShapeLayer *leftArrow;
@property (nonatomic, strong) CAShapeLayer *rightArrow;
@property (nonatomic, strong) CAShapeLayer *upArrow;
@property (nonatomic, strong) CAShapeLayer *downArrow;
@property (nonatomic, strong, readwrite) UIView *contentView;
@property (nonatomic, assign) UIEdgeInsets defaultInset;
@property (nonatomic, assign) CGPoint sourcePoint;

@end

@implementation MZPopView

#pragma mark - init
- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.defaultInset = UIEdgeInsetsMake(5, 5, 5, 5);
        self.state = MZPopViewStateClosed;
        [self addSubview:self.contentView];
        [self.layer addSublayer:self.leftArrow];
        [self.layer addSublayer:self.rightArrow];
        [self.layer addSublayer:self.upArrow];
        [self.layer addSublayer:self.downArrow];
        self.layer.shadowOpacity = 0.3;
        self.layer.shadowOffset = CGSizeMake(0, 2);
        self.color = [UIColor magentaColor];
        self.alpha = 0.0;
        [self hideAllArrow];
    }
    return self;
}

- (void)dealloc
{
    if (_contentView) {
        [_contentView removeObserver:self forKeyPath:@"bounds"];
    }
}

#pragma mark - public

- (void)popLeftFromPoint:(CGPoint)point
{
    self.state = MZPopViewStatePopLeft;
    self.alpha = 0.0;
    self.sourcePoint = point;
    CGRect newFrame = self.bounds;
    newFrame.origin = CGPointMake(point.x - newFrame.size.width + offset, point.y - newFrame.size.height / 2);
    self.frame = newFrame;
    newFrame.origin.x = point.x - newFrame.size.width;
    [self showArrow:self.rightArrow newFrame:newFrame];
}

- (void)popRightFromPoint:(CGPoint)point
{
    self.state = MZPopViewStatePopRight;
    self.alpha = 0.0;
    self.sourcePoint = point;
    CGRect newFrame = self.bounds;
    newFrame.origin = CGPointMake(point.x - offset, point.y - newFrame.size.height / 2);
    self.frame = newFrame;
    newFrame.origin = CGPointMake(point.x, point.y - newFrame.size.height / 2);
    [self showArrow:self.leftArrow newFrame:newFrame];
}

- (void)popUpFromPoint:(CGPoint)point
{
    self.state = MZPopViewStatePopUp;
    self.alpha = 0.0;
    self.sourcePoint = point;
    CGRect newFrame = self.bounds;
    newFrame.origin = CGPointMake(point.x - newFrame.size.width / 2, point.y - newFrame.size.height + offset);
    self.frame = newFrame;
    newFrame.origin = CGPointMake(point.x - newFrame.size.width / 2, point.y - newFrame.size.height);
    [self showArrow:self.downArrow newFrame:newFrame];
}

- (void)popDownFromPoint:(CGPoint)point
{
    self.state = MZPopViewStatePopDown;
    self.alpha = 0.0;
    self.sourcePoint = point;
    CGRect newFrame = self.bounds;
    newFrame.origin = CGPointMake(point.x - newFrame.size.width / 2, point.y - offset);
    self.frame = newFrame;
    newFrame.origin = CGPointMake(point.x - newFrame.size.width / 2, point.y);
    [self showArrow:self.upArrow newFrame:newFrame];
}

- (void)popBack
{
    CGRect dismissFrame = self.frame;
    switch (self.state) {
        case MZPopViewStatePopLeft:
            dismissFrame.origin.x += offset;
            break;
        case MZPopViewStatePopRight:
            dismissFrame.origin.x -= offset;
            break;
        case MZPopViewStatePopUp:
            dismissFrame.origin.y += offset;
            break;
        case MZPopViewStatePopDown:
            dismissFrame.origin.y -= offset;
            break;
        default:
            return;
    }

    [UIView animateWithDuration:duration animations:^{
        self.frame = dismissFrame;
        self.alpha = 0.0;
    } completion:^(BOOL finished) {
        self.state = MZPopViewStateClosed;
    }];
}

#pragma mark - kvo
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if (object == self.contentView && [keyPath isEqualToString:@"bounds"]) {
        CGPoint center = self.center;
        CGRect newFrame = CGRectInset(self.contentView.bounds, -self.defaultInset.left, -self.defaultInset.top);
        self.contentView.center = CGPointMake(CGRectGetWidth(newFrame) / 2, CGRectGetHeight(newFrame) / 2);
        self.frame = newFrame;
        self.center = center;
        [self resetArrowPosition];
        [self resetFrame];
    } else {
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
}

#pragma mark - private
- (void)showArrow:(CAShapeLayer *)arrow newFrame:(CGRect)frame
{
    [self hideAllArrow];
    arrow.hidden = NO;
    [UIView animateWithDuration:duration animations:^{
        self.frame = frame;
        self.alpha = 1.0;
    }];
}

- (void)hideAllArrow
{
    self.leftArrow.hidden = YES;
    self.rightArrow.hidden = YES;
    self.upArrow.hidden = YES;
    self.downArrow.hidden = YES;
}

- (void)resetArrowPosition
{
    {//left right
        CGFloat height = defaultWidth;
        CGFloat width = self.defaultInset.left;

        CGRect lFrame = CGRectMake(0, CGRectGetHeight(self.frame) / 2 - height / 2, width, height);
        _leftArrow.frame = lFrame;
        CGRect rFrame = CGRectMake(CGRectGetWidth(self.frame) - width, CGRectGetHeight(self.frame) / 2 - height / 2, width, height);
        _rightArrow.frame = rFrame;
    }
    {//up down
        CGFloat height = self.defaultInset.top;
        CGFloat width = defaultWidth;

        CGRect uFrame = CGRectMake(CGRectGetWidth(self.frame) / 2 - width / 2, 0, width, height);
        _upArrow.frame = uFrame;
        CGRect dFrame = CGRectMake(CGRectGetWidth(self.frame) / 2 - width / 2, CGRectGetHeight(self.frame) - height, width, height);
        _downArrow.frame = dFrame;
    }
}

- (void)resetFrame
{
    CGRect newFrame = self.bounds;
    switch (self.state) {
        case MZPopViewStatePopLeft:
            newFrame.origin = CGPointMake(self.sourcePoint.x - newFrame.size.width, self.sourcePoint.y - newFrame.size.height / 2);
            self.frame = newFrame;
            break;
        case MZPopViewStatePopRight:
            newFrame.origin = CGPointMake(self.sourcePoint.x, self.sourcePoint.y - newFrame.size.height / 2);
            self.frame = newFrame;
            break;
        case MZPopViewStatePopUp:
            newFrame.origin = CGPointMake(self.sourcePoint.x - newFrame.size.width / 2, self.sourcePoint.y - newFrame.size.height);
            self.frame = newFrame;
            break;
        case MZPopViewStatePopDown:
            newFrame.origin = CGPointMake(self.sourcePoint.x - newFrame.size.width / 2, self.sourcePoint.y);
            self.frame = newFrame;
            break;
        default:
            break;
    }
}

#pragma mark - setters
- (void)setColor:(UIColor *)color
{
    _color = color;
    _contentView.backgroundColor = color;
    _leftArrow.fillColor = color.CGColor;
    _rightArrow.fillColor = color.CGColor;
    _upArrow.fillColor = color.CGColor;
    _downArrow.fillColor = color.CGColor;
}

#pragma mark - getters

- (CAShapeLayer *)leftArrow
{
    if (!_leftArrow) {
        CGFloat height = defaultWidth;
        CGFloat width = self.defaultInset.left;
        UIBezierPath *path = [UIBezierPath bezierPath];
        [path moveToPoint:CGPointMake(0, height / 2)];
        [path addLineToPoint:CGPointMake(width, 0)];
        [path addLineToPoint:CGPointMake(width, height)];
        [path closePath];
        _leftArrow = [CAShapeLayer layer];
        _leftArrow.path = path.CGPath;
        _leftArrow.strokeColor = nil;
        CGRect frame = CGRectMake(0, CGRectGetHeight(self.frame) / 2 - height / 2, width, height);
        _leftArrow.frame = frame;
    }
    return _leftArrow;
}

- (CAShapeLayer *)rightArrow
{
    if (!_rightArrow) {
        CGFloat height = defaultWidth;
        CGFloat width = self.defaultInset.right;
        UIBezierPath *path = [UIBezierPath bezierPath];
        [path moveToPoint:CGPointMake(0, 0)];
        [path addLineToPoint:CGPointMake(width, height / 2)];
        [path addLineToPoint:CGPointMake(0, height)];
        [path closePath];
        _rightArrow = [CAShapeLayer layer];
        _rightArrow.path = path.CGPath;
        _rightArrow.strokeColor = nil;
        CGRect frame = CGRectMake(CGRectGetWidth(self.frame) - width, CGRectGetHeight(self.frame) / 2 - height / 2, width, height);
        _rightArrow.frame = frame;
    }
    return _rightArrow;
}

- (CAShapeLayer *)upArrow
{
    if (!_upArrow) {
        CGFloat height = self.defaultInset.top;
        CGFloat width = defaultWidth;
        UIBezierPath *path = [UIBezierPath bezierPath];
        [path moveToPoint:CGPointMake(0, height)];
        [path addLineToPoint:CGPointMake(width / 2, 0)];
        [path addLineToPoint:CGPointMake(width, height)];
        [path closePath];
        _upArrow = [CAShapeLayer layer];
        _upArrow.path = path.CGPath;
        _upArrow.strokeColor = nil;
        CGRect frame = CGRectMake(CGRectGetWidth(self.frame) / 2 - width / 2, 0, width, height);
        _upArrow.frame = frame;
    }
    return _upArrow;
}

- (CAShapeLayer *)downArrow
{
    if (!_downArrow) {
        CGFloat height = self.defaultInset.bottom;
        CGFloat width = defaultWidth;
        UIBezierPath *path = [UIBezierPath bezierPath];
        [path moveToPoint:CGPointMake(0, 0)];
        [path addLineToPoint:CGPointMake(width / 2, height)];
        [path addLineToPoint:CGPointMake(width, 0)];
        [path closePath];
        _downArrow = [CAShapeLayer layer];
        _downArrow.path = path.CGPath;
        _downArrow.strokeColor = nil;
        CGRect frame = CGRectMake(CGRectGetWidth(self.frame) / 2 - width / 2, CGRectGetHeight(self.frame) - height, width, height);
        _downArrow.frame = frame;
    }
    return _downArrow;
}

- (UIView *)contentView
{
    if (!_contentView) {
        _contentView = [[UIView alloc] initWithFrame:CGRectInset(self.bounds, self.defaultInset.left, self.defaultInset.top)];
        [_contentView addObserver:self forKeyPath:@"bounds" options:NSKeyValueObservingOptionNew context:nil];
        _contentView.layer.cornerRadius = 4.0;
    }
    return _contentView;
}

@end
