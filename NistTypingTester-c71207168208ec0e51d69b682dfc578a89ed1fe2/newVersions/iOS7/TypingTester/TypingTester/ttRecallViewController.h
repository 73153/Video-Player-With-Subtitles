//
//  ttRecallViewController.h
//  TypingTester
//
//  Created by Matthew Kerr on 8/21/13.
//

#import <UIKit/UIKit.h>
#import "ttRecallTableViewController.h"

@class ttSession;

@interface ttRecallViewController : UIViewController <RecallTableViewControllerDelegate>

@property (nonatomic, weak) IBOutlet UIBarButtonItem *donButton;
@property (nonatomic, weak) IBOutlet UIButton *doneButton_iPad;

@property (nonatomic, weak) ttSession *session;

-(IBAction)done;
-(IBAction)backgroundButtonPressed;


@end
