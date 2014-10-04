//
//  BPRPullToRefresh.h
//  Pods
//
//  Created by Richard Martin on 02/10/2014.
//
//

#import <UIKit/UIKit.h>

@class BPRRefreshView;

typedef NS_ENUM(NSUInteger, BPRPullToRefreshState) {
    BPRPullToRefreshStateIdle = 0,
    BPRPullToRefreshStateTriggered,
    BPRPullToRefreshStateLoading
};

@interface BPRPullToRefresh : NSObject

@property (nonatomic, assign) BOOL enabled;
@property (nonatomic, assign, readonly) BPRPullToRefreshState state;

- (id) initWithRefreshView:(BPRRefreshView *)refreshView scrollView:(UIScrollView *)scrollView actionHandler:(void (^)(void))actionHandler;

@end
