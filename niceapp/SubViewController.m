//
//  SubViewController.m
//  niceapp
//
//  Created by Oliver Michalak on 29.05.15.
//  Copyright (c) 2015 Oliver Michalak. All rights reserved.
//

#import "SubViewController.h"
#import "FeedbackController.h"

@implementation SubViewController

- (IBAction)hooray {
	FeedbackController *feedbackController = (FeedbackController*)self.tabBarController;
	[feedbackController presentModule:@"apps"];
}

- (IBAction)close {
	FeedbackController *feedbackController = (FeedbackController*)self.tabBarController;
	[feedbackController dismiss];
}

@end
