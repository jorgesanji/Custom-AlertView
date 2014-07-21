//
//  MLButtonWithTriangle.m
//  ToastAlertProject
//
//  Copyright (c) 2014 Jorge Sanmartin. All rights reserved.
//

#import "MLButtonWithTriangle.h"
#import "UIColor+Components.h"
#import <QuartzCore/QuartzCore.h>

@interface MLButtonWithTriangle ()

@property (nonatomic, strong) UIColor *triangleColor;

@end

@implementation MLButtonWithTriangle

@synthesize triangleColor;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
//- (void)drawRect:(CGRect)rect
//{
//    // Drawing code
//
//    CGContextRef ctx = UIGraphicsGetCurrentContext();
//
//    CGContextBeginPath(ctx);
//    CGContextMoveToPoint   (ctx, CGRectGetMinX(rect), CGRectGetMinY(rect));  // top left
//    CGContextAddLineToPoint(ctx, CGRectGetMaxX(rect), CGRectGetMinY(rect));  // mid right
//    CGContextAddLineToPoint(ctx, CGRectGetMinX(rect), CGRectGetMaxY(rect));  // bottom left
//    CGContextClosePath(ctx);
//
//    CGFloat red = triangleColor == nil ? [self.backgroundColor red] : [triangleColor red];
//    CGFloat blue = triangleColor == nil ? [self.backgroundColor blue] : [triangleColor blue];
//    CGFloat green = triangleColor == nil ? [self.backgroundColor green] : [triangleColor green];
//    CGFloat alpha = triangleColor == nil ? [self.backgroundColor alpha] : [triangleColor alpha];
//
//    CGContextSetRGBFillColor(ctx, red, blue, green, alpha);
//    CGContextFillPath(ctx);
//}

- (void)setupButtonWithTriangleColor:(UIColor *)_triangleColor
{
    self.triangleColor = _triangleColor;
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
                
                //                [self.layer setBorderWidth:6.0];
                [UIView animateWithDuration:0.075 animations:^{
                    self.layer.transform = CATransform3DMakeScale(0.9, 0.8, 1.0);
                }];
                
            } else {
                
                //                [self.layer setBorderWidth:0.0];
                [UIView animateWithDuration:0.075 animations:^{
                    self.layer.transform = CATransform3DIdentity;
                }];
            }
        }
    }
    
    //    if ([@"highlighted" isEqualToString:keyPath]) {
    //
    //        NSNumber *new = [change objectForKey:@"new"];
    //        NSLog(@"estado hightlited: %d", [new integerValue]);
    //        BOOL selected = [new integerValue];
    //
    //        if (selected) {
    //
    //            [self.layer setBorderWidth:6.0];
    ////            self.layer.transform = CATransform3DMakeScale(0.9, 0.9, 1.0);
    //
    //        } else {
    //
    //              [self.layer setBorderWidth:0.0];
    ////            self.layer.transform = CATransform3DIdentity;
    //        }
    //    }
}


@end
