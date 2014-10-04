//
//  BPRPullToRefreshTests.m
//  BobPullToRefresh
//
//  Created by Richard Martin on 04/10/2014.
//  Copyright (c) 2014 bob. All rights reserved.
//

#import "BPRPullToRefresh.h"
#import "BPRRefreshView.h"

SpecBegin(BPRPullToRefresh)

describe(@"bob pull to refresh", ^{
    
    __block BPRPullToRefresh *sut;
    __block UIScrollView *scrollView;
    __block BPRRefreshView *refreshView;
    
    beforeEach(^{
        scrollView = [[UIScrollView alloc] init];
        refreshView = [[BPRRefreshView alloc] initWithLocationType:BPRRefreshViewLocationTypeFixedTop];
        sut = [[BPRPullToRefresh alloc] initWithRefreshView:refreshView scrollView:scrollView actionHandler:nil];
    });
    
    it(@"should be enabled by default", ^{
        expect(sut.enabled).to.beTruthy;
    });
    
    it(@"should be idle on initialisation", ^{
        expect(sut.state).to.equal(BPRPullToRefreshStateIdle);
    });
    
});

SpecEnd