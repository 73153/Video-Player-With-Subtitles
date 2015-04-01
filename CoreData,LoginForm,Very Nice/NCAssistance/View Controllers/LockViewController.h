//
//  LockViewController.h
//  NCAssistance
//
//  Created by Yuyi Zhang on 5/6/13.
//  Copyright (c) 2013 Camel. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol LockViewControllerDelegate
- (BOOL) verify: (NSString *)code;
@end

@interface LockViewController : UIViewController

@property (nonatomic, weak) IBOutlet id <LockViewControllerDelegate> delegate;
@property (weak, nonatomic) IBOutlet UITextField *codeIn;
@property (weak, nonatomic) IBOutlet UILabel *hoverLbl;
@property (weak, nonatomic) IBOutlet UILabel *cast;
@property (weak, nonatomic) IBOutlet UILabel *magic;
@property (weak, nonatomic) IBOutlet UILabel *now;

- (IBAction)touchUpOutside:(id)sender;  //todo
- (IBAction)forgotPassword:(id)sender;

-(void)saveAttempts;

@end
