//
//  ttApplication.h
//  TypingTester
//
//  Created by Matthew Kerr on 8/20/13.
//

#import <UIKit/UIKit.h>

@class ttSession;

@interface ttApplication : UIApplication

@property (atomic, weak) ttSession *session;

@end
