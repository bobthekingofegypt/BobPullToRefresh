//
//  BPRArrowView.m
//  BobPullToRefresh
//
//  Created by Richard Martin on 28/10/2014.
//  Copyright (c) 2014 Richard Martin. All rights reserved.
//

#import "BPRArrowView.h"

static const NSInteger kPadding = 5;

@implementation BPRArrowView

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.opaque = NO;
        
        self.arrowColor = [UIColor whiteColor];
    }
    return self;
}

- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [UIColor clearColor].CGColor);
    
    CGContextFillRect(context, rect);
    
    CGContextSetStrokeColorWithColor(context, self.arrowColor.CGColor);
    
    CGContextSetLineWidth(context, 5.0f);
    
    CGContextMoveToPoint(context, kPadding, kPadding);
    
    CGContextAddLineToPoint(context, CGRectGetWidth(rect)/2.0f, CGRectGetHeight(rect) - kPadding);
    CGContextAddLineToPoint(context, CGRectGetWidth(rect) - kPadding, kPadding);
    
    CGContextStrokePath(context);
}

@end
