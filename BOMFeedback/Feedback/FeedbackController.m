//
//  FeedbackViewController.m
//  callmevip
//
//  Created by Oliver Michalak on 19.05.15.
//  Copyright (c) 2015 Oliver Michalak. All rights reserved.
//

#import "FeedbackController.h"
#import "AbstractFeedbackViewController.h"
#import "UIView+DarkMode.h"

@interface FeedbackController ()

@end

@implementation FeedbackController

- (instancetype) init {
	if ((self = [super init])) {
		[self setup];
	}
	return self;
}

- (void) setup {
	NSDictionary *config = [[NSDictionary alloc] initWithContentsOfFile: [[NSBundle mainBundle] pathForResource:@"Feedback" ofType:@"plist"]];
	if (!config) {
#ifdef DEBUG
		NSAssert(config, @"Feedback.plist missing");
#endif
		return;
	}
	NSMutableDictionary *feedbackConfig = [config mutableCopy];
	[feedbackConfig removeObjectForKey:@"modules"];
	
	if ([feedbackConfig[@"darkMode"] boolValue])
		[self.tabBar setupDarkMode];

	UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Feedback" bundle:nil];
	NSMutableArray *viewControllers = [@[] mutableCopy];
	for (NSDictionary *moduleConfig in config[@"modules"]) {
		NSString *controllerName = [NSString stringWithFormat:@"%@FeedbackViewController", [moduleConfig[@"name"] capitalizedString]];
		AbstractFeedbackViewController *viewController = [storyboard instantiateViewControllerWithIdentifier:controllerName];
		if (viewController) {
			UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:viewController];
			if ([feedbackConfig[@"darkMode"] boolValue]) {
				navigationController.navigationBar.barStyle = UIBarStyleBlack;
				navigationController.view.backgroundColor = [UIColor blackColor];
			}
			else {
				navigationController.view.backgroundColor = [UIColor whiteColor];
			}
			viewController.feedbackConfig = feedbackConfig;
			viewController.moduleConfig = moduleConfig;
			[viewControllers addObject:navigationController];
		}
	}
	self.viewControllers = viewControllers;
	self.selectedIndex = 0;
}

@end
