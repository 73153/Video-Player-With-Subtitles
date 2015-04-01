//
//  ttInstructionsViewController.m
//  TypingTester
//
//  Created by Matthew Kerr on 8/20/13.
//

#import "ttInstructionsViewController.h"
#import "ttUtilities.h"
#import "ttMemorizeViewController.h"
#import "ttPracticeViewController.h"
#import "ttLocalHtmlFile.h"
#import "ttSettings.h"
#import "ttEvent.h"
#import "ttUtilities.h"

@interface ttInstructionsViewController ()

@end

@implementation ttInstructionsViewController
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

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    [self loadInstructionsHtml];
    ttLocalHtmlFile *file = [[ttLocalHtmlFile alloc]initWithFilenameBase:@"temp"];
    [self.webView loadData:file.data MIMEType:@"text/html" textEncodingName:@"UTF-8" baseURL:file.url];
    //NSString *htmlContent = [self loadInstructionsHtml];
    //[self.webView loadHTMLString:htmlContent baseURL:nil];
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    // add event that we entered the instructions
    [self.session enteredPhase:Introduction withNote:@"Entering Introduction Phase"];
}

-(void) viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.session leftPhase:Introduction withNote:@"Leaving Introduction Phase"];
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

-(void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation
{
    [super didRotateFromInterfaceOrientation:fromInterfaceOrientation];
    // log a rotation
    ttEvent *event = [[ttEvent alloc]initWithEventType:OrientationChange andPhase:UnknownPhase];
    event.notes = [NSString stringWithFormat:@"Did rotate from %@ to %@", [ttUtilities stringForOrienatation:fromInterfaceOrientation], [ttUtilities stringForOrienatation:self.interfaceOrientation]];
    [self.session addEvent:event];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // check to see if we are on the first entity
    if (self.session.currentEntity == -1) [self.session nextEntity];
    if ([segue.identifier isEqualToString:@"InstructionsToForcedPractice"])
    {
        ttPracticeViewController *controller = segue.destinationViewController;
        controller.session = self.session;
    }
    else if ([segue.identifier isEqualToString:@"InstructionsToFreePractice"])
    {
        ttMemorizeViewController *controller = segue.destinationViewController;
        controller.session = self.session;
    }
}

-(IBAction)nextScreen
{
    if (settings.disableFreePractice == YES)
    {
        [self performSegueWithIdentifier:@"InstructionsToForcedPractice" sender:self];
    }
    else
    {
        [self performSegueWithIdentifier:@"InstructionsToFreePractice" sender:self];
    }
    
}

- (void) loadInstructionsHtml
{
    NSString *headerText;
    NSString *freePracticeText;
    NSString *forcedPracticeText;
    NSString *verifyText;
    NSString *entryText;
    NSString *footerText;
    NSMutableString *output = [[NSMutableString alloc]init];
    
    // load the files
    headerText = [self loadInstructionFileFragmentNamed:@"instructionsHeader"];
    if (settings.disableFreePractice == NO) freePracticeText = [self loadInstructionFileFragmentNamed:@"instructionsFreePractice"];
    if (settings.forcedPracticeRounds > 0) forcedPracticeText = [self loadInstructionFileFragmentNamed:@"instructionsForcedPractice"];
    if (settings.verifyRounds > 0) verifyText = [self loadInstructionFileFragmentNamed:@"instructionsVerify"];
    entryText = [self loadInstructionFileFragmentNamed:@"instructionsEntry"];
    footerText = [self loadInstructionFileFragmentNamed:@"instructionsFooter"];

    // build the final HTML file
    [output appendFormat:@"<html><head></head><body>"];
    if ([headerText length] > 0) [output appendFormat:@"%@", headerText];
    if ([freePracticeText length] > 0) [output appendFormat:@"%@", freePracticeText];
    if ([forcedPracticeText length] > 0) [output appendFormat:@"%@", forcedPracticeText];
    if ([verifyText length] > 0) [output appendFormat:@"%@", verifyText];
    if ([entryText length] > 0) [output appendFormat:@"%@", entryText];
    if ([footerText length] > 0) [output appendFormat:@"%@", footerText];
    [output appendFormat:@"</body></html>"];
    [self writeTempFile:output];
    return;
}

-(void) writeTempFile:(NSString*)data
{
    NSString *tempFile = [[ttUtilities documentsDirectory] stringByAppendingPathComponent:@"temp.html"];
	NSFileManager *fileManager = [NSFileManager defaultManager];
	NSError* error;
    if ([fileManager fileExistsAtPath:tempFile])
    {
        [fileManager removeItemAtPath:tempFile error:&error];
    }
    [fileManager createFileAtPath:tempFile contents:nil attributes:nil];
    
	NSFileHandle *tempHandle = [NSFileHandle fileHandleForWritingAtPath:tempFile];
	
	[tempHandle writeData:[data dataUsingEncoding:NSUTF8StringEncoding]];
}

- (NSString*)loadInstructionFileFragmentNamed:(NSString*)filenameBase
{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSString *iPadFilename = [NSString stringWithFormat:@"%@-iPad.html", filenameBase];
    NSString *fileToLoad = [NSString stringWithFormat:@"%@.fhtm",filenameBase];
    NSString *fullPath;
    NSString *data;
    // if we are on the iPad see if the iPad version exists
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
    {
        fullPath = [[ttUtilities documentsDirectory] stringByAppendingPathComponent:iPadFilename];
        if ([fileManager fileExistsAtPath:fullPath])
        {
            fileToLoad = iPadFilename;
        }
    }
    fullPath = [[ttUtilities documentsDirectory] stringByAppendingPathComponent:fileToLoad];
    if ([fileManager fileExistsAtPath:fullPath])
    {
        data = [NSString stringWithContentsOfFile:fullPath encoding:NSUTF8StringEncoding error:nil];
    }
    else
    {
        data = @"";
    }
    return [data copy];
}

@end
