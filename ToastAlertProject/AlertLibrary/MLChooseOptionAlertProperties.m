//
//  MLChooseOptionAlertProperties.m
//  ToastAlertProject
//
//  Created by jorge Sanmartin on 14/05/14.
//  Copyright (c) 2014 Jorge Sanmartin. All rights reserved.
//

#import "MLChooseOptionAlertProperties.h"

@implementation MLChooseOptionAlertProperties

@synthesize backgroundColor;
@synthesize textColor;
@synthesize buttonColor;
@synthesize buttonBackgroundPressedColor;
@synthesize buttonTextPressedColor;
@synthesize buttonBorderColor;

@synthesize titleTextFont;
@synthesize buttonTextFont;
@synthesize positionY;
@synthesize bottomPositionY;

- (void)setupChooseOptionAlertPropertiesWithBackgroundColor:(UIColor *)_backgroundColor
                                                  textColor:(UIColor *)_textColor
                                                buttonColor:(UIColor *)_buttonColor
                               buttonBackgroundPressedColor:(UIColor *)_buttonBackgroundPressedColor
                                     buttonTextPressedColor:(UIColor *)_buttonTextPressedColor
                                          buttonBorderColor:(UIColor *)_buttonBorderColor
                                              titleTextFont:(UIFont *)_titleTextFont
                                             buttonTextFont:(UIFont *)_buttonTextFont
                                                  positionY:(NSInteger)_positionY
                                            bottomPositionY:(NSInteger)_bottomPositionY
{
    self.backgroundColor = _backgroundColor;
    self.textColor = _textColor;
    self.buttonColor = _buttonColor;
    self.buttonBackgroundPressedColor = _buttonBackgroundPressedColor;
    self.buttonTextPressedColor = _buttonTextPressedColor;
    self.buttonBorderColor = _buttonBorderColor;
    //    self.buttonTriangleColor = _buttonTriangleColor;
    self.titleTextFont = _titleTextFont;
    self.buttonTextFont = _buttonTextFont;
    self.positionY = _positionY;
    self.bottomPositionY = _bottomPositionY;
}

@end
