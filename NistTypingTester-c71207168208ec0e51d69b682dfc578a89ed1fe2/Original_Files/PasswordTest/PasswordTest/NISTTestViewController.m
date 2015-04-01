//
//  NISTTestViewController.m
//  PasswordTest
//
//  Created by Navneet Kumar on 4/2/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "NISTTestViewController.h"
#import "NISTAppDelegate.h"
#import "NISTMemorizeViewController.h"

@interface NISTTestViewController () {
}
@end

@implementation NISTTestViewController {
    int textLens[10];
}


@synthesize textField1;
@synthesize textField2;
@synthesize textField3;
@synthesize textField4;
@synthesize textField5;
@synthesize textField6;
@synthesize textField7;
@synthesize textField8;
@synthesize textField9;
@synthesize textField10;
@synthesize submitButton;
@synthesize appDel;
@synthesize activeTextField;

#define kEnter @"NEXT"


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }
    return self;
}

- (void)configureView
{
    // Set title
    self.appDel = (NISTAppDelegate *) [[UIApplication sharedApplication] delegate];   
    NSString *titleMsg = [self.appDel getStringMsg];
    self.title = NSLocalizedString(titleMsg, titleMsg);

    // configure Navigation bar
    UINavigationItem *navItem = self.navigationItem;
    navItem.hidesBackButton = YES;   
    submitButton = [[UIBarButtonItem alloc] initWithTitle:@"Done" style:UIBarButtonItemStylePlain target:self action:@selector(submitHandler:forEvent:)];
    [submitButton setEnabled:NO];
    self.navigationItem.rightBarButtonItem = submitButton;
    
    // register for keyboard notifications
    [[NSNotificationCenter defaultCenter] addObserver:self 
                                             selector:@selector(keyboardWillShow:) 
                                                 name:UIKeyboardWillShowNotification 
                                               object:self.view.window];
    [[NSNotificationCenter defaultCenter] addObserver:self 
                                             selector:@selector(keyboardWillHide:) 
                                            name:UIKeyboardWillHideNotification 
                                               object:self.view.window];
    
    //setup scrolloing make contentSize bigger than your scrollSize (you will need to figure out for your own use case)
    CGSize scrollContentSize = CGSizeMake(320, 560);
    UIScrollView *tempScrollView = (UIScrollView *) self.view;
    
    tempScrollView.contentSize = scrollContentSize;
   
    tempScrollView.contentSize = scrollContentSize;
    tempScrollView.pagingEnabled = NO;
 
    UIEdgeInsets contentInsets = UIEdgeInsetsMake(0.0, 0.0,self.appDel.navigationController.navigationBar.frame.size.height, 0.0);    
    tempScrollView.contentInset = contentInsets;
    
    self.textField1.delegate = self;
    self.textField2.delegate = self;
    self.textField3.delegate = self;
    self.textField4.delegate = self;
    self.textField5.delegate = self;
    self.textField6.delegate = self;
    self.textField7.delegate = self;
    self.textField8.delegate = self;
    self.textField9.delegate = self;
    self.textField10.delegate = self;
        
    for (int i=0; i < 10; i++)
        textLens[i] = 0;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self configureView];
    [self configureViewDataAndShow];    
}

- (void)viewWillAppear:(BOOL)animated {    
    [super viewWillAppear:animated];
    
    [self configureViewDataAndShow];
    
    // create the event and fire it
    NISTUserEvent *ue = [[NISTUserEvent alloc] initWithEventype:NISTEventTypePhaseChange andPhase:NISTEnter andSubPhase:0];
    [self.appDel userChangedPhase:ue];
    
}

- (void)viewWillDisappear:(BOOL)animated {
    // Called when the view is dismissed, covered or otherwise hidden. Default does nothing
}


-(void) configureViewDataAndShow {
    
    NSString *titleMsg = [self.appDel getStringMsg];
    self.title = NSLocalizedString(titleMsg, titleMsg);

    [self.textField1 resignFirstResponder];

    [self.textField1 setText:@""];
    [self.textField2 setText:@""];
    [self.textField3 setText:@""];
    [self.textField4 setText:@""];
    [self.textField5 setText:@""];
    [self.textField6 setText:@""];
    [self.textField7 setText:@""];
    [self.textField8 setText:@""];
    [self.textField9 setText:@""];
    [self.textField10 setText:@""];
  
    
    for (int i=0; i < 10; i++)
        textLens[i] = 0;
        
    [self configSubmitButton];
    
    UIScrollView *tempScrollView = (UIScrollView *) self.view;
    UIEdgeInsets contentInsets = UIEdgeInsetsMake(0.0, 0.0,self.appDel.navigationController.navigationBar.frame.size.height, 0.0);    
    tempScrollView.contentInset = contentInsets;
    
}

- (void)submitHandler:(id)sender forEvent: (UIEvent *) event
{
    [self.textField1 becomeFirstResponder];

    NSMutableArray *enteredValues = [NSMutableArray arrayWithCapacity:10];

    [enteredValues addObject: [[NSString alloc] initWithString:textField1.text]];
    [enteredValues addObject: [[NSString alloc] initWithString:textField2.text]];
    [enteredValues addObject: [[NSString alloc] initWithString:textField3.text]];
    [enteredValues addObject: [[NSString alloc] initWithString:textField4.text]];
    [enteredValues addObject: [[NSString alloc] initWithString:textField5.text]];
    [enteredValues addObject: [[NSString alloc] initWithString:textField6.text]];
    [enteredValues addObject: [[NSString alloc] initWithString:textField7.text]];
    [enteredValues addObject: [[NSString alloc] initWithString:textField8.text]];
    [enteredValues addObject: [[NSString alloc] initWithString:textField9.text]];
    [enteredValues addObject: [[NSString alloc] initWithString:textField10.text]];
    
    [appDel userDoneWithCurrentString: enteredValues atTime: event.timestamp];
}

-(void) configSubmitButton {

    BOOL enable = YES;
    
    for (int i=0; i < 10; i++ ) {
        if ( textLens[i] == 0 ) {
            enable = NO;
            break;
        }
    }
    
    [submitButton setEnabled:enable];


}


-(BOOL) textField: (UITextField *) textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    // This will current text in the field but does NOT just typed.
    NSString *newString = [textField.text stringByReplacingCharactersInRange:range withString:string];
    int len = [newString length];
    
    textLens[textField.tag - 1] = len;
    [self configSubmitButton];

    [textField setText: newString];

    NISTUserEvent *ue = [[NISTUserEvent alloc] initWithEventype:NISTEventTypeInput andPhase:NISTEnter andSubPhase:self.activeTextField.tag];
    ue.chacterCode = [[NSString alloc] initWithString:string];
    ue.soFarTypedText = newString;
    [self.appDel userEnteredData:ue];    
    
    //return YES;
    return NO;
}

-(BOOL) textFieldShouldBeginEditing: (UITextField *) textField {
    self.activeTextField = textField;
    [self.appDel resetKeyboardState];
    
    return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    int index  = self.activeTextField.tag;

    NISTUserEvent *ue = [[NISTUserEvent alloc] initWithEventype:NISTEventTypeInput andPhase:NISTEnter andSubPhase:self.activeTextField.tag];
    ue.chacterCode = [[NSString alloc] initWithString:kEnter];
    ue.soFarTypedText = [[NSString alloc] initWithString:[self.activeTextField text]];
    [self.appDel userEnteredData:ue];    

    index++;
    index = index % 11;
    if (index == 0 ) index = 1; // go back to first
    
    switch (index) {
        case 1:
            [self.textField1 becomeFirstResponder];
            break;
        case 2:
            [self.textField2 becomeFirstResponder];
            break;
        case 3:
            [self.textField3 becomeFirstResponder];
            break;
        case 4:
            [self.textField4 becomeFirstResponder];
            break;
        case 5:
            [self.textField5 becomeFirstResponder];
            break;
        case 6:
            [self.textField6 becomeFirstResponder];
            break;
        case 7:
            [self.textField7 becomeFirstResponder];
            break;
        case 8:
            [self.textField8 becomeFirstResponder];
            break;
        case 9:
            [self.textField9 becomeFirstResponder];
            break;
        case 10:
            [self.textField10 becomeFirstResponder];
            break;
            
        default:
            break;
    }
    
    return YES;
}

// called when 'return' key pressed. return NO to ignore.


- (void)keyboardWillShow:(NSNotification*)aNotification
{
    self.appDel.keyBoardVisible = YES;
    
    NSDictionary* info = [aNotification userInfo];
    CGSize kbSize = [info[UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
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
    UIScrollView *tempScrollView = (UIScrollView *) self.view;
    
    
    UIEdgeInsets contentInsets = UIEdgeInsetsZero;
    tempScrollView.contentInset = contentInsets;
    tempScrollView.scrollIndicatorInsets = contentInsets;
}

-(IBAction) backgroundTapped: (id) sender {
    [self.activeTextField  resignFirstResponder];
}

- (void)viewDidUnload
{
    [self setTextField1:nil];
    [self setTextField2:nil];
    [self setTextField3:nil];
    [self setTextField4:nil];
    [self setTextField4:nil];
    [self setTextField5:nil];
    [self setTextField7:nil];
    [self setTextField8:nil];
    [self setTextField9:nil];
    [self setTextField10:nil];

    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
