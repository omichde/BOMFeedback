//
//  AbstractFeedbackViewController.m
//  callmevip
//
//  Created by Oliver Michalak on 21.05.15.
//  Copyright (c) 2015 Oliver Michalak. All rights reserved.
//

#import "AbstractFeedbackViewController.h"
#import "FeedbackIconFont.h"
#import "UIView+DarkMode.h"

@interface AbstractFeedbackViewController ()

@end

@implementation AbstractFeedbackViewController

- (void)viewDidLoad {
	[super viewDidLoad];

	if (1 == self.navigationController.viewControllers.count)
		self.navigationItem.leftBarButtonItems = [UIBarButtonItem feedbackIconBarButtonItems:IFCross target:self action:@selector(close)];

	for (UIView *view in self.framedViews) {
		if ([self.feedbackConfig[@"darkMode"] boolValue])
			view.layer.borderColor = [UIColor colorWithWhite:0.2 alpha:1].CGColor;
		else
			view.layer.borderColor = [UIColor colorWithWhite:0.9 alpha:1.000].CGColor;
		view.layer.borderWidth = 1. / [UIScreen mainScreen].scale;
		view.tintColor = self.tabBarController.view.tintColor;	// propagate tintColor
	}
	if ([self.feedbackConfig[@"darkMode"] boolValue])
		[self.view setupDarkMode];
}

- (void) viewWillAppear:(BOOL)animated {
	[super viewWillAppear:animated];

	self.navigationItem.title = (1 == self.navigationController.viewControllers.count ? self.tabBarItem.title : self.navigationItem.title);
}

- (void)close {
	[self dismissViewControllerAnimated:YES completion:nil];
}

@end
