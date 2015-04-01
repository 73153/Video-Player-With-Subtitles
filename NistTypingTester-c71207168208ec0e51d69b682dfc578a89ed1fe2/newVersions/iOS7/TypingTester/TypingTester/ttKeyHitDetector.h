//
//  ttKeyHitDetector.h
//  TypingTester
//
//  Created by Matthew Kerr on 12/11/13.
//

#import <Foundation/Foundation.h>
#import "ttConstants.h"

@interface ttKeyHitDetector : NSObject

+(ttKeyHitDetector*)Instance;

-(SpecialKey)GetKeyAtPoint:(CGPoint)point;

@end
