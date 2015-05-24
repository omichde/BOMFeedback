//
//  FeedbackViewController.h
//  callmevip
//
//  Created by Oliver Michalak on 19.05.15.
//  Copyright (c) 2015 Oliver Michalak. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FeedbackIconFont.h"

#define FeedbackLocalizedString(key) \
	[[NSBundle mainBundle] localizedStringForKey:(key) value:@"" table:@"FeedbackLocalizable"]

#define UIColorFromRGB(rgbValue) \
	[UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
	green:((float)((rgbValue & 0x00FF00) >>  8))/255.0 \
	blue:((float)((rgbValue & 0x0000FF) >>  0))/255.0 \
	alpha:1.0]

@interface FeedbackController : UITabBarController

@end
