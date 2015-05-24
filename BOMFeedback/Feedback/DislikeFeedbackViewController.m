//
//  DislikeFeedbackViewController.m
//  callmevip
//
//  Created by Oliver Michalak on 22.05.15.
//  Copyright (c) 2015 Oliver Michalak. All rights reserved.
//

#import "DislikeFeedbackViewController.h"
#import <MessageUI/MessageUI.h>
#import <MessageUI/MFMailComposeViewController.h>
#import "FeedbackController.h"

@interface DislikeFeedbackViewController () <MFMailComposeViewControllerDelegate, UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UIButton *emailButton;
@property (assign, nonatomic) NSInteger currentRow;
@property (strong, nonatomic) NSArray *faqList;
@property (nonatomic) NSDictionary *config;

@end

@implementation DislikeFeedbackViewController

- (void)viewDidLoad {
	[super viewDidLoad];

	self.config = [[NSDictionary alloc] initWithContentsOfFile: [[NSBundle mainBundle] pathForResource:@"Feedback" ofType:@"plist"]];
	self.faqList = [[NSArray alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"FeedbackFAQ" ofType:@"plist"]];

	self.currentRow = -1;
	[self.emailButton setTitle:self.setupDict[@"email"] forState:UIControlStateNormal];
}

- (IBAction) email {
	MFMailComposeViewController *emailPicker = [[MFMailComposeViewController alloc] init];
	emailPicker.navigationBar.tintColor = self.view.tintColor;
	emailPicker.mailComposeDelegate = self;
	[emailPicker setToRecipients:@[self.setupDict[@"email"]]];
	emailPicker.subject = FeedbackLocalizedString(@"Report-Subject");
	[emailPicker setMessageBody:[NSString stringWithFormat:FeedbackLocalizedString(@"Report-Template"), self.config[@"ITMSURL"], [[NSBundle mainBundle] infoDictionary][@"CFBundleShortVersionString"], [[NSLocale currentLocale] localeIdentifier], [[UIDevice currentDevice] localizedModel], [[UIDevice currentDevice] systemVersion]] isHTML:NO];
	[self presentViewController:emailPicker animated:YES completion:nil];
}

- (void) mailComposeController: (MFMailComposeViewController*) controller didFinishWithResult:(MFMailComposeResult) result error:(NSError*) error {
	[controller dismissViewControllerAnimated:YES completion:^{
		[self.navigationController popViewControllerAnimated:YES];
	}];
}

#pragma mark FAQ Table View

- (NSInteger) tableView:(UITableView*) tableView numberOfRowsInSection:(NSInteger) section {
	return self.faqList.count + (self.currentRow >= 0 ? 1 : 0);
}

- (NSDictionary*) entryForIndexPath:(NSIndexPath*) indexPath {
	if (self.currentRow < 0)
		return self.faqList[indexPath.row];
	else {
		if (indexPath.row <= self.currentRow)
			return self.faqList[indexPath.row];
		else
			return self.faqList [indexPath.row-1];
	}
}

- (CGFloat) tableView:(UITableView*) tableView heightForRowAtIndexPath:(NSIndexPath*) indexPath {
	NSString *text;
	if (self.currentRow < 0)
		text = self.faqList[indexPath.row][@"question"];
	else {
		if (indexPath.row <= self.currentRow)
			text = self.faqList[indexPath.row][@"question"];
		else if (indexPath.row == self.currentRow+1)
			text = self.faqList[indexPath.row-1][@"answer"];
		else
			text = self.faqList[indexPath.row-1][@"question"];
	}
	CGFloat height = ceil([text boundingRectWithSize:CGSizeMake(CGRectGetWidth(self.view.frame) - 32., FLT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:[UIFont systemFontSize]]} context:nil].size.height);
	return height + 20.;
}

- (UITableViewCell*) tableView:(UITableView*) tableView cellForRowAtIndexPath:(NSIndexPath*) indexPath {
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"FAQCell"];
	if (!cell) {
		cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"FAQCell"];
		cell.textLabel.numberOfLines = 0;
		cell.textLabel.lineBreakMode = NSLineBreakByWordWrapping;
		cell.textLabel.font = [UIFont systemFontOfSize:[UIFont systemFontSize]];
	}

	cell.userInteractionEnabled = YES;
	if (self.currentRow < 0)
		cell.textLabel.text = [self entryForIndexPath:indexPath][@"question"];
	else {
		if (indexPath.row == self.currentRow+1) {
			cell.userInteractionEnabled = NO;
			cell.textLabel.text = [self entryForIndexPath:indexPath][@"answer"];
		}
		else
			cell.textLabel.text = [self entryForIndexPath:indexPath][@"question"];
	}
	return cell;
}

- (void) tableView:(UITableView*) tableView willDisplayCell:(UITableViewCell*) cell forRowAtIndexPath:(NSIndexPath*) indexPath {
	if (self.currentRow >= 0 && indexPath.row == self.currentRow+1)
		cell.backgroundColor = [UIColor whiteColor];
	else
		cell.backgroundColor = [UIColor colorWithWhite:0.9 alpha:1.];
}

- (void) tableView:(UITableView*) tableView didSelectRowAtIndexPath:(NSIndexPath*) indexPath {
	[tableView beginUpdates];
	if (self.currentRow >= 0 && indexPath.row != self.currentRow) {
		[tableView deleteRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:self.currentRow+1 inSection:0]] withRowAnimation:UITableViewRowAnimationTop];
		self.currentRow = (indexPath.row < self.currentRow ? indexPath.row : indexPath.row-1);
		[tableView insertRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:self.currentRow+1 inSection:0]] withRowAnimation:UITableViewRowAnimationTop];
	}
	else if (self.currentRow >= 0) {
		[tableView deleteRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:self.currentRow+1 inSection:0]] withRowAnimation:UITableViewRowAnimationTop];
		[tableView deselectRowAtIndexPath:indexPath animated:YES];
		self.currentRow = -1;
	}
	else {
		self.currentRow = indexPath.row;
		[tableView insertRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:self.currentRow+1 inSection:0]] withRowAnimation:UITableViewRowAnimationTop];
	}
	[tableView endUpdates];
}

@end
