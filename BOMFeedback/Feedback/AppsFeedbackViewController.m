//
//  AppsFeedbackViewController.m
//  callmevip
//
//  Created by Oliver Michalak on 21.05.15.
//  Copyright (c) 2015 Oliver Michalak. All rights reserved.
//

#import "AppsFeedbackViewController.h"
#import "FeedbackController.h"
#import "FeedbackIconFont.h"

@interface AppsFeedbackViewController () <UIWebViewDelegate>

@property (weak, nonatomic) IBOutlet UIWebView *webView;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *busyView;

@end

@implementation AppsFeedbackViewController

- (instancetype) initWithCoder:(NSCoder *)aDecoder {
	self = [super initWithCoder:aDecoder];
	
	self.tabBarItem = [[UITabBarItem alloc] initWithTitle:FeedbackLocalizedString(@"APPs") image:[[UIImage feedbackIconTabBarImage:IFFactory] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] selectedImage:[UIImage feedbackIconTabBarImage:IFFactoryFilled]];
	
	return self;
}

- (void)viewDidLoad {
	[super viewDidLoad];

	if ([self.feedbackConfig[@"darkMode"] boolValue])
		self.busyView.activityIndicatorViewStyle = UIActivityIndicatorViewStyleWhite;

	NSString *urlString = self.moduleConfig[@"URL"];
	urlString = [urlString stringByAppendingFormat:@"?locale=%@&src=%@", [NSLocale currentLocale].localeIdentifier, [[NSBundle mainBundle].infoDictionary[@"CFBundleName"] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
	[self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:urlString]]];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
	[self.busyView stopAnimating];
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
	[self.busyView stopAnimating];
}

@end
