//
//  BPRPullToRefresh.h
//  Pods
//
//  Created by Richard Martin on 02/10/2014.
//
//

#import <UIKit/UIKit.h>

@class BPRRefreshView;

/**
 *  Enum to represent the current state of the refresh control
 */
typedef NS_ENUM(NSUInteger, BPRPullToRefreshState) {
    /**
     *  Idle means we are not moving or we have not passed the threshold height
     */
    BPRPullToRefreshStateIdle = 0,
    /**
     *  Triggered means the user has dragged passed the threshold but has not yet released the gesture
     */
    BPRPullToRefreshStateTriggered,
    /**
     *  Loading means the user has passed the threshold and released the gesture
     */
    BPRPullToRefreshStateLoading
};

/**
 *  Returns an printable english string representing the current pull to refresh state value.
 *  Returns empty string on unknown state value
 *
 *  @param state the state enum value
 *
 *  @return english text representation
 */
extern NSString *NSStringFromBPRPullToRefreshState(BPRPullToRefreshState state);

/**
 *  Main controller for pull to refresh control
 */
@interface BPRPullToRefresh : NSObject

/**
 *  Sets whether or not the component is enabled
 */
@property (nonatomic, assign) BOOL enabled;

/**
 *  The current state of the refresh control
 */
@property (nonatomic, assign, readonly) BPRPullToRefreshState state;

/**
 *  @param refreshView   refresh view to be displayed
 *  @param scrollView    scrollview the refreshview is contained within
 *  @param actionHandler block to be executed when loading is triggered
 *
 *  @return pull to refresh instance
 */
- (id) initWithRefreshView:(BPRRefreshView *)refreshView scrollView:(UIScrollView *)scrollView actionHandler:(void (^)(BPRPullToRefresh *pullToRefresh))actionHandler;

/**
 *  Animate away the pull to refresh control.  Call this once your loading is complete
 */
- (void)dismiss;

@end
