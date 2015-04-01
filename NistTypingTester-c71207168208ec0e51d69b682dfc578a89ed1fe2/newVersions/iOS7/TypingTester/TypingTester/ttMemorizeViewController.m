//
//  ttMemorizeViewController.m
//  TypingTester
//
//  Created by Matthew Kerr on 8/19/13.
//

#import <QuartzCore/QuartzCore.h>

#import "ttMemorizeViewController.h"
#import "ttPracticeViewController.h"
#import "ttVerifyViewController.h"
#import "ttEntryViewController.h"
#import "ttTestEntity.h"
#import "ttSettings.h"
#import "ttUtilities.h"


@interface ttMemorizeViewController ()

@end

@implementation ttMemorizeViewController
{
    unsigned int currentEntity;
    unsigned int totalEntites;
    ttTestEntity *entity;
    ttSettings *settings;
}

-(id) initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self)
    {
        settings = [ttSettings Instance];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    // set a border on the work area text field
    self.workArea.layer.borderWidth = 1.0f;
    self.workArea.layer.borderColor = [[UIColor grayColor]CGColor];
    // check to see if we are on the first entity
    //if (self.session.currentEntity == -1) [self.session nextEntity];
    [self configureUI];
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    // log phase entry
    [self.session enteredPhase:Memorize withNote:@"Entering Memorize Phase"];
    [self.session enteredSubPhase:FreePractice withNote:@"Entering Free Practice"];
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

-(NSUInteger)supportedInterfaceOrientations
{
    switch(UI_USER_INTERFACE_IDIOM())
    {
        case UIUserInterfaceIdiomPad:
            return UIInterfaceOrientationMaskAll;
            
        case UIUserInterfaceIdiomPhone:
            return UIInterfaceOrientationMaskAllButUpsideDown;
    }
    return UIInterfaceOrientationMaskAll;
}

-(void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation
{
    [super didRotateFromInterfaceOrientation:fromInterfaceOrientation];
    // log a rotation
    ttEvent *event = [[ttEvent alloc]initWithEventType:OrientationChange andPhase:Memorize andSubPhase:FreePractice];
    event.notes = [NSString stringWithFormat:@"Did rotate from %@ to %@", [ttUtilities stringForOrienatation:fromInterfaceOrientation], [ttUtilities stringForOrienatation:self.interfaceOrientation]];
    [self.session addEvent:event];
}

-(IBAction)backgroundButtonPressed
{
    [self.view endEditing:YES];
}

-(IBAction)nextButtonPressed
{
    ttEvent *event = [[ttEvent alloc]initWithEventType:ControlActivated andPhase:Memorize andSubPhase:FreePractice];
    event.notes = @"Next button pressed";
    [self.session addEvent:event];
    // do we have forced practice?  if so go there
    if (settings.forcedPracticeRounds > 0)
    {
        [self performSegueWithIdentifier:@"MemorizeToPractice" sender:self];
    }
    else if (settings.verifyRounds > 0) // no forced practice?  do we need to verify?
    {
        [self performSegueWithIdentifier:@"MemorizeToVerify" sender:self];
    }
    else // no forced practice or verification, straight to entry
    {
        //[self performSegueWithIdentifier:@"MemorizeToEntry" sender:self];
        [self askGoToEntry];
    }
}

-(void) askGoToEntry
{
    UIAlertView *proceed = [[UIAlertView alloc]initWithTitle:@"Memorization Complete" message:@"Are you ready to proceed to the Enter task?" delegate:self cancelButtonTitle:@"No" otherButtonTitles:@"Yes", nil];
    [proceed show];
}

-(void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // store the work area contents
    self.session.workAreaContents = self.workArea.text;
    // pass of the session and any other information
    if ([segue.identifier isEqualToString:@"MemorizeToPractice"])
    {
        ttPracticeViewController* controller = segue.destinationViewController;
        controller.session = self.session;
    }
    else if ([segue.identifier isEqualToString:@"MemorizeToVerify"])
    {
        ttVerifyViewController *controller = segue.destinationViewController;
        controller.session = self.session;
    }
    else if ([segue.identifier isEqualToString:@"MemorizeToEntry"])
    {
        [self.session leftPhase:Memorize withNote:@"Leaving Memorize Phase"];
        ttEntryViewController *controller = segue.destinationViewController;
        controller.session = self.session;
    }
}

-(void) configureUI
{
    currentEntity = self.session.currentEntity;
    totalEntites = self.session.entities.count;
    entity = [self.session.entities objectAtIndex:currentEntity];
    self.passwordLabel.text = entity.entityString;
    self.workArea.text = self.session.workAreaContents;
    self.progressLabel.text = [NSString stringWithFormat:@"Password %i of %i", currentEntity+1, totalEntites];
    self.workArea.hidden = settings.disableFreePracticeTextField;
}


#pragma -mark UITextViewDelegate methods
-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    NSString *newString = [textView.text stringByReplacingCharactersInRange:range withString:text];
    ttEvent *inputEvent = [[ttEvent alloc] initWithEventType:Input andPhase:Memorize andSubPhase:FreePractice];
    inputEvent.location = range.location;
    inputEvent.length = range.length;
    inputEvent.enteredCharacters = [self EscapeString:text];
    inputEvent.currentValue = [self EscapeString:newString];
    inputEvent.targetString = entity.entityString;
    if ([text isEqualToString:@""])
    {
        inputEvent.notes = @"Delete event detected";
    }
    else
    {
        inputEvent.notes = [NSString stringWithFormat:@"%@ entered", [self EscapeString:text]];
    }
    [self.session addEvent:inputEvent];
    
    return YES;
}

-(void)textViewDidChange:(UITextView *)textView
{
    if (textView.text.length > 0)
    {
        NSRange bottom = NSMakeRange(textView.text.length -1, 1);
        [textView scrollRangeToVisible:bottom];
    }
}

-(NSString*)EscapeString:(NSString*)input
{
    NSString *ret = [input stringByReplacingOccurrencesOfString:@"\n" withString:@"{LF}"];
    ret = [ret stringByReplacingOccurrencesOfString:@"\r" withString:@"{CR}"];
    return ret;
}

#pragma mark - Alert View Delegate
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    NSString *title= [alertView buttonTitleAtIndex:buttonIndex];
    if ([title isEqualToString:@"Yes"])
    {
        ttEvent *event = [[ttEvent alloc]initWithEventType:ControlActivated andPhase:Memorize andSubPhase:FreePractice];
        event.notes = @"User elected to proceed to the entry subphase.";
        [self.session addEvent:event];
        [self performSegueWithIdentifier:@"MemorizeToEntry" sender:self];
        
    }
    else
    {
        ttEvent *event = [[ttEvent alloc]initWithEventType:ControlActivated andPhase:Memorize andSubPhase:FreePractice];
        event.notes = @"User elected to stay in free practice subphase.";
        [self.session addEvent:event];
    }
}


#pragma mark - Unwind Segue
-(IBAction)unwindToMemorize:(UIStoryboardSegue *)segue
{
    [self configureUI];
}


@end
