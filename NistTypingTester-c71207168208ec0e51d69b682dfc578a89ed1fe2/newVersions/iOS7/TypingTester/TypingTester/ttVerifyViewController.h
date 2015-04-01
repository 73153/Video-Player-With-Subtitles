//
//  ttVerifyViewController.h
//  TypingTester
//
//  Created by Matthew Kerr on 8/21/13.
//

#import <UIKit/UIKit.h>

@class ttSession;

@interface ttVerifyViewController : UIViewController <UITextFieldDelegate, UIAlertViewDelegate>

@property (nonatomic, weak) IBOutlet UILabel *sessionProgressLabel;
@property (nonatomic, weak) IBOutlet UITextField *entryField;
@property (nonatomic, weak) IBOutlet UIBarButtonItem *doneButton;
@property (nonatomic, weak) IBOutlet UIButton *doneButton_iPad;
@property (nonatomic, weak) IBOutlet UIBarButtonItem *backButton;
@property (nonatomic, weak) IBOutlet UIButton *backButton_iPad;
@property (nonatomic, weak) IBOutlet UIImageView *incorrectImage;
@property (nonatomic, weak) IBOutlet UILabel* incorrectText;
@property (nonatomic, weak) IBOutlet UILabel* entityProgressLabel;

@property (nonatomic, weak) ttSession *session;

-(IBAction)done;
-(IBAction)back;
-(IBAction)backgroundButtonPressed;

@end
