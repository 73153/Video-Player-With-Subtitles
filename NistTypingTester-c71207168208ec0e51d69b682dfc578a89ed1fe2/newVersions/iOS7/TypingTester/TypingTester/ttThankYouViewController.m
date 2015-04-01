//
//  ttThankYouViewController.m
//  TypingTester
//
//  Created by Matthew Kerr on 8/20/13.
//

#import "ttThankYouViewController.h"
#import "ttUtilities.h"
#import "ttSession.h"
#import "ttEvent.h"
#import "ttLocalHtmlFile.h"
#import "ttSettings.h"

@interface ttThankYouViewController ()

@end

@implementation ttThankYouViewController
{
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
    ttLocalHtmlFile *file = [[ttLocalHtmlFile alloc]initWithFilenameBase:@"thankYou"];
    [self.webView loadData:file.data MIMEType:@"text/html" textEncodingName:@"UTF-8" baseURL:file.url];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self.session enteredPhase:ThankYou withNote:@"Entered Thank You Phase"];
    // end the session
    [self.session sessionDidFinish];
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
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
    [self performSegueWithIdentifier:@"BackToStart" sender:self];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"BackToStart"])
    {
        // Add any clean up here...
    }
}


@end
