//
//  AppDelegate.m
//  TextValidator
//
//  Created by Eddie on 2/16/13.
//  Copyright (c) 2013 eddieios. All rights reserved.
//

#import "AppDelegate.h"
#import "TextValidator.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];

    NSLog(@"ekc25@cornell.edu: isValidEmail: %d", [TextValidator isValidEmail:@"ekc25@cornell.edu"]);
    NSLog(@"ekc25cornell.edu: isValidEmail: %d", [TextValidator isValidEmail:@"ekc25cornell.edu"]);
    NSLog(@"ekc25@cornelledu: isValidEmail: %d", [TextValidator isValidEmail:@"ekc25@cornelledu"]);
    
    NSLog(@"+1(917)222-9999: isValidPhone: %d", [TextValidator isValidPhone:@"+1(917)222-9999"]);
    NSLog(@"9172229999: isValidPhone: %d", [TextValidator isValidPhone:@"9172229999"]);
    NSLog(@"19172229999: isValidPhone: %d", [TextValidator isValidPhone:@"19172229999"]);
    NSLog(@"917-222-9999: isValidPhone: %d", [TextValidator isValidPhone:@"917-222-9999"]);
    NSLog(@"9172229a999: isValidPhone: %d", [TextValidator isValidPhone:@"9172229a999"]);
    
    NSLog(@"NY: isValidTwoLetterStateAbbreviation: %d", [TextValidator isValidTwoLetterStateAbbreviation:@"NY"]);
    NSLog(@"NYC: isValidTwoLetterStateAbbreviation: %d", [TextValidator isValidTwoLetterStateAbbreviation:@"NYC"]);
    
    NSLog(@"New York: isValidStateName: %d", [TextValidator isValidStateName:@"New York"]);
    NSLog(@"New York City: isValidStateName: %d", [TextValidator isValidStateName:@"New York City"]);
    
    NSLog(@"10001: isValidZipcode: %d", [TextValidator isValidZipcode:@"10001"]);
    NSLog(@"apple: isValidZipcode: %d", [TextValidator isValidZipcode:@"apple"]);
    
    NSLog(@"eddieios: isValidName: %d", [TextValidator isValidName:@"eddieios"]);
    NSLog(@"eddie ios: isValidName: %d", [TextValidator isValidName:@"eddie ios"]);
    NSLog(@"2323eddie: isValidName: %d", [TextValidator isValidName:@"2323eddie"]);

    
    NSError *error = nil;
    NSString *formattedNumber = [TextValidator formatPhoneNumber:@"917.222.333" format:@"+1(###)###-####" error:&error];
    NSLog(@"917.222.3333 formatted to %@", formattedNumber);
    
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
