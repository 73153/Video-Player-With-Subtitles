//
//  ttInstructionsViewController.h
//  TypingTester
//
//  Created by Matthew Kerr on 8/20/13.
//

#import <UIKit/UIKit.h>
#import "ttSession.h"

@interface ttInstructionsViewController : UIViewController

@property (nonatomic, weak) IBOutlet UIWebView *webView;
@property (nonatomic, weak) ttSession *session;

-(IBAction)nextScreen;


@end
