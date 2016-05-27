//
//  MZPopView.h
//  Pods
//
//  Created by Monzy Zhang on 5/26/16.
//
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, MZPopViewState) {
    MZPopViewStateClosed = 0,
    MZPopViewStatePopLeft = 1,
    MZPopViewStatePopRight = 2,
    MZPopViewStatePopUp = 3,
    MZPopViewStatePopDown = 4
};

@interface CATransaction (noImplicit)

+ (void)noImplicitAnimationBlock:(void(^)())block;

@end

@interface MZPopView : UIView

@property (nonatomic, assign) UIEdgeInsets inset;
@property (nonatomic) MZPopViewState state;
@property (nonatomic, strong, readonly) UIView *contentView;
@property (nonatomic, strong) UIColor *color;
@property (nonatomic, assign) CGFloat space;

- (void)popLeftFromPoint:(CGPoint)point;
- (void)popRightFromPoint:(CGPoint)point;
- (void)popUpFromPoint:(CGPoint)point;
- (void)popDownFromPoint:(CGPoint)point;
- (void)popBack;

@end
