//
//  MLEngineAlertView.h
//  ToastAlertProject
//
//  Created by jorge Sanmartin on 14/05/14.
//  Copyright (c) 2014 Jorge Sanmartin. All rights reserved.
//
#import <UIKit/UIKit.h>

@interface MLEngineAlertView : UIView
{
    UIImageView *firstPiston;
    UIImageView *secondPiston;
    BOOL pistonsIsUp;
}

+(MLEngineAlertView *)initEngineAlertView;

@end
