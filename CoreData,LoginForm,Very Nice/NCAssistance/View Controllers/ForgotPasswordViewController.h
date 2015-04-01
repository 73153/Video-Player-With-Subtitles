//
//  ForgotPasswordViewController.h
//  NCAssistance
//
//  Created by Yuyi Zhang on 6/16/13.
//  Copyright (c) 2013 Camel. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Password;

@protocol ForgotPasswordViewControllerDelegate
-(Password *) retriveRecord;
-(void) dismissLockView;
@end

@interface ForgotPasswordViewController : UIViewController <UITextFieldDelegate>

@property (nonatomic, weak) IBOutlet id <ForgotPasswordViewControllerDelegate> delegate;
@property (weak, nonatomic) IBOutlet UITextView *descTxt;
@property (weak, nonatomic) IBOutlet UITextView *question;
@property (weak, nonatomic) IBOutlet UITextField *answerIn;
- (IBAction)back:(id)sender;
- (IBAction)unlock:(id)sender;

@end
