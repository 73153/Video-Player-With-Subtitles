//
//  AppDelegate.h
//  iDontKnow
//
//  Created by Yuyi Zhang on 5/2/13.
//	$Id$
//  Copyright (c) 2013 Camel. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import "ForgotPasswordViewController.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate, ForgotPasswordViewControllerDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

- (void)saveContext;
@property (NS_NONATOMIC_IOSONLY, readonly, copy) NSURL *applicationDocumentsDirectory;
@property (NS_NONATOMIC_IOSONLY, readonly, strong) Password *retriveRecord;
-(void) dismissLockView;

@end
