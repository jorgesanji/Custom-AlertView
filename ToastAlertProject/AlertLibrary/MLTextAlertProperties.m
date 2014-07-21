//
//  MLTextAlertProperties.m
//  ToastAlertProject
//
//  Created by jorge Sanmartin on 14/05/14.
//  Copyright (c) 2014 Jorge Sanmartin. All rights reserved.
//

#import "MLTextAlertProperties.h"

@implementation MLTextAlertProperties

@synthesize backgroundColor;
@synthesize textColor;
@synthesize textFont;
@synthesize positionY;
@synthesize bottomPositionY;

- (void)setupTextAlertPropertiesWithBackgroundColor:(UIColor *)_backgroundColor textColor:(UIColor *)_textColor textFont:(UIFont *)_textFont positionY:(NSInteger)_positionY bottomPositionY:(NSInteger)_bottomPositionY
{
    self.backgroundColor = _backgroundColor;
    self.textColor = _textColor;
    self.textFont = _textFont;
    self.positionY = _positionY;
    self.bottomPositionY = _bottomPositionY;
}

@end
