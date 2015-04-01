//
//  NISTAppDelegate.h
//  PasswordTest
//
//  Created by Navneet Kumar on 3/30/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NISTUserEvent.h"

@class NISTParticipantViewController;
@class NISTReadyViewController;
@class NISTMemorizeViewController;
@class NISTVerifyViewController;
@class NISTTestViewController;
@class NISTRecallViewController;
@class NISTThankYouViewController;

typedef enum {
    NISTShiftAreaKey = 0,
    NISTKBSwitchKey = 1,
} NISTSpecialKeyType;


//#define kMaxNumberOfStrings 2
@interface NISTNavigationController : UINavigationController
   - (UIViewController *) popViewControllerAnimated:(BOOL)animated;
@end


@interface NISTAppDelegate : UIResponder <UIApplicationDelegate, UINavigationControllerDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) NISTNavigationController *navigationController;

@property (strong, nonatomic) NISTParticipantViewController *participantViewController;
@property (strong, nonatomic) NISTReadyViewController *readyViewController;
@property (strong, nonatomic) NISTMemorizeViewController *memorizeViewController;
@property (strong, nonatomic) NISTVerifyViewController *verifyViewController;
@property (strong, nonatomic) NISTTestViewController *testViewController;
@property (strong, nonatomic) NISTRecallViewController *recallViewController;
@property (strong, nonatomic) NISTThankYouViewController *thankYouViewController;

@property (strong, nonatomic) NSString *documentsDir;
@property (nonatomic) NSTimeInterval baseTimeStamp;
@property (strong, nonatomic) NSString *participantId;
@property (nonatomic) NSUInteger numberOfStrings;
@property (nonatomic) BOOL keyBoardVisible;
@property (nonatomic) BOOL numericKeyBoard;
@property (nonatomic) BOOL symbolLayer;
@property (nonatomic) CGPoint lastTouchLocation;

-(void) hideNavigationControllerBackButton;

// string accessors

-(NSString *) getStringMsg;
-(NSString *) getCurrentString;

// user action notifications from various views
-(void) userBeginsTest;
-(void) userChangedPhase: (NISTUserEvent *) event;
-(void) userEnteredData: (NISTUserEvent *) event;
-(void) userDoneWithCurrentString: (NSMutableArray *) entryPhaseStrings atTime:(NSTimeInterval) time;
-(void) userIsDoneRecallingStrings: (NSMutableArray *) recalledValues atTime:(NSTimeInterval) stamp;
-(void) userTappedNextForPhase: (NISTPhase) phase atTime: (NSTimeInterval) time withEnteredStrings: (NSMutableArray *) enteredStrings;
-(void) userTappedBackForPhase:(NISTPhase)phase atTime:(NSTimeInterval)time withEnteredStrings: (NSMutableArray *) enteredStrings;
-(void) userEnteredSpecialKey: (NISTSpecialKeyType) keyType atTime: (NSTimeInterval) time;
-(void) resetKeyboardState;

@end



