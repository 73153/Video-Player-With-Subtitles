//
//  ttSettingsDetailViewController.m
//  TypingTester
//
//  Created by Matthew Kerr on 8/12/13.
//

#import "ttSettingsDetailViewController.h"
#import "ttSettings.h"

@interface ttSettingsDetailViewController ()

@end

@implementation ttSettingsDetailViewController
{
    ttSettings* settings;
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
    // allow single tap outside a text field to hide the keypad
    UITapGestureRecognizer *gestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideKeyboard)];
    gestureRecognizer.cancelsTouchesInView = NO;
    [self.tableView addGestureRecognizer:gestureRecognizer];
    //set up the display values
    [self configureSettingsDisplay];
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

# pragma mark - Private functions
-(void) configureSettingsDisplay
{
    self.numberOfEntities.text = [NSString stringWithFormat:@"%i",  settings.entitiesPerSession];
    self.numberOfRepetitions.text = [NSString stringWithFormat:@"%i", settings.entriesPerEntitiy];
    self.numberOfForcedPracticeRounds.text = [NSString stringWithFormat:@"%i", settings.forcedPracticeRounds];
    self.randomStringOrder.on = settings.randomStringOrder;
    self.useOrderSeed.on = settings.useRandomStringOrderSeed;
    self.randomStringOrderSeedValue.text = [NSString stringWithFormat:@"%i", settings.stringOrderSeed];
    self.randomStringSelection.on =settings.randomStringSelection;
    self.useSelectionSeed.on = settings.useRandomStringSelectionSeed;
    self.randomStringSelectionSeedValue.text = [NSString stringWithFormat:@"%i", settings.stringSelectionSeed];
    self.useGroupId.on = settings.useGroupId;
    self.groupId.text = [NSString stringWithFormat:@"%i", settings.selectedGroup];
    self.quitString.text = [settings.quitString copy];
    self.enableHideOnPracticeScreen.on = settings.enableHideButtonOnPracticeScreen;
    self.enableSkipButton.on = settings.enableSkipButton;
    self.skipString.text = [settings.skipString copy];
    // toggle the enabled value for some text fields
    self.randomStringSelectionSeedValue.enabled = (self.randomStringSelection.on && self.useSelectionSeed.on);
    self.randomStringOrderSeedValue.enabled = (self.randomStringOrder.on && self.useOrderSeed.on);
    self.groupId.enabled = self.useGroupId.on;
    self.numberOfVerifyRounds.text = [NSString stringWithFormat:@"%i", settings.verifyRounds];
    self.disableFreePractice.on = settings.disableFreePractice;
    self.disableFreePracticeTextField.on = settings.disableFreePracticeTextField;
}

- (void) hideKeyboard
{
    [self.view endEditing:YES];
}

-(void) confirmSettingsReset
{
    UIAlertView *warning = [[UIAlertView alloc]initWithTitle:@"Reset all settings" message:@"Are you sure you want to reset the settings?" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Reset", nil];
    [warning show];
}

-(void) confirmFileReset
{
    UIAlertView *warning = [[UIAlertView alloc]initWithTitle:@"Revert to original data files" message:@"Are you sure you want to replace the existing data files with the default ones?" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Revert", nil];
    [warning show];
}

-(BOOL) isStringNumeric:(NSString*)value
{
    NSError *error = NULL;
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"^\\d+$"
                                                                           options:NSRegularExpressionCaseInsensitive
                                                                           error:&error];
    NSUInteger numberOfMatches = [regex numberOfMatchesInString:value
                                                        options:0
                                                        range:NSMakeRange(0, [value length])];
    return (numberOfMatches > 0);
}


#pragma mark - Table view data source


#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 4) // we selected a reset action
    {
        switch(indexPath.row)
        {
            case 0:             // reset all the settings
                [self confirmSettingsReset];
                break;
                
            case 1:             // copy the original data files back in
                [self confirmFileReset];
                break;
        }
        [self configureSettingsDisplay];
    }
}

-(BOOL)tableView:(UITableView *)tableView shouldHighlightRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.section == 4) return YES;
    return NO;
}

#pragma mark - Alert View Delegate
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    NSString *title= [alertView buttonTitleAtIndex:buttonIndex];
    if ([title isEqualToString:@"Reset"])
    {
        [settings resetToDefaults];
        [self.delegate settingsDetailViewControllerDidResetToDefault];
    }
    else if ([title isEqualToString:@"Revert"])
    {
        [ttSettings copyInitialFilesShouldOverwrite:YES];
        [self.delegate settingsDetailViewControllerDidResetToDefault];
    }
}


- (IBAction)numberOfEntitiesChanged:(id)sender
{
    if ([self isStringNumeric:self.numberOfEntities.text])
    {
        [self.delegate settingsDetailViewController:self didChangeNumberOfEntries:[self.numberOfEntities.text intValue]];
    }
}

- (IBAction)numberOfRepetitionsChanged:(id)sender
{
    if ([self isStringNumeric:self.numberOfRepetitions.text])
    {
        [self.delegate settingsDetailViewController:self didChangeNumberOfRepetitions:[self.numberOfRepetitions.text intValue]];
    }
}

- (IBAction)numberOfForcedPracticeRoundsChanged:(id)sender
{
    if([self isStringNumeric:self.numberOfForcedPracticeRounds.text])
    {
        [self.delegate settingsDetailViewController:self didChangeNumberOfForcedPracticeRounds:[self.numberOfForcedPracticeRounds.text intValue]];
    }
}

-(IBAction)numberOfVerifyRoundsChanged:(id)sender
{
    if ([self isStringNumeric:self.numberOfVerifyRounds.text])
    {
        [self.delegate settingsDetailViewController:self didChangeNumberOfVerifyRounds:[self.numberOfVerifyRounds.text intValue]];
    }
}

- (IBAction)randomStringOrderChanged:(id)sender
{
    [self.delegate settingsDetailViewController:self didChangeRandomStringOrder:self.randomStringOrder.on];
    self.useOrderSeed.enabled = self.randomStringOrder.on;
    self.randomStringOrderSeedValue.enabled = (self.useOrderSeed.on && self.randomStringOrder.on);
}

- (IBAction)useOrderSeedChanged:(id)sender
{
    [self.delegate settingsDetailViewController:self didChangeUseOrderSeed:self.useOrderSeed.on];
    self.randomStringOrderSeedValue.enabled = self.useOrderSeed.on;
}

- (IBAction)orderSeedValueChanged:(id)sender
{
    if([self isStringNumeric:self.randomStringOrderSeedValue.text])
    {
        [self.delegate settingsDetailViewController:self didChangeOrderSeedValue:[self.randomStringOrderSeedValue.text intValue]];
    }
}

- (IBAction)useRandomStringSelectionChanged:(id)sender
{
    [self.delegate settingsDetailViewController:self didChangeRandomStringSelection:self.randomStringSelection.on];
    self.useSelectionSeed.enabled = self.randomStringSelection.on;
    self.randomStringSelectionSeedValue.enabled = (self.useSelectionSeed.on && self.randomStringSelection.on);
}

- (IBAction)useSelectionSeedChanged:(id)sender
{
    [self.delegate settingsDetailViewController:self didChangeUseSelectionSeed:self.useSelectionSeed.on];
    self.randomStringSelectionSeedValue.enabled = (self.useSelectionSeed.on && self.randomStringSelection.on);
}

- (IBAction)selectionSeedValueChanged:(id)sender
{
    if ([self isStringNumeric:self.randomStringSelectionSeedValue.text])
    {
        [self.delegate settingsDetailViewController:self didChangeUseSelectionSeed:[self.randomStringSelectionSeedValue.text intValue]];
    }
}

- (IBAction)useGroupIdValueChanged:(id)sender
{
    [self.delegate settingsDetailViewController:self didChangeUseGroupId:self.useGroupId.on];
    self.groupId.enabled = self.useGroupId.on;
}

- (IBAction)groupIdValueChanged:(id)sender
{
    if ([self isStringNumeric:self.groupId.text])
    {
        [self.delegate settingsDetailViewController:self didChangeGroupId:[self.groupId.text intValue]];
    }
}

- (IBAction)quitStringChanged:(id)sender
{
    if (![self.quitString.text isEqualToString:@""])
    {
        [self.delegate settingsDetailViewController:self didChangeQuitString:[self.quitString.text copy]];
    }
}

- (IBAction)skipStringChanged:(id)sender
{
    if (![self.skipString.text isEqualToString:@""])
    {
        [self.delegate settingsDetailViewController:self didChangeSkipString:[self.skipString.text copy]];
    }
}

- (IBAction)enableHideOnPracticeScreenChanged:(id)sender
{
    [self.delegate settingsDetailViewController:self didChangeEnableHideOnPracticeScreen:self.enableHideOnPracticeScreen.on];
}

- (IBAction)enableSkipButtonChanged:(id)sender
{
    [self.delegate settingsDetailViewController:self didChangeEnableSkipButton:self.enableSkipButton.on];
}

- (IBAction)disableFreePracticeChanged:(id)sender
{
    [self.delegate settingsDetailViewController:self didChangeFreePracticeDisabled:self.disableFreePractice.on];
}

- (IBAction)disableFreePracticeTextFieldChanged:(id)sender
{
    [self.delegate settingsDetailViewController:self didChangeFreePracticeTextFieldDisabled:self.disableFreePracticeTextField.on];
}

@end
