//
//  ttRecallTableViewController.h
//  TypingTester
//
//  Created by Matthew Kerr on 8/26/13.
//

#import <UIKit/UIKit.h>

@class ttSession;
@class ttRecallTableViewController;

@protocol RecallTableViewControllerDelegate <NSObject>

-(void)RecallTableViewController:(ttRecallTableViewController*)controller didFinishWithValues:(NSString*)values;

@end

@interface ttRecallTableViewController : UITableViewController <UITextFieldDelegate>

@property (nonatomic, weak) ttSession *session;
@property (nonatomic, weak) id<RecallTableViewControllerDelegate> delegate;

-(IBAction)done;

-(void)hideKeyboard;
-(NSString*) getStrings;

@end
