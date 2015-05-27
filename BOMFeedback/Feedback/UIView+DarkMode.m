//
//  UIView+DarkMode.m
//  niceapp
//
//  Created by Oliver Michalak on 27.05.15.
//  Copyright (c) 2015 Oliver Michalak. All rights reserved.
//

#import "UIView+DarkMode.h"

@implementation UIView (DarkMode)

- (void) setupDarkMode {
	self.backgroundColor = [self.backgroundColor darkModeBackColor];
	for (UIView *subview in self.subviews)
		[subview setupDarkMode];
}

@end

@implementation UILabel (DarkMode)

- (void) setupDarkMode {
	[super setupDarkMode];

	self.textColor = [self.textColor darkModeFrontColor];
}

@end

@implementation UITabBar (DarkMode)

- (void) setupDarkMode {
	[super setupDarkMode];

	// urgh...
	CGSize size = CGSizeMake(CGRectGetWidth(self.bounds), CGRectGetHeight(self.bounds));
	UIGraphicsBeginImageContextWithOptions(size, NO, 0.0);
	CGContextRef ctx = UIGraphicsGetCurrentContext();
	[[UIColor colorWithWhite:0.05 alpha:1] setFill];
	CGContextFillRect(ctx, CGRectMake(0, 0, size.width, size.height));
	[[UIColor colorWithWhite:0.1 alpha:1] setStroke];
	CGContextMoveToPoint(ctx, 0, 0.5);
	CGContextAddLineToPoint(ctx, size.width, 0.5);
	CGContextDrawPath(ctx, kCGPathStroke);
	UIImage *backgroundImage = UIGraphicsGetImageFromCurrentImageContext();
	UIGraphicsEndImageContext();
		
	self.backgroundImage = backgroundImage;
}

@end

@implementation UIColor (DarkMode)

- (UIColor*)darkModeBackColor {
	CGFloat white, alpha;
	[self getWhite:&white alpha:&alpha];
	return [UIColor colorWithWhite: (white < 0.5 ? white : 1. - 2. * white) alpha:alpha];
}

- (UIColor*)darkModeFrontColor {
	CGFloat white, alpha;
	[self getWhite:&white alpha:&alpha];
	return [UIColor colorWithWhite: (white > 0.5 ? white : 1. - 0.5 * white) alpha:alpha];
}

@end