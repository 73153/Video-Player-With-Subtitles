//
//  CreditsViewController.h
//  NCAssistance
//
//  Created by Yuyi Zhang on 5/30/13.
//  Copyright (c) 2013 Camel. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CreditsView;

@interface CreditsViewController : UIViewController

@property (strong, nonatomic) IBOutlet CreditsView *webView;
@property (retain, nonatomic) NSTimer *scrollTimer;

@end
