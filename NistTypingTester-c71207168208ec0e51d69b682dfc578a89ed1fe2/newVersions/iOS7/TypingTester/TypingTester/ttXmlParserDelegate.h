//
//  ttXmlParserDelegate.h
//  TypingTester
//
//  Created by Matthew Kerr on 8/19/13.
//

#import "ttEvent.h"

@interface ttXmlParserDelegate : NSObject <NSXMLParserDelegate>

@property (nonatomic, copy) NSString *name;
@property (nonatomic, strong) NSMutableString *text;
@property (nonatomic, weak) ttXmlParserDelegate *parent;
@property (nonatomic, strong) ttXmlParserDelegate *child;

-(void) startElementNamed:(NSString*)name withParentParser:(ttXmlParserDelegate*)parent;
-(void) makeChild:(Class)class elementName:(NSString*)elementName parser:(NSXMLParser*)parser;
-(void) finishedChild:(NSString*)s;
-(void) parseElementAttributes:(NSDictionary*)attributeDictionary;



@end
