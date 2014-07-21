//
//  MLTextAlert.m
//  ToastAlertProject
//
//  Created by jorge Sanmartin on 14/05/14.
//  Copyright (c) 2014 Jorge Sanmartin. All rights reserved.
//

#import "MLTextAlert.h"
#import <QuartzCore/QuartzCore.h>
#import "Common.h"



@implementation MLTextAlert

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

+ (MLTextAlert *)initTextAlertWithText:(NSString *)text isCritical:(BOOL)isCritical delegate:(id<MLAlertDelegate>)_delegate backgroundColor:(UIColor *)backgroundColor textColor:(UIColor *)textColor textFont:(UIFont *)textFont
{
    UIWindow *window = [[[UIApplication sharedApplication] keyWindow].subviews objectAtIndex:0];
    
    //Setup TextAlert
//    CGFloat widthViewAlert =  MIN(window.bounds.size.width - (LATERAL_VIEW_PADDING * 2), MAX_WIDTH_ALERT);
    CGFloat widthViewAlert =  MIN(window.bounds.size.width, MAX_WIDTH_ALERT);
    
    //Setup TextAlert
    MLTextAlert *viewToast = [[MLTextAlert alloc] initWithFrame:CGRectMake(LATERAL_VIEW_PADDING, (window.bounds.size.height / 2) + MARGIN_CENTER, widthViewAlert, 0)];
    viewToast.delegate = _delegate;
    [viewToast setAlertIsCritical:isCritical];
    
    viewToast.backgroundColor = backgroundColor;
//    viewToast.layer.cornerRadius = DEFAULT_ALERT_CORNER_RADIUS;
    
    //Setup Label Toast
    UILabel *labelToast = [[UILabel alloc] initWithFrame:CGRectMake(viewToast.frame.origin.x + LATERAL_LABEL_PADDING, VERTICAL_PADDING, widthViewAlert - (LATERAL_LABEL_PADDING * 2), 0)];
    labelToast.numberOfLines = 0;
    labelToast.backgroundColor = [UIColor clearColor];
    
    labelToast.font = textFont;
    labelToast.textColor = textColor;
    labelToast.textAlignment = NSTextAlignmentCenter;
    
    //Set Text to Label
    labelToast.text = text;
    [labelToast sizeToFit];
    
//    viewToast.frame = CGRectMake(viewToast.frame.origin.x, viewToast.frame.origin.y, labelToast.frame.size.width + 20, labelToast.frame.size.height + (VERTICAL_PADDING * 2));
    viewToast.frame = CGRectMake(viewToast.frame.origin.x, viewToast.frame.origin.y, viewToast.frame.size.width, labelToast.frame.size.height + (VERTICAL_PADDING * 2));
    [labelToast setCenter:CGPointMake(viewToast.frame.size.width / 2, viewToast.frame.size.height / 2)];
        
    //Add subviews
    [viewToast addSubview:labelToast];
    
    return viewToast;
}


//Override show
-(void)show
{
    [super show];
    
    UIWindow *window = [[[UIApplication sharedApplication] keyWindow].subviews objectAtIndex:0];
    
    CGFloat centerY;
    
    if (originalPositionY > 0) {
        
        //        CGRect frameAlert = self.frame;
        //        frameAlert.origin.y = originalPositionY;
        //        self.frame = frameAlert;
        
        centerY = originalPositionY + (self.frame.size.height / 2);
        originalPositionY = -1;
        
    }
    else if (originalBottomPositionY > 0) {
        
        centerY = (window.bounds.size.height - originalBottomPositionY) - (self.frame.size.height / 2);
        originalBottomPositionY = -1;
        
    } else {
        
        //        self.center = CGPointMake(window.bounds.size.width / 2, window.bounds.size.height / 2);
        
        centerY = window.bounds.size.height / 2;
    }
    
    self.center = CGPointMake(window.bounds.size.width / 2, centerY);
    
    if ([self alertIsCritical]) {
        
        [self hideWithFadeout:[self getTimeFadeOut]];
    }
}

@end
