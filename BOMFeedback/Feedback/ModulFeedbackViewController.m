//
//  ModulFeedbackViewController.m
//  callmevip
//
//  Created by Oliver Michalak on 24.05.15.
//  Copyright (c) 2015 Oliver Michalak. All rights reserved.
//

#import "ModulFeedbackViewController.h"
#import <WebKit/WebKit.h>

@interface ModulFeedbackViewController ()

@property (weak, nonatomic) IBOutlet WKWebView *webView;

@end

@implementation ModulFeedbackViewController

- (void)viewDidLoad {
	[super viewDidLoad];

	[self.webView loadFileURL:self.url allowingReadAccessToURL: self.url];
}

@end
