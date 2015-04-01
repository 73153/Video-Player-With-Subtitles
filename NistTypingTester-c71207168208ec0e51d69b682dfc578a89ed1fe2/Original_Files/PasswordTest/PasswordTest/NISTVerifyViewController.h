//
//  NISTVerifyViewController.h
//  PasswordTest
//
//  Created by Navneet Kumar on 4/2/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NISTAppDelegate.h"

@interface NISTVerifyViewController : UIViewController<UITextFieldDelegate>

@property (strong, nonatomic) IBOutlet UILabel *stringMsgLabel;
@property (strong, nonatomic) IBOutlet UITextField *textField;
@property (strong, nonatomic) UIBarButtonItem *submitButton;
@property (strong, nonatomic) IBOutlet UILabel *okLabel;
@property (strong, nonatomic) NISTAppDelegate *appDel;
@property (strong, nonatomic) IBOutlet UIButton *verifyButton;

- (IBAction)verifyHandler:(id)sender forEvent:(UIEvent *)event;
-(IBAction) backgroundTapped: (id) sender;
-(void) configureViewDataAndShow;
-(void) initForNewString;
- (NSMutableArray *) getEnteredStrings;

@end
