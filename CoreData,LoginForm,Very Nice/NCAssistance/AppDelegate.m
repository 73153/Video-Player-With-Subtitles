//
//  AppDelegate.m
//  iDontKnow
//
//  Created by Yuyi Zhang on 5/2/13.
//  Copyright (c) 2013 Camel. All rights reserved.
//

#import "AppDelegate.h"
#import "MainViewController.h"
#import "LockViewController.h"
#import "LoginViewController.h"
#import "Constants.h"
#import "Password.h"

@interface AppDelegate()

@property (nonatomic, retain) LockViewController *lockViewController;
@property (nonatomic, assign) BOOL bShowLockView;
@property (nonatomic, retain) MainViewController *mainViewControler;

@end

@implementation AppDelegate

@synthesize managedObjectContext = _managedObjectContext;
@synthesize managedObjectModel = _managedObjectModel;
@synthesize persistentStoreCoordinator = _persistentStoreCoordinator;
@synthesize lockViewController;
@synthesize bShowLockView;
@synthesize mainViewControler;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    MainViewController *rootViewController = [[MainViewController alloc] initWithStyle:UITableViewStylePlain];
    NSManagedObjectContext *context = [self managedObjectContext];
    if (!context) {
        // Handle the error.
    }
    // Pass the managed object context to the view controller.
    rootViewController.managedObjectContext = context;
    [self setMainViewControler:rootViewController];
    [self setBShowLockView:YES];
    
    // Create logs for debugging purpose
    UIDevice *device = [UIDevice currentDevice];
    if (![[device model] isEqualToString:@"iPad Simulator"] && ![[device model] isEqualToString:@"iPhone Simulator"]) {
        // 开始保存日志文件
        [self redirectNSlogToDocumentFolder];
    }
    
    return YES;
}
							
- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // save
    [self saveContext];
    [self.lockViewController saveAttempts];
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    [self setBShowLockView:YES];
    
    // In case the app was terminated
    if (!self.mainViewControler) {
        MainViewController *rootViewController = [[MainViewController alloc] initWithStyle:UITableViewStylePlain];
        NSManagedObjectContext *context = [self managedObjectContext];
        if (!context) {
            // Handle the error.
        }
        // Pass the managed object context to the view controller.
        rootViewController.managedObjectContext = context;
        [self setMainViewControler:rootViewController];
    }
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Search to see if login password is set
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Password" inManagedObjectContext:self.managedObjectContext];
    [request setEntity:entity];
    
    //add predicates
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"title = %@ AND username = %@", strAppUnlockTitle, strAppUnlockName];
    [request setPredicate:predicate];
    
    NSError *error = nil;
    NSMutableArray *mutableFetchResults = [[self.managedObjectContext executeFetchRequest:request error:&error] mutableCopy];
    if (mutableFetchResults == nil) {
        // Handle the error.
        UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"Error"
                                                        message:@"Fetching item failed."
                                                       delegate:nil
                                              cancelButtonTitle:@"Sigh..."
                                              otherButtonTitles:nil];
        [alert show];
    }
    
    UIViewController *topController = self.window.rootViewController;
    while (topController.presentedViewController) {
        topController = topController.presentedViewController;
    }
    
    if (mutableFetchResults.count > 0) {
        // Locked
        if (!self.lockViewController) {
            [self setLockViewController:[[LockViewController alloc] initWithNibName:@"LockViewController" bundle:nil]];
            self.lockViewController.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
            self.lockViewController.delegate = self.mainViewControler;
        }
        // reset LockView's texts
        self.lockViewController.hoverLbl.text = @"If you know the code...";
        self.lockViewController.cast.text = @"You can cast your";
        self.lockViewController.now.text = @"now...";
        self.lockViewController.magic.text = @"BLACK MAGIC";
        self.lockViewController.codeIn.text = @"";
        if (topController != self.lockViewController) {
            [topController presentViewController:self.lockViewController animated:NO completion:nil];
        }
    }
    else {      // login password not set, consider as first time login
        LoginViewController *lvc = [[LoginViewController alloc] initWithNibName:@"LoginViewController" bundle:nil];
        lvc.delegate = self.mainViewControler;
        [topController presentViewController:lvc animated:NO completion:nil];
    }
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:
    NSLog(@"APPLICATION WILL TERMINATE!!!!");
    // TODO!!
}

#pragma mark - NSManagedObject methods
- (void)saveContext
{
    NSError *error = nil;
    NSManagedObjectContext *managedObjectContext = self.managedObjectContext;
    if (managedObjectContext != nil) {
        if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error]) {
            // Replace this implementation with code to handle the error appropriately.
            // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        }
    }
}

// Returns the URL to the application's Documents directory.
- (NSURL *)applicationDocumentsDirectory
{
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

#pragma mark - Core Data stack
// Returns the managed object context for the application.
// If the context doesn't already exist, it is created and bound to the persistent store coordinator for the application.
- (NSManagedObjectContext *)managedObjectContext
{
    if (_managedObjectContext != nil) {
        return _managedObjectContext;
    }
    
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (coordinator != nil) {
        _managedObjectContext = [[NSManagedObjectContext alloc] init];
        [_managedObjectContext setPersistentStoreCoordinator:coordinator];
    }
    return _managedObjectContext;
}

// Returns the managed object model for the application.
// If the model doesn't already exist, it is created from the application's model.
- (NSManagedObjectModel *)managedObjectModel
{
    if (_managedObjectModel != nil) {
        return _managedObjectModel;
    }
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"Password" withExtension:@"momd"];
    _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    return _managedObjectModel;
}

// Returns the persistent store coordinator for the application.
// If the coordinator doesn't already exist, it is created and the application's store added to it.
- (NSPersistentStoreCoordinator *)persistentStoreCoordinator
{
    if (_persistentStoreCoordinator != nil) {
        return _persistentStoreCoordinator;
    }
    
    NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"Password.sqlite"];
    
    NSError *error = nil;
    _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    if (![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error]) {
        /*
         Replace this implementation with code to handle the error appropriately.
         
         abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
         
         Typical reasons for an error here include:
         * The persistent store is not accessible;
         * The schema for the persistent store is incompatible with current managed object model.
         Check the error message to determine what the actual problem was.
         
         
         If the persistent store is not accessible, there is typically something wrong with the file path. Often, a file URL is pointing into the application's resources directory instead of a writeable directory.
         
         If you encounter schema incompatibility errors during development, you can reduce their frequency by:
         * Simply deleting the existing store:
         [[NSFileManager defaultManager] removeItemAtURL:storeURL error:nil]
         
         * Performing automatic lightweight migration by passing the following dictionary as the options parameter:
         @{NSMigratePersistentStoresAutomaticallyOption:@YES, NSInferMappingModelAutomaticallyOption:@YES}
         
         Lightweight migration will only work for a limited set of schema changes; consult "Core Data Model Versioning and Data Migration Programming Guide" for details.
         
         */
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
    
    return _persistentStoreCoordinator;
}

// redirect NSLog to Documents/NCA.log
- (void)redirectNSlogToDocumentFolder
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentDirectory = paths[0];
    NSString *fileName = [NSString stringWithFormat:@"NCA.log"];
    NSString *logFilePath = [documentDirectory stringByAppendingPathComponent:fileName];

    freopen([logFilePath cStringUsingEncoding:NSASCIIStringEncoding], "a+", stdout);
    freopen([logFilePath cStringUsingEncoding:NSASCIIStringEncoding], "a+", stderr);
}

#pragma mark - ForgotPasswordViewController delegate
- (Password *) retriveRecord
{
    // Search to see if login password is set
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Password" inManagedObjectContext:self.managedObjectContext];
    [request setEntity:entity];
    
    //add predicates
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"title = %@ AND username = %@", strAppUnlockTitle, strAppUnlockName];
    [request setPredicate:predicate];
    
    NSError *error = nil;
    NSMutableArray *mutableFetchResults = [[self.managedObjectContext executeFetchRequest:request error:&error] mutableCopy];
    if (mutableFetchResults == nil) {
        // Handle the error.
        UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"Error"
                                                        message:@"Fetching item failed."
                                                       delegate:nil
                                              cancelButtonTitle:@"Sigh..."
                                              otherButtonTitles:nil];
        [alert show];
    }

    Password * pswd = (Password *)mutableFetchResults[0];
    return pswd;
}

-(void) dismissLockView
{
    [self.lockViewController dismissViewControllerAnimated:YES completion:nil];
}

@end
