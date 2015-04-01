//
//  AddViewController.m
//  iDontKnow
//
//  Created by Yuyi Zhang on 5/2/13.
//  Copyright (c) 2013 Camel. All rights reserved.
//

#import "AddViewController.h"

@interface AddViewController ()

@end

@implementation AddViewController

- (instancetype)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.doneBtn.target = self;
    self.doneBtn.action = @selector(doneAction);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Text field delegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    if (textField == self.titleIn) {
        [textField resignFirstResponder];
		[self.userIn becomeFirstResponder];
    }
	else if  (textField == self.userIn) {
		[textField resignFirstResponder];
		[self.passwordIn becomeFirstResponder];
	}
	else if (textField == self.passwordIn) {
		[textField resignFirstResponder];
		[self.websiteIn becomeFirstResponder];
	}
	else if (textField == self.websiteIn) {
		[textField resignFirstResponder];
		[self.notesIn becomeFirstResponder];
	}
	else if (textField == self.notesIn) {
		[textField resignFirstResponder];
	}
    return YES;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    if (textField == self.notesIn) {
        [self animateTextField: textField up: YES];
    }
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    if (textField == self.notesIn) {
        [self animateTextField: textField up: NO];
    }
}

- (void) animateTextField: (UITextField*) textField up: (BOOL) up
{
    const int movementDistance = 80; // tweak as needed
    const float movementDuration = 0.3f; // tweak as needed
    
    int movement = (up ? -movementDistance : movementDistance);
    
    [UIView beginAnimations: @"anim" context: nil];
    [UIView setAnimationBeginsFromCurrentState: YES];
    [UIView setAnimationDuration: movementDuration];
    self.view.frame = CGRectOffset(self.view.frame, 0, movement);
    [UIView commitAnimations];
}

- (IBAction)doneAction
{
    // Input Validation
    if (self.titleIn.text.length == 0) {
        UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"Error"
                                                    message:@"Title is required."
                                                    delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [alert show];
        return;
    }
    
    if (self.passwordIn.text.length == 0) {
        UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"Error"
                                                    message:@"Password is required."
                                                    delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [alert show];
        return;
    }
    
    [self performSegueWithIdentifier:@"DoneAdding" sender:self];
}

@end
