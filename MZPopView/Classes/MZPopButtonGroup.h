//
//  MZPopButtonGroup.h
//  Pods
//
//  Created by Monzy Zhang on 5/26/16.
//
//

#import <MZPopView/MZPopView.h>

@interface MZPopButtonGroup : MZPopView

@property (nonatomic, assign) BOOL hasSeparateLine;
@property (nonatomic, strong) UIColor *separateLineColor;
@property (nonatomic, assign) CGFloat separateLineWidth;
@property (nonatomic, strong) NSArray<UIButton *> *buttons;
@property (nonatomic, assign) CGFloat leftPad;
@property (nonatomic, assign) CGFloat topPad;

@end