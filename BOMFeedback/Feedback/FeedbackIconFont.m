//
//  FeedbackIconFont.m
//  callmevip
//
//  Created by Oliver Michalak on 22.05.15.
//  Copyright (c) 2015 Oliver Michalak. All rights reserved.
//

#import "FeedbackIconFont.h"
#import <CoreText/CoreText.h>

NSString *const IFPen = @"\uf000";
NSString *const IFSearch = @"\uf001";
NSString *const IFPlus = @"\uf002";
NSString *const IFMinus = @"\uf003";
NSString *const IFCross = @"\uf004";
NSString *const IFArrowRight = @"\uf005";
NSString *const IFArrowLeft = @"\uf006";
NSString *const IFArrowRightGrowing = @"\uf007";

NSString *const IFHeartFilled = @"\uf008";
NSString *const IFHeart = @"\uf009";
NSString *const IFStarFilled = @"\uf00b";
NSString *const IFStar = @"\uf00c";
NSString *const IFHeadFilled = @"\uf00d";
NSString *const IFHead = @"\uf00e";
NSString *const IFMailFilled = @"\uf00f";
NSString *const IFMail = @"\uf010";
NSString *const IFFactoryFilled = @"\uf012";
NSString *const IFFactory = @"\uf013";
NSString *const IFModulesFilled = @"\uf017";
NSString *const IFModules = @"\uf018";
NSString *const IFBubbleFilled = @"\uf019";
NSString *const IFBubble = @"\uf01a";
NSString *const IFClipFilled = @"\uf01b";
NSString *const IFClip = @"\uf01c";
NSString *const IFBookFilled = @"\uf01d";
NSString *const IFBook = @"\uf01e";

NSString *const IFSmilyProblem = @"\uf00a";
NSString *const IFPuzzleFilled = @"\uf011";
NSString *const IFGear = @"\uf01f";

NSString *const IFTwitter = @"\uf014";
NSString *const IFFacebook = @"\uf015";
NSString *const IFShare = @"\uf016";

CGFloat const IFBarButtonIconFontSize = 20.;

#define kFeedbackDefaultFontSize (15.)

@implementation UIFont (FeedbackIconFont)

+ (UIFont*) feedbackIconFontWithSize:(CGFloat)size {
	UIFont *font = [UIFont fontWithName:@"Feedback" size:size];
	if (!font) {
		NSURL *fontURL = [[NSBundle mainBundle] URLForResource:@"Feedback-Regular" withExtension:@"otf"];
		if (fontURL) {
			CFErrorRef error = NULL;
			CTFontManagerRegisterFontsForURL((__bridge CFURLRef)fontURL, kCTFontManagerScopeProcess, &error);
		}
		font = [UIFont fontWithName:@"Feedback" size:size];
	}
	
	return font;
}

+ (UIFont*) feedbackIconFont {
	return [self feedbackIconFontWithSize:kFeedbackDefaultFontSize];
}

@end

@implementation UIButton (FeedbackIconFont)

+ (UIButton*) feedbackIconButton:(NSString*)token {
	return [self feedbackIconButton:token target:nil action:nil];
}

+ (UIButton*) feedbackIconButton:(NSString*)token target:(id)target action:(SEL)action {
	return [self feedbackIconButton:token fontSize:kFeedbackDefaultFontSize target:target action:action];
}

+ (UIButton*) feedbackIconButton:(NSString*)token fontSize:(CGFloat)fontSize target:(id)target action:(SEL)action {
	UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
	[button feedbackSetIcon:token fontSize:fontSize];
	
	if (target && action) {
		[button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
	}
	return button;
}

- (void) feedbackSetIcon:(NSString*)token {
	NSRange range = NSMakeRange(0, 1);
	NSDictionary *attributes = [self.currentAttributedTitle attributesAtIndex:0 effectiveRange:&range];
	UIFont *font = attributes[NSFontAttributeName];
	[self feedbackSetIcon:token fontSize:(font ? font.pointSize : kFeedbackDefaultFontSize)];
}

- (void) feedbackSetIcon:(NSString*)token fontSize:(CGFloat)fontSize {
	self.titleLabel.font = [UIFont feedbackIconFontWithSize:fontSize];
	[self setTitle:token forState:UIControlStateNormal];
	[self sizeToFit];
}

- (void) feedbackPrependTextWithIcon:(NSString*)token color:(UIColor*)color {
	CGFloat fontSize = self.titleLabel.font.pointSize;
	NSAttributedString *buttonText = [[NSAttributedString alloc] initWithString:self.currentTitle attributes:@{NSFontAttributeName: self.titleLabel.font, NSForegroundColorAttributeName: self.currentTitleColor}];
	
	NSMutableAttributedString *text = [[NSMutableAttributedString alloc] initWithString:token attributes:@{NSFontAttributeName: [UIFont feedbackIconFontWithSize:fontSize], NSForegroundColorAttributeName:color}];
	[text appendAttributedString:[[NSAttributedString alloc] initWithString:@"  " attributes:@{}]];
	[text appendAttributedString:buttonText];
	[self setAttributedTitle:text forState:UIControlStateNormal];
}

@end

@implementation UIBarButtonItem (FeedbackIconFont)

+ (UIBarButtonItem*) feedbackIconBarButtonItem:(NSString*) token target:(id)target action:(SEL)action {
	UIButton *button = [UIButton feedbackIconButton:token fontSize:IFBarButtonIconFontSize target:target action:action];
	return [[UIBarButtonItem alloc] initWithCustomView:button];
}

+ (NSArray*) feedbackIconBarButtonItems:(NSString*) token target:(id)target action:(SEL)action {
	return @[[UIBarButtonItem feedbackSpaceBarButtonItem], [UIBarButtonItem feedbackIconBarButtonItem:token target:target action:action]];
}

- (void) feedbackSetIcon:(NSString*)token {
	[self feedbackSetIcon:token forState:UIControlStateNormal];
}

- (void) feedbackSetIcon:(NSString*)token forState:(UIControlState) state {
	UIButton *nestedButton = (UIButton*)self.customView;
	[nestedButton feedbackSetIcon:token fontSize:kFeedbackDefaultFontSize];
}

+ (UIBarButtonItem*) feedbackSpaceBarButtonItemWithWidth:(CGFloat)width {
	UIBarButtonItem *spaceFix = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:NULL];
	spaceFix.width = width;
	return spaceFix;
}

+ (UIBarButtonItem*) feedbackSpaceBarButtonItem {
	UIBarButtonItem *spaceFix = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:NULL];
	spaceFix.width = -12;
	return spaceFix;
}

@end

@implementation UIImage (FeedbackIconFont)

+ (UIImage*) feedbackIconTabBarImage:(NSString*)token {
	return [self feedbackIconImage:token fontSize:27 fontColor:[UIColor grayColor] forSize:CGSizeMake(30, 30)];
}

+ (UIImage*) feedbackIconImage:(NSString*)token fontSize:(CGFloat)fontSize fontColor:(UIColor*)fontColor forSize:(CGSize)boxSize {
	NSAttributedString *attributedToken = [[NSAttributedString alloc] initWithString:token attributes:@{NSFontAttributeName: [UIFont feedbackIconFontWithSize:fontSize], NSForegroundColorAttributeName: fontColor}];
	CGSize size = [attributedToken size];
	
	UIGraphicsBeginImageContextWithOptions(boxSize, NO, 0.0);
	CGRect tokenRect = CGRectMake((boxSize.width - size.width)/2., (boxSize.height - size.height)/2., size.width, size.height);
	[attributedToken drawInRect:tokenRect];
	UIImage *result = UIGraphicsGetImageFromCurrentImageContext();
	UIGraphicsEndImageContext();
	
	return result;
}

@end

