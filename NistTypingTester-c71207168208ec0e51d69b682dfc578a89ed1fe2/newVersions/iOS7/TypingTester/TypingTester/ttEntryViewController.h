//
//  ttEntryViewController.h
//  TypingTester
//
//  Created by Matthew Kerr on 8/21/13.
//

#import <UIKit/UIKit.h>

@class ttSession;

@interface ttEntryViewController : UIViewController <UITextFieldDelegate>

@property (nonatomic, weak) IBOutlet UILabel *sessionProgressLabel;
@property (nonatomic, weak) IBOutlet UILabel *entityProgressLabel;
@property (nonatomic, weak) IBOutlet UITextField *entryField;
@property (nonatomic, weak) IBOutlet UIBarButtonItem *doneButton;
@property (nonatomic, weak) IBOutlet UIButton *doneButton_iPad;

@property (nonatomic, weak) ttSession *session;

-(IBAction)done;
-(IBAction)backgroundButtonPressed;

@end
