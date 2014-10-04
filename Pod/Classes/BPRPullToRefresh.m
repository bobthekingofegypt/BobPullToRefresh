//
//  BPRPullToRefresh.m
//  Pods
//
//  Created by Richard Martin on 02/10/2014.
//
//

#import "BPRPullToRefresh.h"

#import "BPRRefreshView.h"

@implementation BPRPullToRefresh {
    BPRRefreshView *_refreshView;
    UIScrollView *_scrollView;
    void (^_actionHandler)(void);
    
    UIEdgeInsets _originalContentInsets;
}

- (id) initWithRefreshView:(BPRRefreshView *)refreshView scrollView:(UIScrollView *)scrollView actionHandler:(void (^)(void))actionHandler {
    self = [super init];
    if (self) {
        _refreshView = refreshView;
        _scrollView = scrollView;
        _actionHandler = actionHandler;
        
        UIEdgeInsets originalContentInsets = scrollView.contentInset;
        //make a new copy of the original insets
        _originalContentInsets = UIEdgeInsetsMake(originalContentInsets.top,
                                                  originalContentInsets.left,
                                                  originalContentInsets.bottom,
                                                  originalContentInsets.right);
        
        [scrollView addObserver:self forKeyPath:@"contentOffset" options:NSKeyValueObservingOptionNew context:nil];
        [scrollView addObserver:self forKeyPath:@"contentSize" options:NSKeyValueObservingOptionNew context:nil];
        [scrollView addObserver:self forKeyPath:@"frame" options:NSKeyValueObservingOptionNew context:nil];
    }
    
    return self;
}

- (void)layoutRefreshView {
    if (_scrollView.contentOffset.y > 0) {
        return;
    }
    
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

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    if([keyPath isEqualToString:@"contentOffset"]) {
        CGPoint point = [[change valueForKey:NSKeyValueChangeNewKey] CGPointValue];
        NSLog(@"Content offset changed - %@", NSStringFromCGPoint(point));
        [self adjustForNewPosition:point];
        [self layoutRefreshView];
    } else if([keyPath isEqualToString:@"contentSize"]) {
        NSLog(@"Content size changed");
    } else if([keyPath isEqualToString:@"frame"]) {
        NSLog(@"Content frame changed");
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
