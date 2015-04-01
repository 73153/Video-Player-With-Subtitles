//
//  NISTRolledUpData.h
//  PasswordTest
//
//  Created by Navneet Kumar on 4/18/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface NISTPerStringRolledUpData : NSObject {

@public

    // Memory Phase practice data
    NSMutableArray  *individualMemorizeTime;    // Number of entries in this arrya will correspond to number of time user came back to memorize.
                                                // Values are calculated as - It is elapse time since memeory page was displayed till last character was enteed
                                                // in the MEMEORY page (before user moved to verify page)
    
    NSMutableArray  *individualMemorizeStings;   // contains what use entered for each memorize pahse
    
    NSTimeInterval      totalMemorizeTime;      // This will be some of all entries in array individualMemorizeTime per attempt.

    // Verification data
    NSMutableArray  *individualVerifyTime;      // Number of entries in this arrya will correspond to number of time user 
                                                // came back to memorize and then to verify page   
                                                // From When Verification page was displayed till they clicked PREV button to move to Memorize Page 

    NSMutableArray      *individualVerifyStrings; // This contains all verify strings entered by the user for this string
    
    NSTimeInterval      totalVerifyTime;        // This will be some of all entries in array individualVerifyTime per attempt.
                                                // since user can go backt o memeorize page and come back to verify and back and forth this time will be 
                                                // total of all those "Verifys" including the last one.

    // Entry page data
    NSTimeInterval      entryTime[10];          // Entry time per string for each entry in entry page
                                                // For each entry field it is first chacter on that entry field till last chacter on that entry field 
                                                // till user moves away from this page. So if user comes back to the first entry after going thru alll ten, itmight loo
                                                // like he took really long time to decide.
    NSMutableArray      *individualEntrySrings;
    
    NSTimeInterval      totalEntryTime;         // This will be the some of all entries in last array.

    NSTimeInterval      startMemToEndOfEntryTime;   // #6 This is currently already in rooled-up data file
                                                    // This is calculated as From memeory page is displayed till last chacter entered on entry page before user moved to 
                                                    // next string
    
    NSString        *targetString;              // #9
    
    int             stringNumber;               // 11
    
}


@end
