//
//  ContactFeedbackViewController.m
//  callmevip
//
//  Created by Oliver Michalak on 21.05.15.
//  Copyright (c) 2015 Oliver Michalak. All rights reserved.
//

#import "ContactFeedbackViewController.h"
#import "FeedbackController.h"
#import "FeedbackIconFont.h"

@interface ContactFeedbackViewController ()

@property (weak, nonatomic) IBOutlet UIButton *likeButton;
@property (weak, nonatomic) IBOutlet UIButton *dislikeButton;

@end

@implementation ContactFeedbackViewController

- (instancetype) initWithCoder:(NSCoder *)aDecoder {
	self = [super initWithCoder:aDecoder];
	
	self.tabBarItem = [[UITabBarItem alloc] initWithTitle:FeedbackLocalizedString(@"Contact") image:[[UIImage feedbackIconTabBarImage:IFBubble] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] selectedImage:[UIImage feedbackIconTabBarImage:IFBubbleFilled]];
	
	return self;
}

- (void) viewDidLoad {
	[super viewDidLoad];

	[self.likeButton feedbackPrependTextWithIcon:IFHeartFilled color:[UIColor redColor]];
	[self.dislikeButton feedbackPrependTextWithIcon:IFBubbleFilled color:[UIColor colorWithRed:0.000 green:0.000 blue:0.5 alpha:1.000]];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
	AbstractFeedbackViewController *feedbackViewController = segue.destinationViewController;
	feedbackViewController.feedbackConfig = self.feedbackConfig;
	feedbackViewController.moduleConfig = self.moduleConfig;
}

@end
