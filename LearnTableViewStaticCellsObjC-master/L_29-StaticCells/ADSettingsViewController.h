//
//  ADSettingsViewController.h
//  L_29-StaticCells
//
//  Created by A D on 2/16/14.
//  Copyright (c) 2014 AD. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ADSettingsViewController : UITableViewController


@property (weak, nonatomic) IBOutlet UILabel *firstNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *lastNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *loginLabel;
@property (weak, nonatomic) IBOutlet UILabel *passwordLabel;
@property (weak, nonatomic) IBOutlet UILabel *emailLabel;
@property (weak, nonatomic) IBOutlet UILabel *phoneLabel;




@property (weak, nonatomic) IBOutlet UITextField *firstNameField;
@property (weak, nonatomic) IBOutlet UITextField *lastNameField;
@property (weak, nonatomic) IBOutlet UISlider *ageSlider;
@property (weak, nonatomic) IBOutlet UILabel *ageLabel;
@property (weak, nonatomic) IBOutlet UITextField *loginField;
@property (weak, nonatomic) IBOutlet UITextField *passwordField;
@property (weak, nonatomic) IBOutlet UISegmentedControl *passwordSwitch;

@property (weak, nonatomic) IBOutlet UITextField *emailField;
@property (weak, nonatomic) IBOutlet UITextField *phoneField;

@property (strong, nonatomic) IBOutletCollection(UITextField) NSArray *fieldsCollection;

@property (strong, nonatomic) IBOutletCollection(UIView) NSArray *labelsCollection;

- (IBAction)actionValueChanged:(id)sender;
- (IBAction)resetButtonAction:(UIButton *)sender;


@end
