//
//  MLLoaderAlert.h
//  ToastAlertProject
//
//  Created by jorge Sanmartin on 14/05/14.
//  Copyright (c) 2014 Jorge Sanmartin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MLGenericAlert.h"

@interface MLLoaderAlert : MLGenericAlert

+ (MLLoaderAlert *)initLoaderAlertWithDelegate:(id<MLAlertDelegate>)_delegate;
+ (MLLoaderAlert *)initLoaderAlertWithDelegate:(id<MLAlertDelegate>)_delegate viewForAnimate:(UIView *)viewForAnimate;

@end
