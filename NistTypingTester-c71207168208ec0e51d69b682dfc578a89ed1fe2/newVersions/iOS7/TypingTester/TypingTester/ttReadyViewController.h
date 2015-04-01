//
//  ttReadyViewController.h
//  TypingTester
//
//  Created by Matthew Kerr on 8/1/13.
//

#import <UIKit/UIKit.h>

@interface ttReadyViewController : UIViewController

@property (nonatomic, strong) NSString* participantNumber;

@property (nonatomic, strong) IBOutlet UILabel *participantNumberLabel;
@property (nonatomic, strong) IBOutlet UIWebView *readyTextArea;

-(IBAction)cancel:(id)sender;

@end
