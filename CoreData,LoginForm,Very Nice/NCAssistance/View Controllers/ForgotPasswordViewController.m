//
//  ForgotPasswordViewController.m
//  NCAssistance
//
//  Created by Yuyi Zhang on 6/16/13.
//  Copyright (c) 2013 Camel. All rights reserved.
//

#import "ForgotPasswordViewController.h"
#import "Password.h"
#import "Constants.h"

@interface ForgotPasswordViewController ()

@property (nonatomic,retain) Password * thePassword;
@property (nonatomic,assign) NSInteger failedLogins;
@property (nonatomic,retain) NSDate *lastFailedDate;
@property (nonatomic,assign) BOOL m_bShouldUnlock;

@end

@implementation ForgotPasswordViewController

@synthesize failedLogins;
@synthesize lastFailedDate;

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    self.m_bShouldUnlock = NO;
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.m_bShouldUnlock = NO;
    if (!self.thePassword) {
        self.thePassword = [self.delegate retriveRecord];
    }
    self.question.text = self.thePassword.website;
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = paths[0];
    NSString *fileDir = [documentsDirectory stringByAppendingPathComponent:strAttemptsFileName];
    
    NSFileManager *manager = [NSFileManager defaultManager];
    if ([manager fileExistsAtPath:fileDir]) {
        NSMutableDictionary *dict = [[NSDictionary dictionaryWithContentsOfFile:fileDir] mutableCopy];
        self.failedLogins = [dict[strSecurityAttemptCtr] intValue];
        self.lastFailedDate = dict[strSeciurityLstFailedDt];
        
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

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    if (self.m_bShouldUnlock) {
        [NSTimer scheduledTimerWithTimeInterval:0.2 target:self.delegate selector:@selector(dismissLockView) userInfo:nil repeats:NO];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    [self saveAttempts];
    self.lastFailedDate = nil;
}

- (IBAction)back:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)unlock:(id)sender {
    if (0 == self.answerIn.text.length) {
        return;
    }
    
    if (self.failedLogins > 0 && self.failedLogins <= 10) {
        if ([self.answerIn.text isEqualToString:self.thePassword.notes]) {
            [self setFailedLogins:10];
            self.m_bShouldUnlock = YES;
            [self dismissViewControllerAnimated:YES completion:nil];
            return;
        }
        else {
            self.failedLogins--;
            self.lastFailedDate = [NSDate date];
            self.descTxt.text = [@"Wrong anwser. " stringByAppendingString:[[@(self.failedLogins) stringValue] stringByAppendingString:@" Attempts Left."]];
            [self.descTxt setFont:[UIFont boldSystemFontOfSize:15]];
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
            if ([self.answerIn.text isEqualToString:self.thePassword.notes]) {
                [self setFailedLogins:10];
                [self dismissViewControllerAnimated:YES completion:nil];
                [self saveAttempts];
                return;
            }
            else {     // another failed attempt
                iHrPast = 24;
                self.lastFailedDate = [NSDate date];
            }
        }
    
        self.descTxt.text = [@"Please wait " stringByAppendingString:[[@(iHrPast) stringValue] stringByAppendingString:@" hours to try again."]];
    }

    [self saveAttempts];
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
        [dict setValue:@10 forKey:strLoginAttemptCtr];
    }
    
    int lockCtr = [dict[strLoginAttemptCtr] intValue];
    NSDate *lockDt = dict[strLoginLstFailedDt];
    if (!lockDt) {
        lockDt = [NSDate date];
    }
    
    [dict setValue:@(lockCtr) forKey:strLoginAttemptCtr];
    [dict setValue:lockDt forKey:strLoginLstFailedDt];
    [dict setValue:@(self.failedLogins) forKey:strSecurityAttemptCtr];
    [dict setValue:self.lastFailedDate forKey:strSeciurityLstFailedDt];
    
    NSString *filePath = [documentsDirectory stringByAppendingPathComponent:strAttemptsFileName];
    if (![dict writeToFile:filePath atomically:YES]) {
        NSLog(@"Saving login attempts failed!");
    }
}

#pragma mark - textfield delegate
-(BOOL) textFieldShouldReturn:(UITextField *)textField
{
    if (textField == self.answerIn) {
        [textField resignFirstResponder];
    }
    return YES;
}

@end
