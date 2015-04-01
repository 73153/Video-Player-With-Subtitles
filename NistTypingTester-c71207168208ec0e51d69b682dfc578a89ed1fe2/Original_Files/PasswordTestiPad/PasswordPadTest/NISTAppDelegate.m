//
//  NISTAppDelegate.m
//  PasswordTest
//
//  Created by Navneet Kumar on 3/30/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//


 

#import "NISTAppDelegate.h"

#import "NISTParticipantViewController.h"
#import "NISTMemorizeViewController.h"
#import "NISTRecallViewController.h"
#import "NISTVerifyViewController.h"
#import "NISTPerStringRolledUpData.h"

@implementation NISTNavigationController

- (UIViewController *) popViewControllerAnimated:(BOOL)animated {
    if( [[self.viewControllers lastObject] class] == [NISTVerifyViewController class]) {
        NSLog(@"Moving back to memeorize View\n");
        NISTVerifyViewController *vc = [self.viewControllers lastObject];
        NSMutableArray    *a = [vc getEnteredStrings];
        
        NISTAppDelegate *del = (NISTAppDelegate *) self.delegate;
        
        NSTimeInterval time = [[NSProcessInfo processInfo] systemUptime];
        [del userTappedBackForPhase:NISTMemorize atTime:time withEnteredStrings:a];
    }
        
    return [super popViewControllerAnimated:animated];
}


@end



@implementation NISTAppDelegate {
    int             currentStringNumber;
    NSArray         *inputCharStrings;      // target string
    
    NSArray         *phaseNames;
    NSArray         *phaseShortNames;
    
    NSFileHandle    *rawFileHandle;     // Raw data file handle
    NSFileHandle    *rolledUpFileHandle;// Rolled up file handle
    
 // output data needed.
    NSMutableArray  *userEvents;        // This array stores user events for each string
    NSTimeInterval  baseTimeStamp;

// Rolled up data
    NSTimeInterval  totalSessionTime;   // #1 All Ten Strings + recall
                                        // From when Begine pressed to till done on recall page was pressed.
    
// Recall
    NSMutableArray  *recalledStrings;   // #12 Each Recalled string in Recall Page    
    NSMutableArray  *recalledMatched;       // #13 Each Recall String if it matched one of the traget strings.
    NSTimeInterval  totalRecallTime;    // #7 Duration Recall Page was Displayed.
   
    // Per string data 10 entries
    NSMutableArray  *rolledUpDataPerString;     // #1 - to #12 except 1 and 7 - One object of type NISTROlledUpData;
        
    
// iVars to calculate needed rolled up data
    NSTimeInterval  lastMemorizePageDisplayTime;    //  
    NSTimeInterval  lastVerifyPageDisplayTime;
    NSTimeInterval  nextButtonOnVerifyPageTime;
    NSTimeInterval  backButtonOnVerifyPageTime;
    NSTimeInterval  lastEnterPageDisplayTime;
    NSTimeInterval  lastRecallPageDisplayTime;
    NSTimeInterval  lastCharOnAnyPageTime;
    NSTimeInterval  firstCharTimeInEntryField[10];  // These are used to keep track of firt time hen chacters when eneter in entry fields
    NSTimeInterval  lastCharTimeInEntryField[10];   // These are used to keep track of last chacter time when it was entred in entry field
    NSTimeInterval  lastCharTimeInAnyEntryField;
    
}

@synthesize window = _window;
@synthesize navigationController = _navigationController;

@synthesize documentsDir;
@synthesize baseTimeStamp;
@synthesize participantId;
@synthesize participantViewController;
@synthesize readyViewController;
@synthesize memorizeViewController;
@synthesize verifyViewController;
@synthesize testViewController;
@synthesize recallViewController;
@synthesize thankYouViewController;
@synthesize numberOfStrings;
@synthesize keyBoardVisible;
@synthesize lastTouchLocation;
@synthesize numericKeyBoard;
@synthesize symbolLayer;

///////////////////////////////////////////////////////////////////////////////////
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    currentStringNumber = 0;
    inputCharStrings = nil;
    
    // if our documents folder deos not have inpur strings file use default
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    self.documentsDir = [paths objectAtIndex:0];
    NSString *inputFilePath = [self.documentsDir stringByAppendingPathComponent:@"input.txt"];    
    NSError  *err;
    

    phaseNames = [NSArray arrayWithObjects: @"Memorize", @"Verify", @"Enter", @"Recall", nil];
    phaseShortNames = [NSArray arrayWithObjects: @"M", @"V", @"E", @"R", nil];

    NSFileManager *fileManager;
    fileManager = [NSFileManager defaultManager];
    
    if ([fileManager fileExistsAtPath:inputFilePath] == NO ) {
        // create file default file
        NSArray *array = [[NSArray alloc] initWithObjects:@"ABCD1", @"ABCD2", @"ABCD3",@"ABCD4",@"ABCD5",@"ABCD6",@"ABCD7",@"ABCD8",@"ABCD9",@"ABCD10",nil];
        
        [[array componentsJoinedByString:@"\n"] writeToFile:inputFilePath atomically:YES encoding:NSUTF8StringEncoding error:NULL];       
    }  
    inputCharStrings = [ [NSString stringWithContentsOfFile:inputFilePath encoding: NSASCIIStringEncoding error:&err] componentsSeparatedByString:@"\n"];
    self.numberOfStrings = [inputCharStrings count];
    
    
    // initialize user vents arrya wehre we store all events
    NSNumber *num = [NSNumber numberWithUnsignedInt:1000];
    NSUInteger  count = [num unsignedIntValue];
    userEvents = [NSMutableArray arrayWithCapacity:count];
    
    [self initRolledUpData];
      
 
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
 
    self.participantViewController = [[NISTParticipantViewController alloc] initWithNibName:@"NISTParticipantView" bundle:nil];
    self.navigationController = [[NISTNavigationController alloc] initWithRootViewController:participantViewController];
    self.navigationController.delegate = self;    
    self.window.rootViewController = self.navigationController;
    [self.window makeKeyAndVisible];
    return YES;
    
}

///////////////////////////////////////////////////////////////////////////////////
-(void) initRolledUpData {
    
    // initialize PerStringData
    NSNumber *num = [NSNumber numberWithUnsignedInt:10];
    NSUInteger  count = [num unsignedIntValue];
    rolledUpDataPerString = [NSMutableArray arrayWithCapacity:count];
    
    // initialize recalled values array
    recalledStrings = [NSMutableArray arrayWithCapacity:count];
    recalledMatched = [NSMutableArray arrayWithCapacity:count];
                     
    for ( int i=0; i < 10; i++ ) {
        NISTPerStringRolledUpData *data = [[NISTPerStringRolledUpData alloc] init];
        data->targetString = [[NSString alloc] initWithString:[inputCharStrings objectAtIndex:i]];
        data->stringNumber = i+1;
        [rolledUpDataPerString addObject:data];
    }
    
    [self initForNewString];
}


///////////////////////////////////////////////////////////////////////////////////
-(void) initForNewString {
    
    lastMemorizePageDisplayTime = 0;
    lastCharOnAnyPageTime = 0;
    lastVerifyPageDisplayTime = 0;  
    nextButtonOnVerifyPageTime = 0;
    backButtonOnVerifyPageTime = 0;
    lastEnterPageDisplayTime = 0;
    lastRecallPageDisplayTime = 0;
    lastCharTimeInAnyEntryField = 0;
    for ( int i=0; i < 10; i++ ) {
        firstCharTimeInEntryField[i]=0;
        lastCharTimeInEntryField[i]=0;
    }
}



///////////////////////////////////////////////////////////////////////////////////
-(void) hideNavigationControllerBackButton
{
    UINavigationBar *uiNavBar = [self.navigationController navigationBar];
    UINavigationItem *backItem = [uiNavBar backItem];
    backItem.hidesBackButton = YES;   
}

///////////////////////////////////////////////// USER EVENTS HANDLING ////////////////////////
///////////////////////////////////////////////////////////////////////////////////
-(void) userBeginsTest {
    
    NSString *rawFilePath = [self getRawDataFilePath];
    NSString *rolledFilePath = [self getRolledUpDataFilePath];

    NSFileManager *fileManager;
    fileManager = [NSFileManager defaultManager];

    if ([fileManager fileExistsAtPath:rawFilePath] == YES ) {
        [fileManager removeItemAtPath:rawFilePath error: NULL];
    }

    if ([fileManager fileExistsAtPath:rolledFilePath] == YES ) {
        [fileManager removeItemAtPath:rolledFilePath error: NULL];
    }
    
    
    if ([fileManager fileExistsAtPath:rawFilePath] == NO ) {
        // create file default file
        NSArray *array = [[NSArray alloc] initWithObjects:@"MilliSeconds", @"Phase or Participant", @"String Number", @"Phase Code", @"Character Code", @"Entered String", @"Target String", @"Match", @"X-Cord", @"Y-Cord" @"\n", nil];
        
        [[array componentsJoinedByString:@","] writeToFile:rawFilePath atomically:YES encoding:NSUTF8StringEncoding error:NULL];      
    } 

    if ([fileManager fileExistsAtPath:rolledFilePath] == NO ) {
        // create file default file
        NSArray *array = [[NSArray alloc] initWithObjects:@"Participant Id", @"Target String", @"Entered String", @"Match", @"Elapse Time", @"String Number", @"Phase Code", @"\n", nil];
        
        [[array componentsJoinedByString:@","] writeToFile:rolledFilePath atomically:YES encoding:NSUTF8StringEncoding error:NULL];      
    } 
    
    // open files 
    rawFileHandle = [NSFileHandle fileHandleForUpdatingAtPath:rawFilePath];
    if ( rawFileHandle == nil )
        NSLog(@"Could not open raw output file to update\n");
    
    rolledUpFileHandle = [NSFileHandle fileHandleForUpdatingAtPath:rolledFilePath];
    if ( rawFileHandle == nil )
        NSLog(@"Could not open rolled-up output file to update\n");
    
    
}

///////////////////////////////////////////////////////////////////////////////////
-(void) insertIndividualMemoryTime: (NSTimeInterval) time andString:str forStringNum: (int) index {
    
    // Get PerStringData for string number index
    NISTPerStringRolledUpData *temp = [rolledUpDataPerString objectAtIndex:index];
    
    // add individual memorize time
    [temp->individualMemorizeTime addObject: [[NSNumber alloc] initWithDouble:time]]; 
    [temp->individualMemorizeStings addObject:[[NSString alloc] initWithString:str]];
    
    NSLog(@"Added individual memeory time = %f, and entered string as %@ for string number %d\n", time, str, index);
    
}

///////////////////////////////////////////////////////////////////////////////////
-(void) insertTotalMemorizeTimeForString: (int) index {

    // Get PerStringData for string number index
    NISTPerStringRolledUpData *temp = [rolledUpDataPerString objectAtIndex:index];
    temp->totalMemorizeTime = 0;
    for ( NSNumber *e in temp->individualMemorizeTime ) {
        temp->totalMemorizeTime += [e doubleValue];
    }
    
    NSLog(@"Inserted Total memory time = %f for string number %d\n", temp->totalMemorizeTime, index);

}


///////////////////////////////////////////////////////////////////////////////////
-(void) insertTotalVerifyTimeForString: (int) index {
    
    // Get PerStringData for string number index
    NISTPerStringRolledUpData *temp = [rolledUpDataPerString objectAtIndex:index];
    temp->totalVerifyTime = 0;
    for ( NSNumber *e in temp->individualVerifyTime ) {
        temp->totalVerifyTime += [e doubleValue];
    }
    
    NSLog(@"Inserted Total Verify time = %f for string number %d\n", temp->totalVerifyTime, index);
    
}


///////////////////////////////////////////////////////////////////////////////////
-(void) insertIndividualVerifyTime: (NSTimeInterval) time andString:str forStringNum: (int) index {
    
    // Get PerStringData for string number index
    NISTPerStringRolledUpData *temp = [rolledUpDataPerString objectAtIndex:index];
    
    // add individual verify time
    [temp->individualVerifyTime addObject: [[NSNumber alloc] initWithDouble:time]]; 
    [temp->individualVerifyStrings addObject:[[NSString alloc] initWithString:str]];
    
    NSLog(@"Inserted individual verify time = %f, and entered string as %@ for string number %d\n", time, str, index);
    
}



///////////////////////////////////////////////////////////////////////////////////
-(void) insertEnterPhaseTimeData: (int) index finishedAtTime: (NSTimeInterval) time {
        
    // Get PerStringData for string number index
    NISTPerStringRolledUpData *temp = [rolledUpDataPerString objectAtIndex:index];
    for (int i=0; i < 10; i++ ) {
        temp->entryTime[i] = lastCharTimeInEntryField[i] - firstCharTimeInEntryField[i];
        NSLog(@"Calculating indivdual enter page time per string value [%d] is = %f\n", i+1, temp->entryTime[i]);
    } 
    
    temp->totalEntryTime = time - lastEnterPageDisplayTime;
    NSLog(@"Calculating total enter page time per string value is = %f\n", temp->totalEntryTime);

    temp->startMemToEndOfEntryTime = lastCharTimeInAnyEntryField - lastMemorizePageDisplayTime;
    NSLog(@"Calculating Start of memeory page to end of enter pahse for this string value is = %f\n",  temp->startMemToEndOfEntryTime);
    
}


///////////////////////////////////////////////////////////////////////////////////
-(void) insertEnterPhaseStrings: (NSMutableArray *) entryPhaseStrings forString: (int) index {

    // Get PerStringData for string number index
    NISTPerStringRolledUpData *temp = [rolledUpDataPerString objectAtIndex:index];
    for (NSString *e in entryPhaseStrings) {
        [temp->individualEntrySrings addObject:[[NSString alloc] initWithString:e]];
    }
}


///////////////////////////////////////////////////////////////////////////////////
-(void) updateEnterPhaseDataForEntryField: (int) entryFieldNumber withTime: (NSTimeInterval) time {
    int index = entryFieldNumber-1;
    
    if ( firstCharTimeInEntryField[index] == 0 ) {
        firstCharTimeInEntryField[index] = time;
    }
    
    lastCharTimeInEntryField[index] = time;
    lastCharTimeInAnyEntryField = time;
}

///////////////////////////////////////////////////////////////////////////////////
-(void) switchedToMemorizePage:(NISTUserEvent *)event {
    lastMemorizePageDisplayTime = event.eventTime;
    NSLog(@"Swicthed to Memeorize page and lastMemorizeDisplayTime = %f\n", lastMemorizePageDisplayTime);
}

///////////////////////////////////////////////////////////////////////////////////
-(void) switchedToVerifyPage:(NISTUserEvent *)event {
    
    lastVerifyPageDisplayTime = event.eventTime;
    NSLog(@"Swicthed to Verify Page and lastVerifyPageDisplayTime = %f\n", lastVerifyPageDisplayTime);
    
}

///////////////////////////////////////////////////////////////////////////////////
-(void) switchedToEnterPage:(NISTUserEvent *)event {
    
    lastEnterPageDisplayTime = event.eventTime;    
    NSLog(@"Swicthed to Enter Page and lastEnterPageDisplayTime = %f\n", lastEnterPageDisplayTime);
}



///////////////////////////////////////////////////////////////////////////////////
-(void) switchedToRecallPage:(NISTUserEvent *)event {
    lastRecallPageDisplayTime = event.eventTime;    
    
}

-(NSString *) didMatchAnyInputString: (NSString *) s {
    
    int     count = [inputCharStrings count];
    NSString *match = @"False";

    for (int i=0; i < count; i++) {
        if ( [[inputCharStrings objectAtIndex:i] isEqualToString: s] ) {
            match = @"True";
            break;
        }
    }
    
    return match;
    
}

-(void) userIsDoneRecallingStrings: (NSMutableArray *) values atTime:(NSTimeInterval) stamp { 
    
    // update recalled values
    for (NSString *e in values) {
        [recalledStrings addObject:[[NSString alloc] initWithString:e]];
        NSString *match = [self didMatchAnyInputString: e];
        [recalledMatched addObject:[[NSString alloc] initWithString:match]];
    }
    
    totalRecallTime = stamp - lastRecallPageDisplayTime;
    totalSessionTime = stamp - baseTimeStamp;
    
    [self logRecalledAndSessionData];
    
}

///////////////////////////////////////////////////////////////////////////////////
-(void) userChangedPhase:(NISTUserEvent *)event
{
    if (event.phase == NISTMemorize )
        [self switchedToMemorizePage: event];
    else if (event.phase == NISTVerify )
        [self switchedToVerifyPage: event];
    else if (event.phase == NISTEnter )
        [self switchedToEnterPage: event];
    else if (event.phase == NISTRecall )
        [self switchedToRecallPage: event];
    
    [self resetKeyboardState];    
    // add user event to our array of user events.
    // [userEvents addObject:event];
    NSString *record = [self getRawDataRecord:event];
    
    NSLog(@"%@", record );
    [self logToRawFile:record];
}


///////////////////////////////////////////////////////////////////////////////////
-(void) userTappedNextForPhase:(NISTPhase)phase atTime:(NSTimeInterval)time withEnteredStrings:(NSMutableArray *)enteredStrings {
    
    if ( phase == NISTEnter ) {
        nextButtonOnVerifyPageTime = time;
        NSLog(@"User tapped next on verify page and nextButtonOnVerifyPageTime = %f\n", nextButtonOnVerifyPageTime);
        NSLog(@"Calculating individual verify time as lastTime View page was displayed - time next on view page\n");
        
        // user is moving to Enter pahse so no chance of going back to memorize pahse
        // hence we can calculate total memorize time
        [self insertTotalMemorizeTimeForString:currentStringNumber];
        
        // now that user is going to ENTER pahse add current verify page time interval and also
        // insert total time for verify page sine user can not come back to verify page again
        NSTimeInterval t = time - lastVerifyPageDisplayTime;
        NSString *str = [enteredStrings objectAtIndex:0];
        [self insertIndividualVerifyTime:t andString:str forStringNum:currentStringNumber];
        
        // total verify time
        [self insertTotalVerifyTimeForString:currentStringNumber];
        
    } else if ( phase == NISTVerify) {
        
        NSString *str = [enteredStrings objectAtIndex:0];
        
        // user is entring Verify phase
        // let us determine individual memorize time for the current string
        NSTimeInterval temp;
        if ( [str length] > 0 ) {
            // if user did  enter  text then we calculate time when used pressed last character on memeory view since view was displayed
            temp = lastCharOnAnyPageTime - lastMemorizePageDisplayTime;
        } else {
            // if user did not enter any text then we calculate time when used pressed the next button
            temp = time - lastMemorizePageDisplayTime;
        }
        
        [self insertIndividualMemoryTime:temp andString:str forStringNum:currentStringNumber];

    }
}

-(void) userTappedBackForPhase:(NISTPhase)phase atTime:(NSTimeInterval)time withEnteredStrings: (NSMutableArray *) enteredStrings {
    
    // now that user is going to MEmeory page from verify phase add current verify page time interval
    NSLog(@"Calculating individual verify Time as lastTimeVerifyViewWas dispalyed - back button on view page\n");
    NSTimeInterval t = time - lastVerifyPageDisplayTime;
    NSString *str = [enteredStrings objectAtIndex:0];
    [self insertIndividualVerifyTime:t andString:str forStringNum:currentStringNumber];
    
}


///////////////////////////////////////////////////////////////////////////////////
-(void) insertIndividualVerifyTime:(NISTPhase)phase atTime:(NSTimeInterval)time withEnteredStrings:(NSMutableArray *)enteredStrings {
    if ( phase == NISTMemorize ) {
        backButtonOnVerifyPageTime = time;
        NSLog(@"User tapped Back on verify page and backButtonOnVerifyPageTime = %f\n", backButtonOnVerifyPageTime);
        
        // now that user is coming back form the verify page
        // insert indivdual time entry for verify page
        // let us determine individual memorize time for the current string
        NSTimeInterval timeAtVerify;
        
        timeAtVerify = time - lastVerifyPageDisplayTime;
        NSString *str = [enteredStrings objectAtIndex:0];
        [self insertIndividualVerifyTime:timeAtVerify andString:str forStringNum:currentStringNumber];
        
    }
    
}


///////////////////////////////////////////////////////////////////////////////////
-(void) userEnteredData:(NISTUserEvent *)event
{
    lastCharOnAnyPageTime = event.eventTime;
    
    NSLog(@"Last Character time is = %f\n", lastCharOnAnyPageTime);
    
    if ( event.phase == NISTEnter ) {
        [self updateEnterPhaseDataForEntryField: event.subPhase withTime: event.eventTime];
    }
    
    [userEvents addObject:event];
    NSString *record = [self getRawDataRecord:event];
    NSLog(@"%@", record);
    [self logToRawFile:record];
}

///////////////////////////////////////////////////////////////////////////////////
-(void) userDoneWithCurrentString: (NSMutableArray *) entryPhaseStrings atTime:(NSTimeInterval) time {
    
    // user just finished  working on Enter Page
    [self insertEnterPhaseTimeData: currentStringNumber finishedAtTime:time];

    [self insertEnterPhaseStrings: entryPhaseStrings forString: currentStringNumber];
        
    [self logRolledUpDataForString: currentStringNumber];
    
    
    // initialize yourself and others for the next string handling
    [self initForNewString];
    
    if ( self.memorizeViewController != nil )
        [self.memorizeViewController initForNewString];

    // inform all existing views controllers
    if ( self.verifyViewController != nil )
        [self.verifyViewController initForNewString];
    
        
    if ( currentStringNumber < (int)numberOfStrings-1 ) {
        currentStringNumber++;
        [self.navigationController popToViewController: (UIViewController *) self.memorizeViewController animated:YES];
    } else {      
        // let us load "Recall" View as the next view
        NISTRecallViewController *rvc = [[NISTRecallViewController alloc] initWithNibName:@"NISTRecallViewController" bundle:nil];
        self.recallViewController = rvc;
        [self.navigationController pushViewController:rvc animated:YES];
    }
}

///////////////////////////////////////////////// DATA HANDLING ////////////////////////
///////////////////////////////////////////////////////////////////////////////////
- (void) closeRawFile 
{
    [rawFileHandle closeFile];
}

///////////////////////////////////////////////////////////////////////////////////
- (void) closeRolledUpFile 
{
    [rolledUpFileHandle closeFile];
}

-(BOOL) doesContainComma: (NSString *) strToCheck {

    BOOL bRet;
    // check if sofar types string as a , or not
    NSCharacterSet * set = [NSCharacterSet characterSetWithCharactersInString:@","];
    if ([strToCheck rangeOfCharacterFromSet:set].location == NSNotFound) {
         bRet = NO;
    } else {
        bRet = YES;
    }
   
    return bRet;
    
}

-(void) logRolledUpDataForString: (int) index {

    NSString   *notApplicable = @"n\\a";
    NSString   *match;
    NSString   *enteredString;

    // Get PerStringData for string number index
    NISTPerStringRolledUpData *data = [rolledUpDataPerString objectAtIndex:index];
    
    int i = 1;
    for (NSNumber *n in data->individualMemorizeTime) {
        
        NSString *record;

        // log memory phase record
        double time = [n doubleValue];
        long sec = (long) (time * 1000);
        NSString    *phaseStr;
        phaseStr = [[NSString alloc] initWithFormat:@"%@%i", [phaseShortNames objectAtIndex:NISTMemorize], i];

        enteredString = [data->individualVerifyStrings objectAtIndex:i-1]; 
        if ( [self doesContainComma:enteredString] )
            record = [[NSString alloc] initWithFormat:@"%@,%@,\"%@\",%@,%ld,%i,%@\n", participantId, data->targetString, enteredString, notApplicable, sec, index+1, phaseStr];
        else {
            record = [[NSString alloc] initWithFormat:@"%@,%@,%@,%@,%ld,%i,%@\n", participantId, data->targetString, enteredString, notApplicable, sec, index+1, phaseStr];
        }

        [self logToRolledUpFile:record];
        i++;
    }

    i = 1;
    for (NSNumber *n in data->individualVerifyTime) {
        
        // log memory phase record
        double time = [n doubleValue];
        long sec = (long) (time * 1000);
        
        NSString    *phaseStr;
        phaseStr = [[NSString alloc] initWithFormat:@"%@%i", [phaseShortNames objectAtIndex:NISTVerify], i];
        
        enteredString = [data->individualVerifyStrings objectAtIndex:i-1];
        if ( [data->targetString isEqualToString:enteredString] )
            match = @"True";
        else 
            match = @"False";
        
        
        NSString *record;
        record = [[NSString alloc] initWithFormat:@"%@,%@,%@,%@,%ld,%i,%@\n", participantId, data->targetString, enteredString, match, sec, index+1, phaseStr ];
        [self logToRolledUpFile:record];
        i++;
    }

    // Log total memory phase time entry
    // Log total entry time per string
    double time = data->totalMemorizeTime;
    long sec = (long) (time * 1000);
    
    NSString    *phaseStr;
    phaseStr = [[NSString alloc] initWithFormat:@"%@T", [phaseShortNames objectAtIndex:NISTMemorize]];
    NSString *record;
    record = [[NSString alloc] initWithFormat:@"%@,%@,%@,%@,%ld,%i,%@\n", participantId, data->targetString, notApplicable, notApplicable, sec, index+1, phaseStr ];
    [self logToRolledUpFile:record];
    
    // Log total verification time entry
    time = data->totalVerifyTime;
    sec = (long) (time * 1000);    
    phaseStr = [[NSString alloc] initWithFormat:@"%@T", [phaseShortNames objectAtIndex:NISTVerify]];
    record = [[NSString alloc] initWithFormat:@"%@,%@,%@,%@,%ld,%i,%@\n", participantId, data->targetString, notApplicable, notApplicable, sec, index+1, phaseStr ];
    [self logToRolledUpFile:record];
    
    
    // Log Entry phase records
    for (int k=0; k < 10; k++ ) {
        // log memory phase record
        double time = data->entryTime[k];
        long sec = (long) (time * 1000);
        
        NSString    *phaseStr;
        phaseStr = [[NSString alloc] initWithFormat:@"%@%i", [phaseShortNames objectAtIndex:NISTEnter], k+1];
        enteredString = [data->individualEntrySrings objectAtIndex:k];
        if ( [data->targetString isEqualToString:enteredString] )
            match = @"True";
        else 
            match = @"False";
       
        NSString *record;
        if ( [self doesContainComma:enteredString] )
            record = [[NSString alloc] initWithFormat:@"%@,%@,\"%@\",%@,%ld,%i,%@\n", participantId, data->targetString, enteredString, match, sec, index+1, phaseStr ];
        else {
            record = [[NSString alloc] initWithFormat:@"%@,%@,%@,%@,%ld,%i,%@\n", participantId, data->targetString, enteredString, match, sec, index+1, phaseStr ];
        }

        [self logToRolledUpFile:record];
        i++;        
    }
    
    // Log total entry time per string
    time = data->totalEntryTime;
    sec = (long) (time * 1000);

    phaseStr = [[NSString alloc] initWithFormat:@"%@T", [phaseShortNames objectAtIndex:NISTEnter]];
    record = [[NSString alloc] initWithFormat:@"%@,%@,%@,%@,%ld,%i,%@\n", participantId, data->targetString, notApplicable, notApplicable, sec, index+1, phaseStr ];
    [self logToRolledUpFile:record];
    
    
    // log start memory to end of entry time
    time = data->startMemToEndOfEntryTime;
    sec = (long) (time * 1000);    
    phaseStr = [[NSString alloc] initWithString:@"M2E"];
    record = [[NSString alloc] initWithFormat:@"%@,%@,%@,%@,%ld,%i,%@\n", participantId, data->targetString, notApplicable, notApplicable, sec, index+1, phaseStr ];
    [self logToRolledUpFile:record];
    
}

-(void) logRecalledAndSessionData {

    NSString        *notApplicable = @"n\\a";
    NSTimeInterval  totalEntryTimeForAll;
    
    totalEntryTimeForAll = 0;
    // log total entry time data for ALL string (new requirements)
    for (NISTPerStringRolledUpData *d in rolledUpDataPerString ) {
        totalEntryTimeForAll +=  d->totalEntryTime;
    }
    // log total recall time
    // Log total entry time per string
    double time = totalEntryTimeForAll;
    long sec = (long) (time * 1000);
    NSString    *phaseStr;
    phaseStr = [[NSString alloc] initWithFormat:@"%@TT", [phaseShortNames objectAtIndex:NISTEnter]];
    NSString *record;
    record = [[NSString alloc] initWithFormat:@"%@,%@,%@,%@,%ld,%@,%@\n", participantId, notApplicable, notApplicable, notApplicable, sec, notApplicable, phaseStr ];
    [self logToRolledUpFile:record];

    
    // Log Recalled phase records
    int i = 1;
    for (NSString *r in recalledStrings) {       
        NSString    *phaseStr;
        phaseStr = [[NSString alloc] initWithFormat:@"%@%i", [phaseShortNames objectAtIndex:NISTRecall], i];
        NSString *record;
        
        NSString *match = [recalledMatched objectAtIndex:i-1];
        record = [[NSString alloc] initWithFormat:@"%@,%@,%@,%@,%@,%@,%@\n", participantId, notApplicable, r, match, notApplicable, notApplicable, phaseStr];
        [self logToRolledUpFile:record];
        i++;        
    }
    
    
    // log total recall time
    // Log total entry time per string
    time = totalRecallTime;
    sec = (long) (time * 1000);
    phaseStr = [[NSString alloc] initWithFormat:@"%@T", [phaseShortNames objectAtIndex:NISTRecall]];
    record = [[NSString alloc] initWithFormat:@"%@,%@,%@,%@,%ld,%@,%@\n", participantId, notApplicable, notApplicable, notApplicable, sec, notApplicable, phaseStr ];
    [self logToRolledUpFile:record];
    
    // log total session time
    time = totalSessionTime;
    sec = (long) (time * 1000);
    phaseStr = @"ST";
    record = [[NSString alloc] initWithFormat:@"%@,%@,%@,%@,%ld,%@,%@\n", participantId, notApplicable, notApplicable, notApplicable, sec, notApplicable, phaseStr];
    [self logToRolledUpFile:record];
    
    [self closeRolledUpFile];
    

}

-(void) logToRawFile: (NSString *) record {
    [rawFileHandle seekToEndOfFile];
    [rawFileHandle writeData: [record dataUsingEncoding:NSUTF8StringEncoding]];
    [rawFileHandle synchronizeFile];
}

-(void) logToRolledUpFile: (NSString *) record {
    [rolledUpFileHandle seekToEndOfFile];
    [rolledUpFileHandle writeData: [record dataUsingEncoding:NSUTF8StringEncoding]];    
    [rolledUpFileHandle synchronizeFile];
    
    NSLog(@"Rolled Update File Record->> %@\n", record);
}

- (NSString *) getCurrentString {
    
    NSString *str = @"No String";
    if ( inputCharStrings != nil )
        str = [inputCharStrings objectAtIndex:currentStringNumber];
    
    return str;
}

-(NSString *) getStringMsg {
    NSString *msg;
    
    msg = [[NSString alloc] initWithFormat:@"Character string %d of %d", currentStringNumber+1, numberOfStrings];
    return msg;
}


-(NSString *) mapCharCodeToDisplayString: (NSString *) code {
    if ( [code length] == 0 )
        return @"BACKSPACE";
    
    if ( [code isEqualToString:@"\n"] )
        return @"ENTER";
    
    return code;
}

-(NSString *) mapSoFarTypedStringToDisplayString: (NSString *) soFar {

    NSString *displayString;
    
    if ( (soFar == nil ) || ( [soFar length] == 0 ) ) {
        displayString = [ [NSString alloc] initWithString:@"\"\""];
    }
    
    return displayString;

}



-(NSString *) getRawDataRecord: (NISTUserEvent *) event {

    NSString *retString;
    BOOL    bSoFarTypedStringHasComma  = NO;
    BOOL    bCharCodeHasComma = NO;
    
    double time =  event.eventTime - baseTimeStamp;
    long sec = (long) (time * 1000);
    
    if ( event.eventType == NISTEventTypeInput ) {
        
        // detrmine sub phase string
        NSNumber *num = [NSNumber numberWithUnsignedInt:event.phase];
        NSUInteger  index = [num unsignedIntValue];
        NSString    *phaseStr;
        if ( event.subPhase != 0 )
            phaseStr = [[NSString alloc] initWithFormat:@"%@%i", [phaseShortNames objectAtIndex:index], event.subPhase];
        else {
            phaseStr = [[NSString alloc] initWithFormat:@"%@", [phaseShortNames objectAtIndex:index]];
        }

        // MATCH
        NSString *match;
        if ( [event.soFarTypedText isEqualToString:[self getCurrentString] ] )
            match = @"True";
        else 
            match = @"False";
        
        // SO FAR TYPED TEXT
        NSString *temp = [self mapSoFarTypedStringToDisplayString: event.soFarTypedText];
        if ( temp == nil )
            temp = event.soFarTypedText;
        
        // check if sofar types string as a , or not
        NSCharacterSet * set = [NSCharacterSet characterSetWithCharactersInString:@","];
        if ([temp rangeOfCharacterFromSet:set].location == NSNotFound) {
            bSoFarTypedStringHasComma = NO;
            //NSLog(@"NO there was no comma in the so far typed string\n");
        } else {
            bSoFarTypedStringHasComma = YES;
            //NSLog(@"Yes there was a comma in the so far typed string\n");            
            if ( [temp rangeOfCharacterFromSet:set].location == NSNotFound ) { 
                bCharCodeHasComma = NO;
            } else {
                NSLog(@"Yes, there was a comma in current char string\n");            
                bCharCodeHasComma = YES;
            }
        }
    
        // CHARACTER CODE
        NSString *charCodeStr = [self mapCharCodeToDisplayString:event.chacterCode];
        
        // FINAL STRING
        if ( bSoFarTypedStringHasComma == NO ) {
            retString = [[NSString alloc] initWithFormat:@"%ld,%@,%i,%@,%@,%@,%@,%@,%f,%f\n", sec, participantId, currentStringNumber+1, phaseStr, charCodeStr, temp, [self getCurrentString], match, lastTouchLocation.x, lastTouchLocation.y ];
        } else if (bCharCodeHasComma == YES ) {
            retString = [[NSString alloc] initWithFormat:@"%ld,%@,%i,%@,\"%@\",\"%@\",%@,%@,%f,%f\n", sec, participantId, currentStringNumber+1, phaseStr, charCodeStr, temp, [self getCurrentString], match, lastTouchLocation.x, lastTouchLocation.y ];
        } else {
            retString = [[NSString alloc] initWithFormat:@"%ld,%@,%i,%@,%@,\"%@\",%@,%@,%f,%f\n", sec, participantId, currentStringNumber+1, phaseStr, charCodeStr, temp,[self getCurrentString], match, lastTouchLocation.x, lastTouchLocation.y ];            
        }
    } else if ( event.eventType == NISTEventTypePhaseChange ) {
        retString = [[NSString alloc] initWithFormat:@"%ld,%@\n", sec, [phaseNames objectAtIndex: event.phase]];
    }
    
    return retString;
}

-(NSString *) getRawDataFilePath {
    NSString *rawDataFileName = [[NSString alloc] initWithFormat:@"%@_raw.csv", self.participantId];
    NSString *rawDataFilePath = [self.documentsDir stringByAppendingPathComponent:rawDataFileName];
    return rawDataFilePath;
}

-(NSString *) getRolledUpDataFilePath {
    NSString *fileName = [[NSString alloc] initWithFormat:@"%@_rolled.csv", self.participantId];
    NSString *filePath = [self.documentsDir stringByAppendingPathComponent:fileName];
    return filePath;
}

-(void) resetKeyboardState {
    self.symbolLayer = NO;
    self.numericKeyBoard = NO;
}


-(void) userEnteredSpecialKey: (NISTSpecialKeyType) keyType atTime:(NSTimeInterval)time1 {
    
    double time =  time1 - baseTimeStamp;
    long sec = (long) (time * 1000);
    NSString *keyName = nil;
    
    
    if ( keyType == NISTKBSwitchKey ) {
        self.numericKeyBoard = (! self.numericKeyBoard);
        if ( self.numericKeyBoard ) {
            keyName = @"<.?123>";
            NSLog(@"NOW Numberic Key Board\n");
        } else {
            keyName = @"<ABC>";
            NSLog(@"NOW Alphabetic Key Board\n");
        }
    } else if ( keyType == NISTShiftAreaKey ) {
        if ( self.numericKeyBoard ) {
            self.symbolLayer = (!self.symbolLayer);
            if ( self.symbolLayer ) {
                keyName = @"<#+=>";
                NSLog(@"NOW Symbol Layer\n");
            } else {
                keyName = @"<123>";
                NSLog(@"NOW Number Layer\n");
            }
        } else {
            keyName = @"<SHIFT>";
            NSLog(@"SHIFT Key\n");
        }
    }
    
    NSString *retString = [[NSString alloc] initWithFormat:@"%ld,%@\n", sec, keyName];
    
    [self logToRawFile:retString];
    
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
