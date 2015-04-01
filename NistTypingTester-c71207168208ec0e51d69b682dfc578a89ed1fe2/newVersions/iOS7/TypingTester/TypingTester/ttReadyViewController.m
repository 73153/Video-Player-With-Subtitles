//
//  ttReadyViewController.m
//  TypingTester
//
//  Created by Matthew Kerr on 8/1/13.
//

#import "ttReadyViewController.h"
#import "ttUtilities.h"
#import "ttTypingProficiencyViewController.h"
#import "ttSession.h"
#import "ttLocalHtmlFile.h"
#import "ttSettings.h"

@interface ttReadyViewController ()

@end

@implementation ttReadyViewController
{
    ttSession* session;
    ttSettings *settings;
}

-(id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self)
    {
        settings = [ttSettings Instance];
    }
    return self;
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    self.participantNumberLabel.text = self.participantNumber;
    ttLocalHtmlFile *file = [[ttLocalHtmlFile alloc]initWithFilenameBase:@"welcome"];
    [self.readyTextArea loadData:file.data MIMEType:@"text/html" textEncodingName:@"UTF-8" baseURL:file.url];
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

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"TypingProficiency"])
    {
        ttTypingProficiencyViewController *controller = [segue destinationViewController];
        // this is the start of the session so Initialize it
        session = [[ttSession alloc]initWithParticipantId:self.participantNumber];
        controller.session = session;
    }
}

-(IBAction)cancel:(id)sender
{
    [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
}


@end
