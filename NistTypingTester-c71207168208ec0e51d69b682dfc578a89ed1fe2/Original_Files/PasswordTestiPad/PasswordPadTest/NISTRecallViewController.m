//
//  NISTRecallViewController.m
//  PasswordTest
//
//  Created by Navneet Kumar on 4/6/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "NISTRecallViewController.h"
#import "NISTThankYouViewController.h"
#import "NISTAppDelegate.h"

@interface NISTRecallViewController () {
}

@end

@implementation NISTRecallViewController {
    UITextField *activeField;       // used to keeep track of which text field is first responder  
    NSMutableArray     *recalledValues;
}


@synthesize textField1;
@synthesize textField2;
@synthesize textField3;
@synthesize textField4;
@synthesize textField6;
@synthesize textField7;
@synthesize textField8;
@synthesize textField9;
@synthesize textField10;
@synthesize textField5;
@synthesize activeTextField;
@synthesize appDel;

@synthesize submitButton;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = NSLocalizedString(@"Recall", @"Recall");
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
       
    // configure Navigation bar
    UINavigationItem *navItem = self.navigationItem;   
    navItem.hidesBackButton = YES;
    submitButton = [[UIBarButtonItem alloc] initWithTitle:@"Done" style:UIBarButtonItemStylePlain target:self action:@selector(submitHandler:forEvent:)];
    [submitButton setEnabled:YES];
    self.navigationItem.rightBarButtonItem = submitButton;
    
    // register for keyboard notifications
    [[NSNotificationCenter defaultCenter] addObserver:self 
                                             selector:@selector(keyboardWillShow:) 
                                                 name:UIKeyboardWillShowNotification 
                                               object:self.view.window];
    // register for keyboard notifications
    [[NSNotificationCenter defaultCenter] addObserver:self 
                                             selector:@selector(keyboardWillHide:) 
                                                 name:UIKeyboardWillHideNotification 
                                               object:self.view.window];
        
    //setup scrolloing make contentSize bigger than your scrollSize (you will need to figure out for your own use case)
    CGSize scrollContentSize = CGSizeMake(320, 560);
    UIScrollView *tempScrollView = (UIScrollView *) self.view;
    tempScrollView.contentSize = scrollContentSize;
    tempScrollView.pagingEnabled = NO;
    UIEdgeInsets contentInsets = UIEdgeInsetsMake(0.0, 0.0,self.appDel.navigationController.navigationBar.frame.size.height, 0.0);    
    tempScrollView.contentInset = contentInsets;
    
    textField1.delegate = self;
    textField2.delegate = self;
    textField3.delegate = self;
    textField4.delegate = self;
    textField5.delegate = self;
    textField6.delegate = self;
    textField7.delegate = self;
    textField8.delegate = self;
    textField9.delegate = self;
    textField10.delegate = self;    

    NSNumber *num = [NSNumber numberWithUnsignedInt:10];
    NSUInteger  count = [num unsignedIntValue];
    recalledValues = [NSMutableArray arrayWithCapacity:count];
                      
 
    NISTAppDelegate *delegate = (NISTAppDelegate *) [[UIApplication sharedApplication] delegate];
    self.appDel = delegate;
    
    // create the event and fire it
    NISTUserEvent *ue = [[NISTUserEvent alloc] initWithEventype:NISTEventTypePhaseChange andPhase:NISTRecall andSubPhase:0];
    [self.appDel userChangedPhase:ue];

    
}

-(IBAction) backgroundTapped: (id) sender {
    [activeField  resignFirstResponder];
}


-(BOOL) textField: (UITextField *) textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    // This will current text in the field but does NOT just typed.
    NSString *newString = [textField.text stringByReplacingCharactersInRange:range withString:string];
    int len = [newString length];
    
    if ( len >= 0 && len <= 14 ) {

        [textField setText: newString];
       
        NISTUserEvent *ue = [[NISTUserEvent alloc] initWithEventype:NISTEventTypeInput andPhase:NISTRecall andSubPhase:self.activeTextField.tag];
        
        ue.soFarTypedText = newString;
        ue.chacterCode = [[NSString alloc] initWithString:string];
        [self.appDel userEnteredData:ue];
    }
    
    return NO;
    
    // return !(len > 14);
}


-(BOOL) textFieldShouldBeginEditing: (UITextField *) textField {
    self.activeTextField = textField; 
    [self.appDel resetKeyboardState];
    return YES;
}

-(void) textFieldDidBeginEditing: (UITextField *) textField
{
    activeField = textField;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    int index  = self.activeTextField.tag;
    
    index++;
    index = index % 11;
    if (index == 0 ) index = 1; // go back to first
    
    switch (index) {
        case 1:
            [textField1 becomeFirstResponder];
            break;
        case 2:
            [textField2 becomeFirstResponder];
            break;
        case 3:
            [textField3 becomeFirstResponder];
            break;
        case 4:
            [textField4 becomeFirstResponder];
            break;
        case 5:
            [textField5 becomeFirstResponder];
            break;
        case 6:
            [textField6 becomeFirstResponder];
            break;
        case 7:
            [textField7 becomeFirstResponder];
            break;
        case 8:
            [textField8 becomeFirstResponder];
            break;
        case 9:
            [textField9 becomeFirstResponder];
            break;
        case 10:
            [textField10 becomeFirstResponder];
            break;
            
        default:
            break;
    }
    
    return YES;
}

- (void)keyboardWillShow:(NSNotification*)aNotification
{
    self.appDel.keyBoardVisible = YES;
    NSDictionary* info = [aNotification userInfo];
    CGSize kbSize = [[info objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
    UIScrollView *tempScrollView = (UIScrollView *) self.view;
    
    UIEdgeInsets contentInsets = UIEdgeInsetsMake(0.0, 0.0, kbSize.height, 0.0);
    tempScrollView.contentInset = contentInsets;
    tempScrollView.scrollIndicatorInsets = contentInsets;
    
    // If active text field is hidden by keyboard, scroll it so it's visible
    // Your application might not need or want this behavior.
    CGRect aRect = self.view.frame;
    aRect.size.height -= kbSize.height;
    
    CGRect textViewRect = self.activeTextField.frame;
    [tempScrollView scrollRectToVisible:textViewRect animated:YES];

}

- (void)keyboardWillHide:(NSNotification *)n
{
    self.appDel.keyBoardVisible = NO;
    UIEdgeInsets contentInsets = UIEdgeInsetsZero;
    UIScrollView *tempScrollView = (UIScrollView *) self.view;

    tempScrollView.contentInset = contentInsets;
    tempScrollView.scrollIndicatorInsets = contentInsets;
}

- (void)submitHandler:(id)sender forEvent:(UIEvent *)event
{
    [recalledValues addObject: [[NSString alloc] initWithString:textField1.text]];
    [recalledValues addObject: [[NSString alloc] initWithString:textField2.text]];
    [recalledValues addObject: [[NSString alloc] initWithString:textField3.text]];
    [recalledValues addObject: [[NSString alloc] initWithString:textField4.text]];
    [recalledValues addObject: [[NSString alloc] initWithString:textField5.text]];
    [recalledValues addObject: [[NSString alloc] initWithString:textField6.text]];
    [recalledValues addObject: [[NSString alloc] initWithString:textField7.text]];
    [recalledValues addObject: [[NSString alloc] initWithString:textField8.text]];
    [recalledValues addObject: [[NSString alloc] initWithString:textField9.text]];
    [recalledValues addObject: [[NSString alloc] initWithString:textField10.text]];
    [self.appDel userIsDoneRecallingStrings: recalledValues atTime: event.timestamp];

    // let us load "Ready" View as the next view
    NISTThankYouViewController *thankYouViewController = [[NISTThankYouViewController alloc] initWithNibName:@"NISTThankYouViewController" bundle:nil];        
    [self.appDel.navigationController pushViewController:thankYouViewController animated:YES];
    
}

- (void)viewDidUnload
{
    [self setTextField1:nil];
    [self setTextField2:nil];
    [self setTextField3:nil];
    [self setTextField4:nil];
    [self setTextField8:nil];
    [self setTextField9:nil];
    [self setTextField10:nil];
    [self setTextField5:nil];
    [self setTextField7:nil];
    [self setTextField6:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
