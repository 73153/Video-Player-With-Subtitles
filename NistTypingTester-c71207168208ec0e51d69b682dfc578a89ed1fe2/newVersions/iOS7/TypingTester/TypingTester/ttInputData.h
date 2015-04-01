//
//  ttInputData.h
//  TypingTester
//
//  Created by Matthew Kerr on 8/19/13.
//

#import <Foundation/Foundation.h>
#import "ttXmlParserDelegate.h"

@interface ttInputData : ttXmlParserDelegate

@property (atomic, strong) NSArray *filters;
@property (atomic, strong) NSArray *proficiencyItems;
@property (atomic, strong) NSArray *entities;
@property (atomic, assign) BOOL entityNumberError;
@property (atomic, assign) BOOL entityFilterError;


+(ttInputData*) Instance;

-(void) loadDataFile:(NSString*)filepath;
-(void) clearData;

-(NSArray*) getPhrasesForGroupId:(NSUInteger)groupId;
-(NSArray*) getEntities;
@end
