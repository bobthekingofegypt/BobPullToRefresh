//
//  BPRFakeScrollView.m
//  BobPullToRefresh
//
//  Created by Richard Martin on 04/10/2014.
//  Copyright (c) 2014 bob. All rights reserved.
//

#import "BPRFakeScrollView.h"

@implementation BPRFakeScrollView

- (void)setContentOffset:(CGPoint)contentOffset animated:(BOOL)animated {
    self.contentOffset = contentOffset;
}

- (void)simulateToOffsetDragging:(CGPoint)offset {
    self.isDragging = YES;
    self.contentOffset = offset;
}

- (void)simulateToOffsetNoDragging:(CGPoint)offset {
    self.isDragging = NO;
    self.contentOffset = offset;
}

@end
