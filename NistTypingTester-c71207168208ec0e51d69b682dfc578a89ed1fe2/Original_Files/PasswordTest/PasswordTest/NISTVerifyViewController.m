//
//  NISTVerifyViewController.m
//  PasswordTest
//
//  Created by Navneet Kumar on 4/2/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "NISTVerifyViewController.h"
#import "NISTAppDelegate.h"
#import "NISTMemorizeViewController.h"
#import "NISTTestViewController.h"

@interface NISTVerifyViewController ()

@end

@implementation NISTVerifyViewController {
    int numVistsForThisString;
}

@synthesize stringMsgLabel;
@synthesize textField;
@synthesize submitButton;
@synthesize okLabel;
@synthesize appDel;
@synthesize verifyButton;

#pragma mark - Managing the detail item

- (void)configureView
{
    self.appDel = (NISTAppDelegate *) [[UIApplication sharedApplication] delegate];
    submitButton = [[UIBarButtonItem alloc] initWithTitle:@"Start Test" style:UIBarButtonItemStylePlain target:self action:@selector(submitHandler:forEvent:)];   
    self.navigationItem.rightBarButtonItem = submitButton;
    [self.submitButton setEnabled:NO];
    self.textField.delegate = self;

    // register for keyboard notifications
    [[NSNotificationCenter defaultCenter] addObserver:self 
                                             selector:@selector(keyboardWillShow:) 
                                                 name:UIKeyboardWillShowNotification 
                                               object:self.view.window];
    [[NSNotificationCenter defaultCenter] addObserver:self 
                                             selector:@selector(keyboardWillHide:) 
                                                 name:UIKeyboardWillHideNotification 
                                               object:self.view.window];

}


- (void)keyboardWillHide:(NSNotification *)n
{
    self.appDel.keyBoardVisible = NO;    
}


- (void)keyboardWillShow:(NSNotification*)aNotification
{
    self.appDel.keyBoardVisible = YES;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    [self configureView];
    [self configureViewDataAndShow];
}

-(void) configureViewDataAndShow {
    [self.stringMsgLabel setText: [self.appDel getStringMsg]];
    [self.textField setText:@""];
    [self.okLabel setText:@""];
    [self.submitButton setEnabled:NO]; 
    [self.verifyButton setEnabled:NO];
}


- (void)viewWillAppear:(BOOL)animated {    
    numVistsForThisString++;
    [super viewWillAppear:animated];
    [self configureViewDataAndShow];
    
    // create the event and fire it
    NISTUserEvent *ue = [[NISTUserEvent alloc] initWithEventype:NISTEventTypePhaseChange andPhase:NISTVerify andSubPhase:numVistsForThisString];
    [self.appDel userChangedPhase:ue];
    
}


-(void) initForNewString {
    numVistsForThisString  = 0; 
}

-(BOOL) textField: (UITextField *) textField1 shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    // This will current text in the field but does NOT just typed.
    NSString *newString = [textField1.text stringByReplacingCharactersInRange:range withString:string];
    int len = [newString length];
    
    if ( len > 0 )  
        [self.verifyButton setEnabled:YES];
    else {
        [self.verifyButton setEnabled:NO];        
    }
    
    NSString *text = [self.okLabel text];
    if ( [text length] > 0 ) {
        [self.okLabel setText:@""];
        [self.submitButton setEnabled:NO];
    }
    
    NISTUserEvent *ue = [[NISTUserEvent alloc] initWithEventype:NISTEventTypeInput andPhase:NISTVerify andSubPhase:numVistsForThisString];

    ue.soFarTypedText = newString;
    ue.chacterCode = [[NSString alloc] initWithString:string];
    
    [self.appDel userEnteredData:ue];
    
    return !(len > 14);
}


- (void)viewDidUnload
{
    [self setTextField:nil];
    [self setStringMsgLabel:nil];
    [self setOkLabel:nil];
    [self setVerifyButton:nil];
    [super viewDidUnload];
}


- (IBAction)verifyHandler:(id)sender forEvent:(UIEvent *)event {
    NSString *text;
    
    text = [self.textField text];
    if ( [text isEqualToString:[self.appDel getCurrentString] ] ) {
        UIColor *black= [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:1.0];
        [self.okLabel setTextColor:black];
        
        [self.okLabel setText:@"OK"];
        [self.textField  resignFirstResponder];
        [self.submitButton setEnabled:YES];
    } else {
        UIColor *red= [UIColor colorWithRed:255.0/255.0 green:0.0/255.0 blue:0.0/255.0 alpha:1.0];
        
        [self.okLabel setTextColor:red];

         [self.okLabel setText:@"NOT OK"];        
    }
}

-(IBAction) backgroundTapped: (id) sender {
   [self.textField  resignFirstResponder];
}

- (void)submitHandler:(id)sender forEvent: (UIEvent *) event
{   
    
    NSMutableArray *a = [[NSMutableArray alloc] initWithCapacity:1];
    
    NSString *t = [self.textField text];
    [a addObject: [[NSString alloc] initWithString:t]];
    [self.appDel userTappedNextForPhase:NISTEnter atTime:event.timestamp withEnteredStrings:a];
    
    if ( self.appDel.testViewController == nil ) {
        // let us load "Enter" View as the next view
        NISTTestViewController *testViewController = [[NISTTestViewController alloc] initWithNibName:@"NISTTestViewController" bundle:nil];
        self.appDel.testViewController = testViewController;
    } else {
        [self.appDel.testViewController configureViewDataAndShow];
    }
    [self.appDel.navigationController pushViewController:self.appDel.testViewController animated:YES];
    
}


- (NSMutableArray *) getEnteredStrings {
    
    NSMutableArray *a = [[NSMutableArray alloc] initWithCapacity:1];
    NSString *t = [self.textField text];
    [a addObject:t];
    
    return a;
}


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = NSLocalizedString(@"Verify", @"Verify");
    }
    return self;
}

@end
