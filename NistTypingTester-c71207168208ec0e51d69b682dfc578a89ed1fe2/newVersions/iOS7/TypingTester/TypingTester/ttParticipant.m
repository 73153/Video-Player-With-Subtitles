//
//  ttParticipant.m
//  TypingTester
//
//  Created by Matthew Kerr on 7/31/13.
//

#import "ttParticipant.h"

@implementation ttParticipant


-(id)init
{
    self = [super init];
    if(self)
    {
        self.participantNumber = @"";
    }
    return self;
}

-(id)initWithParticipantNumber:(NSString*)participantNumber;
{
    self = [super init];
    if (self)
    {
        self.participantNumber = participantNumber;
    }
    return self;
}



@end
