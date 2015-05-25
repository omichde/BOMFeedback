//
//  LikeFeedbackViewController.m
//  callmevip
//
//  Created by Oliver Michalak on 22.05.15.
//  Copyright (c) 2015 Oliver Michalak. All rights reserved.
//

#import "LikeFeedbackViewController.h"
#import <MessageUI/MessageUI.h>
#import <MessageUI/MFMailComposeViewController.h>
#import <Social/Social.h>
#import "FeedbackController.h"

@interface LikeFeedbackViewController () <MFMailComposeViewControllerDelegate>

@property (weak, nonatomic) IBOutlet UIButton *rateButton;
@property (weak, nonatomic) IBOutlet UIButton *emailButton;
@property (weak, nonatomic) IBOutlet UIButton *twitterButton;
@property (weak, nonatomic) IBOutlet UIButton *facebookButton;
@property (nonatomic) NSDictionary *config;

@end

@implementation LikeFeedbackViewController

- (void)viewDidLoad {
	[super viewDidLoad];

	self.config = [[NSDictionary alloc] initWithContentsOfFile: [[NSBundle mainBundle] pathForResource:@"Feedback" ofType:@"plist"]];
	[self.rateButton feedbackPrependTextWithIcon:IFStarFilled color:[UIColor redColor]];
	[self.emailButton feedbackPrependTextWithIcon:IFMailFilled color:[UIColor lightGrayColor]];
	[self.twitterButton feedbackPrependTextWithIcon:IFTwitter color:[UIColor colorWithRed:0.000 green:0.502 blue:1.000 alpha:1.000]];
	[self.facebookButton feedbackPrependTextWithIcon:IFFacebook color:[UIColor colorWithRed:0.176 green:0.267 blue:0.525 alpha:1.000]];
}

- (IBAction) appRank {
	NSURL *url;
	float iOSVersion = [UIDevice currentDevice].systemVersion.floatValue;
	if (iOSVersion >= 7. && iOSVersion < 7.1)
		url = [NSURL URLWithString:[NSString stringWithFormat:@"itms-apps://itunes.apple.com/app/id%@", self.config[@"APPId"]]];
	else
		url = [NSURL URLWithString:[NSString stringWithFormat:@"itms-apps://itunes.apple.com/WebObjects/MZStore.woa/wa/viewContentsUserReviews?type=Purple+Software&id=%@", self.config[@"APPId"]]];
	[[UIApplication sharedApplication] openURL: url];
}

- (IBAction) email {
	if ([MFMailComposeViewController canSendMail]) {
		MFMailComposeViewController *emailPicker = [[MFMailComposeViewController alloc] init];
		emailPicker.navigationBar.tintColor = self.view.tintColor;
		emailPicker.mailComposeDelegate = self;
		emailPicker.subject =  FeedbackLocalizedString(@"Email-Subject");
		[emailPicker setMessageBody: FeedbackLocalizedString(@"Email-Text") isHTML:NO];
		[self presentViewController:emailPicker animated:YES completion:nil];
	}
}

- (void) mailComposeController: (MFMailComposeViewController*) controller didFinishWithResult:(MFMailComposeResult) result error:(NSError*) error {
	[controller dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction) twitter {
	NSString *message = FeedbackLocalizedString(@"Twitter-Text");
	
	if ([SLComposeViewController isAvailableForServiceType:SLServiceTypeTwitter]) {
		SLComposeViewController *viewController = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeTwitter];
		[viewController setInitialText: message];
		[self presentViewController:viewController animated:YES completion:nil];
	}
	else {
		NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"twitterrific:///post?message=%@", [message stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]]];
		if ([[UIApplication sharedApplication] canOpenURL:url])
			[[UIApplication sharedApplication] openURL:url];
		else {
			url = [NSURL URLWithString:[NSString stringWithFormat:@"tweetbot:///post?text=%@", [message stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]]];
			if ([[UIApplication sharedApplication] canOpenURL:url])
				[[UIApplication sharedApplication] openURL:url];
			else {
				url = [NSURL URLWithString:[NSString stringWithFormat:@"twitter:///post?text=%@", [message stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]]];
				if ([[UIApplication sharedApplication] canOpenURL:url])
					[[UIApplication sharedApplication] openURL:url];
				else {
					url = [NSURL URLWithString:[NSString stringWithFormat:@"http://twitter.com/home?status=%@", [message stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]]];
					[[UIApplication sharedApplication] openURL:url];
				}
			}
		}
	}
}

- (IBAction) facebook {
	NSString *message = FeedbackLocalizedString(@"Facebook-Text");
	
	if ([SLComposeViewController isAvailableForServiceType:SLServiceTypeFacebook]) {
		SLComposeViewController *socialViewController = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeFacebook];
		socialViewController.initialText = message;
		[self presentViewController:socialViewController animated:YES completion:nil];
	}
	else {
		[[UIApplication sharedApplication] openURL: [NSURL URLWithString:[NSString stringWithFormat:@"https://m.facebook.com/sharer.php?u=%@", [message stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]]]];
	}
}

@end
