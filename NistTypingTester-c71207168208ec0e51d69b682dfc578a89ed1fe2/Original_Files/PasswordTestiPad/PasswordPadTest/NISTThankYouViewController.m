//
//  NISTThankYouViewController.m
//  PasswordTest
//
//  Created by Navneet Kumar on 4/6/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "NISTThankYouViewController.h"

@interface NISTThankYouViewController ()

@end

@implementation NISTThankYouViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = NSLocalizedString(@"Thank You", @"Thank You");
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    UINavigationItem *navItem = self.navigationItem;
    
    navItem.hidesBackButton = YES;
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
