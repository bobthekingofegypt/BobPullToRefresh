//
//  BPRPullToRefresh.m
//  Pods
//
//  Created by Richard Martin on 02/10/2014.
//
//

#import "BPRPullToRefresh.h"

#import <KVOController/FBKVOController.h>
#import "BPRRefreshView.h"

/**
 *  Returns an printable english string representing the current pull to refresh state value.
 *  Returns empty string on unknown state value
 *
 *  @param state the state enum value
 *
 *  @return english text representation
 */
NSString *NSStringFromBPRPullToRefreshState(BPRPullToRefreshState state) {
    switch (state) {
        case BPRPullToRefreshStateIdle:
            return @"Idle";
            break;
        case BPRPullToRefreshStateLoading:
            return @"Loading";
            break;
        case BPRPullToRefreshStateTriggered:
            return @"Triggered";
            break;
            
        default:
            return @"";
            break;
    }
}

@implementation BPRPullToRefresh {
    BPRRefreshView *_refreshView;
    UIScrollView *_scrollView;
    void (^_actionHandler)(BPRPullToRefresh *pullToRefresh);
    
    UIEdgeInsets _originalContentInsets;
    FBKVOController *_observerController;
    
    BOOL triggeredActionHandler;
}

- (id) initWithRefreshView:(BPRRefreshView *)refreshView scrollView:(UIScrollView *)scrollView actionHandler:(void (^)(BPRPullToRefresh *))actionHandler {
    self = [super init];
    if (self) {
        _refreshView = refreshView;
        _scrollView = scrollView;
        _actionHandler = actionHandler;
        
        UIEdgeInsets originalContentInsets = scrollView.contentInset;
        //make a new copy of the original insets don't reference the original struct
        _originalContentInsets = UIEdgeInsetsMake(originalContentInsets.top,
                                                  originalContentInsets.left,
                                                  originalContentInsets.bottom,
                                                  originalContentInsets.right);
        
        //Using facebook's KVO controller to simplify observing and cleaning up observers
        _observerController = [FBKVOController controllerWithObserver:self];
        [self attachObservers:scrollView];
    }
    
    return self;
}

- (void)attachObservers:(UIScrollView *)scrollView {
    [_observerController observe:scrollView keyPath:@"contentOffset"
                         options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionInitial block:^(BPRPullToRefresh *pullToRefresh, UIScrollView *scrollView, NSDictionary *change) {
        CGPoint point = [change[NSKeyValueChangeNewKey] CGPointValue];
        [self adjustForNewPosition:point];
        [self layoutRefreshView];
    }];
}

/*
 *  Lays out refresh view in the correct position based on the mode passed.  This keeps the view fixed at the top so it can appear
 *  from underneath or following the top of the tableview for example if fixed at bottom
 */
- (void)layoutRefreshView {
    BPRRefreshViewLocationType locationType = _refreshView.locationType;
    
    switch (locationType) {
        case BPRRefreshViewLocationTypeFixedBottom:
            //bottom edge is fixed to top edge of table
            _refreshView.frame = CGRectMake(0, -_refreshView.thresholdHeight, CGRectGetWidth(_scrollView.bounds), _refreshView.thresholdHeight);
            break;
        case BPRRefreshViewLocationTypeFixedTop:
            //top edge is fixed to orignal top line of scrollview, appears from underneath
            _refreshView.frame = CGRectMake(0, _scrollView.contentOffset.y, CGRectGetWidth(_scrollView.bounds), _refreshView.thresholdHeight);
            break;
        case BPRRefreshViewLocationTypeScale:
            //refresh view is always the size of the space between scrollview and it's offset
            _refreshView.frame = CGRectMake(0, _scrollView.contentOffset.y, CGRectGetWidth(_scrollView.bounds), ABS(_scrollView.contentOffset.y));
            break;
        default:
            break;
    }
}

- (void)adjustForNewPosition:(CGPoint)position {
    if (position.y > 0) {
        return;
    }
    
    if (_state != BPRPullToRefreshStateLoading) {
        CGFloat scrollOffsetThreshold = _refreshView.thresholdHeight + _originalContentInsets.top;
        
        if (!_scrollView.isDragging && _state == BPRPullToRefreshStateTriggered) {
            //released after having dragged beyond the threshold so loading begins.
            _state = BPRPullToRefreshStateLoading;
            
            [self animateScrollViewContentInsets:UIEdgeInsetsMake(_refreshView.thresholdHeight,
                                                                  _originalContentInsets.left,
                                                                  _originalContentInsets.bottom,
                                                                  _originalContentInsets.right)];
            [_scrollView setContentOffset:CGPointMake(0, -_refreshView.thresholdHeight) animated:YES];
        } else if (ABS(position.y) >= scrollOffsetThreshold && _scrollView.isDragging && _state == BPRPullToRefreshStateIdle) {
            //passed the threshold well still dragging and haven't yet set triggered
            _state = BPRPullToRefreshStateTriggered;
        } else if (ABS(position.y) < scrollOffsetThreshold && _state != BPRPullToRefreshStateIdle) {
            //passed back below the threshold, set the idle state to allow user to cancel by releasing below the threshold
            _state = BPRPullToRefreshStateIdle;
        }
    } else {
        //if we are already loading and the scrollview is resetting itself back to a static position
        if (ABS(position.y) == _refreshView.thresholdHeight && !triggeredActionHandler) {
            if (_actionHandler) {
                _actionHandler(self);
            }
            triggeredActionHandler = YES;
        }
    }
    
    CGFloat progress = ABS(position.y)/_refreshView.thresholdHeight;
    [_refreshView updateForProgress:progress withState:_state];
}

- (void)dismiss {
    _state = BPRPullToRefreshStateIdle;
    triggeredActionHandler = NO;
    
    [self animateScrollViewContentInsets:UIEdgeInsetsMake(_originalContentInsets.top,
                                                          _originalContentInsets.left,
                                                          _originalContentInsets.bottom,
                                                          _originalContentInsets.right)];
    
    [_scrollView setContentOffset:CGPointMake(0, _originalContentInsets.top) animated:YES];
}

- (void)animateScrollViewContentInsets:(UIEdgeInsets)edgeInsets {
    [UIView animateWithDuration:0.3
                          delay:0
                        options:UIViewAnimationOptionAllowUserInteraction|UIViewAnimationOptionBeginFromCurrentState
                     animations:^{
                         _scrollView.contentInset = edgeInsets;
                     }
                     completion:NULL];
}



@end
