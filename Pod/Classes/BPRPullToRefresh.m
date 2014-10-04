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

@implementation BPRPullToRefresh {
    BPRRefreshView *_refreshView;
    UIScrollView *_scrollView;
    void (^_actionHandler)(void);
    
    UIEdgeInsets _originalContentInsets;
    FBKVOController *_observerController;
}

- (id) initWithRefreshView:(BPRRefreshView *)refreshView scrollView:(UIScrollView *)scrollView actionHandler:(void (^)(void))actionHandler {
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
        
        _observerController = [FBKVOController controllerWithObserver:self];
        [self attachObservers:scrollView];
    }
    
    return self;
}

- (void)attachObservers:(UIScrollView *)scrollView {
    [_observerController observe:scrollView keyPath:@"contentOffset"
                         options:NSKeyValueObservingOptionNew block:^(BPRPullToRefresh *pullToRefresh, UIScrollView *scrollView, NSDictionary *change) {
        CGPoint point = [change[NSKeyValueChangeNewKey] CGPointValue];
        [self adjustForNewPosition:point];
        [self layoutRefreshView];
    }];
}

- (void)layoutRefreshView {
    BPRRefreshViewLocationType locationType = _refreshView.locationType;
    
    switch (locationType) {
        case BPRRefreshViewLocationTypeFixedBottom:
            _refreshView.frame = CGRectMake(0, -_refreshView.thresholdHeight, CGRectGetWidth(_scrollView.bounds), _refreshView.thresholdHeight);
            break;
        case BPRRefreshViewLocationTypeFixedTop:
            _refreshView.frame = CGRectMake(0, _scrollView.contentOffset.y, CGRectGetWidth(_scrollView.bounds), _refreshView.thresholdHeight);
            break;
        case BPRRefreshViewLocationTypeScale:
            _refreshView.frame = CGRectMake(0, _scrollView.contentOffset.y, CGRectGetWidth(_scrollView.bounds), ABS(_scrollView.contentOffset.y));
            break;
        default:
            break;
    }
    
}

- (void)adjustForNewPosition:(CGPoint)position {
    //TODO should probably reset to 0 just to be sure?
    if (position.y > 0) {
        return;
    }
    
    //if position over limit and !dragging then change state to loading
    if (_state != BPRPullToRefreshStateLoading) {
        CGFloat scrollOffsetThreshold = _refreshView.thresholdHeight + _originalContentInsets.top;
        
        //states
        if (!_scrollView.isDragging && _state == BPRPullToRefreshStateTriggered) {
            _state = BPRPullToRefreshStateLoading;
        } else if (position.y < scrollOffsetThreshold && _scrollView.isDragging && _state == BPRPullToRefreshStateIdle) {
            _state = BPRPullToRefreshStateTriggered;
        } else if (position.y >= scrollOffsetThreshold && _state != BPRPullToRefreshStateIdle) {
            _state = BPRPullToRefreshStateIdle;
        }
    } else {
        _scrollView.contentInset = UIEdgeInsetsMake(_refreshView.thresholdHeight,
                                                    _originalContentInsets.left,
                                                    _originalContentInsets.bottom,
                                                    _originalContentInsets.right);
    }
}




@end
