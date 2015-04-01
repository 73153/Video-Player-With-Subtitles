//
//  MainViewController.h
//  iDontKnow
//
//  Created by Yuyi Zhang on 5/2/13.
//  Copyright (c) 2013 Camel. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import "LoginViewController.h"
#import "LockViewController.h"
#import "DetailViewController.h"
#import "EditViewController.h"

@class MainViewController;

@interface MainViewController : UITableViewController <NSFetchedResultsControllerDelegate, LoginViewControllerDelegate, LockViewControllerDelegate, DetailViewControllerDelegate, EditViewControllerDelegate> {
    NSMutableArray *aPasswords;
    NSManagedObjectContext *managedObjectContext;
}

@property (nonatomic, retain) NSMutableArray *aPasswords;
@property (nonatomic, retain) NSManagedObjectContext *managedObjectContext;

- (IBAction)done:(UIStoryboardSegue *)segue;
- (IBAction)cancel:(UIStoryboardSegue *)segue;

@end
