//
//  AddViewController.h
//  iDontKnow
//
//  Created by Yuyi Zhang on 5/2/13.
//  Copyright (c) 2013 Camel. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AddViewController : UITableViewController <UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *titleIn;
@property (weak, nonatomic) IBOutlet UITextField *userIn;
@property (weak, nonatomic) IBOutlet UITextField *passwordIn;
@property (weak, nonatomic) IBOutlet UITextField *websiteIn;
@property (weak, nonatomic) IBOutlet UITextField *notesIn;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *doneBtn;

- (IBAction)doneAction;

@end
