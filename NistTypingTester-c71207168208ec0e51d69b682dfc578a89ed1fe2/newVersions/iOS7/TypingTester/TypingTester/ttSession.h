//
//  ttSession.h
//  TypingTester
//
//  Created by Matthew Kerr on 8/13/13.
//

#import <Foundation/Foundation.h>
#import "ttConstants.h"

@class ttParticipant;
@class ttSession;
@class ttEvent;

@protocol SessionDelegate <NSObject>


@end

@interface ttSession : NSObject


@property (nonatomic, weak) id <SessionDelegate> delegate;
@property (nonatomic, strong) ttParticipant *participant;
@property (nonatomic, strong) NSMutableArray* events;

@property (nonatomic, assign) NSUInteger currentProficiencyString;
@property (nonatomic, assign) NSUInteger currentEntity;
@property (nonatomic, assign) NSUInteger currentEntryForEntity;
@property (nonatomic, strong) NSArray *proficiencyStrings;
@property (nonatomic, strong) NSArray *entities;
@property (nonatomic, assign) NSUInteger CurrentPracticeRoundForEntity;
@property (nonatomic, assign) NSUInteger currentVerifyRoundForEntity;

@property (nonatomic, copy) NSString* workAreaContents;
@property (nonatomic, assign) Phase currentPhase;
@property (nonatomic, assign) SubPhase currentSubPhase;


-(id)initWithParticipantId:(NSString*)participantId;

-(void)sessionDidStart;
-(void)sessionDidFinish;

-(void)enteredPhase:(Phase)phase withNote:(NSString*)note;
-(void)leftPhase:(Phase)phase withNote:(NSString*)note;
-(void)enteredSubPhase:(SubPhase)subphase withNote:(NSString*)note;

-(void)enteredProficiencyPhase;
-(BOOL)nextEntity;

-(void)addEvent:(ttEvent*)event;

-(BOOL)initializeLogFiles;
-(void)closeLogFiles;
-(void) writeLineToRawLogFile:(NSString*)string;
-(void) writeLineToSummaryLogFile:(NSString*)string;

-(NSString*) formatDate:(NSDate*)date;

@end
