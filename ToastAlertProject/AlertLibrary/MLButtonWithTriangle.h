//
//  MLButtonWithTriangle.h
//  ToastAlertProject
//
//  Copyright (c) 2014 Jorge Sanmartin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MLButtonWithTriangle : UIButton
{
    UIColor *triangleColor;
}

- (void)setupButtonWithTriangleColor:(UIColor *)_triangleColor;

@end
