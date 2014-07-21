//
//  MLEngineAlertView.m
//  ToastAlertProject
//
//  Created by jorge Sanmartin on 14/05/14.
//  Copyright (c) 2014 Jorge Sanmartin. All rights reserved.
//

#import "MLEngineAlertView.h"

@interface MLEngineAlertView ()

@property (nonatomic, strong) UIImageView *firstPiston;
@property (nonatomic, strong) UIImageView *secondPiston;
@property (nonatomic, assign) BOOL pistonsIsUp;

@end

@implementation MLEngineAlertView

@synthesize firstPiston;
@synthesize secondPiston;
@synthesize pistonsIsUp;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

+(MLEngineAlertView *)initEngineAlertView
{
    UIImageView *backgroundImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"MLfondo_loader"]];
    UIImageView *baseImage = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"MLmotor_base"]];
    
    MLEngineAlertView *loaderView = [[MLEngineAlertView alloc] initWithFrame:backgroundImage.frame];
    
    loaderView.firstPiston = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"MLpiston1"]];
    loaderView.secondPiston = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"MLpiston2"]];
    loaderView.backgroundColor = [UIColor clearColor];
    
    baseImage.center = CGPointMake(loaderView.frame.size.width / 2, loaderView.frame.size.height / 2);
    loaderView.firstPiston.center = CGPointMake((loaderView.frame.size.width / 2) + 1, (loaderView.frame.size.height / 2) - 10);
    loaderView.secondPiston.center = CGPointMake((loaderView.frame.size.width / 2) + 1, (loaderView.frame.size.height / 2) - 14);
    
    loaderView.pistonsIsUp = NO;
    
    [loaderView addSubview:backgroundImage];
    [loaderView addSubview:loaderView.firstPiston];
    [loaderView addSubview:loaderView.secondPiston];
    [loaderView addSubview:baseImage];
    
    [loaderView animateEngine];
    
    return loaderView;
}

- (void) animateEngine
{
    CGFloat offset = pistonsIsUp ? 4 : -4;
    
    [UIView animateWithDuration:0.15
                          delay:0
                        options:(UIViewAnimationOptionCurveEaseInOut|UIViewAnimationOptionAllowUserInteraction)
                     animations:^{
                         
                         firstPiston.frame = CGRectMake(firstPiston.frame.origin.x, firstPiston.frame.origin.y + offset, firstPiston.frame.size.width, firstPiston.frame.size.height);
                         secondPiston.frame = CGRectMake(secondPiston.frame.origin.x, secondPiston.frame.origin.y - offset, secondPiston.frame.size.width, secondPiston.frame.size.height);
                         
                     } completion:^(BOOL finished) {
                         
                         pistonsIsUp = !pistonsIsUp;
                         
                         [self animateEngine];
                         
                     }];
}

@end
