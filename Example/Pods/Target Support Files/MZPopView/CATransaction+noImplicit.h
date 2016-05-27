//
//  CATransaction+noImplicit.h
//  Pods
//
//  Created by Monzy Zhang on 5/27/16.
//
//

#import <QuartzCore/QuartzCore.h>

@interface CATransaction (noImplicit)

+ (void)noImplicitAnimationBlock:(void(^)())block;

@end
