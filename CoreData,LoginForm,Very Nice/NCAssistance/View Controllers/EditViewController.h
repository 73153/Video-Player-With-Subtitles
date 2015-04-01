//
//  EditViewController.h
//  NCAssistance
//
//  Created by Yuyi Zhang on 5/12/13.
//  Copyright (c) 2013 Camel. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Password;

@protocol EditViewControllerDelegate
-(void) deletePassword:(Password *) item;
@end

@interface EditViewController : UITableViewController <UITextFieldDelegate>

@property (nonatomic, weak) IBOutlet id <EditViewControllerDelegate> delegate;
@property (strong, nonatomic) Password *record;
@property (weak, nonatomic) IBOutlet UITextField *titleIn;
@property (weak, nonatomic) IBOutlet UITextField *userIn;
@property (weak, nonatomic) IBOutlet UITextField *passwordIn;
@property (weak, nonatomic) IBOutlet UITextField *websiteIn;
@property (weak, nonatomic) IBOutlet UITextField *notesIn;
@property (weak, nonatomic) IBOutlet UIButton *deleteBtn;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *doneBtn;

- (IBAction)deleteAction:(id)sender;
-(IBAction)doneAction;

@end
