//
//  MZPopLabel.h
//  Pods
//
//  Created by Monzy Zhang on 5/26/16.
//
//

#import <MZPopView/MZPopView.h>

@interface MZPopLabel : MZPopView

@property (nonatomic, strong, readonly) UILabel *label;
@property (nonatomic, assign) CGFloat leftPad;
@property (nonatomic, assign) CGFloat topPad;

@end
