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

@interface FeedbackController : UITabBarController <UITabBarDelegate, UITabBarControllerDelegate>

/**
 * Dismisses the Feedback Controller altogether
 */
- (void) dismiss;

/**
 * Presents a specific module and pops back to its start view controller.
 * @param name The same name given in the configuration file.
 */
- (void) presentModule:(NSString*)name;

@end
