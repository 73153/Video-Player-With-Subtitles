//
//  ttTypingProficiencyViewController.m
//  TypingTester
//
//  Created by Matthew Kerr on 8/1/13.
//

#import "ttTypingProficiencyViewController.h"
#import "ttEvent.h"
#import "ttConstants.h"
#import "ttSession.h"
#import "ttInputData.h"
#import "ttSettings.h"
#import "ttProficiencyItem.h"
#import "ttInstructionsViewController.h"
#import "ttUtilities.h"

@interface ttTypingProficiencyViewController ()

@end

@implementation ttTypingProficiencyViewController
{
    ttSettings *settings;
    ttProficiencyItem *item;
}

-(id) initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self)
    {
        settings = [ttSettings Instance];
        [self.session enteredProficiencyPhase];
        
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

-(void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation
{
    [super didRotateFromInterfaceOrientation:fromInterfaceOrientation];
    // log a rotation
    ttEvent *event = [[ttEvent alloc]initWithEventType:OrientationChange andPhase:Proficiency];
    event.targetString = item.text;
    event.notes = [NSString stringWithFormat:@"Did rotate from %@ to %@", [ttUtilities stringForOrienatation:fromInterfaceOrientation], [ttUtilities stringForOrienatation:self.interfaceOrientation]];
    [self.session addEvent:event];
}

-(void) configureUI
{
    int currentString = self.session.currentProficiencyString;
    int totalStrings = self.session.proficiencyStrings.count;
    item = [self.session.proficiencyStrings objectAtIndex:currentString];
    self.phraseLabel1.text = item.text;
    self.progressLabel.text = [NSString stringWithFormat:@"Phrase %i of %i", currentString+1, totalStrings];
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
    // add the event indicating that a proficiency string was displayed
    ttEvent *event = [[ttEvent alloc]initWithEventType:ProficiencyStringShown andPhase:Proficiency];
    event.notes = [NSString stringWithFormat:@"%i/%i String:%@", currentString+1,totalStrings,item.text];
    event.targetString = item.text;
    [self.session addEvent:event];
}

#pragma mark - IBActions

-(IBAction)doneButtonPressed
{
    [self.view endEditing:YES];
    // create an event indicating that the button was pressed
    ttEvent *donePressed = [[ttEvent alloc]initWithEventType:ControlActivated andPhase:Proficiency];
    donePressed.notes = [NSString stringWithFormat:@"Next button pressed"];
    [self.session addEvent:donePressed];
    ttEvent *valueCompare;
    if ([item.text isEqualToString:self.entryField.text])
    {
        valueCompare = [[ttEvent alloc]initWithEventType:CorrectValueEntered andPhase:Proficiency];
    }
    else
    {
        valueCompare = [[ttEvent alloc]initWithEventType:IncorrectValueEntered andPhase:Proficiency];
    }
    valueCompare.Notes = [NSString stringWithFormat:@"Text Entered: %@", self.entryField.text];
    valueCompare.targetString = item.text;
    valueCompare.currentValue = self.entryField.text;
    [self.session addEvent:valueCompare];
    
    self.session.currentProficiencyString++;
    if (self.session.currentProficiencyString < self.session.proficiencyStrings.count)
    {
        self.entryField.text = @"";
        [self configureUI];
    }
    else
    {
        // prepare for next screen
        [self performSegueWithIdentifier:@"Instructions" sender:self];
    }
}

-(IBAction)backgroundButtonPressed
{
    [self.view endEditing:YES];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // pass the session pointer on ...
    if ([segue.identifier isEqualToString:@"Instructions"])
    {
        ttInstructionsViewController *controller = [segue destinationViewController];
        controller.session = self.session;
    }
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.session leftPhase:Proficiency withNote:@"Typing Proficiency Phase Left"];
}

-(void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    // indicate that the typing proficiency phase has been entered
    [self.session enteredPhase:Proficiency withNote:@"Typing Proficiency Phase Entered"];
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

#pragma mark - UI Text Field Delegate

-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    NSString *newString = [textField.text stringByReplacingCharactersInRange:range withString:string];
    ttEvent *inputEvent = [[ttEvent alloc] initWithEventType:Input andPhase:Proficiency andSubPhase:NoSubPhase];
    inputEvent.location = range.location;
    inputEvent.length = range.length;
    inputEvent.enteredCharacters = string;
    inputEvent.currentValue = newString;
    inputEvent.targetString = item.text;
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
    ttEvent *textFieldEntered = [[ttEvent alloc]initWithEventType:ControlActivated andPhase:Proficiency andSubPhase:NoSubPhase];
    textFieldEntered.notes =[NSString stringWithFormat:@"TextField Became Active"];
    [self.session addEvent:textFieldEntered];
}

-(void) textFieldDidEndEditing:(UITextField *)textField
{
    ttEvent *textFieldLeft= [[ttEvent alloc]initWithEventType:ControlActivated andPhase:Proficiency andSubPhase:NoSubPhase];
    textFieldLeft.notes = [NSString stringWithFormat:@"TextField No Longer Active"];
    [self.session addEvent:textFieldLeft];
}



@end
