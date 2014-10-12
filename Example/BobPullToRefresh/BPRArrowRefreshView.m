//
//  BPRArrowRefreshView.m
//  BobPullToRefresh
//
//  Created by Richard Martin on 11/10/2014.
//  Copyright (c) 2014 bob. All rights reserved.
//

#import "BPRArrowRefreshView.h"

@implementation BPRArrowRefreshView

- (id)initWithLocationType:(BPRRefreshViewLocationType)locationType {
    self = [super initWithLocationType:locationType];
    if (self) {
        _stateLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _stateLabel.textAlignment = NSTextAlignmentCenter;
        _stateLabel.textColor = [UIColor darkGrayColor];
        [self addSubview:_stateLabel];
    }
    
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    _stateLabel.frame = CGRectMake(0, 0, CGRectGetWidth(self.frame), CGRectGetHeight(self.frame));
}

- (void)updateForProgress:(CGFloat)progress withState:(BPRPullToRefreshState)state {
    switch (state) {
        case BPRPullToRefreshStateIdle:
            [self setStateLabelText:@"PULL TO REFRESH"];
            break;
        case BPRPullToRefreshStateTriggered:
            [self setStateLabelText:@"RELEASE TO REFRESH"];
            break;
        case BPRPullToRefreshStateLoading:
            [self setStateLabelText:@"LOADING"];
            break;
    }
}

- (void)setStateLabelText:(NSString *)text {
    _stateLabel.text = text;
}

@end
