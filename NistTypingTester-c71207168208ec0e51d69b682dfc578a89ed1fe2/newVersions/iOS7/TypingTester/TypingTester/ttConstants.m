//
//  ttConstants.m
//  TypingTester
//
//  Created by Matthew Kerr on 8/8/13.
//

NSString *const ttcStringsForTestKey = @"StringsForTest";
NSString *const ttcEntriesPerTestKey = @"EntriesPerTest";
NSString *const ttcForcedPracticeRoundsKey = @"ForcedPracticeRounds";
NSString *const ttcShowQuitButtonKey = @"ShowQuitButton";
NSString *const ttcShowSkipButtonKey = @"ShowSkipButton";
NSString *const ttcRandomStringOrderKey = @"RandomStringOrder";
NSString *const ttcRandomStringSelectionKey = @"RandomStringSelection";
NSString *const ttcQuitStringKey = @"QuitString";
NSString *const ttcStringOrderSeedKey = @"StringOrderSeed";
NSString *const ttcStringSelectionSeedKey = @"StringSelectionSeed";
NSString *const ttcUseRandomStringOrderSeedKey = @"UseRandomStringOrderSeed";
NSString *const ttcUseRandomStringSelectionSeedKey = @"UseRandomStringSelectionSeed";
NSString *const ttcSelectedFiltersKey = @"SelectedFilters";
NSString *const ttcSelectedGroupKey = @"SelectedGroup";
NSString *const ttcUseGroupFilterKey = @"UseGroupFilter";
NSString *const ttcFirstRunKey = @"FirstRun";
NSString *const ttcEnableHideButtonOnPracticeScreenKey = @"EnableHideButtonOnPracticeScreen";
NSString *const ttcProficiencyGroupKey = @"ProficiencyGroup";
NSString *const ttcSkipStringKey =@"SkipString";
NSString *const ttcVerifyRoundsKey = @"VerifyRounds";
NSString *const ttcDisableFreePracticeKey = @"DisableFreePractice";
NSString *const ttcDisableFreePracticeTextFieldKey = @"DisableFreePracticeTextField";

const NSUInteger ttcStringsForTestDefaultValue = 10;
const NSUInteger ttcEntriesPerTestDefaultValue = 10;
const NSUInteger ttcForcedPracticeRoundsDefaultValue = 3;
const NSUInteger ttcStringOrderSeedDefaultValue = 1;
const NSUInteger ttcStringSelectionSeedDefaultValue = 1;
const NSUInteger ttcSelectedGroupValue = 1;
const NSUInteger ttcProficiencyGroupValue = 1;
const NSUInteger ttcVerifyRoundsValue = 1;

const bool ttcShowQuitButtonDefaultValue = NO;
const bool ttcShowSkipButtonDefaultValue = NO;
const bool ttcRandomStringOrderDefaultValue = NO;
const bool ttcRandomStringSelectionDefaultValue = NO;
const bool ttcUseRandomStringOrderSeedDefaultValue = NO;
const bool ttcUseRandomStringSelectionSeedDefaultValue = NO;
const bool ttcEnableHideButtonOnPracticeScreenValue = NO;
const bool ttcUseGroupFilterDefaultValue = NO;
const bool ttcDisableFreePracticeDefaultValue = NO;
const bool ttcDisableFreePracticeTextFieldValue = NO;

NSString *const ttcQuitStringDefaultValue = @"I QUIT";
NSString *const ttcSkipStringDefaultValue = @"I SKIP";


NSString *const ttcPhaseStringArray[] = {@"Unknown Phase", @"Proficiency Phase", @"Introduction Phase", @"Memorize Phase",
                                         @"Entry Phase", @"Recall Phase", @"Thank You Phase"};
NSString *const ttcSubPhaseStringArray[] = {@"Unknown SubPhase", @"Free Practice", @"Forced Practice", @"Verify", @"Entity Change", @"None"};
NSString *const ttcEventTypeStringArray[] = {@"Unknown Event", @"Input", @"Phase Begin", @"Phase End", @"Touch", @"Sub Phase Change",
                                             @"Proficiency String Shown", @"Password Displayed", @"Control Activated", @"Special Key Pressed",
                                             @"Orientation Change", @"Keyboard Shown", @"Keyboard Hidden", @"Keyboard Touch", @"Incorrect Value Entered",
                                             @"Correct Value Entered"};
NSString *const ttcSpecialKeyStringArray[] = {@"Unknown Key", @"Shift Key", @"Keyboard Change Key"};
NSString *const ttcKeyboardModeStringArray[] = {@"Alphabetic", @"Numeric", @"Symbol", @"Unknown"};
