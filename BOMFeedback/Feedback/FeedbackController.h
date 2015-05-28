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

#define FeedbackFAQPList (@"feedbackFAQ.plist")

#define FeedbackFAQUpdate (@"feedbackFAQUpdate")

@interface FeedbackController : UITabBarController

@end
