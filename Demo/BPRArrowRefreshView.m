//
//  BPRArrowRefreshView.m
//  BobPullToRefresh
//
//  Created by Richard Martin on 11/10/2014.
//  Copyright (c) 2014 bob. All rights reserved.
//

#import "BPRArrowRefreshView.h"

#import <QuartzCore/QuartzCore.h>

#import "BPRArrowView.h"
#import "BPRDotsLoadingIndicatorView.h"

@implementation BPRArrowRefreshView {
    BPRArrowView *_arrow;
    BPRDotsLoadingIndicatorView *_loadingIndicator;
    BPRPullToRefreshState _currentState;
}

- (id)initWithLocationType:(BPRRefreshViewLocationType)locationType {
    self = [super initWithLocationType:locationType];
    if (self) {
        self.backgroundColor = [UIColor colorWithRed:28/255.0 green:82/255.0 blue:162/255.0 alpha:1.0];
        
        _arrow = [[BPRArrowView alloc] initWithFrame:CGRectZero];
        [self addSubview:_arrow];
        
        _loadingIndicator = [[BPRDotsLoadingIndicatorView alloc] initWithFrame:CGRectZero];
        _loadingIndicator.hidden = YES;
        [self addSubview:_loadingIndicator];
    }
    
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    _arrow.frame = CGRectMake(CGRectGetWidth(self.bounds)/2.0-20, CGRectGetHeight(self.bounds)/2.0-10, 40, 20);
    _loadingIndicator.frame = CGRectMake(0, CGRectGetHeight(self.bounds)/2.0-4, CGRectGetWidth(self.bounds), 8);
}

- (void)updateForProgress:(CGFloat)progress withState:(BPRPullToRefreshState)state {
    if (_currentState == state) {
        return;
    }
    
    if (state == BPRPullToRefreshStateIdle && _currentState == BPRPullToRefreshStateLoading) {
        [UIView animateWithDuration:0.3 animations:^{
            _loadingIndicator.alpha = 0.0f;
        } completion:^(BOOL finished) {
            [_loadingIndicator stopAnimating];
            _loadingIndicator.hidden = YES;
            _loadingIndicator.alpha = 1.0f;
            _arrow.hidden = NO;
        }];
    }
    
    _currentState = state;
    
    switch (state) {
        case BPRPullToRefreshStateIdle:
            [self rotateFrom:M_PI to:0];
            break;
        case BPRPullToRefreshStateTriggered:
            [self rotateFrom:0 to:M_PI];
            break;
        case BPRPullToRefreshStateLoading:
            _loadingIndicator.hidden = NO;
            _arrow.hidden = YES;
            [_loadingIndicator startAnimating];
            
            break;
    }
}

- (void)rotateFrom:(CGFloat)from to:(CGFloat)to {
    CABasicAnimation* rotationAnimation;
    rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    rotationAnimation.fromValue = [NSNumber numberWithFloat:from];
    rotationAnimation.toValue = [NSNumber numberWithFloat:to];
    rotationAnimation.duration = 0.2;
    rotationAnimation.cumulative = YES;
    rotationAnimation.fillMode = kCAFillModeForwards;
    rotationAnimation.removedOnCompletion = NO;
    [_arrow.layer addAnimation:rotationAnimation forKey:@"rotationAnimation"];
}

@end
