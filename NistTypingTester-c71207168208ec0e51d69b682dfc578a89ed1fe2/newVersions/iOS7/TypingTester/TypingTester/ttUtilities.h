//
//  ttUtilities.h
//  TypingTester
//
//  Created by Matthew Kerr on 8/7/13.
//

#import <Foundation/Foundation.h>

@interface ttUtilities : NSObject

+(NSString*) documentsDirectory;
+(bool) copySourceFile:(NSString*)source toDestination:(NSString*)destination shouldOverwrite:(BOOL)overwrite;
+(NSString*) stringForOrienatation:(UIInterfaceOrientation)orientation;
+(NSString*) getProgramVersion;
+(int) numberOfLogFilesOnDevice;

@end
