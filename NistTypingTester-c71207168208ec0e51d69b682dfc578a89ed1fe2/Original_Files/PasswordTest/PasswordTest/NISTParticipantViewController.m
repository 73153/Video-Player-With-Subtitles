//
//  BIDMasterViewController.m
//  NavTest
//
//  Created by Navneet Kumar on 3/29/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "NISTAppDelegate.h"
#import "NISTReadyViewController.h"
#import "NISTParticipantViewController.h"

@interface NISTParticipantViewController () {
    NSMutableArray *_objects;
}
@end

@implementation NISTParticipantViewController 

@synthesize beginButton = _beginButton;
@synthesize participantNumber = _participantNumber;
@synthesize appDel;
@synthesize nextButton;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = NSLocalizedString(@"Welcome", @"Welcome");
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.appDel = (NISTAppDelegate *) [[UIApplication sharedApplication] delegate];
    
    
    // Do any additional setup after loading the view from its nib.
    nextButton = [[UIBarButtonItem alloc] initWithTitle:@"Done" style:UIBarButtonItemStylePlain target:self action:@selector(beginButtonHandler:)];
    [nextButton setEnabled:NO];
    self.navigationItem.rightBarButtonItem = nextButton;
    
    
    UINavigationItem *navItem = self.navigationItem;
    navItem.hidesBackButton = YES;
    
    self.participantNumber.delegate = (id) self;
    
}

-(IBAction) backgroundTapped: (id) sender {
    [self.participantNumber resignFirstResponder];
}


- (BOOL) textField: (UITextField *) textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    NSString *newString = [textField.text stringByReplacingCharactersInRange:range withString:string];
    
    // Enable Next button if user has entered atleast one number
    if ( [newString length] > 0 )
        [self.nextButton setEnabled:YES];
    else {
        [self.nextButton setEnabled:NO];
    }
    
    return !([newString length] > kMaxParticipantIDLength);
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    NSTimeInterval     s;
    
    s = event.timestamp;
    
}

- (void)viewDidUnload
{
    [self setParticipantNumber:nil];
    [self setBeginButton:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {

    if ( [[self.participantNumber text] length] <=0 )
        return NO;
    
    // access particpant number;
    appDel.participantId = [self.participantNumber text];
    
    
    // let us load "Ready" View as the next view
    NISTReadyViewController *readyViewController = [[NISTReadyViewController alloc] initWithNibName:@"NISTReadyView" bundle:nil];
    self.appDel.readyViewController = readyViewController;
    
    // show it
    [self.appDel.navigationController pushViewController:readyViewController animated:YES];
    
    return YES;
    
    
}
// called when 'return' key pressed. return NO to ignore.


- (IBAction)beginButtonHandler:(id)sender {
    
    // access particpant number;
    appDel.participantId = [self.participantNumber text];
    
    // let us load "Ready" View as the next view
    NISTReadyViewController *readyViewController = [[NISTReadyViewController alloc] initWithNibName:@"NISTReadyView" bundle:nil];
    self.appDel.readyViewController = readyViewController;
    
    // show it
    [self.appDel.navigationController pushViewController:readyViewController animated:YES];
    

}
@end
