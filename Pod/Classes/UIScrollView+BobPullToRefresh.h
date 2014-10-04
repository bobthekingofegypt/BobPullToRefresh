//
//  UIScrollView+BobPullToRefresh.h
//  Pods
//
//  Created by Richard Martin on 01/10/2014.
//
//

#import <UIKit/UIKit.h>

@class BPRPullToRefresh;
@class BPRRefreshView;

@interface UIScrollView (BobPullToRefresh)

@property (nonatomic, strong, readonly) BPRPullToRefresh *pullToRefresh;

- (void)addPullToRefreshView:(BPRRefreshView *)customView withActionHandler:(void (^)(void))actionHandler;

@end
