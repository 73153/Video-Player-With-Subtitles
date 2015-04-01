//
//  ttSettingsViewController.m
//  TypingTester
//
//  Created by Matthew Kerr on 7/31/13.
//

#import "ttSettingsViewController.h"
#import "ttSettings.h"

@interface ttSettingsViewController ()

@end

@implementation ttSettingsViewController
{
    ttSettings* settings;
    
    ttSettingsDetailViewController* child;

    NSUInteger stringsPerSession;
    NSUInteger entriesPerString;
    NSUInteger forcedPracticeRounds;
    bool showQuitButton;
    bool showSkipButton;
    bool randomStringOrder;
    bool randomStringSelection;
    NSUInteger stringOrderKey;
    NSUInteger stringSelectionKey;
    bool useRandomStringOrderSeed;
    bool useRandomStringSelectionSeed;
    NSString *quitString;
    NSString *skipString;
    bool useGroupId;
    NSUInteger selectedGroup;
    NSArray *selectedFilters;
    bool firstRun;
    bool enableHideButtonOnPracticeScreen;
    bool enableSkipButton;
    NSUInteger verifyRounds;
    bool disableFreePractice;
    bool disableFreePracticeTextField;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self)
    {
        settings = [ttSettings Instance];
    }
    return self;
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    stringsPerSession = settings.entitiesPerSession;
    entriesPerString = settings.entriesPerEntitiy;
    forcedPracticeRounds = settings.forcedPracticeRounds;
    showQuitButton = settings.showQuitButton;
    showSkipButton = settings.showSkipButton;
    randomStringOrder = settings.randomStringOrder;
    randomStringSelection = settings.randomStringSelection;
    stringOrderKey = settings.stringOrderSeed;
    stringSelectionKey = settings.stringSelectionSeed;
    useRandomStringOrderSeed = settings.useRandomStringOrderSeed;
    useRandomStringSelectionSeed = settings.useRandomStringSelectionSeed;
    quitString = [settings.quitString copy];
    skipString = [settings.skipString copy];
    useGroupId = settings.useGroupId;
    selectedGroup = settings.selectedGroup;
    enableHideButtonOnPracticeScreen = settings.enableHideButtonOnPracticeScreen;
    verifyRounds = settings.verifyRounds;
    disableFreePractice = settings.disableFreePractice;
    disableFreePracticeTextField = settings.disableFreePracticeTextField;
    [self configureUI];
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

-(void)configureUI
{
    
}

#pragma mark IBActions

-(IBAction)backgroundButtonPressed:(id)sender
{
    [child hideKeyboard];
}

-(IBAction)cancel:(id)sender
{
    [self executeSegueWithIdentifier:@"CancelSettings" sender:self];
}

-(IBAction)save:(id)sender
{
    [child hideKeyboard];
    [self executeSegueWithIdentifier:@"SaveSettings" sender:self];
}

-(void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"SettingDetails"])
    {
        child = segue.destinationViewController;
        child.delegate = self;
    }
    else if ([segue.identifier isEqualToString:@"SaveSettings"])
    {
        [self saveSettings];
    }
}

-(void)executeSegueWithIdentifier:(NSString *)identifier sender:(id)sender
{
    if ([self shouldPerformSegueWithIdentifier:identifier sender:sender] == YES)
    {
        [self performSegueWithIdentifier:identifier sender:sender];
    }
}

-( BOOL) shouldPerformSegueWithIdentifier:(NSString *)identifier sender:(id)sender
{
    // check validity of saved settings
    if ([identifier isEqualToString:@"SaveSettings"])
    {
        if (disableFreePractice == NO || forcedPracticeRounds > 0)
        {
            return YES;
        }
        
        [[[UIAlertView alloc] initWithTitle:nil
                              message:@"Forced Practice rounds must be > 0 when Free Practice is disabled"
                              delegate:nil
                              cancelButtonTitle:@"OK"
                              otherButtonTitles:nil] show];
        return NO;
    }
    // default is to allow the segue
    return YES;
}

-(void) saveSettings
{
    settings.entitiesPerSession = stringsPerSession;
    settings.entriesPerEntitiy = entriesPerString;
    settings.forcedPracticeRounds = forcedPracticeRounds;
    settings.showQuitButton = showQuitButton;
    settings.showSkipButton = showSkipButton;
    settings.randomStringOrder = randomStringOrder;
    settings.randomStringSelection = randomStringSelection;
    settings.stringOrderSeed = stringOrderKey;
    settings.stringSelectionSeed = stringSelectionKey;
    settings.useRandomStringOrderSeed = useRandomStringOrderSeed;
    settings.useRandomStringSelectionSeed = useRandomStringSelectionSeed;
    settings.quitString = quitString;
    settings.useGroupId = useGroupId;
    settings.selectedGroup = selectedGroup;
    settings.enableHideButtonOnPracticeScreen = enableHideButtonOnPracticeScreen;
    settings.skipString = skipString;
    settings.verifyRounds = verifyRounds;
    settings.disableFreePractice = disableFreePractice;
    settings.disableFreePracticeTextField = disableFreePracticeTextField;
    // force saving of defaults when settings return with a saved value
    [[NSUserDefaults standardUserDefaults] synchronize];
}

#pragma mark - Settings Detail View Controller Delegate

-(void)settingsDetailViewControllerDidResetToDefault
{
    [self.delegate SettingsViewControllerDidSave:self];
}

-(void)settingsDetailViewController:(ttSettingsDetailViewController*)controller didChangeNumberOfEntries:(int)value
{
    stringsPerSession = value;
}

-(void)settingsDetailViewController:(ttSettingsDetailViewController *)controller didChangeNumberOfRepetitions:(int)value
{
    entriesPerString = value;
}

-(void)settingsDetailViewController:(ttSettingsDetailViewController *)controller didChangeNumberOfForcedPracticeRounds:(int)value
{
    forcedPracticeRounds = value;
}

-(void)settingsDetailViewController:(ttSettingsDetailViewController *)controller didChangeRandomStringOrder:(BOOL)value
{
    randomStringOrder = value;
}

-(void)settingsDetailViewController:(ttSettingsDetailViewController *)controller didChangeUseOrderSeed:(BOOL)value
{
    useRandomStringOrderSeed = value;
}

-(void)settingsDetailViewController:(ttSettingsDetailViewController *)controller didChangeOrderSeedValue:(int)value
{
    stringOrderKey = value;
}

-(void)settingsDetailViewController:(ttSettingsDetailViewController *)controller didChangeRandomStringSelection:(BOOL)value
{
    randomStringSelection = value;
}

-(void)settingsDetailViewController:(ttSettingsDetailViewController *)controller didChangeUseSelectionSeed:(BOOL)value
{
    useRandomStringSelectionSeed = value;
}

-(void)settingsDetailViewController:(ttSettingsDetailViewController *)controller didChangeSelectionSeedValue:(int)value
{
    stringSelectionKey = value;
}

-(void)settingsDetailViewController:(ttSettingsDetailViewController *)controller didChangeUseGroupId:(BOOL)value
{
    useGroupId = value;
}

-(void)settingsDetailViewController:(ttSettingsDetailViewController *)controller didChangeGroupId:(int)value
{
    selectedGroup = value;
}

-(void)settingsDetailViewController:(ttSettingsDetailViewController *)controller didChangeQuitString:(NSString*)value
{
    quitString = value;
}

-(void)settingsDetailViewController:(ttSettingsDetailViewController *)controller didChangeSkipString:(NSString*)value
{
    skipString = value;
}

-(void)settingsDetailViewController:(ttSettingsDetailViewController *)controller didChangeEnableHideOnPracticeScreen:(BOOL)value
{
    enableHideButtonOnPracticeScreen = value;
}

-(void)settingsDetailViewController:(ttSettingsDetailViewController *)controller didChangeEnableSkipButton:(BOOL)value
{
    enableSkipButton = value;
}

-(void)settingsDetailViewController:(ttSettingsDetailViewController *)controller didChangeNumberOfVerifyRounds:(int)value
{
    verifyRounds = value;
}

-(void)settingsDetailViewController:(ttSettingsDetailViewController *)controller didChangeFreePracticeDisabled:(BOOL)value
{
    disableFreePractice = value;
}

-(void)settingsDetailViewController:(ttSettingsDetailViewController *)controller didChangeFreePracticeTextFieldDisabled:(BOOL)value
{
    disableFreePracticeTextField = value;
}


@end
