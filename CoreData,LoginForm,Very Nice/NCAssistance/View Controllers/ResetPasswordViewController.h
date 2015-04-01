//
//  ResetPasswordViewController.h
//  NCAssistance
//
//  Created by Yuyi Zhang on 5/18/13.
//  Copyright (c) 2013 Camel. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ResetPasswordViewController : UIViewController <UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *passwordIn;
@property (weak, nonatomic) IBOutlet UITextField *confirmIn;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *saveBtn;

- (IBAction)doneAction;

@end
