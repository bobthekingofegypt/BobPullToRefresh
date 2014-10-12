//
//  GCovTestObserver.mm
//  BobPullToRefresh
//
//  Created by Richard Martin on 12/10/2014.
//  Copyright (c) 2014 bob. All rights reserved.
//

#import <XCTest/XCTestObserver.h>

@interface GcovTestObserver : XCTestObserver
@end

@implementation GcovTestObserver

- (void)stopObserving {
    [super stopObserving];
    UIApplication* application = [UIApplication sharedApplication];
    [application.delegate applicationWillTerminate:application];
}

@end