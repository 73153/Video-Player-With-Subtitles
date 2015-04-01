//
//  ttLocalHtmlFile.m
//  TypingTester
//
//  Created by Matthew Kerr on 9/6/13.
//

#import "ttLocalHtmlFile.h"
#import "ttUtilities.h"

@implementation ttLocalHtmlFile

-(id) initWithFilenameBase:(NSString *)filenameBase
{
    self = [super init];
    if (self)
    {
        NSFileManager *fileManager = [NSFileManager defaultManager];
        NSString *iPadFilename = [NSString stringWithFormat:@"%@-iPad.html", filenameBase];
        NSString *htmlFile = [NSString stringWithFormat:@"%@.html",filenameBase];
        NSString *fullPath;
        // if we are on the iPad see if the iPad version exists
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
        {
            fullPath = [[ttUtilities documentsDirectory] stringByAppendingPathComponent:iPadFilename];
            if ([fileManager fileExistsAtPath:fullPath])
            {
                htmlFile = iPadFilename;
            }
        }
        fullPath = [[ttUtilities documentsDirectory] stringByAppendingPathComponent:htmlFile];
        if ([fileManager fileExistsAtPath:fullPath])
        {
            _url = [NSURL fileURLWithPath:fullPath];
            _data = [NSData dataWithContentsOfFile:fullPath];
        }
        else
        {
            // TODO :: add a file not found message
        }
    }
    return self;
}

@end
