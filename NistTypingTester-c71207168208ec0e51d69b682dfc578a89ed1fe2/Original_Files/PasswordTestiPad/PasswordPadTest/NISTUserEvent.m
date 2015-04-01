

#import "NISTUserEvent.h"


@implementation NISTUserEvent
{ 
}

@synthesize chacterCode;
@synthesize soFarTypedText;
@synthesize eventType;
@synthesize eventTime;
@synthesize phase;
@synthesize subPhase;

- (id)init
{
    self = [super init];
    if (self) {
        // any custom initiliazation.
    }
    
    return self;
}

- (id)initWithEventype: (NISTEventType) type andPhase: (NISTPhase) phaseVal andSubPhase: (int) subPhaseVal {
    self = [super init];
    if ( self ) {
        eventTime = [[NSProcessInfo processInfo] systemUptime];
        eventType = type;
        phase = phaseVal;
        subPhase = subPhaseVal;
    }
    
    return self;
}

@end
