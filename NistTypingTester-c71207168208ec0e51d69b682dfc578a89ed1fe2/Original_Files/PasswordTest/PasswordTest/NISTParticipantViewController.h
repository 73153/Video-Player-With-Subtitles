//
//  NISTMasterViewController.h
//  PasswordTest
//
//  Created by Navneet Kumar on 3/30/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

#define kMaxParticipantIDLength 12

@interface NISTParticipantViewController : UIViewController<UITextFieldDelegate>

// properties
@property (strong, nonatomic) IBOutlet UIButton *beginButton;
@property (strong, nonatomic) IBOutlet UITextField *participantNumber;

@property (strong, nonatomic) NISTAppDelegate *appDel;
@property (strong, nonatomic) UIBarButtonItem *nextButton;

// IBActions
- (IBAction) backgroundTapped: (id) sender;
- (IBAction)beginButtonHandler:(id)sender;


@end

