//
//  MLAlert.m
//  ToastAlertProject
//
//  Created by jorge Sanmartin on 14/05/14.
//  Copyright (c) 2014 Jorge Sanmartin. All rights reserved.
//

#import "MLAlert.h"
#import "MLGenericAlert.h"
#import "MLTextAlertProperties.h"
#import "MLChooseOptionAlertProperties.h"
#import "Common.h"

static MLAlert *sharedInstance = nil;

@interface MLAlert ()

@property (nonatomic, assign) CGPoint originalTouchGesture;

@end

@implementation MLAlert

@synthesize listAlerts;
@synthesize waitingAlerts;
@synthesize textAlertProperties;
@synthesize chooseOptionAlertProperties;
@synthesize originalTouchGesture;

+ (MLAlert *)sharedInstance {
    @synchronized(self) {
        if (sharedInstance == nil) {
            sharedInstance = [[self alloc] init];
            [sharedInstance setupAlert];
        }
    }
    return sharedInstance;
}

- (void)panGesture:(UIPanGestureRecognizer *)recognizer
{
    UIWindow *window = [[[UIApplication sharedApplication] delegate] window];
    if (recognizer.state == UIGestureRecognizerStateBegan) {
                originalTouchGesture = [recognizer locationInView:window];
    } else if (recognizer.state == UIGestureRecognizerStateChanged) {
        NSLog(@"UIGestureRecognizerStateChanged");
    } else if (recognizer.state == UIGestureRecognizerStateEnded) {
        CGPoint finalTouchPoint = [recognizer locationInView:window];
        if ((originalTouchGesture.y - finalTouchPoint.y) > MARGIN_TO_FORZE_HIDE_ALERTS) {
            [self cancelAlertsByDraggingDisappearWithAnimationFadeOut];
        }
    }
}

#pragma mark - Setup Alerts

- (void)setupAlert{
    
    sharedInstance.listAlerts = [[NSMutableArray alloc] init];
    sharedInstance.waitingAlerts = [[NSMutableArray alloc] init];
    screenBlocked = NO;
    textAlertProperties = [[MLTextAlertProperties alloc] init];
    chooseOptionAlertProperties = [MLChooseOptionAlertProperties alloc];
    
    [sharedInstance setupTextAlertWithBackgroundColor:[UIColor colorWithRed:255.0/255.0 green:255.0/255.0 blue:255.0/255.0 alpha:0.8f]
                                            textColor:[UIColor colorWithRed:77.0/255.0 green:74.0/255.0 blue:71.0/255.0 alpha:1.0]
                                             textFont:[UIFont systemFontOfSize:18.0f]
                                            positionY:-1
                                      bottomPositionY:-1];
    
    [sharedInstance setupChooseOptionAlertWithbBackgroundColor:[UIColor colorWithRed:255.0/255.0 green:255.0/255.0 blue:255.0/255.0 alpha:0.8f]
                                                     textColor:[UIColor colorWithRed:77.0/255.0 green:74.0/255.0 blue:71.0/255.0 alpha:1.0]
                                                   buttonColor:[UIColor colorWithRed:255.0/255.0 green:255.0/255.0 blue:255.0/255.0 alpha:1.0f]
                                  buttonBackgroundPressedColor:[UIColor colorWithRed:109.0/255.0 green:106.0/255.0 blue:96.0/255.0 alpha:1.0]
                                        buttonTextPressedColor:[UIColor whiteColor]
                                             buttonBorderColor:[UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.4f]
                                                 titleTextFont:[UIFont systemFontOfSize:18.0f]
                                                buttonTextFont:[UIFont systemFontOfSize:30.0f]
                                                     positionY:-1
                                               bottomPositionY:-1];
    
}

//Setup colors and fonts in TextAlerts
- (void)setupTextAlertWithBackgroundColor:(UIColor *)backgroundColor
                                textColor:(UIColor *)textColor
                                 textFont:(UIFont *)textFont
                                positionY:(NSInteger)positionY
                          bottomPositionY:(NSInteger)bottomPositionY
{
    [textAlertProperties setupTextAlertPropertiesWithBackgroundColor:backgroundColor
                                                           textColor:textColor
                                                            textFont:textFont
                                                           positionY:positionY
                                                     bottomPositionY:bottomPositionY];
}

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
                                   bottomPositionY:(NSInteger)bottomPositionY
{
    [chooseOptionAlertProperties setupChooseOptionAlertPropertiesWithBackgroundColor:backgroundColor
                                                                           textColor:textColor
                                                                         buttonColor:buttonColor
                                                        buttonBackgroundPressedColor:buttonBackgroundPressedColor
                                                              buttonTextPressedColor:buttonTexPressedColor
                                                                   buttonBorderColor:buttonBorderColor
                                                                       titleTextFont:titleTextFont
                                                                      buttonTextFont:buttonTextFont
                                                                           positionY:positionY
                                                                     bottomPositionY:bottomPositionY];
}

#pragma mark - Other methods

//Show All Generic and childs Alerts
- (void) showGenericAlertWithObject:(MLGenericAlert *)alert useStack:(BOOL)_useStack
{
    useStack = _useStack;
    
    [self performSelectorOnMainThread:@selector(showAlertInMainThread:) withObject:alert waitUntilDone:NO];
}

//Show the alert on the screen
-(void)showAlertInMainThread:(MLGenericAlert *)alert
{
    if (screenBlocked) {
        
        [waitingAlerts addObject:alert];
        
    } else {
        
        UIPanGestureRecognizer *recognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panGesture:)];
        recognizer.delegate = self;
        [alert addGestureRecognizer:recognizer];
        
        if ([alert isKindOfClass:[MLTextAlert class]]) {
            
            if (textAlertProperties.positionY > 0) {
                
                alert.originalPositionY = textAlertProperties.positionY;
                
            } else if (textAlertProperties.bottomPositionY > 0) {
                
                alert.originalBottomPositionY = textAlertProperties.bottomPositionY;
            }
            
        } else if ([alert isKindOfClass:[MLChooseOptionAlert class]]) {
            
            if (chooseOptionAlertProperties.positionY > 0) {
                
                alert.originalPositionY = chooseOptionAlertProperties.positionY;
                
            } else if (chooseOptionAlertProperties.bottomPositionY > 0) {
                
                alert.originalBottomPositionY = chooseOptionAlertProperties.bottomPositionY;
            }
            
            //            alert.originalBottomPositionY = 0;
        }
        
        
        [alert show];   //Mostramos el alert
        
        if (useStack)
        {
            NSArray* reversed = [[listAlerts reverseObjectEnumerator] allObjects];
            
            CGFloat positionY = alert.frame.origin.y;
            
            for (UIView *aux in reversed)
            {
                if ([aux isKindOfClass:[MLChooseOptionAlert class]]) {
                    
                    positionY = 0;
                    
                } else {
                    
                    positionY = positionY - OFFSET_Y - aux.frame.size.height;
                }
                
                CGRect frameHUD = aux.frame;
                
                frameHUD.origin.y = positionY;
                
                CGFloat alphaHud = aux.alpha;
                if (aux.alpha >= ALPHA_DISSAPEAR)
                {
                    alphaHud -= ALPHA_DISSAPEAR;
                }
                
                [UIView animateWithDuration:ANIMATION_DURATION animations:^{
                    
                    aux.frame = frameHUD;
                    aux.alpha = alphaHud;
                }];
            }
        }
        else
        {
            [self cancelAlerts];
        }
        
        [listAlerts addObject:alert];
        
        if ([self alertIsBlocking:alert]) {
            
            screenBlocked = YES;
            
        } else {
            
            [alert hideWithFadeout:[alert getTimeFadeOut]];
        }
    }
}

- (BOOL)alertIsBlocking:(MLGenericAlert *)alert
{
    if (([alert isKindOfClass:[MLLoaderAlert class]]) || ([alert isKindOfClass:[MLChooseOptionAlert class]]) || ([alert alertIsCritical])) { //Si es critico, es loader o alertview de preguntar SI o NO bloqueamos pantalla
        return YES;
    } else
        return NO;
}

//Method that cancel all alerts (visibles and waitings)
-(void)cancelAlerts
{
    //TODO: Estudiar bien si las alertas waiting tambien deben desaparecer
    NSMutableArray *list = [NSMutableArray arrayWithArray:listAlerts];
    [list addObjectsFromArray:waitingAlerts];
    
    for (MLGenericAlert *auxAlert in list)
    {
        [NSObject cancelPreviousPerformRequestsWithTarget:auxAlert selector:@selector(hide) object:auxAlert];
        [NSObject cancelPreviousPerformRequestsWithTarget:auxAlert selector:@selector(hideWithFadeout:) object:auxAlert];
        [auxAlert forzeHide];
    }
    
    [listAlerts removeAllObjects];
    [waitingAlerts removeAllObjects];
    
    screenBlocked = NO;
}

- (void)cancelAlertsByDraggingOnlyDisappear
{
    NSMutableArray *listAlertsToRemove = [[NSMutableArray alloc] init];
    for (int i = 0; i < listAlerts.count; i++)
    {
        MLGenericAlert *auxAlert = [listAlerts objectAtIndex:i];
        
        if (![self alertIsBlocking:auxAlert] || (i != (listAlerts.count - 1))) {
            
            [NSObject cancelPreviousPerformRequestsWithTarget:auxAlert selector:@selector(hide) object:auxAlert];
            [NSObject cancelPreviousPerformRequestsWithTarget:auxAlert selector:@selector(hideWithFadeout:) object:auxAlert];
            [auxAlert forzeHide];
            
            [listAlertsToRemove addObject:auxAlert];
        }
    }
    
    [listAlerts removeObjectsInArray:listAlertsToRemove];
}

- (void)cancelAlertsByDraggingDisappearWithAnimationFadeOut
{
    NSArray* reversed = [[listAlerts reverseObjectEnumerator] allObjects];
    NSMutableArray *listAlertsToRemove = [[NSMutableArray alloc] init];
    
    CGFloat positionY = 0;
    //    NSLog(@"list alerts count.: %d", listAlerts.count);
    //    NSLog(@"reversed count: %d", reversed.count);
    for (int i = 0; i < listAlerts.count; i++)
    {
        //        NSLog(@"i = %d", i);
        MLGenericAlert *aux = [reversed objectAtIndex:i];
        //        NSLog(@"antes i = %d", i);
        if (![self alertIsBlocking:aux] || (i != 0)) {
            
            //            NSLog(@"despues i = %d", i);
            [listAlertsToRemove addObject:aux];
            
            CGRect frameHUD = aux.frame;
            positionY = positionY - OFFSET_Y - aux.frame.size.height;
            frameHUD.origin.y = positionY;
            
            //        CGFloat alphaHud = aux.alpha;
            //        if (aux.alpha >= ALPHA_DISSAPEAR)
            //        {
            //            alphaHud -= ALPHA_DISSAPEAR;
            //        }
            
            
            //            [listAlerts removeObject:aux];
            [UIView animateWithDuration:0.3 animations:^{
                
                aux.frame = frameHUD;
                //            aux.alpha = alphaHud;
            } completion:^(BOOL finished) {
                
                if (i == (listAlerts.count - 1)) {
                    
                    for (MLGenericAlert *alert in listAlertsToRemove) {
                        
                        [alert hide];
                    }
                }
            }];
        }
    }
}


//This method is called (internitily) for unblocking the alerts
- (void)finishBlockingAlert:(MLGenericAlert *)alert
{
    BOOL foundInMainList = NO;
    
    for (MLGenericAlert *view in listAlerts) {
        
        if (view == alert) {
            
            foundInMainList = YES;
            screenBlocked = NO;
            
            break;
        }
    }
    
    if (foundInMainList) {
        
        if ([listAlerts containsObject:alert]) {
            [listAlerts removeObject:alert];
        }
        
        NSMutableArray *auxWaitingAlerts = [[NSMutableArray alloc] initWithArray:waitingAlerts];
        [waitingAlerts removeAllObjects];
        
        for (int i = 0; i < auxWaitingAlerts.count; i++) {
            
            [self performSelector:@selector(showAlertInMainThread:) withObject:[auxWaitingAlerts objectAtIndex:i] afterDelay:(i * ANIMATION_DURATION)];
        }
    } else {
        
        UIView *viewWaiting = nil;
        
        for (MLGenericAlert *view in waitingAlerts) {
            
            if (view == alert) {
                
                viewWaiting = view;
                
                break;
            }
        }
        
        if (viewWaiting != nil) {   //Si un bloqueante que estaba esperando salir en la pantalla finalizó antes que la alerta que esta bloqueando la pantalla ya no aparece en el stack
            
            if ([waitingAlerts containsObject:viewWaiting]) {
                
                [waitingAlerts removeObject:viewWaiting];
            }
        }
    }
}


#pragma mark - Text Alert methods

////////////////////////////////////////////////////////
//////////////  Text Alert  ////////////////////////////
////////////////////////////////////////////////////////


//Show Alert With Title
-(void)showAlertWithText:(NSString *)text
{
    [self showAlertWithText:text isCritical:NO useStack:YES];
}

//Show Alert with Title and isCritical
- (void)showAlertWithText:(NSString *)text
               isCritical:(BOOL)isCritical
{
    [self showAlertWithText:text
                 isCritical:isCritical
                   useStack:YES];
}

//Show Alert With Title using or no stacks
-(void)showAlertWithText:(NSString *)text
              isCritical:(BOOL)isCritical
                useStack:(BOOL)_useStack
{
    [self showAlertWithText:text
                 isCritical:isCritical
                   useStack:_useStack
            backgroundColor:self.textAlertProperties.backgroundColor
                  textColor:self.textAlertProperties.textColor];
}

//Show Alert With Title and custimize colors
-(void)showAlertWithText:(NSString *)text
              isCritical:(BOOL)isCritical
                useStack:(BOOL)_useStack
         backgroundColor:(UIColor *)backgroundColor
               textColor:(UIColor *)textColor
{
    [self showAlertWithText:text
                 isCritical:isCritical
                   useStack:_useStack
            backgroundColor:backgroundColor
                  textColor:textColor
                   textFont:self.textAlertProperties.textFont];
}

//Show Alert With Title and customize colors and font
-(void)showAlertWithText:(NSString *)text
              isCritical:(BOOL)isCritical
                useStack:(BOOL)_useStack
         backgroundColor:(UIColor *)backgroundColor
               textColor:(UIColor *)textColor
                textFont:(UIFont *)textFont
{
    dispatch_async(dispatch_get_main_queue(), ^{
        MLTextAlert *textAlert = [MLTextAlert initTextAlertWithText:text
                                                         isCritical:isCritical
                                                           delegate:self
                                                    backgroundColor:backgroundColor
                                                          textColor:textColor
                                                           textFont:textFont];
        
        [self showGenericAlertWithObject:textAlert
                                useStack:_useStack];
    });
    
}

////////////////////////////////////////////////////////
////////////////////////////////////////////////////////
////////////////////////////////////////////////////////

#pragma mark - Loader Alert methods
////////////////////////////////////////////////////////
//////////////  Loader Alert  //////////////////////////
////////////////////////////////////////////////////////

//Show Alert With Loader
-(MLLoaderAlert *)showAlertLoader
{
    return [self showAlertLoaderUsingStack:YES];
}

//Show Alert With Loader using or no stacks
-(MLLoaderAlert *)showAlertLoaderUsingStack:(BOOL)_useStack
{
    MLLoaderAlert *loaderAlert = [MLLoaderAlert initLoaderAlertWithDelegate:self];
    
    [self showGenericAlertWithObject:loaderAlert
                            useStack:_useStack];
    
    return loaderAlert;
}

//Show Alert With Loader customizing view For Animate
-(MLLoaderAlert *)showAlertLoaderWithViewForAnimate:(UIView *)viewForAnimate
{
    return [self showAlertLoaderUsingStack:YES
                            viewForAnimate:viewForAnimate];
}

//Show Alert With Loader using or no stacks and customize view For Animate
-(MLLoaderAlert *)showAlertLoaderUsingStack:(BOOL)_useStack
                             viewForAnimate:(UIView *)viewForAnimate
{
    MLLoaderAlert *loaderAlert = [MLLoaderAlert initLoaderAlertWithDelegate:self
                                                             viewForAnimate:viewForAnimate];
    
    [self showGenericAlertWithObject:loaderAlert
                            useStack:_useStack];
    
    return loaderAlert;
}

////////////////////////////////////////////////////////
////////////////////////////////////////////////////////
////////////////////////////////////////////////////////

#pragma mark - Choose Option Alert methods
////////////////////////////////////////////////////////
///////////  Choose Option Alert  //////////////////////
////////////////////////////////////////////////////////

//Show Alert with Choose Options
-(void)showChooseAlertWithText:(NSString *)title
                    cancelText:(NSString *)cancelText
                      delegate:(id<MLChooseOptionAlertDelegate>)delegate
                  otherButtons:(NSString *) key1, ... NS_REQUIRES_NIL_TERMINATION
{
    va_list args;
    va_start(args, key1);
    
    [self showChooseAlertWithText:title
                       cancelText:cancelText
                         delegate:delegate
                         useStack:YES
                              tag:12
                      otherButton:key1
                otherButtonsArray:args];
    
    va_end(args);
}

//Show Alert with Choose Options customizing tag
-(void)showChooseAlertWithText:(NSString *)title
                    cancelText:(NSString *)cancelText
                      delegate:(id<MLChooseOptionAlertDelegate>)delegate
                           tag:(NSInteger)tag
                  otherButtons:(NSString *) key1, ... NS_REQUIRES_NIL_TERMINATION
{
    va_list args;
    va_start(args, key1);
    
    [self showChooseAlertWithText:title
                       cancelText:cancelText
                         delegate:delegate
                         useStack:YES
                              tag:tag
                      otherButton:key1
                otherButtonsArray:args];
    
    va_end(args);
}

//Show Alert with Choose Options customizing useStack
-(void)showChooseAlertWithText:(NSString *)title
                    cancelText:(NSString *)cancelText
                      delegate:(id<MLChooseOptionAlertDelegate>)delegate
                      useStack:(BOOL)_useStack
                           tag:(NSInteger)tag
                  otherButtons:(NSString *) key1, ... NS_REQUIRES_NIL_TERMINATION
{
    va_list args;
    va_start(args, key1);
    
    [self showChooseAlertWithText:title
                       cancelText:cancelText
                         delegate:delegate
                         useStack:_useStack
                  backgroundColor:chooseOptionAlertProperties.backgroundColor
                        textColor:chooseOptionAlertProperties.textColor
                              tag:tag
                      otherButton:key1
                otherButtonsArray:args];
    
    va_end(args);
}

//Show Alert with Choose Options customizing useStack
-(void)showChooseAlertWithText:(NSString *)title
                    cancelText:(NSString *)cancelText
                      delegate:(id<MLChooseOptionAlertDelegate>)delegate
                      useStack:(BOOL)_useStack
                           tag:(NSInteger)tag
                   otherButton:(NSString *)key1
             otherButtonsArray:(va_list)otherButtons
{
    [self showChooseAlertWithText:title
                       cancelText:cancelText
                         delegate:delegate
                         useStack:_useStack
                  backgroundColor:chooseOptionAlertProperties.backgroundColor
                        textColor:chooseOptionAlertProperties.textColor
                              tag:tag
                      otherButton:key1
                otherButtonsArray:otherButtons];
}

//Show Alert with Choose Options customizing BackgroundColor and TextColor
-(void)showChooseAlertWithText:(NSString *)title
                    cancelText:(NSString *)cancelText
                      delegate:(id<MLChooseOptionAlertDelegate>)delegate
                      useStack:(BOOL)_useStack
               backgroundColor:(UIColor *)backgroundColor
                     textColor:(UIColor *)textColor
                           tag:(NSInteger)tag
                  otherButtons:(NSString *) key1, ... NS_REQUIRES_NIL_TERMINATION
{
    va_list args;
    va_start(args, key1);
    
    [self showChooseAlertWithText:title
                       cancelText:cancelText
                         delegate:delegate
                         useStack:_useStack
                  backgroundColor:backgroundColor
                        textColor:textColor
                      buttonColor:chooseOptionAlertProperties.buttonColor
     buttonBackgroundPressedColor:chooseOptionAlertProperties.buttonBackgroundPressedColor
           buttonTextPressedColor:chooseOptionAlertProperties.buttonTextPressedColor
                buttonBorderColor:chooseOptionAlertProperties.buttonBorderColor
                              tag:tag
                      otherButton:key1
                otherButtonsArray:args];
    
    va_end(args);
}

//Show Alert with Choose Options customizing BackgroundColor and TextColor
-(void)showChooseAlertWithText:(NSString *)title
                    cancelText:(NSString *)cancelText
                      delegate:(id<MLChooseOptionAlertDelegate>)delegate
                      useStack:(BOOL)_useStack
               backgroundColor:(UIColor *)backgroundColor
                     textColor:(UIColor *)textColor
                           tag:(NSInteger)tag
                   otherButton:(NSString *)key1
             otherButtonsArray:(va_list)otherButtons
{
    [self showChooseAlertWithText:title
                       cancelText:cancelText
                         delegate:delegate
                         useStack:_useStack
                  backgroundColor:backgroundColor
                        textColor:textColor
                      buttonColor:chooseOptionAlertProperties.buttonColor
     buttonBackgroundPressedColor:chooseOptionAlertProperties.buttonBackgroundPressedColor
           buttonTextPressedColor:chooseOptionAlertProperties.buttonTextPressedColor
                buttonBorderColor:chooseOptionAlertProperties.buttonBorderColor
                              tag:tag
                      otherButton:key1
                otherButtonsArray:otherButtons];
}


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
                  otherButtons:(NSString *) key1, ... NS_REQUIRES_NIL_TERMINATION
{
    va_list args;
    va_start(args, key1);
    
    [self showChooseAlertWithText:title
                       cancelText:cancelText
                         delegate:delegate
                         useStack:_useStack
                  backgroundColor:backgroundColor
                        textColor:textColor
                      buttonColor:buttonColor
     buttonBackgroundPressedColor:buttonBackgroundPressedColor
           buttonTextPressedColor:buttonTextPressedColor
                buttonBorderColor:buttonBorderColor
                    titleTextFont:chooseOptionAlertProperties.titleTextFont
                   buttonTextFont:chooseOptionAlertProperties.buttonTextFont
                              tag:tag
                      otherButton:key1 otherButtonsArray:args];
    
    va_end(args);
}

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
             otherButtonsArray:(va_list)otherButtons
{
    [self showChooseAlertWithText:title
                       cancelText:cancelText
                         delegate:delegate
                         useStack:_useStack
                  backgroundColor:backgroundColor
                        textColor:textColor
                      buttonColor:buttonColor
     buttonBackgroundPressedColor:buttonBackgroundPressedColor
           buttonTextPressedColor:buttonTextPressedColor
                buttonBorderColor:buttonBorderColor
                    titleTextFont:chooseOptionAlertProperties.titleTextFont
                   buttonTextFont:chooseOptionAlertProperties.buttonTextFont
                              tag:tag
                      otherButton:key1
                otherButtonsArray:otherButtons];
}

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
                  otherButtons:(NSString *) key1, ... NS_REQUIRES_NIL_TERMINATION
{
    va_list args;
    va_start(args, key1);
    
    [self showChooseAlertWithText:title
                       cancelText:cancelText
                         delegate:delegate
                         useStack:_useStack
                  backgroundColor:backgroundColor
                        textColor:textColor
                      buttonColor:buttonColor
     buttonBackgroundPressedColor:buttonBackgroundPressedColor
           buttonTextPressedColor:buttonTextPressedColor
                buttonBorderColor:buttonBorderColor
                    titleTextFont:titleTextFont
                   buttonTextFont:buttonTextFont
                              tag:tag
                      otherButton:key1
                otherButtonsArray:args];
    
    va_end(args);
    
}

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
             otherButtonsArray:(va_list)otherButtons
{
    
    NSMutableArray *listOthersOptions = [[NSMutableArray alloc] init];
    
    for (NSString *arg = key1; arg != nil; arg = va_arg(otherButtons, NSString*)) {
        
        [listOthersOptions addObject:arg];
    }
    
    MLChooseOptionAlert *chooseAlert = [MLChooseOptionAlert initChooseOptionAlertWithText:title
                                                                               cancelText:cancelText
                                                                             otherOptions:listOthersOptions
                                                                                 delegate:self
                                                                       controllerDelegate:delegate
                                                                          backgroundColor:backgroundColor
                                                                                textColor:textColor
                                                                              buttonColor:buttonColor
                                                             buttonBackgroundPressedColor:buttonBackgroundPressedColor
                                                                   buttonTextPressedColor:buttonTextPressedColor
                                                                        buttonBorderColor:buttonBorderColor
                                                                            titleTextFont:titleTextFont
                                                                           buttonTextFont:buttonTextFont
                                                                                      tag:tag];
    
    [self showGenericAlertWithObject:chooseAlert
                            useStack:_useStack];
    
    //    return chooseAlert;
}

////////////////////////////////////////////////////////
////////////////////////////////////////////////////////
////////////////////////////////////////////////////////

#pragma mark AlertDelegate

-(void)alertHided:(MLGenericAlert *)alert
{
    if ([self alertIsBlocking:alert]) {
        
        [self performSelectorOnMainThread:@selector(finishBlockingAlert:) withObject:alert waitUntilDone:YES];
        
    } else {
        
        if ([listAlerts containsObject:alert]) {
            [listAlerts removeObject:alert];
        }
    }
}

@end
