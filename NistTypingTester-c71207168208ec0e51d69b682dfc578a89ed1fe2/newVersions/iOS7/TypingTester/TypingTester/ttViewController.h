//
//  ttViewController.h
//  TypingTester
//
//  Created by Matthew Kerr on 7/31/13.
//

#import <UIKit/UIKit.h>
#import "ttSettingsViewController.h"

@interface ttViewController : UIViewController <UITextFieldDelegate, SettingsViewControllerDelegate>

//@property (nonatomic, weak) IBOutlet UIButton *backgroundButton;
@property (nonatomic, weak) IBOutlet UITextField *participantNumber;
@property (nonatomic, weak) IBOutlet UIBarButtonItem *startButton;
@property (nonatomic, weak) IBOutlet UIButton *startButton_iPad;
@property (nonatomic, weak) IBOutlet UIImageView *invalidImage;
@property (nonatomic, weak) IBOutlet UILabel *invalidString;

-(IBAction)backgroundTouch;

@end
