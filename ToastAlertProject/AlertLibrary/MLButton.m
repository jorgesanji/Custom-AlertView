//
//  MLButton.m
//  ToastAlertProject
//
//  Copyright (c) 2014 Jorge Sanmartin. All rights reserved.
//

#import "MLButton.h"
#import <QuartzCore/QuartzCore.h>

#define MARGIN_LATERAL_AND_VERTICAL 8

@implementation MLButton
@synthesize titleLabelAsociated;
@synthesize textColorPressed;
@synthesize textColorNormal;
@synthesize fontButtonsIsIncreased;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if ([@"highlighted" isEqualToString:keyPath]) {
        
        NSNumber *new = [change objectForKey:@"new"];
        NSNumber *old = [change objectForKey:@"old"];
        
        if (old && [new isEqualToNumber:old]) {
            //            NSLog(@"Highlight state has not changed");
        } else {
            //            NSLog(@"Highlight state has changed to %d", [object isHighlighted]);
            BOOL selected = [new integerValue];
            
            if (selected) {
                
                CGFloat lateralPercent = (self.frame.size.width - MARGIN_LATERAL_AND_VERTICAL * 2) / self.frame.size.width;
                CGFloat verticalPercent = (self.frame.size.height - MARGIN_LATERAL_AND_VERTICAL * 2) / self.frame.size.height;
                titleLabelAsociated.textColor = self.textColorPressed;
                
                //                [self.layer setBorderWidth:6.0];
                [UIView animateWithDuration:0.075 animations:^{
                    self.layer.transform = CATransform3DMakeScale(lateralPercent, verticalPercent, 1);
                    self.titleLabelAsociated.layer.transform = CATransform3DMakeScale(0.9, 0.9, 0.9);
                } completion:^(BOOL finished) {
                }];
                
            } else {
                titleLabelAsociated.textColor = textColorNormal;
                
                //                [self.layer setBorderWidth:0.0];
                [UIView animateWithDuration:0.075 animations:^{
                    self.layer.transform = CATransform3DIdentity;
                    self.titleLabelAsociated.layer.transform = CATransform3DIdentity;
                } completion:^(BOOL finished) {
                }];
            }
        }
    }
}

@end
