//
//  ViewController.m
//  niceapp
//
//  Created by Oliver Michalak on 24.05.15.
//  Copyright (c) 2015 Oliver Michalak. All rights reserved.
//

#import "ViewController.h"
#import "FeedbackController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
	[super viewDidLoad];
}

- (IBAction)openFeedback {
	FeedbackController *feedbackController = [[FeedbackController alloc] init];
	feedbackController.modalPresentationStyle = (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad ? UIModalPresentationFormSheet : UIModalPresentationFullScreen);
	[self presentViewController:feedbackController animated:YES completion:nil];
}

@end
