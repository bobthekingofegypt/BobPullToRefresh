//
//  BPRDotsLoadingIndicatorView.m
//  BobPullToRefresh
//
//  Created by Richard Martin on 28/10/2014.
//  Copyright (c) 2014 Richard Martin. All rights reserved.
//

#import "BPRDotsLoadingIndicatorView.h"


static const NSInteger kCirclePadding = 13;

@implementation BPRDotsLoadingIndicatorView {
    UIView *dotOne;
    UIView *dotTwo;
    UIView *dotThree;
    
    BOOL _animating;
}

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        dotOne = [[UIView alloc] initWithFrame:CGRectZero];
        dotOne.backgroundColor = [UIColor whiteColor];
        [self addSubview:dotOne];
        dotTwo = [[UIView alloc] initWithFrame:CGRectZero];
        dotTwo.backgroundColor = [UIColor whiteColor];
        [self addSubview:dotTwo];
        dotThree = [[UIView alloc] initWithFrame:CGRectZero];
        dotThree.backgroundColor = [UIColor whiteColor];
        [self addSubview:dotThree];
    }
    
    return self;
}

- (void)setFrame:(CGRect)frame {
    [super setFrame:frame];
    
    CGFloat centerPointX = CGRectGetWidth(self.bounds)/2.0;
    CGFloat height = CGRectGetHeight(self.bounds);
    
    dotOne.frame = CGRectMake(centerPointX - height - kCirclePadding - height/2.0,
                              0, height, height);
    dotTwo.frame = CGRectMake(centerPointX - height/2.0,
                              0, height, height);
    dotThree.frame = CGRectMake(centerPointX + kCirclePadding + height/2.0,
                                0, height, height);
    
    
    dotOne.layer.cornerRadius = height/2.0;
    dotTwo.layer.cornerRadius = height/2.0;
    dotThree.layer.cornerRadius = height/2.0;
}

- (void)layoutSubviews {
    [super layoutSubviews];
}

- (void)startAnimating {
    _animating = YES;
    [self animatePulse];
}

- (void)animatePulse {
    [UIView animateWithDuration:0.2 delay:0 options:UIViewAnimationOptionCurveEaseIn animations:^{
        dotOne.transform = CGAffineTransformMakeScale(1.4, 1.4);
    }
    completion:^(BOOL finished) {
        [UIView animateWithDuration:0.2 delay:0.05 options:UIViewAnimationOptionCurveEaseOut animations:^{
            dotOne.transform = CGAffineTransformMakeScale(1.0, 1.0);
        }
        completion:^(BOOL finished) {
        }];
    }];
    
    [UIView animateWithDuration:0.2 delay:0.18 options:UIViewAnimationOptionCurveEaseIn animations:^{
        dotTwo.transform = CGAffineTransformMakeScale(1.4, 1.4);
    }
    completion:^(BOOL finished) {
        [UIView animateWithDuration:0.2 delay:0.05 options:UIViewAnimationOptionCurveEaseOut animations:^{
            dotTwo.transform = CGAffineTransformMakeScale(1.0, 1.0);
        }
        completion:^(BOOL finished) {
        }];
    }];
    
    [UIView animateWithDuration:0.2 delay:0.36 options:UIViewAnimationOptionCurveEaseIn animations:^{
        dotThree.transform = CGAffineTransformMakeScale(1.4, 1.4);
    }
    completion:^(BOOL finished) {
        [UIView animateWithDuration:0.2 delay:0.05 options:UIViewAnimationOptionCurveEaseOut animations:^{
            dotThree.transform = CGAffineTransformMakeScale(1.0, 1.0);
        }
        completion:^(BOOL finished) {
            if (_animating) {
                [self performSelector:@selector(animatePulse) withObject:nil afterDelay:0.05];
            }
        }];
    }];
}


- (void)stopAnimating {
    _animating = NO;
}


@end
