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
#import <SpriteKit/SpriteKit.h>
#import "FeedbackController.h"
#import "UIView+DarkMode.h"

@interface LikeFeedbackViewController () <MFMailComposeViewControllerDelegate>

@property (weak, nonatomic) IBOutlet SKView *thanksView;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *servicesButtons;
@property (strong, nonatomic) IBOutletCollection(NSLayoutConstraint) NSArray *servicesConstraints;

@end

@implementation LikeFeedbackViewController

- (void)viewDidLoad {
	[super viewDidLoad];

	[self.servicesButtons[0] feedbackPrependTextWithIcon:IFStarFilled color:[UIColor redColor]];
	[self.servicesButtons[1] feedbackPrependTextWithIcon:IFMailFilled color:[UIColor lightGrayColor]];
	[self.servicesButtons[2] feedbackPrependTextWithIcon:IFTwitter color:[UIColor colorWithRed:0.000 green:0.502 blue:1.000 alpha:1.000]];
	[self.servicesButtons[3] feedbackPrependTextWithIcon:IFFacebook color:[UIColor colorWithRed:0.176 green:0.267 blue:0.525 alpha:1.000]];

	if (self.moduleConfig[@"services"]) {
		NSArray *services = [self.moduleConfig[@"services"] componentsSeparatedByString:@","];
		NSArray *tokens = @[@"store", @"email", @"twitter", @"facebook"];
		CGFloat __block pos = ((NSLayoutConstraint*)self.servicesConstraints[0]).constant;
		[tokens enumerateObjectsUsingBlock:^(NSString *token, NSUInteger idx, BOOL *stop) {
			if ([services containsObject:token]) {
				((NSLayoutConstraint*)self.servicesConstraints[idx]).constant = pos;
				pos += 50;
			}
			else
				((UIButton*)self.servicesButtons[idx]).hidden = YES;
		}];
	}

	// just for the fun of it...
	SKEmitterNode *starNode = [SKEmitterNode nodeWithFileNamed:@"FeedbackStar"];
	starNode.particleTexture = [SKTexture textureWithImage:[UIImage feedbackIconImage:IFStarFilled fontSize:50 fontColor:[UIColor whiteColor] forSize:CGSizeMake(50, 50)]];
	starNode.position = CGPointMake(CGRectGetMidX(self.thanksView.bounds), CGRectGetMaxY(self.thanksView.bounds) * 0.3);
	starNode.particlePositionRange = CGVectorMake(CGRectGetWidth(self.thanksView.bounds) * 0.6, 10);
	SKScene *scene = [SKScene sceneWithSize:self.thanksView.bounds.size];
	scene.backgroundColor = [UIColor colorWithWhite:0.95 alpha:1.000];
	if ([self.feedbackConfig[@"darkMode"] boolValue])
		scene.backgroundColor = [scene.backgroundColor darkModeBackColor];

	scene.scaleMode = SKSceneScaleModeAspectFit;
	[scene addChild: starNode];
	[self.thanksView presentScene:scene];
}

- (IBAction) appRank {
	NSURL *url;
	float iOSVersion = [UIDevice currentDevice].systemVersion.floatValue;
	if (iOSVersion >= 7. && iOSVersion < 7.1)
		url = [NSURL URLWithString:[NSString stringWithFormat:@"itms-apps://itunes.apple.com/app/id%@", self.feedbackConfig[@"APPId"]]];
	else
		url = [NSURL URLWithString:[NSString stringWithFormat:@"itms-apps://itunes.apple.com/WebObjects/MZStore.woa/wa/viewContentsUserReviews?type=Purple+Software&id=%@", self.feedbackConfig[@"APPId"]]];
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
