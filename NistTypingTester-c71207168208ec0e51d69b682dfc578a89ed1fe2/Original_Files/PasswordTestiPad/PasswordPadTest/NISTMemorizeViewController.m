//
//  NISTMemorizeViewController.m
//  PasswordTestnumVistsForThisString
//
//  Created by Navneet Kumar on 3/30/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "NISTMemorizeViewController.h"
#import "NISTVerifyViewController.h"
#import "NISTAppDelegate.h"
#import "NISTUserEvent.h"
#import "NISTApplication.h"


@implementation NISTMemorizeViewController {
    NSTimeInterval touchStartTime;
    NSTimeInterval touchEndTime;
    int numVistsForThisString;    
}

@synthesize stringLabel;
@synthesize nextButton;
@synthesize textView;
@synthesize stringMsgLabel;
@synthesize appDel;



- (void)configureView
{
    self.appDel = (NISTAppDelegate *) [[UIApplication sharedApplication] delegate];    
    // Do any additional setup after loading the view from its nib.
    nextButton = [[UIBarButtonItem alloc] initWithTitle:@"Next" style:UIBarButtonItemStylePlain target:self action:@selector(nextHandler:forEvent:)];
    [nextButton setEnabled:YES];
    self.navigationItem.rightBarButtonItem = nextButton;

    
    UINavigationItem *navItem = self.navigationItem;
    navItem.hidesBackButton = YES;
    
    
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
    
    [self.textView setText:@""];
    
    //make contentSize bigger than your scrollSize (you will need to figure out for your own use case)
    CGSize scrollContentSize = CGSizeMake(320, 460);
    UIScrollView *tempScrollView = (UIScrollView *) self.view;
                                    
    tempScrollView.contentSize = scrollContentSize;
    tempScrollView.pagingEnabled = NO;
    UIEdgeInsets contentInsets = UIEdgeInsetsMake(0.0, 0.0,self.appDel.navigationController.navigationBar.frame.size.height, 0.0);    
    tempScrollView.contentInset = contentInsets;
    
    textView.delegate = self;
    
    
}


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = NSLocalizedString(@"Memorize", @"Memorize");
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
   
	// Do any additional setup after loading the view, typically from a nib.
    [self configureView];
    [self configureViewDataAndShow];
            
}

-(void) initForNewString {
    numVistsForThisString  = 0;
}

- (void)viewWillAppear:(BOOL)animated {    
    numVistsForThisString++;
   [super viewWillAppear:animated];
   [self configureViewDataAndShow];

    // create the event and fire it
    NISTUserEvent *ue = [[NISTUserEvent alloc] initWithEventype:NISTEventTypePhaseChange andPhase:NISTMemorize andSubPhase:numVistsForThisString];
    [self.appDel userChangedPhase:ue];
    
}

-(void) configureViewDataAndShow {
    [self.stringMsgLabel setText:self.appDel.getStringMsg];
    [self.stringLabel setText:self.appDel.getCurrentString];    
    [self clearText];
}

-(IBAction) backgroundTapped: (id) sender {
    [self.textView resignFirstResponder];
}


-(void) clearText {
    [textView setText:@""];
    UIScrollView *tempScrollView;
    
    tempScrollView = (UIScrollView *) self.view;
    
    [tempScrollView setContentOffset:CGPointMake(0.0, 0.0)];
}

- (void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    touchStartTime = event.timestamp;
} 

- (void) touchesEnded:(NSSet *)touches 
            withEvent:(UIEvent *)event {
    touchEndTime = event.timestamp;
}


- (NSString *) convertNewLines: (NSString *) input {
    NSString *output;
   
    if ( [input length] > 0 ) {
        NSArray *subStrings = [ input componentsSeparatedByString:@"\n"];   
        if ( [subStrings count] > 1 ) {
            output = [subStrings componentsJoinedByString:@"\\n"];
        } else {
            output = [[NSString alloc] initWithString:input];
        }
    } else {
        output = [[NSString alloc] initWithString:@""];
    }
    return output;
    
}



-(BOOL) textView: (UITextView *) textView1 shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{

    // This will current text in the field but does NOT just typed.
    NSString *newString1 = [textView1.text stringByReplacingCharactersInRange:range withString:text];

    
    NISTUserEvent *ue = [[NISTUserEvent alloc] initWithEventype:NISTEventTypeInput andPhase:NISTMemorize andSubPhase:numVistsForThisString];
    NSString *text1 = [ self convertNewLines:newString1 ];        
    ue.soFarTypedText = text1;
    ue.chacterCode = [[NSString alloc] initWithString:text];

    [self.appDel userEnteredData:ue];
  

    return YES; 
}



- (void)nextHandler:(id)sender forEvent: (UIEvent *) event
{

    NSMutableArray *a = [[NSMutableArray alloc] initWithCapacity:1];
    [a addObject: [[NSString alloc] initWithString:[self.textView text]]];
    [self.appDel userTappedNextForPhase:NISTVerify atTime:event.timestamp withEnteredStrings:a];

    [textView resignFirstResponder];
    
    // let us load verify View as the next view
    if ( self.appDel.verifyViewController == nil ) {
        NISTVerifyViewController *verifyViewController = [[NISTVerifyViewController alloc] initWithNibName:@"NISTVerifyViewController" bundle:nil];
        self.appDel.verifyViewController = verifyViewController;
    } else {
        [self.appDel.verifyViewController configureViewDataAndShow];
    }
    [self.appDel.navigationController pushViewController:self.appDel.verifyViewController animated:YES];
    
    
}

- (void)viewDidUnload
{
    // unregister for keyboard notifications while not visible.
    [[NSNotificationCenter defaultCenter] removeObserver:self 
                                                    name:UIKeyboardWillShowNotification 
                                                  object:nil]; 
    // unregister for keyboard notifications while not visible.
    [[NSNotificationCenter defaultCenter] removeObserver:self 
                                                    name:UIKeyboardWillHideNotification 
                                                  object:nil];      
    [self setTextView:nil];
    [self setStringMsgLabel:nil];
    [self setStringLabel:nil];
    [super viewDidUnload];

}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}


- (void)keyboardWillHide:(NSNotification *)n
{
    self.appDel.keyBoardVisible = NO;

    UIScrollView *tempScrollView;
    tempScrollView = (UIScrollView *) self.view;
    
    UIEdgeInsets contentInsets = UIEdgeInsetsZero;
    tempScrollView.contentInset = contentInsets;
    tempScrollView.scrollIndicatorInsets = contentInsets;
}


- (void)keyboardWillShow:(NSNotification*)aNotification
{
    self.appDel.keyBoardVisible = YES;
    NSDictionary* info = [aNotification userInfo];
    CGSize kbSize = [[info objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
    
    UIScrollView *tempScrollView;
    tempScrollView = (UIScrollView *) self.view;

    UIEdgeInsets contentInsets = UIEdgeInsetsMake(0.0, 0.0, kbSize.height, 0.0);
    tempScrollView.contentInset = contentInsets;
    tempScrollView.scrollIndicatorInsets = contentInsets;
    
    // If active text field is hidden by keyboard, scroll it so it's visible
    // Your application might not need or want this behavior.
    CGRect aRect = self.view.frame;
    aRect.size.height -= kbSize.height;
    
    CGRect textViewRect = textView.frame;
    [tempScrollView scrollRectToVisible:textViewRect animated:YES];
}



@end
