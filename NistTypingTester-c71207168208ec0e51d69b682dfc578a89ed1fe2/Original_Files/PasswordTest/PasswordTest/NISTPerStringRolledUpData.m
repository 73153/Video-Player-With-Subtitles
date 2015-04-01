//
//  NISTRolledUpData.m
//  PasswordTest
//
//  Created by Navneet Kumar on 4/18/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "NISTPerStringRolledUpData.h"

@implementation NISTPerStringRolledUpData {
}

- (id)init
{
    self = [super init];
    if (self) {

        // allocate per string data objects in array.
        NSNumber *num = @1U;
        NSUInteger  count = [num unsignedIntValue];
        individualMemorizeTime = [NSMutableArray arrayWithCapacity:count];
        totalMemorizeTime = 0;
        
        individualMemorizeStings = [NSMutableArray arrayWithCapacity:count];
        individualVerifyStrings = [NSMutableArray arrayWithCapacity:count];
        
        
        // Verification data
        individualVerifyTime = [NSMutableArray arrayWithCapacity:count];
        totalVerifyTime = 0;
        
        // Enter phase data
        for (int i=0; i < 10; i++ )
            entryTime[i] = 0;
        totalEntryTime = 0;
        individualEntrySrings = [NSMutableArray arrayWithCapacity:10];
        
        //Misc
        startMemToEndOfEntryTime = 0;      
        targetString = nil;
        stringNumber = 0;
    }
    
    return self;
}

@end
