//
//  MLChooseOptionAlertProperties.h
//  ToastAlertProject
//
//  Created by jorge Sanmartin on 14/05/14.
//  Copyright (c) 2014 Jorge Sanmartin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MLChooseOptionAlertProperties : NSObject
{
    UIColor *backgroundColor;
    UIColor *textColor;
    UIColor *buttonColor;
    UIColor *buttonBackgroundPressedColor;
    UIColor *buttonTextPressedColor;
    UIColor *buttonBorderColor;
    
    UIFont *titleTextFont;
    UIFont *buttonTextFont;
    NSInteger positionY;
    NSInteger bottomPositionY;
}

@property (nonatomic, strong) UIColor *backgroundColor;
@property (nonatomic, strong) UIColor *textColor;
@property (nonatomic, strong) UIColor *buttonColor;
@property (nonatomic, strong) UIColor *buttonBackgroundPressedColor;
@property (nonatomic, strong) UIColor *buttonTextPressedColor;
@property (nonatomic, strong) UIColor *buttonBorderColor;
//@property (nonatomic, strong) UIColor *buttonTriangleColor;

@property (nonatomic, strong) UIFont *titleTextFont;
@property (nonatomic, strong) UIFont *buttonTextFont;
@property (nonatomic, assign) NSInteger positionY;
@property (nonatomic, assign) NSInteger bottomPositionY;

- (void)setupChooseOptionAlertPropertiesWithBackgroundColor:(UIColor *)_backgroundColor
                                                  textColor:(UIColor *)_textColor
                                                buttonColor:(UIColor *)_buttonColor
                               buttonBackgroundPressedColor:(UIColor *)_buttonBackgroundPressedColor
                                     buttonTextPressedColor:(UIColor *)_buttonTextPressedColor
                                          buttonBorderColor:(UIColor *)_buttonBorderColor
                                              titleTextFont:(UIFont *)_titleTextFont
                                             buttonTextFont:(UIFont *)_buttonTextFont
                                                  positionY:(NSInteger)_positionY
                                            bottomPositionY:(NSInteger)_bottomPositionY;

@end
