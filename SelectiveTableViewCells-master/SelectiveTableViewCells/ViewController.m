//
//  ViewController.m
//  SelectiveTableViewCells
//
//  Created by Nandeep Mali on 26/09/12.
//  Copyright (c) 2012 Nandeep Mali. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"ZOMG %d", [cell tag]);
    if ([cell tag] == 1) {
        cell.hidden = shouldHideFoo ? YES : NO;
    } else if ([cell tag] == 2) {
        cell.hidden = shouldHideBar ? YES : NO;
    } else if ([cell tag] == 3) {
        cell.hidden = shouldHideBaz ? YES : NO;
    }
}

- (IBAction)toggleFoo:(id)sender
{
    NSLog(@"ZOMGFOO %d", shouldHideFoo);
    shouldHideFoo = !shouldHideFoo;

    [[self tableView] reloadData];
}

- (IBAction)toggleBar:(id)sender
{
    NSLog(@"ZOMGBAR");
    shouldHideBar = !shouldHideBar;
    
    [[self tableView] reloadData];
}

- (IBAction)toggleBaz:(id)sender
{
    NSLog(@"ZOMGBAZ");
    shouldHideBaz = !shouldHideBaz;

    [[self tableView] reloadData];
}
@end
