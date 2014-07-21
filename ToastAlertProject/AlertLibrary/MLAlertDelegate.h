//
//  MLAlertDelegate.h
//  ToastAlertProject
//
//  Created by jorge Sanmartin on 14/05/14.
//  Copyright (c) 2014 Jorge Sanmartin. All rights reserved.
//

#import <Foundation/Foundation.h>

@class MLGenericAlert;

@protocol MLAlertDelegate <NSObject>

-(void)alertHided:(MLGenericAlert *)alert;

@end
