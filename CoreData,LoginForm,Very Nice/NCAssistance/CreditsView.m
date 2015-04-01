//
//  CreditsView.m
//  NCAssistance
//
//  Created by Yuyi Zhang on 9/14/13.
//  Copyright (c) 2013 Camel. All rights reserved.
//

#import "CreditsView.h"

@interface CreditsView ()

@property (assign, nonatomic) bool bScrollingUp;
@property (assign, nonatomic) CGFloat lastScrollingIndex;

@end


@implementation CreditsView

- (instancetype)initWithFrame:(CGRect)frame
{
    self.lastScrollingIndex = 0;
    self.bIsDragging = NO;
    
    self = [super initWithFrame:frame];
    if (self) {
        NSString *htmlFile = [[NSBundle mainBundle] pathForResource:@"Credits" ofType:@"html"];
        NSString* htmlString = [NSString stringWithContentsOfFile:htmlFile encoding:NSUTF8StringEncoding error:nil];
        
        // Dynamically sets place holder heights
        NSString *strHeight = [NSString stringWithFormat: @"%.0f", self.bounds.size.height - 62];
        htmlString = [htmlString stringByReplacingOccurrencesOfString:@"%PLACEHOLDER_HEADER_HEIGHT%" withString:strHeight];
        strHeight = [NSString stringWithFormat: @"%.0f", self.bounds.size.height - 10];
        htmlString = [htmlString stringByReplacingOccurrencesOfString:@"%PLACEHOLDER_FOOTER_HEIGHT%" withString:strHeight];

        [self loadHTMLString:htmlString baseURL:nil];
        
        self.scrollView.bounces = NO;
        self.scrollView.showsVerticalScrollIndicator = NO;
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    NSLog(@"%f, %f, %f, %f", self.scrollView.contentOffset.y, self.lastScrollingIndex, self.scrollView.contentSize.height, self.bounds.size.height);
    
    if (self.bScrollingUp && self.scrollView.contentOffset.y < 1.0) {
        [self.scrollView setContentOffset:CGPointMake(self.scrollView.contentOffset.x, self.scrollView.contentSize.height - self.bounds.size.height) animated:NO];
        return;     // Do not save this scroll for comparison
    }
    if (!self.bScrollingUp && self.scrollView.contentOffset.y >= self.scrollView.contentSize.height - self.bounds.size.height) {
        [self.scrollView setContentOffset:CGPointMake(self.scrollView.contentOffset.x, 1.0) animated:NO];
        return;     // Do not save this scroll for comparison
    }
    
    // Save data to compare with the next scroll
    if (self.scrollView.contentOffset.y < self.lastScrollingIndex) {
        [self setBScrollingUp:YES];
    }
    else {
        [self setBScrollingUp:NO];
    }
    [self setLastScrollingIndex:self.scrollView.contentOffset.y];
    
}

- (void) scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    self.bIsDragging = YES;
}

- (void) scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    self.bIsDragging = NO;
}

@end
