//
//  NISTApplication.h
//  PasswordTest
//
//  Created by Navneet Kumar on 4/14/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NISTApplication : UIApplication {

@public
    NSTimeInterval lastEventStamp;
    
}

- (void)sendEvent:(UIEvent *)event;


@end
