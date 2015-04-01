//
//  ViewController.h
//  SelectiveTableViewCells
//
//  Created by Nandeep Mali on 26/09/12.
//  Copyright (c) 2012 Nandeep Mali. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UITableViewController
{
    BOOL shouldHideFoo;
    BOOL shouldHideBar;
    BOOL shouldHideBaz;
}

- (IBAction)toggleFoo:(id)sender;
- (IBAction)toggleBar:(id)sender;
- (IBAction)toggleBaz:(id)sender;
@end
