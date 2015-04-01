//
//  main.m
//  PasswordTest
//
//  Created by Navneet Kumar on 3/30/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "NISTAppDelegate.h"
#import "NISTApplication.h"

int main(int argc, char *argv[])
{
    @autoreleasepool {
        //return UIApplicationMain(argc, argv, nil, NSStringFromClass([NISTAppDelegate class]));
        return UIApplicationMain(argc, argv, NSStringFromClass([NISTApplication class]), NSStringFromClass([NISTAppDelegate class]));
    }
}
