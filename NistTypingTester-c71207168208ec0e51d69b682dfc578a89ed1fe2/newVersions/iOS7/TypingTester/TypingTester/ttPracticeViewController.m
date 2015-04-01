//
//  ttPracticeViewController.m
//  TypingTester
//
//  Created by Matthew Kerr on 8/20/13.
//

#import "ttPracticeViewController.h"
#import "ttMemorizeViewController.h"
#import "ttVerifyViewController.h"
#import "ttEntryViewController.h"
#import "ttSettings.h"
#import "ttTestEntity.h"
#import "ttRecallViewController.h"
#import "ttUtilities.h"

@interface ttPracticeViewController ()

@end

@implementation ttPracticeViewController
{
    NSString *currentString;
    NSString *maskedString;
    BOOL maskEntityDisplay;
    ttSettings *settings;
    int practiceStringNumber;
    //int totalEntities;
    //int entityNumber;
    int numberOfRequiredPractices;
    ttTestEntity *e;
}


-(id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self)
    {
        maskEntityDisplay = NO;
        maskedString = @"*";
        settings = [ttSettings Instance];
        numberOfRequiredPractices = 1;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    numberOfRequiredPractices = settings.forcedPracticeRounds;
    [self configureUI];
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    // if free practice is disabled we need to log that we have entered the memorize phase
    if (settings.disableFreePractice == YES) [self.session enteredPhase:Memorize withNote:@"Entering Memorize Phase"];
    // log that we are entering the forced practice phase
    [self.session enteredSubPhase:ForcedPractice withNote:@"Entering Forced Practice SubPhase"];
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
    ttEvent *event = [[ttEvent alloc]initWithEventType:OrientationChange andPhase:Memorize andSubPhase:ForcedPractice];
    event.notes = [NSString stringWithFormat:@"Did rotate from %@ to %@", [ttUtilities stringForOrienatation:fromInterfaceOrientation], [ttUtilities stringForOrienatation:self.interfaceOrientation]];
    [self.session addEvent:event];
}


-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"unwindToMemorizeSegue"])
    {
        ttMemorizeViewController* controller = segue.destinationViewController;
        controller.session = self.session;
    }
    else if ([segue.identifier isEqualToString:@"PracticeToVerify"])
    {
        ttVerifyViewController* controller = segue.destinationViewController;
        controller.session = self.session;
    }
    else if ([segue.identifier isEqualToString:@"PracticeToRecall"])
    {
        [self.session leftPhase:Memorize withNote:@"Leaving Memorize Phase, skipping to recall"];
        ttRecallViewController* controller = segue.destinationViewController;
        controller.session = self.session;
    }
    else if ([segue.identifier isEqualToString:@"PracticeToEntry"])
    {
        [self.session leftPhase:Memorize withNote:@"Leaving Memorize Phase"];
        ttEntryViewController *controller = segue.destinationViewController;
        controller.session = self.session;
    }
}

#pragma -mark UI Configuration

-(void)configureUI
{
    //totalEntities = self.session.entities.count;
    //entityNumber = self.session.currentEntity;
    // display the string
    e = [self.session.entities objectAtIndex:self.session.currentEntity];
    currentString = e.entityString;
    // configure the display of the text
    [self configureEntityDisplay];
    // enable/disable the done button
    if (self.entryField.text.length > 0)
    {
        self.doneButton.enabled = YES;
        self.doneButton_iPad.enabled = YES;
    }
    else
    {
        self.doneButton.enabled = NO;
        self.doneButton_iPad.enabled = NO;
    }
    // back button visibility
    if (settings.disableFreePractice == YES)
    {
        self.backButton_iPad.hidden = YES;
        self.backButton.enabled = NO;
        self.backButton.image = nil;
    }
    
    // configure optional button visibility
    self.visibilityButton.hidden = !settings.enableHideButtonOnPracticeScreen;
    self.skipButton.hidden = !settings.showSkipButton;
    // update the progress labels
    practiceStringNumber = self.session.CurrentPracticeRoundForEntity;
    self.sessionProgressLabel.text = [NSString stringWithFormat:@"Password %i of %i",self.session.currentEntity+1,self.session.entities.count];
    
    if (self.session.CurrentPracticeRoundForEntity < settings.forcedPracticeRounds)
    {
        self.entitiyProgressLabel.text = [NSString stringWithFormat:@"Round %i of %i", practiceStringNumber+1, numberOfRequiredPractices];
    }
    else
    {
        self.entitiyProgressLabel.text = [NSString stringWithFormat:@"Complete"];
        self.doneButton.enabled = YES;
        self.doneButton_iPad.enabled = YES;
    }
    
    // hide the incorrect labels
    self.correctIndicator.hidden = YES;
    self.correctTextLable.hidden = YES;
}

-(void)configureEntityDisplay
{
    // set up the entity text to display
    if (maskEntityDisplay == YES) self.entity.text = maskedString;
    else self.entity.text = currentString;
}

-(void) askGoToNextTask
{
    NSString *promptText;
    if (settings.verifyRounds > 0)
    {
        promptText = [NSString stringWithFormat:@"Are you ready to proceed to the Verify task?"];
    }
    else
    {
        promptText = [NSString stringWithFormat:@"Are you ready to proceed to the Enter task?"];
    }
    UIAlertView *proceed = [[UIAlertView alloc]initWithTitle:@"Practice Complete" message:promptText delegate:self cancelButtonTitle:@"No" otherButtonTitles:@"Yes", nil];
    [proceed show];
}

#pragma -mark IBActions

-(IBAction)visibilityButtonPressed
{
    // toggle visibility of the entity field
    maskEntityDisplay = !maskEntityDisplay;
    self.visibilityButton.selected = maskEntityDisplay;
    [self configureEntityDisplay];
}

-(IBAction)skipButtonPressed
{
    ttEvent *event = [[ttEvent alloc]initWithEventType:ControlActivated andPhase:Memorize andSubPhase:ForcedPractice];
    event.notes = [NSString stringWithFormat:@"Skip button pressed by user"];
    [self.session addEvent:event];
    if ([self.session nextEntity] == YES)
    {
        // TODO
        [self performSegueWithIdentifier:@"unwindToMemorizeSegue" sender:self];
    }
    else
    {
        [self performSegueWithIdentifier:@"PracticeToRecall" sender:self];
    }
}

-(IBAction)backButtonPressed
{
    // log back button press
    ttEvent *backButtonEvent = [[ttEvent alloc]initWithEventType:ControlActivated andPhase:Memorize andSubPhase:ForcedPractice];
    backButtonEvent.notes = @"Back button pressed";
    [self.session addEvent:backButtonEvent];
    [self performSegueWithIdentifier:@"unwindToMemorizeSegue" sender:self];
}

-(IBAction)doneButtonPressed
{
    // resign any active controllers to dismiss the keyboard
    [self.view endEditing:YES];
    // log next button press
    ttEvent *doneButtonEvent = [[ttEvent alloc]initWithEventType:ControlActivated andPhase:Memorize andSubPhase:ForcedPractice];
    doneButtonEvent.notes = @"Next button pressed";
    [self.session addEvent:doneButtonEvent];
    // check to see if the entered string matches the target string
    if([currentString isEqualToString:self.entryField.text])
    {
        ttEvent *event = [[ttEvent alloc]initWithEventType:CorrectValueEntered andPhase:Memorize andSubPhase:ForcedPractice];
        event.notes = [NSString stringWithFormat:@"Pratice Round: %i", self.session.CurrentPracticeRoundForEntity];
        event.targetString = e.entityString;
        event.currentValue = self.entryField.text;
        [self.session addEvent:event];
        self.session.CurrentPracticeRoundForEntity++;
        self.entryField.text = @"";
        [self configureUI];
        if (self.session.CurrentPracticeRoundForEntity >= settings.forcedPracticeRounds)
        {
            [self askGoToNextTask];
        }
    }
    else if ([self.entryField.text isEqualToString:settings.quitString])
    {
        ttEvent *event = [[ttEvent alloc]initWithEventType:ControlActivated andPhase:Memorize andSubPhase:ForcedPractice];
        event.targetString = e.entityString;
        event.notes = @"User entered quit string, transitioning to recall phase.";
        [self.session addEvent:event];
        [self performSegueWithIdentifier:@"PracticeToRecall" sender:self];
    }
    else if ([self.entryField.text isEqualToString:settings.skipString])
    {
        ttEvent *event = [[ttEvent alloc]initWithEventType:ControlActivated andPhase:Memorize andSubPhase:ForcedPractice];
        event.targetString = e.entityString;
        // move to the next entity
        if ([self.session nextEntity] == YES)
        {
            event.notes = @"User entered skip string, transitioning to next entity.";
            [self.session addEvent:event];
            // is free practice disabled?
            if (settings.disableFreePractice == YES)
            {
                [self setupForNextEntityDueToSkip];
            }
            else
            {
                [self performSegueWithIdentifier:@"unwindToMemorizeSegue" sender:self];
            }
        }
        else // cannot move to a next entity (end of entities) go to recall
        {
            event.notes = @"User entered skip string, last entity reached, moving to recall phase";
            [self.session addEvent:event];
            [self performSegueWithIdentifier:@"PracticeToRecall" sender:self];
        }
    }
    else    // entry does not match practice string
    {
        ttEvent *event = [[ttEvent alloc]initWithEventType:IncorrectValueEntered andPhase:Memorize andSubPhase:ForcedPractice];
        event.notes = [NSString stringWithFormat:@"Pratice Round: %i", self.session.CurrentPracticeRoundForEntity];
        event.targetString = e.entityString;
        event.currentValue = self.entryField.text;
        if (self.session.CurrentPracticeRoundForEntity >= settings.forcedPracticeRounds)
        {
            [self askGoToNextTask];
        }
        if (![self.entryField.text isEqualToString:@""])
        {
            self.correctIndicator.hidden = NO;
            self.correctTextLable.hidden = NO;
        }
    }
}

-(IBAction)backgroundButtonPressed
{
    [self.view endEditing:YES];
}

-(void) setupForNextEntityDueToSkip
{
    self.entryField.text = @"";
    // if free practice is disabled we need to log that we have entered the memorize phase
    if (settings.disableFreePractice == YES) [self.session enteredPhase:Memorize withNote:@"Entering Memorize Phase"];
    // log that we are entering the forced practice phase
    [self.session enteredSubPhase:ForcedPractice withNote:@"Entering Forced Practice SubPhase"];
    [self configureUI];
}

#pragma -mark UITextFieldDelegate methods

-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    NSString *newString = [textField.text stringByReplacingCharactersInRange:range withString:string];
    ttEvent *inputEvent = [[ttEvent alloc] initWithEventType:Input andPhase:Memorize andSubPhase:ForcedPractice];
    inputEvent.location = range.location;
    inputEvent.length = range.length;
    inputEvent.enteredCharacters = string;
    inputEvent.currentValue = newString;
    inputEvent.targetString = e.entityString;
    // determine if delete event occured
    if ([string isEqualToString:@""])
    {
        inputEvent.notes = @"Delete event detected";
    }
    else
    {
        inputEvent.notes = [NSString stringWithFormat:@"%@ entered", string];
    }
    [self.session addEvent:inputEvent];
    // determine if we enable the done button
    if (newString.length > 0 || self.session.CurrentPracticeRoundForEntity >= settings.forcedPracticeRounds)
    {
        self.doneButton.enabled = YES;
        self.doneButton_iPad.enabled = YES;
    }
    else
    {
        self.doneButton.enabled = NO;
        self.doneButton_iPad.enabled = NO;
    }
    //NSLog(@"Change Location:%i, Length:%i, withString:%@", range.location, range.length, string);
    // hids the incorrect icon and label
    self.correctTextLable.hidden = YES;
    self.correctIndicator.hidden = YES;
    return YES;
}

// hides the keyboard when the user returns
-(BOOL) textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}


-(void) textFieldDidBeginEditing:(UITextField *)textField
{
    ttEvent *textFieldEntered = [[ttEvent alloc]initWithEventType:ControlActivated andPhase:Memorize andSubPhase:ForcedPractice];
    textFieldEntered.notes =[NSString stringWithFormat:@"TextField Became Active"];
    [self.session addEvent:textFieldEntered];
}

-(void) textFieldDidEndEditing:(UITextField *)textField
{
    ttEvent *textFieldLeft= [[ttEvent alloc]initWithEventType:ControlActivated andPhase:Memorize andSubPhase:ForcedPractice];
    textFieldLeft.notes = [NSString stringWithFormat:@"TextField No Longer Active"];
    [self.session addEvent:textFieldLeft];
}

#pragma mark - Alert View Delegate
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    NSString *title= [alertView buttonTitleAtIndex:buttonIndex];
    if ([title isEqualToString:@"Yes"])
    {
        ttEvent *event = [[ttEvent alloc]initWithEventType:ControlActivated andPhase:Memorize andSubPhase:ForcedPractice];
        if (settings.verifyRounds > 0)
        {
            event.notes = @"User elected to proceed to verify subphase.";
            [self.session addEvent:event];
            [self performSegueWithIdentifier:@"PracticeToVerify" sender:self];
        }
        else
        {
            event.notes = @"User elected to proceed to the entry subphase.";
            [self.session addEvent:event];
            [self performSegueWithIdentifier:@"PracticeToEntry" sender:self];
        }
        
    }
    else
    {
        ttEvent *event = [[ttEvent alloc]initWithEventType:ControlActivated andPhase:Memorize andSubPhase:ForcedPractice];
        event.notes = @"User elected to stay in practice subphase.";
        [self.session addEvent:event];
    }
}


#pragma mark - Unwind Segue
-(IBAction)unwindToForcedPractice:(UIStoryboardSegue *)segue
{
    [self configureUI];
}


@end
