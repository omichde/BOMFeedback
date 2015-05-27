//
//  FeedbackIconFont.h
//  callmevip
//
//  Created by Oliver Michalak on 22.05.15.
//  Copyright (c) 2015 Oliver Michalak. All rights reserved.
//

#import <UIKit/UIKit.h>

extern NSString *const IFPen;
extern NSString *const IFSearch;
extern NSString *const IFPlus;
extern NSString *const IFMinus;
extern NSString *const IFCross;
extern NSString *const IFArrowRight;
extern NSString *const IFArrowLeft;
extern NSString *const IFArrowRightGrowing;

extern NSString *const IFHeartFilled;
extern NSString *const IFHeart;
extern NSString *const IFStarFilled;
extern NSString *const IFStar;
extern NSString *const IFSmilyProblem;
extern NSString *const IFHeadFilled;
extern NSString *const IFHead;
extern NSString *const IFMailFilled;
extern NSString *const IFMail;
extern NSString *const IFFactoryFilled;
extern NSString *const IFFactory;
extern NSString *const IFModulesFilled;
extern NSString *const IFModules;
extern NSString *const IFBubbleFilled;
extern NSString *const IFBubble;
extern NSString *const IFClipFilled;
extern NSString *const IFClip;
extern NSString *const IFBookFilled;
extern NSString *const IFBook;

extern NSString *const IFPuzzleFilled;
extern NSString *const IFBookFilled;
extern NSString *const IFGear;

extern NSString *const IFTwitter;
extern NSString *const IFFacebook;
extern NSString *const IFShare;

extern CGFloat const IFBarButtonIconFontSize;

@interface UIFont (FeedbackIconFont)

+ (UIFont*) feedbackIconFont;
+ (UIFont*) feedbackIconFontWithSize:(CGFloat)size;

@end

@interface UIButton (FeedbackIconFont)

+ (UIButton*) feedbackIconButton:(NSString*)token;
+ (UIButton*) feedbackIconButton:(NSString*)token target:(id)target action:(SEL)action;
+ (UIButton*) feedbackIconButton:(NSString*)token fontSize:(CGFloat)fontSize target:(id)target action:(SEL)action;

- (void) feedbackSetIcon:(NSString*)token;
- (void) feedbackSetIcon:(NSString*)token fontSize:(CGFloat)fontSize;

- (void) feedbackPrependTextWithIcon:(NSString*)token color:(UIColor*)color;

@end

@interface UIBarButtonItem (FeedbackIconFont)

+ (UIBarButtonItem*) feedbackIconBarButtonItem:(NSString*) token target:(id)target action:(SEL)action;
+ (NSArray*) feedbackIconBarButtonItems:(NSString*) token target:(id)target action:(SEL)action;

- (void) feedbackSetIcon:(NSString*)token;
- (void) feedbackSetIcon:(NSString*)token forState:(UIControlState) state;

+ (UIBarButtonItem*) feedbackSpaceBarButtonItemWithWidth:(CGFloat)width;
+ (UIBarButtonItem*) feedbackSpaceBarButtonItem;

@end

@interface UIImage (FeedbackIconFont)

+ (UIImage*) feedbackIconTabBarImage:(NSString*)token;
+ (UIImage*) feedbackIconImage:(NSString*)token fontSize:(CGFloat)fontSize fontColor:(UIColor*) fontColor forSize:(CGSize)boxSize;

@end
