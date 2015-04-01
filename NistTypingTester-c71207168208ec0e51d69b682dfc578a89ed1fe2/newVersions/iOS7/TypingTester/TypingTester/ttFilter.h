//
//  ttFilter.h
//  TypingTester
//
//  Created by Matthew Kerr on 8/19/13.
//

#import "ttXmlParserDelegate.h"

@interface ttFilter : ttXmlParserDelegate

@property (nonatomic, copy) NSString *filterId;
@property (nonatomic, assign) BOOL selected;

@end
