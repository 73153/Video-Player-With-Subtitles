//
//  ADSettingsViewController.m
//  L_29-StaticCells
//
//  Created by A D on 2/16/14.
//  Copyright (c) 2014 AD. All rights reserved.
//

#import "ADSettingsViewController.h"

@interface ADSettingsViewController () <UITextFieldDelegate>

@end

static NSString *kSettingsFirstName         = @"firstName";
static NSString *kSettingsLastName          = @"lastName";
static NSString *kSettingsAgeSlider         = @"ageSlider";
static NSString *kSettingsAge               = @"ageLabel";
static NSString *kSettingsLogin             = @"login";
static NSString *kSettingsPassword          = @"password";
static NSString *kSettingsPasswordSwitch    = @"passwordSwitch";
static NSString *kSettingsEmail             = @"email";
static NSString *kSettingsPhone             = @"phone";
static NSString *kSettingsPasswordSecure    = @"passwordSecure";


@implementation ADSettingsViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.passwordField.secureTextEntry = YES;
    
    [self loadSettings];

    for(UITextField *field in self.fieldsCollection){
        field.delegate = self;
        
    }
    
    NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
    
    [nc addObserver:self selector:@selector(handleTextFieldNotification:) name:UITextFieldTextDidChangeNotification object:nil];
    
}


- (void) dealloc{
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}



#pragma mark - UITextFieldDelegate

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    
    BOOL result = YES;
    
    if ([textField isEqual:self.emailField]) {
        
        result = [self handleEmailImputOf:textField chnagingCharsInRange:range replacingSting:string];
        
    }else if([textField isEqual:self.phoneField]){
        
        result = [self handlePhoneInputOf:textField chnagingCharsInRange:range replacingSting:string];
    }
    [self updateOutLabelForField:textField];
    
    return result;
}


- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    if([textField isEqual:self.fieldsCollection.lastObject]){
        
        [textField resignFirstResponder];
        
    }else{
        
        [[self.fieldsCollection objectAtIndex:[self.fieldsCollection indexOfObject:textField]+1] becomeFirstResponder];
    }
    
    return YES;
}


#pragma mark - textField notification

- (void) handleTextFieldNotification:(NSNotification *) notification{
    
    [self updateOutLabelForField:[notification object]];
}


#pragma  mark - handle input

- (BOOL) handleEmailImputOf:(UITextField *)textField chnagingCharsInRange:(NSRange)range replacingSting:(NSString *)string{
    
    static const int emailLength = 20;
    BOOL result = YES;
    
    NSString *resultString = [textField.text stringByReplacingCharactersInRange:range withString:string];
    
    NSCharacterSet *tempSet = [NSCharacterSet characterSetWithCharactersInString:@"@."];
    NSMutableCharacterSet *validationSet = [NSMutableCharacterSet alphanumericCharacterSet];
    [validationSet formUnionWithCharacterSet:tempSet];
    [validationSet invert];
    
    NSArray *components = [resultString componentsSeparatedByCharactersInSet:validationSet];
    
    NSArray *atSeparatedComponents = [resultString componentsSeparatedByString:@"@"];
    
    if([components count] > 1 || [atSeparatedComponents count] > 2 || [resultString length] > emailLength){
        result = NO;
    }
    
    return result;
}

- (BOOL) handlePhoneInputOf:(UITextField *)textField chnagingCharsInRange:(NSRange)range replacingSting:(NSString *)string{
    
    static const int localNumberMaxLength = 7;
    static const int areaCodeMaxLength = 3;
    static const int countryCodeMaxLength = 3;
    
    NSCharacterSet *validationSet = [[NSCharacterSet decimalDigitCharacterSet] invertedSet];
    NSArray *components = [string componentsSeparatedByCharactersInSet:validationSet];
    
    if ([components count] > 1) {
        return  NO;
    }
    
    NSString *newString = [textField.text stringByReplacingCharactersInRange:range withString:string];
    NSArray *validComponents = [newString componentsSeparatedByCharactersInSet:validationSet];
    newString = [validComponents componentsJoinedByString:@""];
    
    if ([newString length] > localNumberMaxLength + areaCodeMaxLength + countryCodeMaxLength) {
        return  NO;
    }
    
    NSMutableString *resultString = [NSMutableString string];
    NSInteger localNumberLength = MIN([newString length], localNumberMaxLength);
    
    if(localNumberLength > 0){
        
        NSString *number = [newString substringFromIndex:(int)[newString length] - localNumberLength];
        [resultString appendString:number];
        
        if([resultString length] > 3){
            
            [resultString insertString:@"-" atIndex:3];
        }
    }
    
    if([newString length] > localNumberLength){
        
        NSInteger areaCodeLength = MIN((int)[newString length] - localNumberMaxLength, areaCodeMaxLength);
        NSRange areaRange = NSMakeRange((int)[newString length] - localNumberMaxLength - areaCodeLength, areaCodeLength);
        NSString *area = [newString substringWithRange:areaRange];
        area = [NSString stringWithFormat:@"(%@) ", area];
        [resultString insertString:area atIndex:0];
    }
    
    if([newString length] > localNumberMaxLength + areaCodeMaxLength){
        
        NSInteger countryCodeLength = MIN((int)[newString length] - localNumberMaxLength - areaCodeMaxLength, countryCodeMaxLength);
        NSRange countryCodeRange = NSMakeRange(0, countryCodeLength);
        NSString *countryCode = [newString substringWithRange:countryCodeRange];
        countryCode = [NSString stringWithFormat:@"+%@ ", countryCode];
        [resultString insertString:countryCode atIndex:0];
    }
    
    textField.text = resultString;
    //[self updateOutLabelForField:textField];
    
    return NO;
}


#pragma  mark - set output label

- (void) updateOutLabelForField:(UITextField *) field{
    
    UILabel *outputLabel = [self.labelsCollection objectAtIndex:[self.fieldsCollection indexOfObject:field]];
    outputLabel.text = field.text;
    [self saveSettings];
    
}


#pragma mark - control value changed

- (IBAction)actionValueChanged:(id)sender {
    
    
    
    if([sender isEqual:self.ageSlider]){
        
        if (self.ageSlider.value < 1) {
            self.ageLabel.text = [NSString stringWithFormat:@"Baby"];
        }else if(self.ageSlider.value  >= 1 && self.ageSlider.value < 2){
            self.ageLabel.text = [NSString stringWithFormat:@"Teenager"];
        }else if(self.ageSlider.value >= 2 && self.ageSlider.value < 3){
            self.ageLabel.text = [NSString stringWithFormat:@"Adult"];
        }else if(self.ageSlider.value >= 3 && self.ageSlider.value < 4){
            self.ageLabel.text = [NSString stringWithFormat:@"Oldman"];
        }else{
            self.ageLabel.text = [NSString stringWithFormat:@"No life is found in the body"];
        }
        
    }else if([sender isEqual:self.passwordSwitch]){
        
        if(self.passwordSwitch.selectedSegmentIndex == 0){
            self.passwordField.secureTextEntry = YES;
        }else{
            self.passwordField.secureTextEntry = NO;
        }
    }
    [self saveSettings];
}


#pragma mark - resetSettings

- (IBAction)resetButtonAction:(UIButton *)sender {

    self.ageSlider.value = 0.f;
    self.ageLabel.text = [NSString stringWithFormat:@""];
    
    self.passwordSwitch.selectedSegmentIndex = 0;
    self.passwordField.secureTextEntry = YES;
    
    
    for (UILabel *label in self.labelsCollection){
        
        label.text = [NSString stringWithFormat:@""];

    }
    
    for (UITextField * field in self.fieldsCollection){
        
        field.text = [NSString stringWithFormat:@""];
    }

    [self saveSettings];

}


#pragma mark - userDefaults

- (void) saveSettings{
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    
    [userDefaults setObject:self.firstNameLabel.text forKey:kSettingsFirstName];
    [userDefaults setObject:self.lastNameLabel.text forKey:kSettingsLastName];
    [userDefaults setFloat:self.ageSlider.value forKey:kSettingsAgeSlider];
    [userDefaults setObject:self.ageLabel.text forKey:kSettingsAge];
    [userDefaults setObject:self.loginLabel.text forKey:kSettingsLogin];
    [userDefaults setObject:self.passwordLabel.text forKey:kSettingsPassword];
    [userDefaults setInteger:self.passwordSwitch.selectedSegmentIndex forKey:kSettingsPasswordSwitch];
    [userDefaults setObject:self.emailLabel.text forKey:kSettingsEmail];
    [userDefaults setObject:self.phoneLabel.text forKey:kSettingsPhone];
    [userDefaults setBool:self.passwordField.secureTextEntry forKey:kSettingsPasswordSecure];
    
    [userDefaults synchronize];
}

- (void) loadSettings{
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    
    self.firstNameLabel.text = [userDefaults objectForKey:kSettingsFirstName];
    self.lastNameLabel.text = [userDefaults objectForKey:kSettingsLastName];
    self.ageSlider.value = [userDefaults floatForKey:kSettingsAgeSlider];
    self.ageLabel.text = [userDefaults objectForKey:kSettingsAge];
    self.loginLabel.text = [userDefaults objectForKey:kSettingsLogin];
    self.passwordLabel.text = [userDefaults objectForKey:kSettingsPassword];
    self.passwordSwitch.selectedSegmentIndex = [userDefaults integerForKey:kSettingsPasswordSwitch];
    self.emailLabel.text = [userDefaults objectForKey:kSettingsEmail];
    self.phoneLabel.text = [userDefaults objectForKey:kSettingsPhone];
    self.passwordField.secureTextEntry = [userDefaults boolForKey:kSettingsPasswordSecure];
}


@end
