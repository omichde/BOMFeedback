//
//  UIView+DarkMode.m
//  niceapp
//
//  Created by Oliver Michalak on 27.05.15.
//  Copyright (c) 2015 Oliver Michalak. All rights reserved.
//

#import "UIView+DarkMode.h"

@implementation UIView (DarkMode)

- (BOOL) darkModeEnabled {
	if (@available(iOS 13.0, *))
		return self.traitCollection.userInterfaceStyle == UIUserInterfaceStyleDark;
	else
		return NO;
}

@end
