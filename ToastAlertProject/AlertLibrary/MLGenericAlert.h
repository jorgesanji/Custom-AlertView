//
//  MLGenericAlert.h
//  ToastAlertProject
//
//  Created by jorge Sanmartin on 14/05/14.
//  Copyright (c) 2014 Jorge Sanmartin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MLAlertDelegate.h"

#define TIME_FADEOUT 3.5
#define TIME_CRITICAL_FADEOUT 4.5
#define ANIMATION_ALERT_DURATION 0.15

#define DEFAULT_ALERT_CORNER_RADIUS 8.0f

@interface MLGenericAlert : UIView
{
    __weak id<MLAlertDelegate> delegate;
    BOOL isCritical;
    NSInteger originalPositionY;
    NSInteger originalBottomPositionY;
}

@property (weak) id<MLAlertDelegate> delegate;
@property (nonatomic, assign) NSInteger originalPositionY;
@property (nonatomic, assign) NSInteger originalBottomPositionY;

- (void) show;
- (void) hide;
- (void) forzeHide;
- (void) hideWithFadeout:(CGFloat)timeFadeout;
- (CGFloat)getTimeFadeOut;
- (void)setAlertIsCritical:(BOOL)_isCritical;
- (BOOL)alertIsCritical;

@end
