//
//  ttFilter.m
//  TypingTester
//
//  Created by Matthew Kerr on 8/19/13.
//

#import "ttFilter.h"

@implementation ttFilter

-(id) init
{
    self = [super init];
    if (self)
    {
    
    }
    return self;
}

#pragma -mark ttXmlParserDelegate functions

-(void) finishedChild:(NSString*)s;
{
    self.child = nil;
}
-(void)parseElementAttributes:(NSDictionary *)attributeDictionary
{
    self.filterId = [attributeDictionary objectForKey:@"filterId"];
}


@end
