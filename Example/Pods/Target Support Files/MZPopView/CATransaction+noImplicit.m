//
//  CATransaction+noImplicit.m
//  Pods
//
//  Created by Monzy Zhang on 5/27/16.
//
//

#import "CATransaction+noImplicit.h"

@implementation CATransaction (noImplicit)

+ (void)noImplicitAnimationBlock:(void(^)())block
{
    if (block) {
        BOOL beforeDisableActions = CATransaction.disableActions;
        [CATransaction setDisableActions:YES];
        block();
        [CATransaction setDisableActions:beforeDisableActions];
    }
}

@end
