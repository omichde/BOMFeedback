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

@property (nonatomic) NSDictionary *feedbackConfig;
@property (assign, nonatomic) BOOL isUpdatingFAQ;
@end

@implementation FeedbackController

- (instancetype) init {
	if ((self = [super init])) {
		[self setup];
	}
	return self;
}

- (void) setup {
	self.feedbackConfig = [[NSDictionary alloc] initWithContentsOfFile: [[NSBundle mainBundle] pathForResource:@"Feedback" ofType:@"plist"]];
	if (!self.feedbackConfig) {
#ifdef DEBUG
		NSAssert(self.feedbackConfig, @"Feedback.plist missing");
#endif
		return;
	}
	NSMutableDictionary *feedbackConfig = [self.feedbackConfig mutableCopy];
	[feedbackConfig removeObjectForKey:@"modules"];
	
	if ([feedbackConfig[@"darkMode"] boolValue])
		[self.tabBar setupDarkMode];

	UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Feedback" bundle:nil];
	NSMutableArray *viewControllers = [@[] mutableCopy];
	for (NSDictionary *moduleConfig in self.feedbackConfig[@"modules"]) {
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

			// test/update FAQ list for contact module
			if ([moduleConfig[@"name"] isEqualToString:@"contact"]) {
				dispatch_async (dispatch_get_global_queue (DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
					[self updateFAQ:moduleConfig[@"faq"]];
				});
			}
		}
	}
	self.viewControllers = viewControllers;
	self.selectedIndex = 0;
}

- (void) updateFAQ:(NSDictionary*)config {
	if (config[@"file"] || !config[@"URL"])
		return;

	NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
	NSDate *updated = [defaults objectForKey:FeedbackFAQUpdate];
	NSNumber *limit = config[@"updateLimit"];
	NSDate *updatedLimit = [NSDate dateWithTimeIntervalSinceNow:-(60*60*24) * limit.integerValue];
	
	NSString *fileName = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES).firstObject stringByAppendingPathComponent:FeedbackFAQPList];
	NSArray *faqList = [NSArray arrayWithContentsOfFile:fileName];
	
	if (!self.isUpdatingFAQ &&
			(!faqList.count || !updated || NSOrderedAscending == [updated compare:updatedLimit])) {
		self.isUpdatingFAQ = YES;
	
		NSString *urlString = config[@"URL"];
		urlString = [urlString stringByAppendingFormat:@"?locale=%@&src=%@", [NSLocale currentLocale].localeIdentifier, [[NSBundle mainBundle].infoDictionary[@"CFBundleName"] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];

		NSURLRequest *urlRequest = [NSURLRequest requestWithURL:[NSURL URLWithString:urlString]];
		NSURLResponse *response;
		//				[UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
		NSData *urlData = [NSURLConnection sendSynchronousRequest:urlRequest returningResponse:&response error:nil];
		//				[UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
		if (urlData) {
			[[NSFileManager defaultManager] removeItemAtPath:fileName error:nil];
			[urlData writeToFile:fileName atomically:YES];
		}
		self.isUpdatingFAQ = NO;
		[defaults setObject:[NSDate date] forKey:FeedbackFAQUpdate];
	}
}

#pragma mark FeedbackControllerDelegate

- (void) dismiss {
	[self dismissViewControllerAnimated:YES completion:nil];
}

- (void) presentModule:(NSString *)name {
	NSUInteger pos = [self.viewControllers indexOfObjectPassingTest:^BOOL(UINavigationController *navigationController, NSUInteger idx, BOOL *stop) {
		AbstractFeedbackViewController *viewController = navigationController.viewControllers.firstObject;
		if ([viewController.moduleConfig[@"name"] isEqualToString:name]) {
			*stop = YES;
			return YES;
		}
		return NO;
	}];
	if (NSNotFound != pos) {
		UINavigationController *navigationController = self.viewControllers[pos];
		[navigationController popToRootViewControllerAnimated:NO];
		self.selectedViewController = navigationController;
	}
}

@end
