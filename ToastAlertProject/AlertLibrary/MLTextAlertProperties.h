//
//  MLTextAlertProperties.h
//  ToastAlertProject
//
//  Created by jorge Sanmartin on 14/05/14.
//  Copyright (c) 2014 Jorge Sanmartin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MLTextAlertProperties : NSObject
{
    UIColor *backgroundColor;
    UIColor *textColor;
    UIFont *textFont;
    NSInteger positionY;
    NSInteger bottomPositionY;
}

@property (nonatomic, strong) UIColor *backgroundColor;
@property (nonatomic, strong) UIColor *textColor;
@property (nonatomic, strong) UIFont *textFont;
@property (nonatomic, assign) NSInteger positionY;
@property (nonatomic, assign) NSInteger bottomPositionY;

- (void)setupTextAlertPropertiesWithBackgroundColor:(UIColor *)_backgroundColor textColor:(UIColor *)_textColor textFont:(UIFont *)_textFont positionY:(NSInteger)_positionY bottomPositionY:(NSInteger)_bottomPositionY;

@end
