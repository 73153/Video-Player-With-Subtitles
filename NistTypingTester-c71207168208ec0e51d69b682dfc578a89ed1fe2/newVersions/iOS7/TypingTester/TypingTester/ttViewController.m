//
//  ttViewController.m
//  TypingTester
//
//  Created by Matthew Kerr on 7/31/13.
//

#import "ttViewController.h"
#import "ttParticipant.h"
#import "ttReadyViewController.h"
#import "ttSettings.h"
#import "ttInputData.h"


@interface ttViewController ()

@end

@implementation ttViewController
{
    ttSettings* settings;
    ttParticipant *participant;
    ttInputData *inputData;
}

-(id) initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self)
    {
        settings = [ttSettings Instance];
        inputData = [ttInputData Instance];
    }
    return self;
}

-(void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    //[self.participantNumber becomeFirstResponder];
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self.participantNumber becomeFirstResponder];
    [inputData loadDataFile:nil];
}

-(void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"Settings"])
    {
        ttSettingsViewController *controller = segue.destinationViewController;
        controller.delegate = self;
    }
    else if ([segue.identifier isEqualToString:@"ReadyScreen"])
    {
        ttReadyViewController *controller = segue.destinationViewController;
        controller.participantNumber = self.participantNumber.text;
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

#pragma mark private methods

-(void) configureInterfaceForParticipantNumber:(NSString*)number
{
    if ([self isValidParticipantNumber:number])
    {
        self.startButton.enabled = YES;
        self.startButton_iPad.enabled = YES;
        self.invalidImage.hidden = YES;
        self.invalidString.hidden = YES;
    }
    else
    {
        self.startButton.enabled = NO;
        self.startButton_iPad.enabled = NO;
        self.invalidImage.hidden = NO;
        self.invalidString.hidden = NO;
    }

}

-(BOOL) isValidParticipantNumber:(NSString*)participantNumber
{
    BOOL isValid = NO;
    if (participantNumber.length > 0) isValid = YES;
    return isValid;
}

#pragma mark Actions

-(IBAction)backgroundTouch
{
    [self.participantNumber resignFirstResponder];
}

#pragma mark TextFieldDelegate Methods

-(BOOL) textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

-(BOOL) textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    NSString *newString = [textField.text stringByReplacingCharactersInRange:range withString:string];
    [self configureInterfaceForParticipantNumber:newString];
    return YES;
}

#pragma mark SettingsViewControllerDelegate methods

-(void)SettingViewControllerDidCancel:(ttSettingsViewController *)controller
{
    [self dismissViewControllerAnimated:YES completion:nil];
    [inputData loadDataFile:nil];
}

-(void)SettingsViewControllerDidSave:(ttSettingsViewController *)controller
{
    [self dismissViewControllerAnimated:YES completion:nil];
    [inputData loadDataFile:nil];
}

#pragma mark - Unwind Segue
-(IBAction)reset:(UIStoryboardSegue *)segue
{
    self.participantNumber.text = @"";
}

-(IBAction)cancelSettings:(UIStoryboardSegue *)segue
{
    [inputData loadDataFile:nil];
}

-(IBAction)saveSettings:(UIStoryboardSegue *)segue
{
    // force saving of defaults when settings return with a saved value
    [[NSUserDefaults standardUserDefaults] synchronize];
    [inputData loadDataFile:nil];
}


@end
