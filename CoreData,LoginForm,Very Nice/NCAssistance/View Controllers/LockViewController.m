//
//  LockViewController.m
//  NCAssistance
//
//  Created by Yuyi Zhang on 5/6/13.
//  Copyright (c) 2013 Camel. All rights reserved.
//

#import "LockViewController.h"
#import "Constants.h"
#import "AppDelegate.h"
#import "ForgotPasswordViewController.h"

@interface LockViewController ()

@property (nonatomic,assign) NSInteger failedLogins;
@property (nonatomic,retain) NSDate *lastFailedDate;

@end

@implementation LockViewController

@synthesize failedLogins;
@synthesize lastFailedDate;

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = paths[0];
    NSString *fileDir = [documentsDirectory stringByAppendingPathComponent:strAttemptsFileName];
    
    NSFileManager *manager = [NSFileManager defaultManager];
    if ([manager fileExistsAtPath:fileDir]) {
        NSMutableDictionary *dict = [[NSDictionary dictionaryWithContentsOfFile:fileDir] mutableCopy];
        self.failedLogins = [dict[strLoginAttemptCtr] intValue];
        self.lastFailedDate = dict[strLoginLstFailedDt];
        
        if (self.failedLogins > 10) {
            // file has sth wrong. Probably being hacked...
            self.failedLogins = 10;
        }
    }
    else {
        self.failedLogins = 10;
        self.lastFailedDate = [NSDate date];
    }
    
    if (!self.lastFailedDate) {
        self.lastFailedDate = [NSDate date];
    }
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    [self saveAttempts];
    self.lastFailedDate = nil;
}

-(void)saveAttempts
{
    // save failedLogins to disk
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = paths[0];
    NSString *fileDir = [documentsDirectory stringByAppendingPathComponent:strAttemptsFileName];
    NSMutableDictionary *dict = [[NSDictionary dictionaryWithContentsOfFile:fileDir] mutableCopy];
    if (!dict) {
        dict = [[NSMutableDictionary alloc] init];
        [dict setValue:@10 forKey:strSecurityAttemptCtr];
    }
    
    int secCtr = [dict[strSecurityAttemptCtr] intValue];
    NSDate *secDt = dict[strSeciurityLstFailedDt];
    if (!secDt) {
        secDt = [NSDate date];
    }
    
    [dict setValue:@(self.failedLogins) forKey:strLoginAttemptCtr];
    [dict setValue:self.lastFailedDate forKey:strLoginLstFailedDt];
    [dict setValue:@(secCtr) forKey:strSecurityAttemptCtr];
    [dict setValue:secDt forKey:strSeciurityLstFailedDt];
    
    if (![dict writeToFile:fileDir atomically:YES]) {
        NSLog(@"Saving login attempts failed!");
    }
}

#pragma mark - Text field delegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    if (textField == self.codeIn) {
        [textField resignFirstResponder];
        if (self.codeIn.text.length > 0) {
            if (self.failedLogins > 0 && self.failedLogins <= 10) {
                if ([self.delegate verify:self.codeIn.text]) {
                    [self setFailedLogins:10];
                    [self dismissViewControllerAnimated:YES completion:nil];
                }
                else {
                    self.failedLogins--;
                    self.lastFailedDate = [NSDate date];
                    self.hoverLbl.text = @"Oops, your password is wrong!";
                    self.cast.text = @"Don't do it wrong";
                    self.now.text = @"";
                    self.magic.text = [[@(self.failedLogins) stringValue] stringByAppendingString:@" Attempts Left."];
                    self.codeIn.text = @"";
                }
            }
            else {
                static NSDateFormatter *dateFormatter = nil;
                if (dateFormatter == nil) {
                    dateFormatter = [[NSDateFormatter alloc] init];
                    [dateFormatter setTimeStyle:NSDateFormatterNoStyle];
                    [dateFormatter setDateStyle:NSDateFormatterMediumStyle];
                }
                
                // calculate how many hours past since lastFailedDate
                NSCalendar *cal = [NSCalendar currentCalendar];
                NSDateComponents *components = [cal components:( NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit ) fromDate:self.lastFailedDate toDate:[NSDate date] options:0];
                long iHrPast = 24 - [components hour];
                if (iHrPast <= 0) {
                    if ([self.delegate verify:self.codeIn.text]) {
                        [self setFailedLogins:10];
                        [self dismissViewControllerAnimated:YES completion:nil];
                        [self saveAttempts];
                        return YES;
                    }
                    else {     // another failed attempt
                        iHrPast = 24;
                        self.lastFailedDate = [NSDate date];
                    }
                }

                self.hoverLbl.text = @"Too many failed attemts!";
                self.cast.text = @"You have to wait";
                self.now.text = @"to try again...";
                
                if (1 == iHrPast) {
                    self.magic.text = [[@(iHrPast) stringValue] stringByAppendingString:@" Hour"];
                }
                else {
                    self.magic.text = [[@(iHrPast) stringValue] stringByAppendingString:@" Hours"];
                }
                self.codeIn.text = @"";
            }
        }
        else {
            self.hoverLbl.text = @"So, do you have the code?";
        }
            
    }
    
    [self saveAttempts];
    return YES;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    [self animateTextField: textField up: YES];
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    [self animateTextField: textField up: NO];
}

- (void) animateTextField: (UITextField*) textField up: (BOOL) up
{
    const int movementDistance = 150; // tweak as needed
    const float movementDuration = 0.3f; // tweak as needed
    
    int movement = (up ? -movementDistance : movementDistance);
    
    [UIView beginAnimations: @"anim" context: nil];
    [UIView setAnimationBeginsFromCurrentState: YES];
    [UIView setAnimationDuration: movementDuration];
    self.view.frame = CGRectOffset(self.view.frame, 0, movement);
    [UIView commitAnimations];
}

- (IBAction)touchUpOutside:(id)sender {
    [self.codeIn resignFirstResponder];
}

- (IBAction)forgotPassword:(id)sender {
    ForgotPasswordViewController *fpvc = [[ForgotPasswordViewController alloc] initWithNibName:@"ForgotPasswordViewController" bundle:nil];
    fpvc.delegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    [self presentViewController:fpvc animated:NO completion:nil];
}
@end
