//
//  BPRFakeScrollView.h
//  BobPullToRefresh
//
//  Created by Richard Martin on 04/10/2014.
//  Copyright (c) 2014 bob. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BPRFakeScrollView : NSObject

@property (nonatomic, assign) BOOL isDragging;
@property (nonatomic, assign) CGPoint contentOffset;
@property (nonatomic, assign) UIEdgeInsets contentInset;
@property (nonatomic, assign) CGRect bounds;
@property (nonatomic, assign) CGRect frame;

- (void)setContentOffset:(CGPoint)contentOffset animated:(BOOL)animated;

- (void)simulateToOffsetDragging:(CGPoint)offset;
- (void)simulateToOffsetNoDragging:(CGPoint)offset;

@end
