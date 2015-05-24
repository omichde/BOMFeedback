//
//  AboutFeedbackViewController.m
//  callmevip
//
//  Created by Oliver Michalak on 21.05.15.
//  Copyright (c) 2015 Oliver Michalak. All rights reserved.
//

#import "AboutFeedbackViewController.h"
#import "FeedbackController.h"

@interface AboutFeedbackViewController ()

@property (weak, nonatomic) IBOutlet UIWebView *webView;

@end

@implementation AboutFeedbackViewController

- (instancetype) initWithCoder:(NSCoder *)aDecoder {
	self = [super initWithCoder:aDecoder];
	
	self.tabBarItem = [[UITabBarItem alloc] initWithTitle:FeedbackLocalizedString(@"About") image:[[UIImage feedbackIconTabBarImage:IFHead] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] selectedImage:[UIImage feedbackIconTabBarImage:IFHeadFilled]];
	
	return self;
}

- (void)viewDidLoad {
	[super viewDidLoad];

	[self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"about" ofType:@"html"]]]];
}

@end
