//
//  AbstractFeedbackViewController.h
//  callmevip
//
//  Created by Oliver Michalak on 21.05.15.
//  Copyright (c) 2015 Oliver Michalak. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AbstractFeedbackViewController : UIViewController

@property (nonatomic) NSDictionary *setupDict;
@property (nonatomic) IBOutletCollection(UIButton) NSArray *framedViews;

@end
