//
//  UIColor+Components.m
//  ToastAlertProject
//
//  Copyright (c) 2014 Jorge Sanmartin. All rights reserved.
//

#import "UIColor+Components.h"

@implementation UIColor (Components)

- (BOOL) canProvideRGBComponents
{
	return (([self colorSpaceModel] == kCGColorSpaceModelRGB) ||
			([self colorSpaceModel] == kCGColorSpaceModelMonochrome));
}

- (CGColorSpaceModel) colorSpaceModel
{
	return CGColorSpaceGetModel(CGColorGetColorSpace(self.CGColor));
}

- (NSString *) colorSpaceString
{
	switch ([self colorSpaceModel])
	{
		case kCGColorSpaceModelUnknown:
			return @"kCGColorSpaceModelUnknown";
		case kCGColorSpaceModelMonochrome:
			return @"kCGColorSpaceModelMonochrome";
		case kCGColorSpaceModelRGB:
			return @"kCGColorSpaceModelRGB";
		case kCGColorSpaceModelCMYK:
			return @"kCGColorSpaceModelCMYK";
		case kCGColorSpaceModelLab:
			return @"kCGColorSpaceModelLab";
		case kCGColorSpaceModelDeviceN:
			return @"kCGColorSpaceModelDeviceN";
		case kCGColorSpaceModelIndexed:
			return @"kCGColorSpaceModelIndexed";
		case kCGColorSpaceModelPattern:
			return @"kCGColorSpaceModelPattern";
		default:
			return @"Not a valid color space";
	}
}

- (CGFloat) red
{
	NSAssert (self.canProvideRGBComponents, @"Must be a RGB color to use -red, -green, -blue");
	const CGFloat *c = CGColorGetComponents(self.CGColor);
	return c[0];
}

- (CGFloat) green
{
	NSAssert (self.canProvideRGBComponents, @"Must be a RGB color to use -red, -green, -blue");
	const CGFloat *c = CGColorGetComponents(self.CGColor);
	if ([self colorSpaceModel] == kCGColorSpaceModelMonochrome) return c[0];
	return c[1];
}

- (CGFloat) blue
{
	NSAssert (self.canProvideRGBComponents, @"Must be a RGB color to use -red, -green, -blue");
	const CGFloat *c = CGColorGetComponents(self.CGColor);
	if ([self colorSpaceModel] == kCGColorSpaceModelMonochrome) return c[0];
	return c[2];
}

- (CGFloat) alpha
{
	const CGFloat *c = CGColorGetComponents(self.CGColor);
	return c[CGColorGetNumberOfComponents(self.CGColor)-1];
}

@end
