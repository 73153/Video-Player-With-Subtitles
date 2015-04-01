//
//  EditViewController.m
//  NCAssistance
//
//  Created by Yuyi Zhang on 5/12/13.
//  Copyright (c) 2013 Camel. All rights reserved.
//

#import "EditViewController.h"
#import "Password.h"

@interface EditViewController ()

@end

@implementation EditViewController

- (instancetype)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    if (self.record) {
        self.titleIn.text = self.record.title;
        self.userIn.text = self.record.username;
        self.passwordIn.text = self.record.password;
        self.websiteIn.text = self.record.website;
        self.notesIn.text = self.record.notes;
    }
    self.doneBtn.target = self;
    self.doneBtn.action = @selector(doneAction);
}/*
    UIView *newView = [[UIView alloc]initWithFrame:CGRectMake(10, 70, 300, 45)];
    submit = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [submit setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    //[submit setTitleColor:[UIColor colorWithWhite:0.0 alpha:0.56] forState:UIControlStateDisabled];
    [submit setTitle:@"Login" forState:UIControlStateNormal];
    [submit.titleLabel setFont:[UIFont boldSystemFontOfSize:14]];
    [submit setFrame:CGRectMake(10.0, 15.0, 280.0, 44.0)];
    [newView addSubview:self.deleteBtn];
    
    [self.tableView setTableFooterView:newView];
    
    [super viewDidLoad];
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    
    return 50;
}
*/
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Text field delegate
-(BOOL) textFieldShouldReturn:(UITextField *)textField
{
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

- (IBAction)deleteAction:(id)sender {
    UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@""
                                                    message:@"Delete this password?"
                                                   delegate:self
                                                cancelButtonTitle:@"Cancel"
                                                otherButtonTitles:@"Delete", nil];
    [alert show];
    
    
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if(buttonIndex == 1) { // Delete
        [self.delegate deletePassword:self.record];
        [self dismissViewControllerAnimated:YES completion:nil];
        
        // Go to MainViewController
        UINavigationController *nc = (UINavigationController *)[self presentingViewController];
        [nc popToRootViewControllerAnimated:NO];
    }
}

-(IBAction)doneAction
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
    
    self.record.title = self.titleIn.text;
    self.record.username = self.userIn.text;
    self.record.password = self.passwordIn.text;
    self.record.website = self.websiteIn.text;
    self.record.notes = self.notesIn.text;
    [self performSegueWithIdentifier:@"DoneEditing" sender:self];
}

@end
