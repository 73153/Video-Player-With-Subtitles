//
//  ttSettingsDetailViewController.h
//  TypingTester
//
//  Created by Matthew Kerr on 8/12/13.
//

#import <UIKit/UIKit.h>

@class ttSettingsDetailViewController;

@protocol SettingsDetailViewControllerDelegate <NSObject>

-(void)settingsDetailViewControllerDidResetToDefault;
-(void)settingsDetailViewController:(ttSettingsDetailViewController*)controller didChangeNumberOfEntries:(int)value;
-(void)settingsDetailViewController:(ttSettingsDetailViewController *)controller didChangeNumberOfRepetitions:(int)value;
-(void)settingsDetailViewController:(ttSettingsDetailViewController *)controller didChangeNumberOfForcedPracticeRounds:(int)value;
-(void)settingsDetailViewController:(ttSettingsDetailViewController *)controller didChangeRandomStringOrder:(BOOL)value;
-(void)settingsDetailViewController:(ttSettingsDetailViewController *)controller didChangeUseOrderSeed:(BOOL)value;
-(void)settingsDetailViewController:(ttSettingsDetailViewController *)controller didChangeOrderSeedValue:(int)value;
-(void)settingsDetailViewController:(ttSettingsDetailViewController *)controller didChangeRandomStringSelection:(BOOL)value;
-(void)settingsDetailViewController:(ttSettingsDetailViewController *)controller didChangeUseSelectionSeed:(BOOL)value;
-(void)settingsDetailViewController:(ttSettingsDetailViewController *)controller didChangeSelectionSeedValue:(int)value;
-(void)settingsDetailViewController:(ttSettingsDetailViewController *)controller didChangeUseGroupId:(BOOL)value;
-(void)settingsDetailViewController:(ttSettingsDetailViewController *)controller didChangeGroupId:(int)value;
-(void)settingsDetailViewController:(ttSettingsDetailViewController *)controller didChangeQuitString:(NSString*)value;
-(void)settingsDetailViewController:(ttSettingsDetailViewController *)controller didChangeSkipString:(NSString*)value;
-(void)settingsDetailViewController:(ttSettingsDetailViewController *)controller didChangeEnableHideOnPracticeScreen:(BOOL)value;
-(void)settingsDetailViewController:(ttSettingsDetailViewController *)controller didChangeEnableSkipButton:(BOOL)value;
-(void)settingsDetailViewController:(ttSettingsDetailViewController *)controller didChangeNumberOfVerifyRounds:(int)value;
-(void)settingsDetailViewController:(ttSettingsDetailViewController *)controller didChangeFreePracticeDisabled:(BOOL)value;
-(void)settingsDetailViewController:(ttSettingsDetailViewController *)controller didChangeFreePracticeTextFieldDisabled:(BOOL)value;

@end

@interface ttSettingsDetailViewController : UITableViewController <UIAlertViewDelegate>

@property (nonatomic, weak) id <SettingsDetailViewControllerDelegate> delegate;

@property (weak, nonatomic) IBOutlet UITextField *numberOfEntities;
@property (weak, nonatomic) IBOutlet UITextField *numberOfRepetitions;
@property (weak, nonatomic) IBOutlet UITextField *numberOfForcedPracticeRounds;
@property (weak, nonatomic) IBOutlet UISwitch *randomStringOrder;
@property (weak, nonatomic) IBOutlet UISwitch *useOrderSeed;
@property (weak, nonatomic) IBOutlet UITextField *randomStringOrderSeedValue;
@property (weak, nonatomic) IBOutlet UISwitch *randomStringSelection;
@property (weak, nonatomic) IBOutlet UISwitch *useSelectionSeed;
@property (weak, nonatomic) IBOutlet UITextField *randomStringSelectionSeedValue;
@property (weak, nonatomic) IBOutlet UISwitch *useGroupId;
@property (weak, nonatomic) IBOutlet UITextField *groupId;
@property (strong, nonatomic) IBOutlet UITextField *quitString;
@property (strong, nonatomic) IBOutlet UITextField *skipString;
@property (strong, nonatomic) IBOutlet UISwitch *enableHideOnPracticeScreen;
@property (strong, nonatomic) IBOutlet UISwitch *enableSkipButton;
@property (strong, nonatomic) IBOutlet UITextField *numberOfVerifyRounds;
@property (strong, nonatomic) IBOutlet UISwitch *disableFreePractice;
@property (strong, nonatomic) IBOutlet UISwitch *disableFreePracticeTextField;


- (IBAction)numberOfEntitiesChanged:(id)sender;
- (IBAction)numberOfRepetitionsChanged:(id)sender;
- (IBAction)numberOfForcedPracticeRoundsChanged:(id)sender;
- (IBAction)randomStringOrderChanged:(id)sender;
- (IBAction)useOrderSeedChanged:(id)sender;
- (IBAction)orderSeedValueChanged:(id)sender;
- (IBAction)useRandomStringSelectionChanged:(id)sender;
- (IBAction)useSelectionSeedChanged:(id)sender;
- (IBAction)selectionSeedValueChanged:(id)sender;
- (IBAction)useGroupIdValueChanged:(id)sender;
- (IBAction)groupIdValueChanged:(id)sender;
- (IBAction)quitStringChanged:(id)sender;
- (IBAction)skipStringChanged:(id)sender;
- (IBAction)enableHideOnPracticeScreenChanged:(id)sender;
- (IBAction)enableSkipButtonChanged:(id)sender;
- (IBAction)numberOfVerifyRoundsChanged:(id)sender;
- (IBAction)disableFreePracticeChanged:(id)sender;
- (IBAction)disableFreePracticeTextFieldChanged:(id)sender;

- (void) hideKeyboard;

@end
