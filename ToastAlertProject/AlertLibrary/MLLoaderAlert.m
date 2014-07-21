//
//  MLLoaderAlert.m
//  ToastAlertProject
//
//  Created by jorge Sanmartin on 14/05/14.
//  Copyright (c) 2014 Jorge Sanmartin. All rights reserved.
//

#import "MLLoaderAlert.h"
#import <QuartzCore/QuartzCore.h>
#import "Common.h"

@implementation MLLoaderAlert

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

+ (MLLoaderAlert *)initLoaderAlertWithDelegate:(id<MLAlertDelegate>)_delegate
{
    UIView *backgroundIndicatorView = [[UIView alloc] init];
    backgroundIndicatorView.backgroundColor = [UIColor blackColor];
    backgroundIndicatorView.alpha = 0.75f;
    backgroundIndicatorView.layer.cornerRadius = 8.0f;
    [backgroundIndicatorView.layer setMasksToBounds:YES];
    
    UIActivityIndicatorView *indicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    [indicator startAnimating];
    
    backgroundIndicatorView.frame = CGRectMake(backgroundIndicatorView.frame.origin.x, backgroundIndicatorView.frame.origin.y, indicator.frame.size.width + (PADDDING_INDICATOR_VIEW * 2), indicator.frame.size.height + (PADDDING_INDICATOR_VIEW * 2));
    [backgroundIndicatorView addSubview:indicator];
    indicator.center = CGPointMake(backgroundIndicatorView.frame.size.width / 2, backgroundIndicatorView.frame.size.height / 2);
    
    return [MLLoaderAlert initLoaderAlertWithDelegate:_delegate viewForAnimate:backgroundIndicatorView];
}


+ (MLLoaderAlert *)initLoaderAlertWithDelegate:(id<MLAlertDelegate>)_delegate viewForAnimate:(UIView *)viewForAnimate
{
    UIWindow *window = [[[UIApplication sharedApplication] keyWindow].subviews objectAtIndex:0];
    
    MLLoaderAlert *backgroundView = [[MLLoaderAlert alloc] initWithFrame:window.bounds];
    backgroundView.autoresizingMask = backgroundView.autoresizingMask | UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    backgroundView.backgroundColor = [UIColor clearColor];
    
//    UIView *loaderView = [[UIView alloc] initWithFrame:viewForAnimate.frame];
//    
//    loaderView.backgroundColor = [UIColor clearColor];
    backgroundView.delegate = _delegate;
    backgroundView.opaque = NO;
    
//    [backgroundView addSubview:loaderView];
    
    viewForAnimate.autoresizingMask = UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin
    | UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin;
    
    [backgroundView addSubview:viewForAnimate];
    
    viewForAnimate.center = backgroundView.center;
    
    return backgroundView;
}

//-(void)hide
//{
//    if ([delegate respondsToSelector:@selector(alertHided:)]) {
//
//        [delegate alertHided:self];
//    }
//
//    [UIView animateWithDuration:ANIMATION_ALERT_DURATION delay:[self getTimeFadeOut] options:UIViewAnimationOptionTransitionNone animations:^{
//
//        self.alpha = 0.0f;
//
//    } completion:^(BOOL finished) {
//
//        if ([self superview] != nil) {
//
//            [self removeFromSuperview];
//        }
//    }];
//}

@end
