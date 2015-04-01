//
//  NISTApplication.m
//  PasswordTest
//
//  Created by Navneet Kumar on 4/14/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "NISTApplication.h"
#import "NISTAppDelegate.h"

@implementation NISTApplication {

}

- (void)sendEvent:(UIEvent *)event {
    NISTAppDelegate *del = (NISTAppDelegate *) self.delegate;
    CGPoint shiftOrg = CGPointMake(2,375);
    CGSize shiftSize = CGSizeMake(49, 49);
    CGRect shiftRect = {shiftOrg, shiftSize};
    
    CGPoint kbSwitchOrg = CGPointMake(2,425);
    CGSize kbSwitchSize = CGSizeMake(79, 49);
    CGRect kbSwitchRect = {kbSwitchOrg, kbSwitchSize};
    
    if ( del.keyBoardVisible == YES ) {       
        UITouch* touch;
        UITouch* lastTouch = nil;
        for ( touch in [event allTouches] )
        {
            lastTouch = touch;
        }
        
        if ( lastTouch != nil ) {            
            CGPoint windowLocation = [lastTouch locationInView:nil];
            del.lastTouchLocation = windowLocation;
            if ( [lastTouch phase] == UITouchPhaseEnded ) {
                NSLog( @"Current Location = %@ KBSwitch = %@", NSStringFromCGPoint( windowLocation ), NSStringFromCGRect(kbSwitchRect) ); 
                if ( CGRectContainsPoint(shiftRect, windowLocation) ) {
                    [del userEnteredSpecialKey:NISTShiftAreaKey atTime:[lastTouch timestamp]];
                    //NSLog(@"SHIFT - It was a shift key\n");
                } else if ( CGRectContainsPoint(kbSwitchRect, windowLocation)) {
                    [del userEnteredSpecialKey:NISTKBSwitchKey atTime: [lastTouch timestamp] ];
                    //NSLog(@"KBSWITCH - It was a KBSWITCH key\n");                    
                }
            }
        }
    }   
    
    [super sendEvent:event];    
}


/*

#define GSEVENT_TYPE 2
#define GSEVENT_SUBTYPE 3
#define GSEVENT_FLAGS 12
#define GSEVENTKEY_KEYCODE 15
#define GSEVENT_TYPE_KEYUP 11

NSString *const GSEventKeyUpNotification = @"GSEventKeyUpHackNotification";

- (void)sendEvent:(UIEvent *)event
{
    [super sendEvent:event];
    
    if ([event respondsToSelector:@selector(_gsEvent)]) {
        
        // Key events come in form of UIInternalEvents.
        // They contain a GSEvent object which contains 
        // a GSEventRecord among other things
        
        int *eventMem;
        id id1;
        id1 = [event performSelector:@selector(_gsEvent)];
        eventMem = (int *)id1;
        if (eventMem) {
            
            // So far we got a GSEvent :)
            
            int eventType = eventMem[GSEVENT_TYPE];
            int eventSubType = eventMem[GSEVENT_SUBTYPE];
            
            if (eventType == GSEVENT_TYPE_KEYUP) {
                
                // Now we got a GSEventKey!
                
                // Read flags from GSEvent
                int eventFlags = eventMem[GSEVENT_FLAGS];
                if (eventFlags) { 
                    
                    // This example post notifications only when 
                    // pressed key has Shift, Ctrl, Cmd or Alt flags
                    
                    // Read keycode from GSEventKey
                    int tmp = eventMem[GSEVENTKEY_KEYCODE];
                    UniChar *keycode = (UniChar *)&tmp;                    
                }
            }
        }
    }
}
*/


@end
