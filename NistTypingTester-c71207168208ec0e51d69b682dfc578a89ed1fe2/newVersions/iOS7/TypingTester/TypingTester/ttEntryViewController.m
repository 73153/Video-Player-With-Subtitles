//
//  ttEntryViewController.m
//  TypingTester
//
//  Created by Matthew Kerr on 8/21/13.
//

#import "ttEntryViewController.h"
#import "ttSettings.h"
#import "ttSession.h"
#import "ttEvent.h"
#import "ttRecallViewController.h"
#import "ttMemorizeViewController.h"
#import "ttPracticeViewController.h"
#import "ttTestEntity.h"
#import "ttSettings.h"
#import "ttUtilities.h"

@interface ttEntryViewController ()

@end

@implementation ttEntryViewController
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
    [self.session enteredPhase:Entry withNote:@"Started Entry Phase"];
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.session leftPhase:Entry withNote:@"Leaving Entry Phase"];
}

-(void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([segue.identifier isEqualToString:@"Recall"])
    {
        ttRecallViewController *controller = segue.destinationViewController;
        controller.session = self.session;
    }
    else if ([segue.identifier isEqualToString:@"unwindToMemorizeSegue"])
    {
        ttMemorizeViewController *controller = segue.destinationViewController;
        controller.session = self.session;
    }
    else if ([segue.identifier isEqualToString:@"unwindToForcedPracticeSegue"])
    {
        ttPracticeViewController *controller = segue.destinationViewController;
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
    ttEvent *event = [[ttEvent alloc]initWithEventType:OrientationChange andPhase:Entry];
    event.notes = [NSString stringWithFormat:@"Did rotate from %@ to %@", [ttUtilities stringForOrienatation:fromInterfaceOrientation], [ttUtilities stringForOrienatation:self.interfaceOrientation]];
    [self.session addEvent:event];
}

#pragma mark - UI Configuration

-(void) configureUI
{
    entity = [self.session.entities objectAtIndex:self.session.currentEntity];
    int totalEntites = self.session.entities.count;
    int currentEntity = self.session.currentEntity;
    int currentEntry = self.session.currentEntryForEntity;
    int totalEntries = [[ttSettings Instance]entriesPerEntitiy];
    self.sessionProgressLabel.text = [NSString stringWithFormat:@"Password %i of %i",currentEntity+1, totalEntites];
    self.entityProgressLabel.text = [NSString stringWithFormat:@"Round %i of %i", currentEntry+1, totalEntries];
}

#pragma mark - IBAction
-(IBAction)done
{
    [self.view endEditing:YES];
    // add event for done button
    ttEvent *doneButtonEvent = [[ttEvent alloc]initWithEventType:ControlActivated andPhase:Entry andSubPhase:NoSubPhase];
    doneButtonEvent.notes = @"Next button pressed";
    [self.session addEvent:doneButtonEvent];

    // check for quit string entered
    if ([self.entryField.text isEqualToString:[ttSettings Instance].quitString])
    {
        ttEvent *event = [[ttEvent alloc]initWithEventType:ControlActivated andPhase:Entry andSubPhase:NoSubPhase];
        event.notes = @"Quit string entered";
        event.targetString = entity.entityString;
        [self.session addEvent:event];
        // if so go to recall
        [self performSegueWithIdentifier:@"Recall" sender:self];
        return;
    }
    else if ([self.entryField.text isEqualToString:[ttSettings Instance].skipString])  // check for skip string
    {
        ttEvent *event = [[ttEvent alloc]initWithEventType:ControlActivated andPhase:Entry andSubPhase:NoSubPhase];
        event.targetString = entity.entityString;
        if ([self.session nextEntity] == YES)
        {
            event.notes = @"User entered skip string, transitioning to next entity.";
            [self.session addEvent:event];
            [self performSegueWithIdentifier:@"MemorizeNextEntity" sender:self];
        }
        else
        {
            event.notes = @"User entered skip string, last entity reached, moving to recall phase";
            [self.session addEvent:event];
            [self performSegueWithIdentifier:@"Recall" sender:self];
        }
        
        return;
    }
    // check for correct/incorrect entry
    if ([self.entryField.text isEqualToString:entity.entityString])
    {
        ttEvent *event = [[ttEvent alloc]initWithEventType:CorrectValueEntered andPhase:Entry];
        event.targetString = entity.entityString;
        event.currentValue = self.entryField.text;
        event.notes = [NSString stringWithFormat:@"Round:%i for Password:%i", self.session.currentEntity, self.session.currentEntryForEntity];
        [self.session addEvent:event];
    }
    else
    {
        ttEvent *event = [[ttEvent alloc]initWithEventType:IncorrectValueEntered andPhase:Entry];
        event.targetString = entity.entityString;
        event.currentValue = self.entryField.text;
        event.notes = [NSString stringWithFormat:@"Round:%i for Password:%i", self.session.currentEntity, self.session.currentEntryForEntity];
        [self.session addEvent:event];
    }
    self.session.currentEntryForEntity++;
    int currentEntry = self.session.currentEntryForEntity;
    int totalEntriesRequired = [[ttSettings Instance]entriesPerEntitiy];
    // have we entered the string X # of times?
    if (currentEntry < totalEntriesRequired)
    {
        // no so we need to enter it again
        self.entryField.text = @"";
        self.doneButton.enabled = NO;
        self.doneButton_iPad.enabled = NO;
        [self configureUI];
    }
    else  // entered string the required number of times
    {
        if ([self.session nextEntity] == YES)
        {
            if (settings.disableFreePractice == NO)
            {
                [self performSegueWithIdentifier:@"unwindToMemorizeSegue" sender:self];
            }
            else
            {
                [self performSegueWithIdentifier:@"unwindToForcedPracticeSegue" sender:self];
            }
        }
        else
        {
            [self performSegueWithIdentifier:@"Recall" sender:self];
        }
    }
}

-(IBAction)backgroundButtonPressed
{
    [self.view endEditing:YES];
}

#pragma mark - UITextFieldDelegate methods
-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    NSString *newString = [textField.text stringByReplacingCharactersInRange:range withString:string];
    ttEvent *inputEvent = [[ttEvent alloc] initWithEventType:Input andPhase:Entry andSubPhase:NoSubPhase];
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
    if (newString.length > 0)
    {
        self.doneButton.enabled = YES;
        self.doneButton_iPad.enabled = YES;
    }
    else
    {
        self.doneButton.enabled = NO;
        self.doneButton_iPad.enabled = NO;
    }
    NSLog(@"Change Location:%i, Length:%i, withString:%@", range.location, range.length, string);
    return YES;
}

-(BOOL) textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}


-(void) textFieldDidBeginEditing:(UITextField *)textField
{
    ttEvent *textFieldEntered = [[ttEvent alloc]initWithEventType:ControlActivated andPhase:Entry andSubPhase:NoSubPhase];
    textFieldEntered.notes =[NSString stringWithFormat:@"TextField Became Active"];
    [self.session addEvent:textFieldEntered];
}

-(void) textFieldDidEndEditing:(UITextField *)textField
{
    ttEvent *textFieldLeft= [[ttEvent alloc]initWithEventType:ControlActivated andPhase:Entry andSubPhase:NoSubPhase];
    textFieldLeft.notes = [NSString stringWithFormat:@"TextField No Longer Active"];
    [self.session addEvent:textFieldLeft];
}


@end
