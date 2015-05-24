//
//  ModulesFeedbackViewController.m
//  callmevip
//
//  Created by Oliver Michalak on 21.05.15.
//  Copyright (c) 2015 Oliver Michalak. All rights reserved.
//

#import "ModulesFeedbackViewController.h"
#import "ModulFeedbackViewController.h"
#import "FeedbackController.h"

@interface ModulesFeedbackViewController () <UITableViewDataSource, UITableViewDelegate>

@end

@implementation ModulesFeedbackViewController

- (instancetype) initWithCoder:(NSCoder *)aDecoder {
	self = [super initWithCoder:aDecoder];
	
	self.tabBarItem = [[UITabBarItem alloc] initWithTitle:FeedbackLocalizedString(@"Modules") image:[[UIImage feedbackIconTabBarImage:IFModules] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] selectedImage:[UIImage feedbackIconTabBarImage:IFModulesFilled]];

	return self;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	return ((NSArray*)self.setupDict[@"files"]).count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ModulesCell"];
	if (!cell)
		cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"ModulesCell"];

	NSString *fileName = ((NSArray*)self.setupDict[@"files"])[indexPath.row];
	fileName = [fileName substringToIndex:fileName.length - (fileName.pathExtension.length+1)];
	cell.textLabel.text = fileName;

	return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	[tableView deselectRowAtIndexPath:indexPath animated:YES];
	NSString *fileName = ((NSArray*)self.setupDict[@"files"])[indexPath.row];
	NSString *fileExtension = fileName.pathExtension;
	fileName = [fileName substringToIndex:fileName.length - (fileName.pathExtension.length+1)];
	NSString *filePath = [[NSBundle mainBundle] pathForResource:fileName ofType:fileExtension];

	if (filePath) {
		ModulFeedbackViewController *modulViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"ModulFeedbackViewController"];
		modulViewController.url = [NSURL fileURLWithPath:filePath];
		[self.navigationController pushViewController:modulViewController animated:YES];
	}
	else {
#ifdef DEBUG
		NSAssert (filePath, @"Cannot find %@.%@", fileName, fileExtension);
#endif
	}
}

@end
