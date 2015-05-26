//
//  FeedbackThanks.m
//  niceapp
//
//  Created by Oliver Michalak on 26.05.15.
//  Copyright (c) 2015 Oliver Michalak. All rights reserved.
//

#import "FeedbackThanks.h"

@interface FeedbackThanks ()

@property (nonatomic) SKEmitterNode *sprites;

@end

@implementation FeedbackThanks

-(id)initWithSize:(CGSize)size {
	if (self = [super initWithSize:size]) {
		self.backgroundColor = [SKColor colorWithWhite:0.948 alpha:1.000];
		NSString *emitterPath = [[NSBundle mainBundle] pathForResource:@"FeedbackThanks" ofType:@"sks"];
		self.sprites = [NSKeyedUnarchiver unarchiveObjectWithFile:emitterPath];
		self.sprites.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMaxY(self.frame) * 0.3);
		self.sprites.targetNode = self.scene;
		self.sprites.particlePositionRange = CGVectorMake(CGRectGetWidth(self.frame) * 0.8, 0);
		[self addChild:self.sprites];
	}
	return self;
}

@end
