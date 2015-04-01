//
//  ttTestEntity.h
//  TypingTester
//
//  Created by Matthew Kerr on 8/14/13.
//

#import <Foundation/Foundation.h>
#import "ttXmlParserDelegate.h"

@interface ttTestEntity : ttXmlParserDelegate

@property (nonatomic, copy) NSString *entityString;
@property (nonatomic, assign) NSUInteger groupId;
@property (nonatomic, assign) NSUInteger itemId;
@property (nonatomic, copy) NSDate *date;
@property (nonatomic, strong) NSMutableArray *filterValues;

-(BOOL)hasFilterValue:(NSString*)value;
-(BOOL)IsFromBefore:(NSDate*)date;

@end
