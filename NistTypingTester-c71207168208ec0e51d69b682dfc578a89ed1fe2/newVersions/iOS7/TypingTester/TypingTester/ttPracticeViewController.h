//
//  ttPracticeViewController.h
//  TypingTester
//
//  Created by Matthew Kerr on 8/20/13.
//

#import <UIKit/UIKit.h>
#import "ttSession.h"

@interface ttPracticeViewController : UIViewController <UITextFieldDelegate, UIAlertViewDelegate>

@property (nonatomic, weak) IBOutlet UILabel *sessionProgressLabel;
@property (nonatomic, weak) IBOutlet UILabel *entitiyProgressLabel;
@property (nonatomic, weak) IBOutlet UILabel *entity;
@property (nonatomic, weak) IBOutlet UITextField *entryField;
@property (nonatomic, weak) IBOutlet UIBarButtonItem *doneButton;
@property (nonatomic, weak) IBOutlet UIButton *doneButton_iPad;
@property (nonatomic, weak) IBOutlet UIBarButtonItem *backButton;
@property (nonatomic, weak) IBOutlet UIButton *backButton_iPad;
@property (nonatomic, weak) IBOutlet UIButton *visibilityButton;
@property (nonatomic, weak) IBOutlet UIButton *skipButton;
@property (nonatomic, weak) IBOutlet UIImageView *correctIndicator;
@property (nonatomic, weak) IBOutlet UILabel *correctTextLable;
@property (nonatomic, weak) IBOutlet UINavigationBar *navigationBar;


@property (nonatomic, weak) ttSession *session;


-(IBAction)visibilityButtonPressed;
-(IBAction)skipButtonPressed;
-(IBAction)doneButtonPressed;
-(IBAction)backButtonPressed;

-(IBAction)backgroundButtonPressed;


@end
