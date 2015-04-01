//
//  CreditsViewController.m
//  NCAssistance
//
//  Created by Yuyi Zhang on 5/30/13.
//  Copyright (c) 2013 Camel. All rights reserved.
//

#import "CreditsViewController.h"
#import "CreditsView.h"

@interface CreditsViewController ()

@end

@implementation CreditsViewController

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    self.webView = [[CreditsView alloc] initWithFrame:CGRectMake(0,0, self.view.bounds.size.width, self.view.bounds.size.height)];
    if (self.webView) {
        [self.view addSubview:self.webView];
    }
    [super viewDidLoad];
    
    if (!self.scrollTimer)
    {
        [self setScrollTimer: [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(performAnimation) userInfo:nil repeats:YES]];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)performAnimation
{
    if (!self.webView.bIsDragging)
    {
        [self.webView.scrollView setContentOffset:CGPointMake(self.webView.scrollView.contentOffset.x, self.webView.scrollView.contentOffset.y + 10) animated:YES];
    }
}

- (void) viewDidDisappear:(BOOL)animated
{
    if (self.scrollTimer) {
        self.scrollTimer = nil;
    }
    
    if (self.webView) {
        self.webView = nil;
    }
}

@end
