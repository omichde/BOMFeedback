//
//  AboutFeedbackViewController.m
//  callmevip
//
//  Created by Oliver Michalak on 21.05.15.
//  Copyright (c) 2015 Oliver Michalak. All rights reserved.
//

#import "AboutFeedbackViewController.h"
#import "FeedbackController.h"
#import <WebKit/WebKit.h>

@interface AboutFeedbackViewController ()

@property (weak, nonatomic) IBOutlet WKWebView *webView;

@end

@implementation AboutFeedbackViewController

- (instancetype) initWithCoder:(NSCoder *)aDecoder {
	self = [super initWithCoder:aDecoder];
	
	self.tabBarItem = [[UITabBarItem alloc] initWithTitle:FeedbackLocalizedString(@"About") image:[[UIImage feedbackIconTabBarImage:IFHead] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] selectedImage:[UIImage feedbackIconTabBarImage:IFHeadFilled]];
	
	return self;
}

- (void)viewDidLoad {
	[super viewDidLoad];

	NSString *fileName = self.moduleConfig[@"file"];
	NSString *extension = fileName.pathExtension;
	fileName = [fileName substringToIndex:fileName.length - (extension.length+1)];

	NSURL *url = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:fileName	ofType:extension]];
	[self.webView loadFileURL:url allowingReadAccessToURL:url];
}

@end
