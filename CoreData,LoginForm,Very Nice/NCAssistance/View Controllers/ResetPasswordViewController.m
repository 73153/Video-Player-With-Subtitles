//
//  ResetPasswordViewController.m
//  NCAssistance
//
//  Created by Yuyi Zhang on 5/18/13.
//  Copyright (c) 2013 Camel. All rights reserved.
//

#import "ResetPasswordViewController.h"

@interface ResetPasswordViewController ()

@end

@implementation ResetPasswordViewController

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	
    self.saveBtn.target = self;
    self.saveBtn.action = @selector(doneAction);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)doneAction
{
    // Input Validation
    if (self.passwordIn.text.length == 0) {
        UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"Error"
                                                        message:@"Please enter a password."
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [alert show];
        return;
    }
    if (self.confirmIn.text.length == 0) {
        UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"Error"
                                                        message:@"Please confirm your password."
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [alert show];
        return;
    }
    if (![self.passwordIn.text isEqualToString: self.confirmIn.text]) {
        UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"Error"
                                                        message:@"Password and confirmation don't match!"
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [alert show];
        return;
    }
    
    [self performSegueWithIdentifier:@"ChangePassword" sender:self];
}

#pragma mark - Text field delegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    if (textField == self.passwordIn) {
        [textField resignFirstResponder];
		[self.confirmIn becomeFirstResponder];
    }
	else if (textField == self.confirmIn) {
		[textField resignFirstResponder];
	}
    return YES;
}

@end
