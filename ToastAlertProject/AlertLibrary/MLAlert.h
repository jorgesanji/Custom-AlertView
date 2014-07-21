//
//  MLAlert.h
//  ToastAlertProject
//
//  Created by jorge Sanmartin on 14/05/14.
//  Copyright (c) 2014 Jorge Sanmartin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MLTextAlert.h"
#import "MLLoaderAlert.h"
#import "MLChooseOptionAlert.h"
#import "MLAlertDelegate.h"
#import "MLTextAlertProperties.h"
#import "MLChooseOptionAlertProperties.h"

@interface MLAlert : NSObject<MLAlertDelegate, UIGestureRecognizerDelegate>
{
    NSMutableArray *listAlerts;
    NSMutableArray *waitingAlerts;
    BOOL useStack;
    BOOL screenBlocked;
    
    MLTextAlertProperties *textAlertProperties;
    MLChooseOptionAlertProperties *chooseOptionAlertProperties;
    
    CGPoint originalTouchGesture;
}

@property (nonatomic, strong) NSMutableArray *listAlerts;
@property (nonatomic, strong) NSMutableArray *waitingAlerts;

@property (nonatomic, strong) MLTextAlertProperties *textAlertProperties;
@property (nonatomic, strong) MLChooseOptionAlertProperties *chooseOptionAlertProperties;

+ (MLAlert *)sharedInstance;
-(void)cancelAlerts;

- (void)setupAlert;

//Setup colors and fonts in TextAlerts
- (void)setupTextAlertWithBackgroundColor:(UIColor *)backgroundColor
                                textColor:(UIColor *)textColor
                                 textFont:(UIFont *)textFont
                                positionY:(NSInteger)positionY
                          bottomPositionY:(NSInteger)bottomPositionY;

//Setup colors and fonts in ChoooseOptionAlerts
- (void)setupChooseOptionAlertWithbBackgroundColor:(UIColor *)backgroundColor
                                         textColor:(UIColor *)textColor
                                       buttonColor:(UIColor *)buttonColor
                      buttonBackgroundPressedColor:(UIColor *)buttonBackgroundPressedColor
                            buttonTextPressedColor:(UIColor *)buttonTexPressedColor
                                 buttonBorderColor:(UIColor *)buttonBorderColor
                                     titleTextFont:(UIFont *)titleTextFont
                                    buttonTextFont:(UIFont *)buttonTextFont
                                         positionY:(NSInteger)positionY
                                   bottomPositionY:(NSInteger)bottomPositionY;


////////////////////////////////////////////////////////
//////////////  Text Alert  ////////////////////////////
////////////////////////////////////////////////////////

//Show Alert With Title
-(void)showAlertWithText:(NSString *)text;

//Show Alert with Title and isCritical
- (void)showAlertWithText:(NSString *)text
               isCritical:(BOOL)isCritical;

//Show Alert With Title using or no stacks
-(void)showAlertWithText:(NSString *)text
              isCritical:(BOOL)isCritical
                useStack:(BOOL)_useStack;

//Show Alert With Title and custimize colors
-(void)showAlertWithText:(NSString *)text
              isCritical:(BOOL)isCritical
                useStack:(BOOL)_useStack
         backgroundColor:(UIColor *)backgroundColor
               textColor:(UIColor *)textColor;

//Show Alert With Title and customize colors and font
-(void)showAlertWithText:(NSString *)text
              isCritical:(BOOL)isCritical
                useStack:(BOOL)_useStack
         backgroundColor:(UIColor *)backgroundColor
               textColor:(UIColor *)textColor
                textFont:(UIFont *)textFont;

////////////////////////////////////////////////////////
////////////////////////////////////////////////////////
////////////////////////////////////////////////////////


////////////////////////////////////////////////////////
//////////////  Loader Alert  //////////////////////////
////////////////////////////////////////////////////////

//Show Alert With Loader
-(MLLoaderAlert *)showAlertLoader;

//Show Alert With Loader using or no stacks
-(MLLoaderAlert *)showAlertLoaderUsingStack:(BOOL)_useStack;

//Show Alert With Loader customizing view For Animate
-(MLLoaderAlert *)showAlertLoaderWithViewForAnimate:(UIView *)viewForAnimate;

//Show Alert With Loader using or no stacks and customize view For Animate
-(MLLoaderAlert *)showAlertLoaderUsingStack:(BOOL)_useStack
                             viewForAnimate:(UIView *)viewForAnimate;

////////////////////////////////////////////////////////
////////////////////////////////////////////////////////
////////////////////////////////////////////////////////


////////////////////////////////////////////////////////
///////////  Choose Option Alert  //////////////////////
////////////////////////////////////////////////////////

//Show Alert with Choose Options
-(void)showChooseAlertWithText:(NSString *)title
                    cancelText:(NSString *)cancelText
                      delegate:(id<MLChooseOptionAlertDelegate>)delegate
                  otherButtons:(NSString *) key1, ... NS_REQUIRES_NIL_TERMINATION;

//Show Alert with Choose Options customizing tag
-(void)showChooseAlertWithText:(NSString *)title
                    cancelText:(NSString *)cancelText
                      delegate:(id<MLChooseOptionAlertDelegate>)delegate
                           tag:(NSInteger)tag
                  otherButtons:(NSString *) key1, ... NS_REQUIRES_NIL_TERMINATION;

//Show Alert with Choose Options customizing useStack
-(void)showChooseAlertWithText:(NSString *)title
                    cancelText:(NSString *)cancelText
                      delegate:(id<MLChooseOptionAlertDelegate>)delegate
                      useStack:(BOOL)_useStack
                           tag:(NSInteger)tag
                  otherButtons:(NSString *) key1, ... NS_REQUIRES_NIL_TERMINATION;

//Show Alert with Choose Options customizing useStack
-(void)showChooseAlertWithText:(NSString *)title
                    cancelText:(NSString *)cancelText
                      delegate:(id<MLChooseOptionAlertDelegate>)delegate
                      useStack:(BOOL)_useStack
                           tag:(NSInteger)tag
                   otherButton:(NSString *)key1
             otherButtonsArray:(va_list)otherButtons;

//Show Alert with Choose Options customizing BackgroundColor and TextColor
-(void)showChooseAlertWithText:(NSString *)title
                    cancelText:(NSString *)cancelText
                      delegate:(id<MLChooseOptionAlertDelegate>)delegate
                      useStack:(BOOL)_useStack
               backgroundColor:(UIColor *)backgroundColor
                     textColor:(UIColor *)textColor
                           tag:(NSInteger)tag
                  otherButtons:(NSString *) key1, ... NS_REQUIRES_NIL_TERMINATION;

//Show Alert with Choose Options customizing BackgroundColor and TextColor
-(void)showChooseAlertWithText:(NSString *)title
                    cancelText:(NSString *)cancelText
                      delegate:(id<MLChooseOptionAlertDelegate>)delegate
                      useStack:(BOOL)_useStack
               backgroundColor:(UIColor *)backgroundColor
                     textColor:(UIColor *)textColor
                           tag:(NSInteger)tag
                   otherButton:(NSString *)key1
             otherButtonsArray:(va_list)otherButtons;


//Show Alert with Choose Options customizing BackgroundColor, TextColor, button background and Button Background pressed
-(void)showChooseAlertWithText:(NSString *)title
                    cancelText:(NSString *)cancelText
                      delegate:(id<MLChooseOptionAlertDelegate>)delegate
                      useStack:(BOOL)_useStack
               backgroundColor:(UIColor *)backgroundColor
                     textColor:(UIColor *)textColor
                   buttonColor:(UIColor *)buttonColor
  buttonBackgroundPressedColor:(UIColor *)buttonBackgroundPressedColor
        buttonTextPressedColor:(UIColor *)buttonTextPressedColor
             buttonBorderColor:(UIColor *)buttonBorderColor
                           tag:(NSInteger)tag
                  otherButtons:(NSString *) key1, ... NS_REQUIRES_NIL_TERMINATION;

//Show Alert with Choose Options customizing BackgroundColor, TextColor, button background and Button Background pressed
-(void)showChooseAlertWithText:(NSString *)title
                    cancelText:(NSString *)cancelText
                      delegate:(id<MLChooseOptionAlertDelegate>)delegate
                      useStack:(BOOL)_useStack
               backgroundColor:(UIColor *)backgroundColor
                     textColor:(UIColor *)textColor
                   buttonColor:(UIColor *)buttonColor
  buttonBackgroundPressedColor:(UIColor *)buttonBackgroundPressedColor
        buttonTextPressedColor:(UIColor *)buttonTextPressedColor
             buttonBorderColor:(UIColor *)buttonBorderColor
                           tag:(NSInteger)tag
                   otherButton:(NSString *)key1
             otherButtonsArray:(va_list)otherButtons;

//Show Alert with Choose Options customizing BackgroundColor, TextColor, Title Text Font and Cancel Text Font
-(void)showChooseAlertWithText:(NSString *)title
                    cancelText:(NSString *)cancelText
                      delegate:(id<MLChooseOptionAlertDelegate>)delegate
                      useStack:(BOOL)_useStack
               backgroundColor:(UIColor *)backgroundColor
                     textColor:(UIColor *)textColor
                   buttonColor:(UIColor *)buttonColor
  buttonBackgroundPressedColor:(UIColor *)buttonBackgroundPressedColor
        buttonTextPressedColor:(UIColor *)buttonTextPressedColor
             buttonBorderColor:(UIColor *)buttonBorderColor
                 titleTextFont:(UIFont *)titleTextFont
                buttonTextFont:(UIFont *)buttonTextFont
                           tag:(NSInteger)tag
                  otherButtons:(NSString *) key1, ... NS_REQUIRES_NIL_TERMINATION;

//Show Alert with Choose Options customizing BackgroundColor, TextColor, Title Text Font and Cancel Text Font
-(void)showChooseAlertWithText:(NSString *)title
                    cancelText:(NSString *)cancelText
                      delegate:(id<MLChooseOptionAlertDelegate>)delegate
                      useStack:(BOOL)_useStack
               backgroundColor:(UIColor *)backgroundColor
                     textColor:(UIColor *)textColor
                   buttonColor:(UIColor *)buttonColor
  buttonBackgroundPressedColor:(UIColor *)buttonBackgroundPressedColor
        buttonTextPressedColor:(UIColor *)buttonTextPressedColor
             buttonBorderColor:(UIColor *)buttonBorderColor
                 titleTextFont:(UIFont *)titleTextFont
                buttonTextFont:(UIFont *)buttonTextFont
                           tag:(NSInteger)tag
                   otherButton:(NSString *)key1
             otherButtonsArray:(va_list)otherButtons;

////////////////////////////////////////////////////////
////////////////////////////////////////////////////////
////////////////////////////////////////////////////////


@end
