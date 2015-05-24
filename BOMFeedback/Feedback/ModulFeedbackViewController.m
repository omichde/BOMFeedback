//
//  ModulFeedbackViewController.m
//  callmevip
//
//  Created by Oliver Michalak on 24.05.15.
//  Copyright (c) 2015 Oliver Michalak. All rights reserved.
//

#import "ModulFeedbackViewController.h"

@interface ModulFeedbackViewController ()

@property (weak, nonatomic) IBOutlet UIWebView *webView;

@end

@implementation ModulFeedbackViewController

- (void)viewDidLoad {
	[super viewDidLoad];

	[self.webView loadRequest:[NSURLRequest requestWithURL:self.url]];
}

@end
