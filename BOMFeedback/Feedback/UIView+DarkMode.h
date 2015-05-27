//
//  UIView+DarkMode.h
//  niceapp
//
//  Created by Oliver Michalak on 27.05.15.
//  Copyright (c) 2015 Oliver Michalak. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (DarkMode)

- (void) setupDarkMode;

@end

@interface UIColor (DarkMode)

- (UIColor*)darkModeBackColor;
- (UIColor*)darkModeFrontColor;

@end