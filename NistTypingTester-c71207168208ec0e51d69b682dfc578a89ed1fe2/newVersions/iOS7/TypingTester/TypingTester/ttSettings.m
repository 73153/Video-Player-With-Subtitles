//
//  ttSettings.m
//  A singleton object to manage the program settings.
//
//  Created by Matthew Kerr on 8/8/13.
//

#import "ttSettings.h"
#import "ttConstants.h"
#import "ttUtilities.h"

@implementation ttSettings
{
    
}

static ttSettings *instance = nil;

+(ttSettings*) Instance
{
    static dispatch_once_t _singletonPredicate;
    
    dispatch_once(&_singletonPredicate, ^{ instance = [[self alloc] init];});
    
    return instance;
}

-(id) init
{
    self = [super init];
    if (self)
    {
        
    }
    return self;
}

-(NSString*)getSettings
{
    NSMutableString *string = [[NSMutableString alloc]init];
    [string appendFormat:@"Settings:\n"];
    [string appendFormat:@"Password:%lu\n", (unsigned long)self.entitiesPerSession];
    [string appendFormat:@"Rounds Per Password:%lu\n", (unsigned long)self.entriesPerEntitiy];
    [string appendFormat:@"Forced Practice Rounds:%lu\n", (unsigned long)self.forcedPracticeRounds];
    [string appendFormat:@"Verify Rounds:%lu\n", (unsigned long)self.verifyRounds];
    [string appendFormat:@"Random String Order:%@\n", (self.randomStringOrder ? @"Yes":@"No")];
    [string appendFormat:@"Specified Seed:%@\n", (self.useRandomStringOrderSeed ? @"Yes":@"No")];
    [string appendFormat:@"String Order Seed:%lu\n", (unsigned long)self.effectiveOrderSeed];
    [string appendFormat:@"Random String Selection:%@\n", (self.randomStringSelection ? @"Yes":@"No")];
    [string appendFormat:@"Specified Seed:%@\n", (self.useRandomStringSelectionSeed ? @"Yes":@"No")];
    [string appendFormat:@"String Selection Seed:%lu\n", (unsigned long)self.effectiveSelectionSeed];
    [string appendFormat:@"Use Group Id:%@\n", (self.useGroupId ? @"Yes":@"No")];
    [string appendFormat:@"Group Id:%lu\n", (unsigned long)self.selectedGroup];
    [string appendFormat:@"Disabled Free Practice:%@\n", (self.disableFreePractice ? @"Yes":@"No")];
    [string appendFormat:@"Disable Free Practice Text Field:%@\n", (self.disableFreePracticeTextField ? @"Yes":@"No")];
    return string;
}


#pragma mark DefaultValuesSection

-(void) registerDefaults
{
    NSMutableDictionary *defaults = [[NSMutableDictionary alloc]init];
    [defaults setValue:[NSNumber numberWithBool:YES] forKey:ttcFirstRunKey];
    [defaults setValue:[NSNumber numberWithUnsignedInteger:ttcStringsForTestDefaultValue] forKey:ttcStringsForTestKey];
    [defaults setValue:[NSNumber numberWithUnsignedInteger:ttcEntriesPerTestDefaultValue] forKey:ttcEntriesPerTestKey];
    [defaults setValue:[NSNumber numberWithUnsignedInteger:ttcForcedPracticeRoundsDefaultValue] forKey:ttcForcedPracticeRoundsKey];
    [defaults setValue:[NSNumber numberWithBool:ttcShowQuitButtonDefaultValue] forKey:ttcShowQuitButtonKey];
    [defaults setValue:[NSNumber numberWithBool:ttcShowSkipButtonDefaultValue] forKey:ttcShowSkipButtonKey];
    [defaults setValue:[NSNumber numberWithBool:ttcRandomStringOrderDefaultValue] forKey:ttcRandomStringOrderKey];
    [defaults setValue:[NSNumber numberWithBool:ttcRandomStringSelectionDefaultValue] forKey:ttcRandomStringSelectionKey];
    [defaults setValue:ttcQuitStringDefaultValue forKey:ttcQuitStringKey];
    [defaults setValue:[NSNumber numberWithUnsignedInteger:ttcStringOrderSeedDefaultValue] forKey:ttcStringOrderSeedKey];
    [defaults setValue:[NSNumber numberWithUnsignedInteger:ttcStringSelectionSeedDefaultValue] forKey:ttcStringSelectionSeedKey];
    [defaults setValue:[NSNumber numberWithBool:ttcUseRandomStringOrderSeedDefaultValue] forKey:ttcUseRandomStringOrderSeedKey];
    [defaults setValue:[NSNumber numberWithBool:ttcUseRandomStringSelectionSeedDefaultValue] forKey:ttcUseRandomStringSelectionSeedKey];
    [defaults setValue:[NSNumber numberWithUnsignedInteger:ttcSelectedGroupValue] forKey:ttcSelectedGroupKey];
    [defaults setValue:[NSNumber numberWithBool:ttcUseGroupFilterDefaultValue] forKey:ttcUseGroupFilterKey];
    [defaults setValue:[[NSArray alloc]init] forKey:ttcSelectedFiltersKey];
    [defaults setValue:[NSNumber numberWithBool:ttcEnableHideButtonOnPracticeScreenValue] forKey:ttcEnableHideButtonOnPracticeScreenKey];
    [defaults setValue:[NSNumber numberWithUnsignedInteger:ttcProficiencyGroupValue] forKey:ttcProficiencyGroupKey];
    [defaults setValue:ttcSkipStringDefaultValue forKey:ttcSkipStringKey];
    [defaults setValue:[NSNumber numberWithUnsignedInteger:ttcVerifyRoundsValue] forKey:ttcVerifyRoundsKey];
    [defaults setValue:[NSNumber numberWithBool:ttcDisableFreePracticeDefaultValue] forKey:ttcDisableFreePracticeKey];
    [defaults setValue:[NSNumber numberWithBool:ttcDisableFreePracticeTextFieldValue] forKey:ttcDisableFreePracticeTextFieldKey];
    [[NSUserDefaults standardUserDefaults]registerDefaults:defaults];
}

// resets the default values, will not erase any custom settings (yet)
-(void) resetToDefaults
{
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    [prefs setInteger:ttcStringsForTestDefaultValue forKey:ttcStringsForTestKey];
    [prefs setInteger:ttcEntriesPerTestDefaultValue forKey:ttcEntriesPerTestKey];
    [prefs setInteger:ttcForcedPracticeRoundsDefaultValue forKey:ttcForcedPracticeRoundsKey];
    [prefs setBool:ttcShowQuitButtonDefaultValue forKey:ttcShowQuitButtonKey];
    [prefs setBool:ttcShowSkipButtonDefaultValue forKey:ttcShowSkipButtonKey];
    [prefs setBool:ttcRandomStringOrderDefaultValue forKey:ttcRandomStringOrderKey];
    [prefs setBool:ttcRandomStringSelectionDefaultValue forKey:ttcRandomStringSelectionKey];
    [prefs setObject:ttcQuitStringDefaultValue forKey:ttcQuitStringKey];
    [prefs setInteger:ttcStringOrderSeedDefaultValue forKey:ttcStringOrderSeedKey];
    [prefs setInteger:ttcStringSelectionSeedDefaultValue forKey:ttcStringSelectionSeedKey];
    [prefs setBool:ttcUseRandomStringOrderSeedDefaultValue forKey:ttcUseRandomStringOrderSeedKey];
    [prefs setBool:ttcUseRandomStringSelectionSeedDefaultValue forKey:ttcUseRandomStringSelectionSeedKey];
    [prefs setInteger:ttcSelectedGroupValue forKey:ttcSelectedGroupKey];
    [prefs setObject:[[NSArray alloc]init] forKey:ttcSelectedFiltersKey];
    [prefs setBool:YES forKey:ttcFirstRunKey];
    [prefs setBool:ttcEnableHideButtonOnPracticeScreenValue forKey:ttcEnableHideButtonOnPracticeScreenKey];
    [prefs setInteger:ttcProficiencyGroupValue forKey:ttcProficiencyGroupKey];
    [prefs setValue:ttcSkipStringDefaultValue forKey:ttcSkipStringKey];
    [prefs setInteger:ttcVerifyRoundsValue forKey:ttcVerifyRoundsKey];
    [prefs setBool:ttcUseGroupFilterDefaultValue forKey:ttcUseGroupFilterKey];
    [prefs setBool:ttcDisableFreePracticeDefaultValue forKey:ttcDisableFreePracticeKey];
    [prefs setBool:ttcDisableFreePracticeTextFieldValue forKey:ttcDisableFreePracticeTextFieldKey];
}

#pragma mark Custom setter/getter pairs

-(NSUInteger) entitiesPerSession
{
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    return [prefs integerForKey:ttcStringsForTestKey];
}

-(void) setEntitiesPerSession:(NSUInteger)StringsPerSession
{
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    [prefs setInteger:StringsPerSession forKey:ttcStringsForTestKey];
}

-(NSUInteger) entriesPerEntitiy
{
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    return [prefs integerForKey:ttcEntriesPerTestKey];
}

-(void) setEntriesPerEntitiy:(NSUInteger)EntriesPerString
{
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    [prefs setInteger:EntriesPerString forKey:ttcEntriesPerTestKey];
}

-(NSUInteger) forcedPracticeRounds
{
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    return [prefs integerForKey:ttcForcedPracticeRoundsKey];
}

-(void) setForcedPracticeRounds:(NSUInteger)ForcedPracticeRounds
{
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    [prefs setInteger:ForcedPracticeRounds forKey:ttcForcedPracticeRoundsKey];
}

-(bool) showQuitButton
{
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    return [prefs boolForKey:ttcShowQuitButtonKey];
}

-(void) setShowQuitButton:(bool)ShowQuitButton
{
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    [prefs setBool:ShowQuitButton forKey:ttcShowQuitButtonKey];
}

-(bool) showSkipButton
{
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    return [prefs boolForKey:ttcShowSkipButtonKey];
}

-(void) setShowSkipButton:(bool)ShowSkipButton
{
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    [prefs setBool:ShowSkipButton forKey:ttcShowSkipButtonKey];
}

-(bool) randomStringOrder
{
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    return [prefs boolForKey:ttcRandomStringOrderKey];
}

-(void) setRandomStringOrder:(bool)RandomStringOrder
{
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    [prefs setBool:RandomStringOrder forKey:ttcRandomStringOrderKey];
}

-(bool) randomStringSelection
{
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    return [prefs boolForKey:ttcRandomStringSelectionKey];
}

-(void) setRandomStringSelection:(bool)RandomStringSelection
{
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    [prefs setBool:RandomStringSelection forKey:ttcRandomStringSelectionKey];
}

-(NSUInteger) stringOrderSeed
{
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    return [prefs integerForKey:ttcStringOrderSeedKey];
}

-(void) setStringOrderSeed:(NSUInteger)StringOrderKey
{
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    [prefs setInteger:StringOrderKey forKey:ttcStringOrderSeedKey];
}

-(NSUInteger) stringSelectionSeed
{
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    return [prefs integerForKey:ttcStringSelectionSeedKey];
}

-(void) setStringSelectionSeed:(NSUInteger)StringSelectionKey
{
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    [prefs setInteger:StringSelectionKey forKey:ttcStringSelectionSeedKey];
}

-(bool) useRandomStringOrderSeed
{
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    return [prefs boolForKey:ttcUseRandomStringOrderSeedKey];
}

-(void) setUseRandomStringOrderSeed:(bool)UseRandomStringOrderSeedKey
{
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    [prefs setBool:UseRandomStringOrderSeedKey forKey:ttcUseRandomStringOrderSeedKey];
}

-(bool) useRandomStringSelectionSeed
{
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    return [prefs boolForKey:ttcUseRandomStringSelectionSeedKey];
}

-(void)setUseRandomStringSelectionSeed:(bool)UseRandomStringSelectionSeedKey
{
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    [prefs setBool:UseRandomStringSelectionSeedKey forKey:ttcUseRandomStringSelectionSeedKey];
}

-(NSString*) quitString
{
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    return [prefs stringForKey:ttcQuitStringKey];
    
}

-(void) setQuitString:(NSString *)QuitString
{
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    [prefs setObject:QuitString forKey:ttcQuitStringKey];
}

-(NSUInteger) selectedGroup
{
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    return [prefs integerForKey:ttcSelectedGroupKey];
}

-(void) setSelectedGroup:(NSUInteger)SelectedGroup
{
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    [prefs setInteger:SelectedGroup forKey:ttcSelectedGroupKey];
}

-(bool) useGroupId
{
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    return [prefs boolForKey:ttcUseGroupFilterKey];
}

- (void)setUseGroupId:(bool)useGroupIdValue
{
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    [prefs setBool:useGroupIdValue forKey:ttcUseGroupFilterKey];
}

-(bool) firstRun
{
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    return [prefs boolForKey:ttcFirstRunKey];
}

-(void) setFirstRun:(bool)FirstRun
{
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    [prefs setBool:FirstRun forKey:ttcFirstRunKey];
}

-(bool) enableHideButtonOnPracticeScreen
{
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    return [prefs boolForKey:ttcEnableHideButtonOnPracticeScreenKey];
}

-(void) setEnableHideButtonOnPracticeScreen:(bool)EnableHideButtonOnPracticeScreen
{
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    [prefs setBool:EnableHideButtonOnPracticeScreen forKey:ttcEnableHideButtonOnPracticeScreenKey];
}


-(NSUInteger) proficiencyGroup
{
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    return [prefs integerForKey:ttcProficiencyGroupKey];
}

-(void) setProficiencyGroup:(NSUInteger)proficiencyGroup
{
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    [prefs setInteger:proficiencyGroup forKey:ttcProficiencyGroupKey];
}

-(NSString*) skipString
{
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    return [prefs stringForKey:ttcSkipStringKey];
}

-(void) setSkipString:(NSString *)skipString
{
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    [prefs setObject:skipString forKey:ttcSkipStringKey];
}

-(NSUInteger) verifyRounds
{
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    return [prefs integerForKey:ttcVerifyRoundsKey];
}

-(void) setVerifyRounds:(NSUInteger)verifyRounds
{
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    [prefs setInteger:verifyRounds forKey:ttcVerifyRoundsKey];
}

-(bool) disableFreePractice
{
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    return [prefs boolForKey:ttcDisableFreePracticeKey];
}

-(void) setDisableFreePractice:(bool)disableFreePractice
{
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    [prefs setBool:disableFreePractice forKey:ttcDisableFreePracticeKey];
}

-(bool) disableFreePracticeTextField
{
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    return [prefs boolForKey:ttcDisableFreePracticeTextFieldKey];
}

-(void) setDisableFreePracticeTextField:(bool)disableFreePracticeTextField
{
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    [prefs setBool:disableFreePracticeTextField forKey:ttcDisableFreePracticeTextFieldKey];
}


#pragma mark setup functions

+(void) copyInitialFilesShouldOverwrite:(BOOL)overwrite
{
    [self copyToDocumentsResourceFileNamed:@"welcome" ofType:@"html" toFileName:@"welcome.html" shouldOverwrite:overwrite];
    [self copyToDocumentsResourceFileNamed:@"welcome-iPad" ofType:@"html" toFileName:@"welcome-iPad.html" shouldOverwrite:overwrite];
    [self copyToDocumentsResourceFileNamed:@"instructions" ofType:@"html" toFileName:@"instructions.html" shouldOverwrite:overwrite];
    [self copyToDocumentsResourceFileNamed:@"instructions-iPad" ofType:@"html" toFileName:@"instructions-iPad.html" shouldOverwrite:overwrite];
    [self copyToDocumentsResourceFileNamed:@"thankYou" ofType:@"html" toFileName:@"thankYou.html" shouldOverwrite:overwrite];
    [self copyToDocumentsResourceFileNamed:@"thankYou-iPad" ofType:@"html" toFileName:@"thankYou-iPad.html" shouldOverwrite:overwrite];
    
    [self copyToDocumentsResourceFileNamed:@"instructionsHeader" ofType:@"fhtm" toFileName:@"instructionsHeader.fhtm" shouldOverwrite:overwrite];
    [self copyToDocumentsResourceFileNamed:@"instructionsFreePractice" ofType:@"fhtm" toFileName:@"instructionsFreePractice.fhtm" shouldOverwrite:overwrite];
    [self copyToDocumentsResourceFileNamed:@"instructionsForcedPractice" ofType:@"fhtm" toFileName:@"instructionsForcedPractice.fhtm" shouldOverwrite:overwrite];
    [self copyToDocumentsResourceFileNamed:@"instructionsVerify" ofType:@"fhtm" toFileName:@"instructionsVerify.fhtm" shouldOverwrite:overwrite];
    [self copyToDocumentsResourceFileNamed:@"instructionsEntry" ofType:@"fhtm" toFileName:@"instructionsEntry.fhtm" shouldOverwrite:overwrite];
    [self copyToDocumentsResourceFileNamed:@"instructionsFooter" ofType:@"fhtm" toFileName:@"instructionsFooter.fhtm" shouldOverwrite:overwrite];
    
    [self copyToDocumentsResourceFileNamed:@"instructionsHeader-iPad" ofType:@"fhtm" toFileName:@"instructionsHeader-iPad.fhtm" shouldOverwrite:overwrite];
    [self copyToDocumentsResourceFileNamed:@"instructionsFreePractice-iPad" ofType:@"fhtm" toFileName:@"instructionsFreePractice-iPad.fhtm" shouldOverwrite:overwrite];
    [self copyToDocumentsResourceFileNamed:@"instructionsForcedPractice-iPad" ofType:@"fhtm" toFileName:@"instructionsForcedPractice-iPad.fhtm" shouldOverwrite:overwrite];
    [self copyToDocumentsResourceFileNamed:@"instructionsVerify-iPad" ofType:@"fhtm" toFileName:@"instructionsVerify-iPad.fhtm" shouldOverwrite:overwrite];
    [self copyToDocumentsResourceFileNamed:@"instructionsEntry-iPad" ofType:@"fhtm" toFileName:@"instructionsEntry-iPad.fhtm" shouldOverwrite:overwrite];
    [self copyToDocumentsResourceFileNamed:@"instructionsFooter-iPad" ofType:@"fhtm" toFileName:@"instructionsFooter-iPad.fhtm" shouldOverwrite:overwrite];
    
    [self copyToDocumentsResourceFileNamed:@"inputStrings" ofType:@"xml" toFileName:@"inputStrings.xml" shouldOverwrite:overwrite];
}

+(void) copyToDocumentsResourceFileNamed:(NSString*)sourceName ofType:(NSString*)type toFileName:(NSString*)destinationName shouldOverwrite:(BOOL)overwrite
{
    NSString *documentsDirectory = [ttUtilities documentsDirectory];
    NSString *destinationFile = [documentsDirectory stringByAppendingPathComponent:destinationName];
    NSString *sourceFile = [[NSBundle mainBundle] pathForResource:sourceName ofType:type];
    if (sourceFile != nil)
    {
        [ttUtilities copySourceFile:sourceFile toDestination:destinationFile shouldOverwrite:overwrite];
    }
}

@end
