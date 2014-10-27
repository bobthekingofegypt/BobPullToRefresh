//
//  BPRAppDelegate.m
//  BobPullToRefresh
//
//  Created by CocoaPods on 10/01/2014.
//  Copyright (c) 2014 bob. All rights reserved.
//

#import "BPRAppDelegate.h"

#import "BPRViewController.h"

@implementation BPRAppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    BPRViewController *controller = [[BPRViewController alloc] init];
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:controller];
    navigationController.navigationBar.backgroundColor = [UIColor grayColor];
    
    self.window.rootViewController = navigationController;
    
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    return YES;
}

@end
