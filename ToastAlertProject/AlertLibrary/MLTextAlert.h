//
//  MLTextAlert.h
//  ToastAlertProject
//
//  Created by jorge Sanmartin on 14/05/14.
//  Copyright (c) 2014 Jorge Sanmartin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MLGenericAlert.h"

@interface MLTextAlert : MLGenericAlert

+ (MLTextAlert *)initTextAlertWithText:(NSString *)text isCritical:(BOOL)isCritical delegate:(id<MLAlertDelegate>)_delegate backgroundColor:(UIColor *)backgroundColor textColor:(UIColor *)textColor textFont:(UIFont *)textFont;

@end
