
#import <Foundation/Foundation.h>

typedef enum {
    NISTEventTypeInput = 0,
    NISTEventTypePhaseChange = 1,
    NISTEventTypeTouch = 2,
} NISTEventType;

typedef enum {
    NISTMemorize =0,
    NISTVerify = 1,
    NISTEnter= 2,
    NISTRecall = 3,
} NISTPhase;


@interface NISTUserEvent : NSObject 

- (id)initWithEventype: (NISTEventType) type andPhase: (NISTPhase) phaseVal andSubPhase: (int) subPhaseVal;


// event type text input or touch etc.
@property (nonatomic) NISTEventType eventType;

// time when this event was generated
@property (nonatomic) NSTimeInterval eventTime;

// Phase we are in
@property (nonatomic) NISTPhase phase;

// Refers to entry filed being edited within the phase
// For Memoize and Verify it is attemp number 
@property (nonatomic) int      subPhase;

// last character entered as string
@property (nonatomic, retain) NSString      *chacterCode;

// current text in the fiedl/view being edited
@property (nonatomic, retain) NSString      *soFarTypedText;


@end
