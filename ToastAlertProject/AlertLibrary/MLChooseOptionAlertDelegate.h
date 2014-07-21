//
//  MLChooseOptionAlertDelegate.h
//  ToastAlertProject
//
//  Created by jorge Sanmartin on 14/05/14.
//  Copyright (c) 2014 Jorge Sanmartin. All rights reserved.
//

#import <Foundation/Foundation.h>
@class MLChooseOptionAlert;

@protocol MLChooseOptionAlertDelegate <NSObject>

-(void)alertView:(MLChooseOptionAlert *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex;

@end
