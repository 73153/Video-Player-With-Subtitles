//
//  ttEvent.h
//  TypingTester
//
//  Created by Matthew Kerr on 8/15/13.
//

#import <Foundation/Foundation.h>
#import "ttConstants.h"

@class ttSession;

@interface ttEvent : NSObject

@property (nonatomic, assign) Event event;
@property (nonatomic, assign) Phase phase;
@property (nonatomic, assign) SubPhase subPhase;
@property (nonatomic, copy) NSDate *time;
@property (nonatomic, copy) NSString *notes;
@property (nonatomic, assign) NSTimeInterval interval;
@property (nonatomic, copy) NSString *targetString;
@property (nonatomic, copy) NSString *participantNumber;
@property (nonatomic, assign) NSInteger location;
@property (nonatomic, assign) NSUInteger length;
@property (nonatomic, copy) NSString *enteredCharacters;
@property (nonatomic, copy) NSString *currentValue;
@property (nonatomic, assign) CGPoint point;
@property (nonatomic, assign) NSUInteger currentRound;
@property (nonatomic, assign) NSUInteger subphaseVisitNumber;
@property (nonatomic, weak) ttSession *session;

-(id)initWithEventType:(Event)event;
-(id)initWithEventType:(Event)event andPhase:(Phase)phase;
-(id)initWithEventType:(Event)event andPhase:(Phase)phase andSubPhase:(SubPhase)subPhase;
-(id)initWithEventType:(Event)event andPhase:(Phase)phase andSubPhase:(SubPhase)subPhase andTime:(NSDate*)date;

-(BOOL)writeEventToLog:(NSFileHandle*)fileHandle;

+(NSString*)getHeaderLine;

@end
