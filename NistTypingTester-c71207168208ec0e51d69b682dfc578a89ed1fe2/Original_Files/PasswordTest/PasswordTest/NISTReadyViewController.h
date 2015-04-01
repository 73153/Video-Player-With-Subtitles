//
//  NISTDetailViewController.h
//  PasswordTest
//
//  Created by Navneet Kumar on 3/30/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NISTAppDelegate.h"
#import "NISTUserEvent.h"

@interface NISTReadyViewController : UIViewController

- (IBAction)beginHandler:(id)sender forEvent:(UIEvent *)event;
@property (strong, nonatomic) UIBarButtonItem *nextButton;
@property (strong, nonatomic) NISTAppDelegate *appDel;

@end

   
