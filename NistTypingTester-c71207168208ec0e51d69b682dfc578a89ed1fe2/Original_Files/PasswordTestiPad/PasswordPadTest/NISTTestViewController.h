//
//  NISTTestViewController.h
//  PasswordTest
//
//  Created by Navneet Kumar on 4/2/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class NISTAppDelegate;

@interface NISTTestViewController : UIViewController<UITextFieldDelegate>

@property (strong, nonatomic) IBOutlet UITextField *textField1;
@property (strong, nonatomic) IBOutlet UITextField *textField2;
@property (strong, nonatomic) IBOutlet UITextField *textField3;
@property (strong, nonatomic) IBOutlet UITextField *textField4;
@property (strong, nonatomic) IBOutlet UITextField *textField5;
@property (strong, nonatomic) IBOutlet UITextField *textField6;
@property (strong, nonatomic) IBOutlet UITextField *textField7;
@property (strong, nonatomic) IBOutlet UITextField *textField8;
@property (strong, nonatomic) IBOutlet UITextField *textField9;
@property (strong, nonatomic) IBOutlet UITextField *textField10;


@property (strong, nonatomic) UIBarButtonItem *submitButton;
@property (strong, nonatomic) NISTAppDelegate *appDel;
@property (strong, nonatomic) UITextField *activeTextField;

-(IBAction) backgroundTapped: (id) sender;
-(void) configureViewDataAndShow;


@end

