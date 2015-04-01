//
//  LoginViewController.m
//  NCAssistance
//
//  Created by Yuyi Zhang on 5/6/13.
//  Copyright (c) 2013 Camel. All rights reserved.
//

#import "LoginViewController.h"
#import "Constants.h"

@interface LoginViewController ()

@end

@implementation LoginViewController

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
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)login:(id)sender {
    if (self.passwordIn.text.length == 0) {
        UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"Error"
                                                        message:@"Please set your password."
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [alert show];
        return;
    }
    
    if (self.passwordConfirm.text.length == 0) {
        UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"Error"
                                                        message:@"Please confirm your password."
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [alert show];
        return;
    }
    
    if (![self.passwordIn.text isEqualToString: self.passwordConfirm.text]) {
        UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"Error"
                                                        message:@"Please make sure your password and confirmation matches."
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [alert show];
        return;
    }
    
    if (self.question.text.length == 0) {
        UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"Error"
                                                        message:@"Please set your security question."
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [alert show];
        return;
    }
    
    if (self.answer.text.length == 0) {
        UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"Error"
                                                        message:@"Please set your security answer."
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [alert show];
        return;
    }
    
    [self.delegate addRecord:strAppUnlockTitle name:strAppUnlockName password:self.passwordIn.text onWeb:self.question.text withNotes:self.answer.text];

    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - Text field delegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    if (textField == self.passwordIn) {
        [textField resignFirstResponder];
		[self.passwordConfirm becomeFirstResponder];
    }
	else if (textField == self.passwordConfirm) {
		[textField resignFirstResponder];
		[self.question becomeFirstResponder];
	}
	else if (textField == self.question) {
		[textField resignFirstResponder];
		[self.answer becomeFirstResponder];
	}
	else if (textField == self.answer) {
		[textField resignFirstResponder];
	}
    return YES;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
        [self animateTextField: textField up: YES];
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    [self animateTextField: textField up: NO];
}

- (void) animateTextField: (UITextField*) textField up: (BOOL) up
{
    int movementDistance = 0;
    float movementDuration = 0.0f;
    if (textField == self.question) {
        movementDistance = 80; // tweak as needed
        movementDuration = 0.3f; // tweak as needed
    }
    else if (textField == self.answer) {
        movementDistance = 130; // tweak as needed
        movementDuration = 0.3f; // tweak as needed
    }
    
    int movement = (up ? -movementDistance : movementDistance);
    
    [UIView beginAnimations: @"anim" context: nil];
    [UIView setAnimationBeginsFromCurrentState: YES];
    [UIView setAnimationDuration: movementDuration];
    self.view.frame = CGRectOffset(self.view.frame, 0, movement);
    [UIView commitAnimations];
}

@end
