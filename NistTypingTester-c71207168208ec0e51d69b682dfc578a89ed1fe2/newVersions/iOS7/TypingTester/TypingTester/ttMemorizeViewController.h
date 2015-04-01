//
//  ttMemorizeViewController.h
//  TypingTester
//
//  Created by Matthew Kerr on 8/19/13.
//

#import <UIKit/UIKit.h>
#import "ttSession.h"

@interface ttMemorizeViewController : UIViewController <UITextViewDelegate, UIAlertViewDelegate>

@property (nonatomic, weak) IBOutlet UILabel *passwordLabel;
@property (nonatomic, weak) IBOutlet UIBarButtonItem *doneButton;
@property (nonatomic, weak) IBOutlet UIButton *doneButton_iPad;
@property (nonatomic, weak) IBOutlet UILabel *progressLabel;
@property (nonatomic, weak) IBOutlet UITextView *workArea;

@property (nonatomic, weak) ttSession *session;

-(IBAction)backgroundButtonPressed;
-(IBAction)nextButtonPressed;

@end
