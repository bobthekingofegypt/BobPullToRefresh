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

#ifdef COVERAGE
+ (void)initialize {
    //need to flush test observer to get coverage details
    [[NSUserDefaults standardUserDefaults] setValue:@"XCTestLog,GcovTestObserver"
                                             forKey:@"XCTestObserverClass"];
}
#endif

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
#ifdef COVERAGE
    return YES;
    //During coverage we don't want to have to execute the below code as it has side effects
#endif
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    BPRViewController *controller = [[BPRViewController alloc] init];
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:controller];
    navigationController.navigationBar.backgroundColor = [UIColor grayColor];
    
    self.window.rootViewController = navigationController;
    
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)applicationWillTerminate:(UIApplication *)application
{
#ifdef COVERAGE
    extern void __gcov_flush(void);
    __gcov_flush();
#endif
}

@end
