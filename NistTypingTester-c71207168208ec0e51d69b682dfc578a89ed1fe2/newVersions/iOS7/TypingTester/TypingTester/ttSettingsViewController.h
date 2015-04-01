//
//  ttSettingsViewController.h
//  TypingTester
//
//  Created by Matthew Kerr on 7/31/13.
//

#import <UIKit/UIKit.h>
#import "ttSettingsDetailViewController.h"

@class ttSettingsViewController;


// Delegate protocol for caller to implement to recieve notifications from this view contoller
@protocol SettingsViewControllerDelegate <NSObject>

-(void)SettingViewControllerDidCancel:(ttSettingsViewController*)controller;
-(void)SettingsViewControllerDidSave:(ttSettingsViewController*)controller;

@end


@interface ttSettingsViewController : UIViewController <SettingsDetailViewControllerDelegate>

// The delegate to send messages to
@property (nonatomic, weak) id <SettingsViewControllerDelegate> delegate;

// Action for the cancel button
-(IBAction)cancel:(id)sender;
// Action for the save button
-(IBAction)save:(id)sender;
// Action for the background button
-(IBAction)backgroundButtonPressed:(id)sender;

@end
