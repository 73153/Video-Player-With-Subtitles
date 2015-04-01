//
//  NISTMemorizeViewController.h
//  PasswordTest
//
//  Created by Navneet Kumar on 3/30/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class NISTAppDelegate;

@interface NISTMemorizeViewController : UIViewController<UITextViewDelegate>

@property (strong, nonatomic) IBOutlet UILabel *stringLabel;

@property (strong, nonatomic) UIBarButtonItem *nextButton;
@property (strong, nonatomic) IBOutlet UITextView *textView;
@property (strong, nonatomic) IBOutlet UILabel *stringMsgLabel;
@property (strong, nonatomic) NISTAppDelegate *appDel;

- (IBAction) backgroundTapped: (id) sender;

-(BOOL) textView: (UITextView *) textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text;
-(void) configureViewDataAndShow;
-(void) initForNewString;


@end

