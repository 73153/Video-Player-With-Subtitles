//
//  ttLocalHtmlFile.h
//  TypingTester
//
//  Created by Matthew Kerr on 9/6/13.
//

#import <Foundation/Foundation.h>

@interface ttLocalHtmlFile : NSObject

@property (nonatomic, copy) NSURL *url;
@property (nonatomic, copy) NSData *data;

-(id) initWithFilenameBase:(NSString*)filenameBase;

@end
