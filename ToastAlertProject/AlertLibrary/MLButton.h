//
//  MLButton.h
//  ToastAlertProject
//
//  Copyright (c) 2014 Jorge Sanmartin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MLButton : UIButton
{
    UILabel *titleLabelAsociated;
    UIColor *textColorPressed;
    UIColor *textColorNormal;
    BOOL fontButtonsIsIncreased;
}

@property (nonatomic, strong) UILabel *titleLabelAsociated;
@property (nonatomic, strong) UIColor *textColorPressed;
@property (nonatomic, strong) UIColor *textColorNormal;
@property (nonatomic, assign) BOOL fontButtonsIsIncreased;
@end
