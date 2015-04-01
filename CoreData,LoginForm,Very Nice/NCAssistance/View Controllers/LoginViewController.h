//
//  LoginViewController.h
//  NCAssistance
//
//  Created by Yuyi Zhang on 5/6/13.
//  Copyright (c) 2013 Camel. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol LoginViewControllerDelegate
- (void)addRecord:(NSString *)title name:(NSString *)username password:(NSString *)pswd onWeb:(NSString *)website withNotes:(NSString *)notes;
@end

@interface LoginViewController : UIViewController <UITextFieldDelegate>

@property (nonatomic, weak) IBOutlet id <LoginViewControllerDelegate> delegate;
@property (weak, nonatomic) IBOutlet UITextField *passwordIn;
@property (weak, nonatomic) IBOutlet UITextField *passwordConfirm;
@property (weak, nonatomic) IBOutlet UITextField *question;
@property (weak, nonatomic) IBOutlet UITextField *answer;
@property (weak, nonatomic) IBOutlet UIButton *loginBtn;
- (IBAction)login:(id)sender;

@end
