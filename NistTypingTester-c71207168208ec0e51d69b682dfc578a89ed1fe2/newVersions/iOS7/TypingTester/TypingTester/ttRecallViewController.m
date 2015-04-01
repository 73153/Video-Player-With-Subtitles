//
//  ttRecallViewController.m
//  TypingTester
//
//  Created by Matthew Kerr on 8/21/13.
//

#import "ttRecallViewController.h"
#import "ttRecallTableViewController.h"
#import "ttSession.h"
#import "ttSettings.h"
#import "ttUtilities.h"
#import "ttEvent.h"
#import "ttThankYouViewController.h"

@interface ttRecallViewController ()

@end

@implementation ttRecallViewController
{
    ttRecallTableViewController *child;
    ttSettings *settings;
}

-(id) initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self)
    {
        settings = [ttSettings Instance];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.

}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self.session enteredPhase:Recall withNote:@"Entered Recall Phase"];
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.session leftPhase:Recall withNote:@"Leaving Recall Phase"];
    // end the session
    //[self.session sessionDidFinish];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"RecallTableView"])
    {
        child = segue.destinationViewController;
        child.session = self.session;
        child.delegate = self;
    }
    else if ([segue.identifier isEqualToString:@"ThankYou"])
    {
        // get the entered text strings, log them in the summary log
        [self.session writeLineToSummaryLogFile:@"Entered Recall Strings"];
        [self.session writeLineToSummaryLogFile:[child getStrings]];
        ttThankYouViewController *controller = [segue destinationViewController];
        controller.session = self.session;
    }
}

-(void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation
{
    [super didRotateFromInterfaceOrientation:fromInterfaceOrientation];
    // log a rotation
    ttEvent *event = [[ttEvent alloc]initWithEventType:OrientationChange andPhase:Recall];
    event.notes = [NSString stringWithFormat:@"Did rotate from %@ to %@", [ttUtilities stringForOrienatation:fromInterfaceOrientation], [ttUtilities stringForOrienatation:self.interfaceOrientation]];
    [self.session addEvent:event];
}

-(NSUInteger)supportedInterfaceOrientations
{
    switch(UI_USER_INTERFACE_IDIOM())
    {
        case UIUserInterfaceIdiomPad:
            return UIInterfaceOrientationMaskAll;
            
        case UIUserInterfaceIdiomPhone:
            return UIInterfaceOrientationMaskAllButUpsideDown;
    }
    return UIInterfaceOrientationMaskAll;
}

-(IBAction)done
{
    // add event for done button
    ttEvent *doneButtonEvent = [[ttEvent alloc]initWithEventType:ControlActivated andPhase:Recall andSubPhase:NoSubPhase];
    doneButtonEvent.notes = @"Done button pressed";
    [self.session addEvent:doneButtonEvent];
    [self performSegueWithIdentifier:@"ThankYou" sender:self];
}

-(IBAction)backgroundButtonPressed
{
    [child hideKeyboard];
}

-(void)RecallTableViewController:(ttRecallTableViewController *)controller didFinishWithValues:(NSString *)values
{
    [self performSegueWithIdentifier:@"ThankYou" sender:self];
}



@end
