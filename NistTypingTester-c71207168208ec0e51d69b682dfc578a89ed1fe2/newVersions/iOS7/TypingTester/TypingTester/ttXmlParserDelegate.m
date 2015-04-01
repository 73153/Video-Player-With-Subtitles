//
//  ttXmlParserDelegate.m
//  TypingTester
//
//  Created by Matthew Kerr on 8/19/13.
//

#import "ttXmlParserDelegate.h"

@implementation ttXmlParserDelegate

-(void) startElementNamed:(NSString*)name withParentParser:(ttXmlParserDelegate*)parent
{
    self.name = name;
    self.parent = parent;
    self.text = [NSMutableString string];
}

-(void) makeChild:(Class)class elementName:(NSString*)elementName parser:(NSXMLParser*)parser
{
    ttXmlParserDelegate *del = [[class alloc]init];
    self.child = del;
    parser.delegate = del;
    [del startElementNamed:elementName withParentParser:self];
}

-(void) finishedChild:(NSString*)s
{
    
}

-(void) parseElementAttributes:(NSDictionary *)attributeDictionary
{
    // OVERRIDE Point to handle attributes
}

#pragma -mark NSXmlDelegate methods

-(void) parser:(NSXMLParser *)parser foundCharacters:(NSString *)string
{
    [self.text appendString:string];
}

-(void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName
{
    if (self.parent)
    {
        [self.parent finishedChild:[self.text copy]];
        parser.delegate = self.parent;
    }
    
}



@end
