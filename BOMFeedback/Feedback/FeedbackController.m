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

@interface UIColor (StringColor)
+ (UIColor*)colorFromString:(NSString*)text;
@end

@implementation UIColor (StringColor)
+ (UIColor*)colorFromString:(NSString*)text {
	if ([text hasPrefix:@"#"] && 7 == text.length) {
		NSString *red = [text substringWithRange:NSMakeRange(1, 2)];
		NSString *green = [text substringWithRange:NSMakeRange(3, 2)];
		NSString *blue = [text substringWithRange:NSMakeRange(5, 2)];
		
		unsigned int r, g, b;
		[[NSScanner scannerWithString:red] scanHexInt:&r];
		[[NSScanner scannerWithString:green] scanHexInt:&g];
		[[NSScanner scannerWithString:blue] scanHexInt:&b];
		
		return [UIColor colorWithRed:(r & 0xFF) / 255.0f green:(g & 0xFF) / 255.0f blue:(b & 0xFF) / 255.0f alpha: 1.0f];
	}
	NSArray *colorList = [text componentsSeparatedByString:@","];
	if (3 == colorList.count) {
		float r, g, b;
		[[NSScanner scannerWithString:colorList[0]] scanFloat:&r];
		[[NSScanner scannerWithString:colorList[1]] scanFloat:&g];
		[[NSScanner scannerWithString:colorList[2]] scanFloat:&b];
		
		return [UIColor colorWithRed:r green:g blue:b alpha: 1.0f];
	}
	return nil;
}
@end

#pragma mark -

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
	
	UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Feedback" bundle:nil];
	NSMutableArray *viewControllers = [@[] mutableCopy];
	for (NSDictionary *moduleConfig in self.feedbackConfig[@"modules"]) {
		NSString *controllerName = [NSString stringWithFormat:@"%@FeedbackViewController", [moduleConfig[@"name"] capitalizedString]];
		AbstractFeedbackViewController *viewController = [storyboard instantiateViewControllerWithIdentifier:controllerName];
		if (viewController) {
			UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:viewController];
			if (feedbackConfig[@"navigationBarColor"]) {
				navigationController.navigationBar.barTintColor = [UIColor colorFromString:feedbackConfig[@"navigationBarColor"]];
				navigationController.navigationBar.translucent = NO;
			}
			if (self.view.darkModeEnabled) {
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
				[self updateFAQ:moduleConfig[@"faq"]];
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
		urlString = [urlString stringByAppendingFormat:@"?locale=%@&src=%@", [NSLocale currentLocale].localeIdentifier, [[NSBundle mainBundle].infoDictionary[@"CFBundleName"] stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]]];

//		[UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
		NSURLSessionDataTask *task = [NSURLSession.sharedSession dataTaskWithURL:[NSURL URLWithString:urlString] completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
//			[UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
			if (data) {
				[[NSFileManager defaultManager] removeItemAtPath:fileName error:nil];
				[data writeToFile:fileName atomically:YES];
			}
			self.isUpdatingFAQ = NO;
			[defaults setObject:[NSDate date] forKey:FeedbackFAQUpdate];
		}];
		[task resume];
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
