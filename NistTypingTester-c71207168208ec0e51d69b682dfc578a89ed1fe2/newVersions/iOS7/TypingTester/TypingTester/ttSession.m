//
//  ttSession.m
//  TypingTester
//
//  Created by Matthew Kerr on 8/13/13.
//

#import "ttSession.h"
#import "ttParticipant.h"
#import "ttEvent.h"
#import "ttUtilities.h"
#import "ttSettings.h"
#import "ttInputData.h"
#import "ttTestEntity.h"
#import "ttUtilities.h"
#import "ttSettings.h"

@implementation ttSession
{
    NSFileHandle *rawFileHandle;
    NSFileHandle *summaryFileHandle;
    NSDate *sessionEnd;
    ttSettings *settings;
    NSDate *sessionStartTime;
    NSDate *phaseStartTime;
    NSDate *subPhaseStartTime;
    NSDate *entityStart;
    NSTimeInterval timeInFreePractice;
    NSTimeInterval timeInForcedPractice;
    NSTimeInterval timeInVerify;
    NSTimeInterval timeOnEntity;
    int timesInFreePractice;
    int timesInForcedPractice;
    int timesInVerify;
    NSDateFormatter *dateFormatter;
    NSDateFormatter *fileDateFormatter;
}

-(id) init
{
    return [self initWithParticipantId:@"000000000"];
}

-(id) initWithParticipantId:(NSString *)participantId
{
    self = [super init];
    if (self)
    {
        self.currentPhase = UnknownPhase;
        self.currentSubPhase = UnknownSubPhase;
        self.participant = [[ttParticipant alloc]initWithParticipantNumber:participantId];
        self.events = [[NSMutableArray alloc]init];
        dateFormatter = [[NSDateFormatter alloc]init];
        [dateFormatter setDateFormat:@"MM-dd-yyyy HH:mm:ss"];
        fileDateFormatter = [[NSDateFormatter alloc]init];
        [fileDateFormatter setDateFormat:@"yyyy-MM-dd_HH_mm"];
        if ([self initializeLogFiles] == NO)
        {
            // TODO :: Add error handling
        }
        settings = [ttSettings Instance];
        [self loadProficiencyGroups];
        [self loadEntities];
        [self sessionDidStart];
        [[UIApplication sharedApplication] setValue:self forKey:@"session"];
    }
    return self;
}

-(void) loadEntities
{
    self.entities = [[ttInputData Instance]getEntities];
    self.currentEntity = -1;
}

-(void) loadProficiencyGroups
{
    self.proficiencyStrings = [[ttInputData Instance]getPhrasesForGroupId:settings.proficiencyGroup];
    self.currentProficiencyString = 0;
}

#pragma mark - Lifecycle Events

-(BOOL) nextEntity
{
    //did we have a previous entity started?
    if (entityStart != nil)
    {
        NSTimeInterval totalEntityTime = [[NSDate date] timeIntervalSinceDate:entityStart];
        [self writeLineToSummaryLogFile:[NSString stringWithFormat:@"Total Free Practice: %i views for %f (s)", timesInFreePractice, timeInFreePractice]];
        [self writeLineToSummaryLogFile:[NSString stringWithFormat:@"Total Forced Practice: %i views for %f (s)", timesInForcedPractice, timeInForcedPractice]];
        [self writeLineToSummaryLogFile:[NSString stringWithFormat:@"Total Verify: %i views for %f", timesInVerify, timeInVerify]];
        [self writeLineToSummaryLogFile:[NSString stringWithFormat:@"Finishing Password: %lu at %@ in %f", (unsigned long)self.currentEntity, entityStart, totalEntityTime]];
    }
    NSUInteger currentE = self.currentEntity;
    NSUInteger eCount = self.entities.count;
    //if (self.currentEntity < self.entities.count)
    if (currentE + 1 < eCount)
    {
        self.currentEntity++;
        [self startEntity];
    
        ttEvent *event = [[ttEvent alloc]initWithEventType:SubPhaseChange andPhase:Entry andSubPhase:EntityChange];
        ttTestEntity *entity = [self.entities objectAtIndex:self.currentEntity];
        event.notes = [NSString stringWithFormat:@"Moving to Password:%@", entity.entityString];
        return YES;
    }
    else
    {
        return NO;
    }
}

-(void) startEntity
{
    entityStart = [NSDate date];
    timeInForcedPractice = 0;
    timeInForcedPractice = 0;
    timeInVerify = 0;
    timesInForcedPractice = 0;
    timesInFreePractice = 0;
    timesInVerify = 0;
    self.CurrentPracticeRoundForEntity = 0;
    self.currentEntryForEntity = 0;
    self.currentVerifyRoundForEntity = 0;
    self.workAreaContents = @"";
    [self writeLineToSummaryLogFile:[NSString stringWithFormat:@"Starting Password: %lu at %@", (unsigned long)self.currentEntity, entityStart]];
}

-(void) sessionDidStart
{
    //sessionStartTime = [NSDate date];
    [self writeLineToSummaryLogFile:[ttUtilities getProgramVersion]];
    [self writeLineToSummaryLogFile:[self getDeviceInformation]];
    [self writeLineToSummaryLogFile:[settings getSettings]];
    [self writeLineToRawLogFile:[NSString stringWithFormat:@"Initial orientation of device:%@", [ttUtilities stringForOrienatation:[UIApplication sharedApplication].statusBarOrientation]]];
    [self writeLineToSummaryLogFile:[NSString stringWithFormat:@"Session Started:%@", sessionStartTime]];
    [self writeLineToSummaryLogFile:[NSString stringWithFormat:@"Participant Id:%@", self.participant.participantNumber]];
    phaseStartTime = [NSDate date];
    // write error message for entity error lines
    if ([ttInputData Instance].entityNumberError == YES)
    {
        [self writeLineToSummaryLogFile:[NSString stringWithFormat:@"Settings Error: %lu passwords specified in settings, only %lu passwords found matching specified criteria.", (unsigned long)settings.entitiesPerSession, (unsigned long)self.entities.count]];
    }
    // check for filter errors
    if ([ttInputData Instance].entityFilterError == YES)
    {
        [self writeLineToSummaryLogFile:[NSString stringWithFormat:@"Settings Error: No passwords found matching specified filters, using all passwords as source pool."]];
    }
    // write out strings
    [self writeLineToSummaryLogFile:@"Passwords for session:"];
    for(int i = 0; i < self.entities.count; i++)
    {
        ttTestEntity *entity = [self.entities objectAtIndex:i];
        [self writeLineToSummaryLogFile:entity.entityString];
    }
    [self writeLineToSummaryLogFile:@"End Password list"];
    return;
}

-(void)enteredPhase:(Phase)phase withNote:(NSString*)note
{
    // only log if we are not in current phase
    if (phase != self.currentPhase)
    {
        phaseStartTime = [NSDate date];
        ttEvent *event = [[ttEvent alloc]initWithEventType:PhaseBegin andPhase:phase andSubPhase:NoSubPhase andTime:phaseStartTime];
        event.notes = note;
        [self addEvent:event];
        NSString *line = [NSString stringWithFormat:@"Started Phase:%@ at %@", ttcPhaseStringArray[phase], phaseStartTime];
        [self writeLineToSummaryLogFile:line];
        self.currentPhase = phase;
        // start a phase in no sub phase
        [self enteredSubPhase:NoSubPhase withNote:@"Starting new phase"];
    }
}

-(void)leftPhase:(Phase)phase withNote:(NSString*)note
{
    NSDate *now = [NSDate date];
    ttEvent *event = [[ttEvent alloc]initWithEventType:PhaseEnd andPhase:phase andSubPhase:self.currentSubPhase andTime:now];
    event.notes = note;
    [self addEvent:event];
    [self enteredSubPhase:NoSubPhase withNote:@"Preparing to leave phase"];
    self.currentPhase = UnknownPhase;
    NSString *line = [NSString stringWithFormat:@"Leaving Phase %@, overall time in phase:%f : %@", ttcPhaseStringArray[phase], [now timeIntervalSinceDate:phaseStartTime], note];
    [self writeLineToSummaryLogFile:line];
}

-(void)enteredSubPhase:(SubPhase)subphase withNote:(NSString*)note
{
    if (subphase != self.currentSubPhase)
    {
        ttEvent *event;
        NSString *line;
        NSDate *endTime = [NSDate date];
        // only log a change when moving from a known subphase to another
        if (self.currentSubPhase != NoSubPhase && self.currentSubPhase != UnknownSubPhase)
        {
            // log event about previous subphase ending
            event = [[ttEvent alloc] initWithEventType:SubPhaseChange andPhase:self.currentPhase andSubPhase:self.currentSubPhase andTime:endTime];
            event.notes = [NSString stringWithFormat:@"Time in subphase %@: %f", ttcSubPhaseStringArray[self.currentSubPhase], [endTime timeIntervalSinceDate:subPhaseStartTime]];
            line = [NSString stringWithFormat:@"Leaving subphase %@, time spent in subphase : %f", ttcSubPhaseStringArray[self.currentSubPhase],[endTime timeIntervalSinceDate:subPhaseStartTime]];
            [self writeLineToSummaryLogFile:line];

        }
        // if we are in a repeatable subphase track overall time in subphase.
        switch(self.currentSubPhase)
        {
            case FreePractice:
                timeInFreePractice += [endTime timeIntervalSinceDate:subPhaseStartTime];
                timesInFreePractice++;
                break;
                
            case ForcedPractice:
                timeInForcedPractice += [endTime timeIntervalSinceDate:subPhaseStartTime];
                timesInForcedPractice++;
                break;
                
            case Verify:
                timeInVerify += [endTime timeIntervalSinceDate:subPhaseStartTime];
                timesInVerify++;
                break;
                
            default:
                break;
        }
        
        // start new subphase
        subPhaseStartTime = [NSDate date];
        event = [[ttEvent alloc]initWithEventType:SubPhaseChange andPhase:self.currentPhase andSubPhase:subphase andTime:subPhaseStartTime];
        event.notes = note;
        [self addEvent:event];
        self.currentSubPhase = subphase;
        line = [NSString stringWithFormat:@"Starting Subphase %@", ttcSubPhaseStringArray[self.currentSubPhase]];
        [self writeLineToSummaryLogFile:line];
    }
}

-(void)enteredProficiencyPhase
{
    self.proficiencyStrings = [[ttInputData Instance]getPhrasesForGroupId:settings.proficiencyGroup];
    self.currentProficiencyString = 0;
}

-(void) sessionDidFinish
{
    sessionEnd = [NSDate date];
    [[UIApplication sharedApplication] setValue:nil forKey:@"session"];
    NSString *startString = [NSString stringWithFormat:@"Session Finished:%@", sessionEnd];
    [self writeLineToSummaryLogFile:startString];
    [self closeLogFiles];
    return;
}

-(NSString*) getDeviceInformation
{
    UIDevice *device = [UIDevice currentDevice];
    return [NSString stringWithFormat:@"Model:%@\nOS Version:%@\nDevice Name:%@\nSystem Name:%@\nDevice UUID(*):%@\n", device.model, device.systemVersion, device.name, device.systemName, device.identifierForVendor];
}


#pragma -mark Log Functions

-(void) addEvent:(ttEvent *)event
{
    // set the event session
    event.session = self;
    // any special event handling goes here
    NSString *line;
    switch (event.event)
    {
        case IncorrectValueEntered:
            line = [NSString stringWithFormat:@"Incorrect string value entered at %@: %@ , expected %@", event.time, event.currentValue, event.targetString];
            [self writeLineToSummaryLogFile:line];
            break;
            
        case CorrectValueEntered:
            line = [NSString stringWithFormat:@"Correct string value entered at %@: %@ , expected %@", event.time, event.currentValue, event.targetString];
            [self writeLineToSummaryLogFile:line];
            break;
            
        default:
            break;
    }
    // add subphase # to the notes
    switch(event.subPhase)
    {
        case FreePractice:
            event.subphaseVisitNumber = timesInFreePractice;
            event.notes = [NSString stringWithFormat:@"%@, Free Practice #:%i", event.notes, timesInFreePractice];
            break;
            
        case ForcedPractice:
            event.subphaseVisitNumber = timesInForcedPractice;
            event.notes = [NSString stringWithFormat:@"%@, Forced Practice #:%i", event.notes, timesInForcedPractice];
            break;
            
        case Verify:
            event.subphaseVisitNumber = timesInVerify;
            event.notes = [NSString stringWithFormat:@"%@, Verify #:%i", event.notes, timesInVerify];
            break;
            
        default:
            event.subphaseVisitNumber = 1;
            break;
    }
    event.interval = [event.time timeIntervalSinceDate:sessionStartTime];
    event.participantNumber = self.participant.participantNumber;
    [self writeLineToRawLogFile:[event description]];
    return;
}


-(BOOL)initializeLogFiles
{
    sessionStartTime = [NSDate date];
    NSString *deviceString;
    switch(UI_USER_INTERFACE_IDIOM())
    {
        case UIUserInterfaceIdiomPad:
            deviceString = [NSString stringWithFormat:@"iPad"];
            break;
            
        case UIUserInterfaceIdiomPhone:
            deviceString = [NSString stringWithFormat:@"iPhone"];
            break;
            
        default:
            deviceString = [NSString stringWithFormat:@"iOS_Device"];
            break;
    }

    NSString *filenameBase = [NSString stringWithFormat:@"%@_%@_%@", self.participant.participantNumber, [fileDateFormatter stringFromDate:sessionStartTime], deviceString];
    NSString *rawFileName = [NSString stringWithFormat:@"%@-raw.txt",filenameBase];
    NSString *summaryFileName = [NSString stringWithFormat:@"%@-summary.txt", filenameBase];
    NSString *rawLogFile = [[ttUtilities documentsDirectory] stringByAppendingPathComponent:rawFileName];
    NSString *summaryLogFile = [[ttUtilities documentsDirectory] stringByAppendingPathComponent:summaryFileName];
    rawFileHandle = [self createLogfile:rawLogFile];
    summaryFileHandle = [self createLogfile:summaryLogFile];
    // write the raw log file header
    [self writeLineToRawLogFile:[ttEvent getHeaderLine]];
    if (rawFileHandle == nil || summaryFileHandle == nil) return NO;
    return YES;
}

-(void)closeLogFiles
{
    [rawFileHandle closeFile];
    [summaryFileHandle closeFile];
}

-(void) writeLineToRawLogFile:(NSString*)string
{
    NSString *lineToWrite = [NSString stringWithFormat:@"%@\n",string];
    // TODO :: ADD Better error handling
    @try
    {
        [rawFileHandle writeData:[lineToWrite dataUsingEncoding:NSUTF8StringEncoding]];
        NSLog(@"RL:%@", lineToWrite);
    }
    @catch (NSException *exception)
    {
        NSLog(@"Error writing data to the raw log file");
    }
    @finally
    {
    }
}

-(void) writeLineToSummaryLogFile:(NSString*)string
{
    NSString *lineToWrite = [NSString stringWithFormat:@"%@\n",string];
    // TODO :: ADD Better error handling
    @try
    {
        [summaryFileHandle writeData:[lineToWrite dataUsingEncoding:NSUTF8StringEncoding]];
        NSLog(@"SL:%@", lineToWrite);
    }
    @catch (NSException *exception)
    {
        NSLog(@"Error writing data to the summary log file");
    }
    @finally
    {
        
    }
}

-(NSFileHandle*) createLogfile:(NSString*)logfileName
{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSError* error;
    if ([fileManager fileExistsAtPath:logfileName])
    {
        [fileManager removeItemAtPath:logfileName error:&error];
    }
    [fileManager createFileAtPath:logfileName contents:nil attributes:nil];
    return [NSFileHandle fileHandleForWritingAtPath:logfileName];
}
         
-(NSString*) formatDate:(NSDate*)date
{
    return [dateFormatter stringFromDate:date];
}

@end
