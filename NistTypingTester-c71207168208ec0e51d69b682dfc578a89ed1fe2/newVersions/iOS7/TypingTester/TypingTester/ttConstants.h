//
//  ttConstants.h
//  TypingTester
//
//  Created by Matthew Kerr on 8/8/13.
//

#import <Foundation/Foundation.h>

FOUNDATION_EXPORT NSString *const ttcStringsForTestKey;
FOUNDATION_EXPORT NSString *const ttcEntriesPerTestKey;
FOUNDATION_EXPORT NSString *const ttcForcedPracticeRoundsKey;
FOUNDATION_EXPORT NSString *const ttcShowQuitButtonKey;
FOUNDATION_EXPORT NSString *const ttcShowSkipButtonKey;
FOUNDATION_EXPORT NSString *const ttcRandomStringOrderKey;
FOUNDATION_EXPORT NSString *const ttcRandomStringSelectionKey;
FOUNDATION_EXPORT NSString *const ttcQuitStringKey;
FOUNDATION_EXPORT NSString *const ttcStringOrderSeedKey;
FOUNDATION_EXPORT NSString *const ttcStringSelectionSeedKey;
FOUNDATION_EXPORT NSString *const ttcUseRandomStringOrderSeedKey;
FOUNDATION_EXPORT NSString *const ttcUseRandomStringSelectionSeedKey;
FOUNDATION_EXPORT NSString *const ttcSelectedFiltersKey;
FOUNDATION_EXPORT NSString *const ttcSelectedGroupKey;
FOUNDATION_EXPORT NSString *const ttcUseGroupFilterKey;
FOUNDATION_EXPORT NSString *const ttcFirstRunKey;
FOUNDATION_EXPORT NSString *const ttcEnableHideButtonOnPracticeScreenKey;
FOUNDATION_EXPORT NSString *const ttcProficiencyGroupKey;
FOUNDATION_EXPORT NSString *const ttcSkipStringKey;
FOUNDATION_EXPORT NSString *const ttcVerifyRoundsKey;
FOUNDATION_EXPORT NSString *const ttcDisableFreePracticeKey;
FOUNDATION_EXPORT NSString *const ttcDisableFreePracticeTextFieldKey;

FOUNDATION_EXPORT const NSUInteger ttcStringsForTestDefaultValue;
FOUNDATION_EXPORT const NSUInteger ttcEntriesPerTestDefaultValue;
FOUNDATION_EXPORT const NSUInteger ttcForcedPracticeRoundsDefaultValue;
FOUNDATION_EXPORT const NSUInteger ttcStringOrderSeedDefaultValue;
FOUNDATION_EXPORT const NSUInteger ttcStringSelectionSeedDefaultValue;
FOUNDATION_EXPORT const NSUInteger ttcSelectedGroupValue;
FOUNDATION_EXPORT const NSUInteger ttcProficiencyGroupValue;
FOUNDATION_EXPORT const NSUInteger ttcVerifyRoundsValue;

FOUNDATION_EXPORT const bool ttcShowQuitButtonDefaultValue;
FOUNDATION_EXPORT const bool ttcShowSkipButtonDefaultValue;
FOUNDATION_EXPORT const bool ttcRandomStringOrderDefaultValue;
FOUNDATION_EXPORT const bool ttcRandomStringSelectionDefaultValue;
FOUNDATION_EXPORT const bool ttcUseRandomStringOrderSeedDefaultValue;
FOUNDATION_EXPORT const bool ttcUseRandomStringSelectionSeedDefaultValue;
FOUNDATION_EXPORT const bool ttcEnableHideButtonOnPracticeScreenValue;
FOUNDATION_EXPORT const bool ttcUseGroupFilterDefaultValue;
FOUNDATION_EXPORT const bool ttcDisableFreePracticeDefaultValue;
FOUNDATION_EXPORT const bool ttcDisableFreePracticeTextFieldValue;

FOUNDATION_EXPORT NSString *const ttcQuitStringDefaultValue;
FOUNDATION_EXPORT NSString *const ttcSkipStringDefaultValue;

FOUNDATION_EXPORT NSString *const ttcPhaseStringArray[];
FOUNDATION_EXPORT NSString *const ttcSubPhaseStringArray[];
FOUNDATION_EXPORT NSString *const ttcEventTypeStringArray[];
FOUNDATION_EXPORT NSString *const ttcSpecialKeyStringArray[];
FOUNDATION_EXPORT NSString *const ttcKeyboardModeStringArray[];

typedef enum
{
    UnknownEvent,
    Input,
    PhaseBegin,
    PhaseEnd,
    Touch,
    SubPhaseChange,
    ProficiencyStringShown,
    EntityDisplayed,
    ControlActivated,
    SpecialKeyPressed,
    OrientationChange,
    KeyboardShown,
    KeyboardHidden,
    KeyboardTouch,
    IncorrectValueEntered,
    CorrectValueEntered
} Event;

typedef enum
{
    UnknownPhase,
    Proficiency,
    Introduction,
    Memorize,
    Entry,
    Recall,
    ThankYou
} Phase;

typedef enum
{
    UnknownSubPhase,
    FreePractice,
    ForcedPractice,
    Verify,
    EntityChange,
    NoSubPhase
}SubPhase;

// defines special keys that can be pressed on the keyboard/detected
// SpecialKeyOffKeyboard  defines the bounds off the displayed keyboard
typedef enum
{
    SpecialKeyNone,
    SpecialKeyShift,
    SpecialKeyShiftRight,
    SpecialKeyKeyboardChange,
    SpecialKeyKeyboardChangeRight,
    SpecialKeyReturn,
    SpecialKeyHideKeyboard,
    SpecialKeyDelete,
    SpecialKeyUndo,
    SpecialKeyOffKeyboard
} SpecialKey;

typedef enum
{
    Alphabetic,
    Numeric,
    Symbol,
    UnknownMode
} KeyboardMode;


