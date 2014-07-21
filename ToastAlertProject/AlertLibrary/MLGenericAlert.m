//
//  MLGenericAlert.m
//  ToastAlertProject
//
//  Created by jorge Sanmartin on 14/05/14.
//  Copyright (c) 2014 Jorge Sanmartin. All rights reserved.
//

#import "MLGenericAlert.h"
#import "Common.h"

@interface MLGenericAlert ()

@property (nonatomic, assign) BOOL isCritical;

@end

@implementation MLGenericAlert

@synthesize delegate;
@synthesize isCritical;
@synthesize originalPositionY;
@synthesize originalBottomPositionY;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
        self.autoresizingMask = UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin
        | UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin;
    }
    return self;
}

-(void)show
{
    UIWindow *window = [[[UIApplication sharedApplication] keyWindow].subviews objectAtIndex:0];
    self.center = CGPointMake(window.bounds.size.width / 2, window.bounds.size.height / 2);
    
    self.alpha = 0.0f;
    [window addSubview:self];
    [UIView animateWithDuration:0.3 animations:^{
        self.alpha = 1.0f;
    }];
}

-(void)hide
{
    [UIView animateWithDuration:ANIMATION_ALERT_DURATION animations:^{
        
        self.alpha = 0.0f;
        
    } completion:^(BOOL finished) {
        
        [self removeFromSuperview];
        
        if ([delegate respondsToSelector:@selector(alertHided:)]) {
            
            [delegate alertHided:self];
        }
    }];
}

- (void)forzeHide
{
    [UIView animateWithDuration:ANIMATION_ALERT_DURATION animations:^{
        
        self.alpha = 0.0f;
        
    } completion:^(BOOL finished) {
        
        if ([self superview] != nil) {
            
            [self removeFromSuperview];
        }
    }];
}

- (void)hideWithFadeout:(CGFloat)timeFadeout
{
    [self performSelector:@selector(hide) withObject:nil afterDelay:timeFadeout];
}

- (CGFloat)getTimeFadeOut
{
    return (isCritical ? TIME_CRITICAL_FADEOUT : TIME_FADEOUT);
}

- (void)setAlertIsCritical:(BOOL)_isCritical
{
    self.isCritical = _isCritical;
}

- (BOOL)alertIsCritical
{
    return self.isCritical;
}

@end
