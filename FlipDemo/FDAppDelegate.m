//
//  FDAppDelegate.m
//  FlipDemo
//
//  Created by jorf on 1/11/14.
//  Copyright (c) 2014 Jeff Davis. All rights reserved.
//

#import "FDAppDelegate.h"

#import "FDViewController.h"

@implementation FDAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    [[UIApplication sharedApplication] setStatusBarHidden:YES];

    self.viewController = [[FDViewController alloc] init];
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.rootViewController = self.viewController;
    [self.window makeKeyAndVisible];

    return YES;
}
							
- (void)applicationWillResignActive:(UIApplication *)application
{
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
}

- (void)applicationWillTerminate:(UIApplication *)application
{
}

@end
