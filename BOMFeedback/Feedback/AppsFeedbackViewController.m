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
#import "UIView+DarkMode.h"
#import <WebKit/WebKit.h>

@interface AppsFeedbackViewController ()

@property (weak, nonatomic) IBOutlet WKWebView *webView;

@end

@implementation AppsFeedbackViewController

- (instancetype) initWithCoder:(NSCoder *)aDecoder {
	self = [super initWithCoder:aDecoder];
	
	self.tabBarItem = [[UITabBarItem alloc] initWithTitle:FeedbackLocalizedString(@"APPs") image:[[UIImage feedbackIconTabBarImage:IFFactory] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] selectedImage:[UIImage feedbackIconTabBarImage:IFFactoryFilled]];
	
	return self;
}

- (void)viewDidLoad {
	[super viewDidLoad];

	NSString *urlString = self.moduleConfig[@"URL"];
	urlString = [urlString stringByAppendingFormat:@"?locale=%@&src=%@", [NSLocale currentLocale].localeIdentifier, [[NSBundle mainBundle].infoDictionary[@"CFBundleName"] stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]]];
	[self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:urlString]]];
}

@end
