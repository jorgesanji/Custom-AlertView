//
//  MLChooseOptionAlert.m
//  ToastAlertProject
//
//  Created by jorge Sanmartin on 14/05/14.
//  Copyright (c) 2014 Jorge Sanmartin. All rights reserved.
//

#import "MLChooseOptionAlert.h"
#import <QuartzCore/QuartzCore.h>
#import "MLButton.h"
#import "Utils.h"
#import "Common.h"


@interface MLChooseOptionAlert ()

@property (weak) id<MLChooseOptionAlertDelegate> controllerDelegate;
@property (nonatomic, assign) NSInteger arrayCurrentIndex;
@property (nonatomic, assign) BOOL alertAlreadyCanceled;
@property (nonatomic, strong) UIView *viewToast;

@end

@implementation MLChooseOptionAlert

@synthesize controllerDelegate;
@synthesize cancelButtonIndex;
@synthesize arrayCurrentIndex;
@synthesize alertAlreadyCanceled;
@synthesize viewToast;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

+ (MLChooseOptionAlert *)initChooseOptionAlertWithText:(NSString *)text
                                            cancelText:(NSString *)cancelText
                                          otherOptions:(NSMutableArray *)otherOptions
                                              delegate:(id<MLAlertDelegate>)_delegate
                                    controllerDelegate:(id<MLChooseOptionAlertDelegate>)_controllerDelegate
                                       backgroundColor:(UIColor *)backgroundColor
                                             textColor:(UIColor *)textColor
                                           buttonColor:(UIColor *)buttonColor
                          buttonBackgroundPressedColor:(UIColor *)buttonBackgroundPressedColor
                                buttonTextPressedColor:(UIColor *)buttonTextPressedColor
                                     buttonBorderColor:(UIColor *)buttonBorderColor
                                         titleTextFont:(UIFont *)titleTextFont
                                        buttonTextFont:(UIFont *)buttonTextFont
                                                   tag:(NSInteger)tag
{
    UIWindow *window = [[[UIApplication sharedApplication] keyWindow].subviews objectAtIndex:0];
    
    //Setup TextAlert
    CGFloat widthViewAlert =  MIN(window.bounds.size.width - (CH_LATERAL_VIEW_PADDING * 2), MAX_WIDTH_ALERT);
    
    MLChooseOptionAlert *backgroundView = [[MLChooseOptionAlert alloc] initWithFrame:window.bounds];
    backgroundView.autoresizingMask = backgroundView.autoresizingMask | UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    backgroundView.backgroundColor = [UIColor clearColor];
    
    backgroundView.viewToast = [[UIView alloc] initWithFrame:CGRectMake(CH_LATERAL_VIEW_PADDING, (window.bounds.size.height / 2), widthViewAlert, 0)];
    backgroundView.viewToast.autoresizingMask = UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin
    | UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin;
    backgroundView.controllerDelegate = _controllerDelegate;
    backgroundView.delegate = _delegate;
    backgroundView.cancelButtonIndex = 0;
    backgroundView.alertAlreadyCanceled = NO;
    backgroundView.arrayCurrentIndex = 0;
    backgroundView.tag = tag;
    
    backgroundView.viewToast.backgroundColor = [UIColor clearColor];
    
    [backgroundView addSubview:backgroundView.viewToast];
    
    //Setup Label Toast
    UILabel *labelToast = [[UILabel alloc] initWithFrame:CGRectMake(backgroundView.viewToast.frame.origin.x + CH_LATERAL_LABEL_PADDING, VERTICAL_PADDING, widthViewAlert - (CH_LATERAL_LABEL_PADDING * 2), 0)];
    labelToast.numberOfLines = 0;
    labelToast.backgroundColor = [UIColor clearColor];
    
    labelToast.font = titleTextFont;
    labelToast.textColor = textColor;
    labelToast.textAlignment = NSTextAlignmentCenter;
    
    //Set Text to Label
    labelToast.text = text;
    [labelToast sizeToFit];
    
    UIView *backgroundViewForLabel = [[UIView alloc] initWithFrame:CGRectMake(0,0, backgroundView.viewToast.frame.size.width, labelToast.frame.origin.y + labelToast.frame.size.height + VERTICAL_PADDING)];
    backgroundViewForLabel.backgroundColor = backgroundColor;
    
    MLButton *cancelButton = [[MLButton alloc] initWithFrame:CGRectMake(LATERAL_BUTTON_PADDING, backgroundViewForLabel.frame.origin.y + backgroundViewForLabel.frame.size.height, backgroundView.viewToast.frame.size.width - (LATERAL_BUTTON_PADDING * 2), HEIGHT_BUTTONS)];
    
    cancelButton.textColorPressed = buttonTextPressedColor;
    cancelButton.textColorNormal = textColor;
    
    UILabel *cancelLabel = [[UILabel alloc] initWithFrame:cancelButton.frame];
    
    cancelButton.titleLabelAsociated = cancelLabel;
    
    cancelLabel.numberOfLines = 0;
    cancelLabel.textAlignment = NSTextAlignmentCenter;
    cancelLabel.layer.transform = CATransform3DMakeScale(FONT_LABEL_DECREASE_PERCENT, FONT_LABEL_DECREASE_PERCENT, FONT_LABEL_DECREASE_PERCENT);
    [cancelLabel setFont:buttonTextFont];
    cancelLabel.text = cancelText;
    cancelLabel.textColor = textColor;
    cancelLabel.backgroundColor = [UIColor clearColor];
    [cancelLabel sizeToFit];
    
    cancelButton.tag = backgroundView.cancelButtonIndex;
    
    cancelButton.frame = CGRectMake(cancelButton.frame.origin.x, cancelButton.frame.origin.y, cancelButton.frame.size.width, MAX(cancelLabel.frame.size.height + MARGIN_BUTTON_HEIGHT, cancelButton.frame.size.height));
    
    cancelLabel.center = CGPointMake(cancelButton.frame.size.width / 2, cancelButton.frame.size.height / 2);
    
    
    UIView *backgroundForCancelButtonPresed = [[UIView alloc] initWithFrame:cancelButton.frame];
    backgroundForCancelButtonPresed.backgroundColor = buttonBorderColor;

    
    [cancelButton addTarget:backgroundView action:@selector(cancelButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    
    [cancelButton.layer setBorderColor:buttonBorderColor.CGColor];
    [cancelButton.layer setBorderWidth:0.0f];
    
    [cancelButton setBackgroundColor:buttonColor];
    
    [cancelButton setBackgroundImage:[Utils imageWithColor:buttonBackgroundPressedColor andSize:CGSizeMake(1, 1)] forState:UIControlStateSelected];
    [cancelButton setBackgroundImage:[Utils imageWithColor:buttonBackgroundPressedColor andSize:CGSizeMake(1, 1)] forState:UIControlStateHighlighted];
    
    [cancelButton addObserver:cancelButton forKeyPath:@"highlighted" options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld context:NULL];
    
    CGFloat positionY = (otherOptions.count == 0) ? cancelButton.frame.origin.y + cancelButton.frame.size.height : backgroundViewForLabel.frame.origin.y + backgroundViewForLabel.frame.size.height;
    
    NSInteger indexForButton = backgroundView.cancelButtonIndex + 1;
    
    for (int i = 0; i < otherOptions.count; i++) {
        
        NSString *stringValue = [otherOptions objectAtIndex:i];
        
        MLButton *otherOptionButton = [[MLButton alloc] initWithFrame:CGRectMake(0,  positionY, backgroundView.viewToast.frame.size.width - (LATERAL_BUTTON_PADDING * 2), HEIGHT_BUTTONS)];
        otherOptionButton.textColorPressed = buttonTextPressedColor;
        otherOptionButton.textColorNormal = textColor;
        
        UILabel *otherOptionLabel = [[UILabel alloc] initWithFrame:cancelButton.frame];
        
        otherOptionButton.titleLabelAsociated = otherOptionLabel;
        
        otherOptionLabel.layer.transform = CATransform3DMakeScale(FONT_LABEL_DECREASE_PERCENT, FONT_LABEL_DECREASE_PERCENT, FONT_LABEL_DECREASE_PERCENT);
        otherOptionLabel.font = buttonTextFont;
        otherOptionLabel.numberOfLines = 0;
        otherOptionLabel.textAlignment = NSTextAlignmentCenter;
        otherOptionLabel.backgroundColor = [UIColor clearColor];
        
        otherOptionLabel.text = stringValue;
        otherOptionLabel.textColor = textColor;
        [otherOptionLabel sizeToFit];
        
        otherOptionButton.tag = indexForButton;
        indexForButton++;
        
        otherOptionButton.frame = CGRectMake(otherOptionButton.frame.origin.x, otherOptionButton.frame.origin.y, otherOptionButton.frame.size.width, MAX(otherOptionLabel.frame.size.height + MARGIN_BUTTON_HEIGHT, otherOptionButton.frame.size.height));
        
        otherOptionLabel.center = CGPointMake(otherOptionButton.frame.size.width / 2, otherOptionButton.frame.size.height / 2);
        
        [otherOptionButton addTarget:backgroundView action:@selector(acceptButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
        
        [otherOptionButton.layer setBorderColor:buttonBorderColor.CGColor];
        [otherOptionButton.layer setBorderWidth:0.0f];
        
        if (otherOptions.count == 1) {
            
            cancelButton.frame = CGRectMake(cancelButton.frame.origin.x, cancelButton.frame.origin.y, cancelButton.frame.size.width / 2, cancelButton.frame.size.height);
            
            otherOptionButton.frame = CGRectMake(cancelButton.frame.origin.x + cancelButton.frame.size.width + (LATERAL_BUTTON_PADDING * 2), otherOptionButton.frame.origin.y, otherOptionButton.frame.size.width / 2, otherOptionButton.frame.size.height);
            
            CGFloat maxHeight = MAX(MAX(cancelButton.frame.size.height, cancelButton.titleLabelAsociated.frame.size.height), MAX(otherOptionButton.frame.size.height, otherOptionButton.titleLabelAsociated.frame.size.height));
            cancelButton.frame = CGRectMake(cancelButton.frame.origin.x, cancelButton.frame.origin.y, cancelButton.frame.size.width, maxHeight);
            cancelButton.titleLabelAsociated.frame = cancelButton.frame;
            backgroundForCancelButtonPresed.frame = cancelButton.frame;
            otherOptionButton.frame = CGRectMake(otherOptionButton.frame.origin.x, otherOptionButton.frame.origin.y, otherOptionButton.frame.size.width, maxHeight);
            otherOptionButton.titleLabelAsociated.frame = otherOptionButton.frame;
        }
        
        otherOptionLabel.frame = otherOptionButton.frame;
        
        UIView *backgroundForAcceptButtonPresed = [[UIView alloc] initWithFrame:otherOptionButton.frame];
        backgroundForAcceptButtonPresed.backgroundColor = buttonBorderColor;
        
        [otherOptionButton setBackgroundColor:buttonColor];
        
        [otherOptionButton addObserver:otherOptionButton forKeyPath:@"highlighted" options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld context:NULL];
        
        [otherOptionButton setBackgroundImage:[Utils imageWithColor:buttonBackgroundPressedColor andSize:CGSizeMake(1, 1)] forState:UIControlStateSelected];
        [otherOptionButton setBackgroundImage:[Utils imageWithColor:buttonBackgroundPressedColor andSize:CGSizeMake(1, 1)] forState:UIControlStateHighlighted];
        
        positionY += otherOptionButton.frame.size.height;
        
        [backgroundView.viewToast addSubview:backgroundForAcceptButtonPresed];
        [backgroundView.viewToast addSubview:otherOptionButton];
        [backgroundView.viewToast addSubview:otherOptionLabel];
    }
    
    if (otherOptions.count > 1) {
        cancelButton.frame = CGRectMake(cancelButton.frame.origin.x, positionY, cancelButton.frame.size.width, cancelButton.frame.size.height);
        backgroundForCancelButtonPresed.frame = cancelButton.frame;
        positionY += cancelButton.frame.size.height;
    }
    
    cancelLabel.frame  = cancelButton.frame;
    
    backgroundView.viewToast.frame = CGRectMake(backgroundView.viewToast.frame.origin.x, backgroundView.viewToast.frame.origin.y, backgroundView.viewToast.frame.size.width, positionY);
    [labelToast setCenter:CGPointMake(backgroundView.viewToast.frame.size.width / 2, (labelToast.frame.size.height + (VERTICAL_PADDING * 2)) / 2)];
    
    
    //Add subviews
    [backgroundViewForLabel addSubview:labelToast];
    [backgroundView.viewToast addSubview:backgroundViewForLabel];
    
    [backgroundView.viewToast addSubview:backgroundForCancelButtonPresed];
    [backgroundView.viewToast addSubview:cancelButton];
    [backgroundView.viewToast addSubview:cancelLabel];
    
    backgroundView.viewToast.center = backgroundView.center;
    
    return backgroundView;
}

- (void)initialAlertsStartWithArray:(NSMutableArray *)arrayFontButtons
{
    if (arrayFontButtons.count == 2) {
        for (int i = 0; i < arrayFontButtons.count; i++) {
            MLButton *button = (MLButton *)[arrayFontButtons objectAtIndex:i];
            CGFloat reScaleLabelToPercent;
            if (i == 0) {
                reScaleLabelToPercent = FONT_LABEL_INCREASE_PERCENT;
                button.fontButtonsIsIncreased = YES;
                button.titleLabelAsociated.layer.transform = CATransform3DMakeScale(FONT_LABEL_DECREASE_PERCENT, FONT_LABEL_DECREASE_PERCENT, FONT_LABEL_DECREASE_PERCENT);
            } else {
                reScaleLabelToPercent = FONT_LABEL_DECREASE_PERCENT;
                button.fontButtonsIsIncreased = NO;
                button.titleLabelAsociated.layer.transform = CATransform3DMakeScale(FONT_LABEL_INCREASE_PERCENT, FONT_LABEL_INCREASE_PERCENT, FONT_LABEL_INCREASE_PERCENT);
            }
            
            [UIView animateWithDuration:TIME_FOR_RESCALE_FONTS animations:^{
                
                button.titleLabelAsociated.layer.transform = CATransform3DMakeScale(reScaleLabelToPercent, reScaleLabelToPercent, reScaleLabelToPercent);
                
            } completion:^(BOOL finished) {
                [self reScaleFontButton:button];
            }];
        }
    } else {
        
        if (arrayFontButtons.count > 0)  { //Always must be grather than zero
            
            for (int i = 0; i < arrayFontButtons.count; i++) {
                
                MLButton *button = [arrayFontButtons objectAtIndex:i];
                button.fontButtonsIsIncreased = YES;
                CGFloat reScaleLabelFromPercent = FONT_LABEL_DECREASE_PERCENT + (i / arrayFontButtons.count);
                button.titleLabelAsociated.layer.transform = CATransform3DMakeScale(reScaleLabelFromPercent, reScaleLabelFromPercent, reScaleLabelFromPercent);
                CGFloat remainingTime = TIME_FOR_RESCALE_FONTS - (TIME_FOR_RESCALE_FONTS * ((float)i / (float)arrayFontButtons.count));
                
                [UIView animateWithDuration:remainingTime animations:^{
                    button.titleLabelAsociated.layer.transform = CATransform3DMakeScale(FONT_LABEL_INCREASE_PERCENT, FONT_LABEL_INCREASE_PERCENT, FONT_LABEL_INCREASE_PERCENT);
                } completion:^(BOOL finished) {
                    NSLog(@"completion");
                    [self reScaleFontButton:button];
                }];
            }
        }
    }
}

- (void) reScaleFontButton:(MLButton *)button
{
    CGFloat reScaleLabelToPercent = button.fontButtonsIsIncreased ? FONT_LABEL_DECREASE_PERCENT : FONT_LABEL_INCREASE_PERCENT;
    button.fontButtonsIsIncreased = !button.fontButtonsIsIncreased;
    
    [UIView animateWithDuration:TIME_FOR_RESCALE_FONTS animations:^{
        
        button.titleLabelAsociated.layer.transform = CATransform3DMakeScale(reScaleLabelToPercent, reScaleLabelToPercent, reScaleLabelToPercent);
        
    } completion:^(BOOL finished) {
        NSLog(@"completion reScaleFontButton");
        
         if (!alertAlreadyCanceled) {
             
             [self reScaleFontButton:button];
         }
    }];
}

-(IBAction)cancelButtonPressed:(id)sender
{
    UIButton *button = (UIButton *)sender;
    [self changeAppearanceToButtonPressed:button];
    self.userInteractionEnabled = NO;
    [self hide];
    self.alertAlreadyCanceled = YES;
    if ([controllerDelegate respondsToSelector:@selector(alertView:clickedButtonAtIndex:)]) {
        [controllerDelegate alertView:self clickedButtonAtIndex:button.tag];
    }
}

- (IBAction)acceptButtonPressed:(id)sender
{
    UIButton *button = (UIButton *)sender;
    [self changeAppearanceToButtonPressed:button];
    self.userInteractionEnabled = NO;
    [self hide];
    self.alertAlreadyCanceled = YES;
    if ([controllerDelegate respondsToSelector:@selector(alertView:clickedButtonAtIndex:)]) {
        [controllerDelegate alertView:self clickedButtonAtIndex:button.tag];
    }
}

- (void)changeAppearanceToButtonPressed:(UIButton *)button
{
    UIImage *imageColorPressed = [button backgroundImageForState:UIControlStateSelected];
    [button setBackgroundImage:imageColorPressed forState:UIControlStateNormal];
    UIColor *colorTextPressed = [button titleColorForState:UIControlStateSelected];
    [button setTitleColor:colorTextPressed forState:UIControlStateNormal];
}

-(void)hide
{
    for (UIView *subView in self.viewToast.subviews) {
        if ([subView isKindOfClass:[MLButton class]]) {
            @try {
                [subView removeObserver:subView forKeyPath:@"highlighted"];
            }
            @catch (NSException *exception) {
                NSLog(@"Exception deleting observer highlighted in button");
            }
        }
    }
    
    CGRect frameAlert = self.frame;
    frameAlert.origin.y = -self.frame.size.height;
    
    [UIView animateWithDuration:1.0f animations:^{
        
        self.frame = frameAlert;
        [super hide];
        
    } completion:^(BOOL finished) {
        
    }];
}

-(void)show
{
    [super show];
    UIWindow *window = [[[UIApplication sharedApplication] keyWindow].subviews objectAtIndex:0];
    CGFloat centerY;
    UIView *subView;
    
    if (self.subviews.count > 0) {
        subView = [self.subviews objectAtIndex:0];
    }
    
    if (subView != nil) {
        if (originalPositionY > 0) {
            centerY = originalPositionY + (subView.frame.size.height / 2);
            originalPositionY = -1;
        }
        else if (originalBottomPositionY > 0) {
            
            centerY = (window.bounds.size.height - originalBottomPositionY) - (subView.frame.size.height / 2);
            originalBottomPositionY = -1;
        } else {
            centerY = window.bounds.size.height / 2;
        }
        subView.center = CGPointMake(window.bounds.size.width / 2, centerY);
    }
    
    NSMutableArray *allButtonsArray = [[NSMutableArray alloc] init];
    
    for (UIView *view in self.subviews) {
        if ([view isKindOfClass:[MLButton class]]) {
            MLButton *button = (MLButton *)view;
            [allButtonsArray addObject:button];
        }
    }
    
    if (allButtonsArray.count > 0) {
        [self initialAlertsStartWithArray:allButtonsArray];
    }
}




@end
