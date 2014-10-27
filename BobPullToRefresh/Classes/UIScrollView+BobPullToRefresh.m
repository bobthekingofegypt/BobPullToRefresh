//
//  UIScrollView+BobPullToRefresh.m
//  Pods
//
//  Created by Richard Martin on 01/10/2014.
//
//

#import "UIScrollView+BobPullToRefresh.h"

#import <objc/runtime.h>
#import "BPRRefreshView.h"
#import "BPRPullToRefresh.h"

@implementation UIScrollView (BobPullToRefresh)

static char UIScrollViewPullToRefresh;
    
@dynamic pullToRefresh;

- (void)addPullToRefreshView:(BPRRefreshView *)view withActionHandler:(void (^)(BPRPullToRefresh *pullToRefresh))actionHandler {
    
    BPRPullToRefresh *pullToRefresh = [[BPRPullToRefresh alloc] initWithRefreshView:view scrollView:self actionHandler:actionHandler];
    [self insertSubview:view atIndex:0];
    
    self.pullToRefresh = pullToRefresh;
    
}

- (void)setPullToRefresh:(BPRPullToRefresh *)pullToRefresh {
    [self willChangeValueForKey:@"BobPullToRefresh"];
    objc_setAssociatedObject(self, &UIScrollViewPullToRefresh,
                             pullToRefresh,
                             OBJC_ASSOCIATION_RETAIN);
    [self didChangeValueForKey:@"BobPullToRefresh"];
}

- (BPRPullToRefresh *)pullToRefresh {
    return objc_getAssociatedObject(self, &UIScrollViewPullToRefresh);
}

@end
