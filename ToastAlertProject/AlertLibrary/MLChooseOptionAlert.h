//
//  MLChooseOptionAlert.h
//  ToastAlertProject
//
//  Created by jorge Sanmartin on 14/05/14.
//  Copyright (c) 2014 Jorge Sanmartin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MLChooseOptionAlertDelegate.h"
#import "MLGenericAlert.h"

@interface MLChooseOptionAlert : MLGenericAlert
{
    __weak id<MLChooseOptionAlertDelegate> controllerDelegate;
    NSInteger cancelButtonIndex;
    NSInteger arrayCurrentIndex;
    BOOL alertAlreadyCanceled;
}

@property (nonatomic, assign) NSInteger cancelButtonIndex;

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
                                                   tag:(NSInteger)tag;

@end
