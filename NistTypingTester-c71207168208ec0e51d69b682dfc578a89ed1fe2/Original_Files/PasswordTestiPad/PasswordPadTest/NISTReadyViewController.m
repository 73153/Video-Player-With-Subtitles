//
//  BIDDetailViewController.m
//  NavTest
//
//  Created by Navneet Kumar on 3/29/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "NISTReadyViewController.h"
#import "NISTAppDelegate.h"
#import "NISTMemorizeViewController.h"


@interface NISTReadyViewController ()
- (void)configureView;
@end

@implementation NISTReadyViewController

@synthesize nextButton;
@synthesize appDel;


#pragma mark - Managing the detail item

- (void)configureView
{
    UINavigationItem *navItem = self.navigationItem;    
    navItem.hidesBackButton = YES;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.appDel = (NISTAppDelegate *) [[UIApplication sharedApplication] delegate];
    
	// Do any additional setup after loading the view, typically from a nib.
    [self configureView];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
}

- (void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
    NSTimeInterval touchStartTime;

    touchStartTime = event.timestamp;
    NSLog(@"Touch Start Time = %f\n", touchStartTime);
    
} 

- (void) touchesEnded:(NSSet *)touches 
            withEvent:(UIEvent *)event {
    
    NSTimeInterval touchEndTime;
    touchEndTime = event.timestamp;
    NSLog(@"Touch End Time = %f\n", touchEndTime);

}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = NSLocalizedString(@"Ready?", @"Ready?");
    }
    return self;
}

- (IBAction)beginHandler:(id)sender forEvent:(UIEvent *)event {

    self.appDel.baseTimeStamp = event.timestamp;
    
    [self.appDel userBeginsTest];
    
    // let us load "Ready" View as the next view
    NISTMemorizeViewController *memorizeViewController = [[NISTMemorizeViewController alloc] initWithNibName:@"NISTMemorizeViewController" bundle:nil];
    self.appDel.memorizeViewController = memorizeViewController;
    [self.appDel.navigationController pushViewController:memorizeViewController animated:YES];  
    
    NSLog(@"Begin Button Time = %f\n", event.timestamp);
    
}
@end




