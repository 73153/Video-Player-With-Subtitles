//
//  ttVerifyViewController.m
//  TypingTester
//
//  Created by Matthew Kerr on 8/21/13.
//

#import "ttVerifyViewController.h"
#import "ttSession.h"
#import "ttSettings.h"
#import "ttEvent.h"
#import "ttEntryViewController.h"
#import "ttPracticeViewController.h"
#import "ttTestEntity.h"
#import "ttRecallViewController.h"
#import "ttSettings.h"
#import "ttMemorizeViewController.h"
#import "ttUtilities.h"

@interface ttVerifyViewController ()

@end

@implementation ttVerifyViewController
{
    ttTestEntity *entity;
    ttSettings *settings;
}

-(id)initWithCoder:(NSCoder *)aDecoder
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
    [self configureUI];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self.session enteredSubPhase:Verify withNote:@"Entered Verify Phase"];
    // try to skip when there are no verify rounds required
    if (settings.verifyRounds <= 0)
    {
        [self performSegueWithIdentifier:@"Entry" sender:self];
    }
}

-(void) viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}

-(void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"VerifyToEntry"])
    {
        [self.session leftPhase:Memorize withNote:@"Leaving Memorize Phase"];
        ttEntryViewController *controller = segue.destinationViewController;
        controller.session = self.session;
    }
    else if ([segue.identifier isEqualToString:@"unwindToForcedPracticeSegue"])
    {
        ttPracticeViewController *controller = segue.destinationViewController;
        controller.session = self.session;
    }
    else if ([segue.identifier isEqualToString:@"unwindToMemorizeSegue"])
    {
        ttMemorizeViewController *controller = segue.destinationViewController;
        controller.session = self.session;
    }
    else if ([segue.identifier isEqualToString:@"VerifyToRecall"])
    {
        [self.session leftPhase:Memorize withNote:@"Leaving Memorize Phase, skipping to recall phase"];
        ttRecallViewController *controller = segue.destinationViewController;
        controller.session = self.session;
    }
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
    ttEvent *event = [[ttEvent alloc]initWithEventType:OrientationChange andPhase:Memorize andSubPhase:Verify];
    event.notes = [NSString stringWithFormat:@"Did rotate from %@ to %@", [ttUtilities stringForOrienatation:fromInterfaceOrientation], [ttUtilities stringForOrienatation:self.interfaceOrientation]];
    [self.session addEvent:event];
}

#pragma -mark IBActions
-(IBAction)back
{
    // add event for back button
    ttEvent *backButtonEvent = [[ttEvent alloc]initWithEventType:ControlActivated andPhase:Memorize andSubPhase:Verify];
    backButtonEvent.notes = @"Back button pressed";
    [self.session addEvent:backButtonEvent];
    if (settings.forcedPracticeRounds > 0)
    {
        [self performSegueWithIdentifier:@"unwindToForcedPracticeSegue" sender:self];
    }
    else
    {
        [self performSegueWithIdentifier:@"unwindToMemorizeSegue" sender:self];
    }
}

-(IBAction)done
{
    [self.view endEditing:YES];
    // add event for done button
    ttEvent *doneButtonEvent = [[ttEvent alloc]initWithEventType:ControlActivated andPhase:Memorize andSubPhase:Verify];
    doneButtonEvent.notes = @"Next button pressed";
    [self.session addEvent:doneButtonEvent];
    ttTestEntity *currentEntity = [self.session.entities objectAtIndex:self.session.currentEntity];
    if ([self.entryField.text isEqualToString:currentEntity.entityString])
    {
        ttEvent *event = [[ttEvent alloc]initWithEventType:CorrectValueEntered andPhase:Memorize andSubPhase:Verify];
        event.targetString = entity.entityString;
        event.currentValue = self.entryField.text;
        [self.session addEvent:event];
        self.session.currentVerifyRoundForEntity++;
        if (self.session.currentVerifyRoundForEntity >= settings.verifyRounds)
        {
            [self askGoToEntry];
        }
        [self configureUI];
    }
    else if ([self.entryField.text isEqualToString:[ttSettings Instance].quitString])
    {
        ttEvent *event = [[ttEvent alloc]initWithEventType:ControlActivated andPhase:Memorize andSubPhase:Verify];
        event.targetString = entity.entityString;
        event.notes = @"Quit phrase entered";
        [self.session addEvent:event];
        [self performSegueWithIdentifier:@"VerifyToRecall" sender:self];
    }
    else if ([self.entryField.text isEqualToString:[ttSettings Instance].skipString])
    {
        ttEvent *event = [[ttEvent alloc]initWithEventType:ControlActivated andPhase:Memorize andSubPhase:Verify];
        event.targetString = entity.entityString;
        if ([self.session nextEntity] == YES)
        {
            event.notes = @"User entered skip string, transitioning to next entity.";
            [self.session addEvent:event];
            [self performSegueWithIdentifier:@"UnwindToMemorizeSegue" sender:self];
        }
        else
        {
            event.notes = @"User entered skip string, last entity reached, moving to recall phase";
            [self.session addEvent:event];
            [self performSegueWithIdentifier:@"VerifyToRecall" sender:self];
        }
        
    }
    else
    {
        ttEvent *event = [[ttEvent alloc]initWithEventType:IncorrectValueEntered andPhase:Memorize andSubPhase:Verify];
        event.targetString = entity.entityString;
        event.currentValue = self.entryField.text;
        [self.session addEvent:event];
        if (self.session.currentVerifyRoundForEntity >= settings.verifyRounds)
        {
            [self askGoToEntry];
        }
        if (![self.entryField.text isEqualToString:@""])
        {
            self.incorrectText.hidden = NO;
            self.incorrectImage.hidden = NO;
        }
    }
}

-(IBAction)backgroundButtonPressed
{
    [self.view endEditing:YES];
}

#pragma -mark UI configuration
-(void)configureUI
{
    entity = [self.session.entities objectAtIndex:self.session.currentEntity];
    int currentEntity = self.session.currentEntity;
    int totalEntities = self.session.entities.count;
    self.sessionProgressLabel.text = [NSString stringWithFormat:@"Password %i of %i", currentEntity+1, totalEntities];
    
    if (self.session.currentVerifyRoundForEntity >= settings.verifyRounds)
    {
        self.entityProgressLabel.text = [NSString stringWithFormat:@"Complete"];
        self.doneButton.enabled = YES;
    }
    else
    {
        self.entityProgressLabel.text = [NSString stringWithFormat:@"Round %i of %i", self.session.currentVerifyRoundForEntity+1, settings.verifyRounds];
        self.doneButton.enabled = NO;
    }
    self.entryField.text = @"";
    // hide the incorrect icon and label
    self.incorrectImage.hidden = YES;
    self.incorrectText.hidden = YES;
}

#pragma -mark UITextFieldDelegate methods

-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    NSString *newString = [textField.text stringByReplacingCharactersInRange:range withString:string];
    ttEvent *inputEvent = [[ttEvent alloc] initWithEventType:Input andPhase:Memorize andSubPhase:Verify];
    inputEvent.location = range.location;
    inputEvent.length = range.length;
    inputEvent.enteredCharacters = string;
    inputEvent.currentValue = newString;
    inputEvent.targetString = entity.entityString;
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
    if (newString.length > 0 || self.session.currentVerifyRoundForEntity >= settings.verifyRounds)
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
    // hides the incorrect icon and label
    self.incorrectImage.hidden = YES;
    self.incorrectText.hidden = YES;
    return YES;
}

-(BOOL) textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}


-(void) textFieldDidBeginEditing:(UITextField *)textField
{
    ttEvent *textFieldEntered = [[ttEvent alloc]initWithEventType:ControlActivated andPhase:Memorize andSubPhase:Verify];
    textFieldEntered.notes =[NSString stringWithFormat:@"TextField Became Active"];
    [self.session addEvent:textFieldEntered];
}

-(void) textFieldDidEndEditing:(UITextField *)textField
{
    ttEvent *textFieldLeft= [[ttEvent alloc]initWithEventType:ControlActivated andPhase:Memorize andSubPhase:Verify];
    textFieldLeft.notes = [NSString stringWithFormat:@"TextField No Longer Active"];
    [self.session addEvent:textFieldLeft];
}

-(void) askGoToEntry
{
    UIAlertView *proceed = [[UIAlertView alloc]initWithTitle:@"Verify Completed" message:@"Are you ready to proceed to the Enter Task?" delegate:self cancelButtonTitle:@"No" otherButtonTitles:@"Yes", nil];
    [proceed show];
}

#pragma mark - Alert View Delegate
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    NSString *title= [alertView buttonTitleAtIndex:buttonIndex];
    if ([title isEqualToString:@"Yes"])
    {
        ttEvent *event = [[ttEvent alloc]initWithEventType:ControlActivated andPhase:Memorize andSubPhase:Verify];
        event.notes = @"User elected to proceed to enter subphase.";
        [self.session addEvent:event];
        [self performSegueWithIdentifier:@"VerifyToEntry" sender:self];
    }
    else
    {
        ttEvent *event = [[ttEvent alloc]initWithEventType:ControlActivated andPhase:Memorize andSubPhase:Verify];
        event.notes = @"User elected to stay in verify subphase.";
        [self.session addEvent:event];
    }
}



@end
