//
//  BPRPullToRefreshTests.m
//  BobPullToRefresh
//
//  Created by Richard Martin on 04/10/2014.
//  Copyright (c) 2014 bob. All rights reserved.
//

#import "BPRPullToRefresh.h"
#import "BPRRefreshView.h"
#import "BPRFakeScrollView.h"

#import <OCMock/OCMock.h>

SpecBegin(BPRPullToRefresh)

describe(@"bob pull to refresh progress", ^{
    
    __block BPRPullToRefresh *sut;
    __block BPRFakeScrollView *scrollView;
    __block BPRRefreshView *refreshView;
    __block id refreshViewMock;
    
    beforeEach(^{
        scrollView = [[BPRFakeScrollView alloc] init];
        refreshView = [[BPRRefreshView alloc] initWithLocationType:BPRRefreshViewLocationTypeFixedTop];
        refreshViewMock = OCMPartialMock(refreshView);
        sut = [[BPRPullToRefresh alloc] initWithRefreshView:refreshViewMock scrollView:(id)scrollView actionHandler:nil];
    });
    
    it(@"should set the progress to match the offset and height settings", ^{
        [scrollView simulateToOffsetDragging:CGPointMake(0, -refreshView.thresholdHeight)];
        OCMVerify([refreshViewMock updateForProgress:1.0 withState:BPRPullToRefreshStateTriggered]);
    });
    
    it(@"should set the progress to match the offset and height settings and change to loading on trigger", ^{
        [scrollView simulateToOffsetDragging:CGPointMake(0, -refreshView.thresholdHeight)];
        [scrollView simulateToOffsetNoDragging:CGPointMake(0, -refreshView.thresholdHeight)];
        OCMVerify([refreshViewMock updateForProgress:1.0 withState:BPRPullToRefreshStateTriggered]);
        OCMVerify([refreshViewMock updateForProgress:1.0 withState:BPRPullToRefreshStateLoading]);
    });
    
    it(@"should set the progress to match the offset and height 50%", ^{
        [scrollView simulateToOffsetDragging:CGPointMake(0, -refreshView.thresholdHeight/2.0)];
        OCMVerify([refreshViewMock updateForProgress:30/60.0 withState:BPRPullToRefreshStateIdle]);
    });
    
    it(@"should set the progress to match the offset and height above 100%", ^{
        [scrollView simulateToOffsetDragging:CGPointMake(0, -refreshView.thresholdHeight*2.0)];
        OCMVerify([refreshViewMock updateForProgress:2.0 withState:BPRPullToRefreshStateTriggered]);
    });
});

describe(@"bob pull to refresh initialisation", ^{
    
    __block BPRPullToRefresh *sut;
    __block BPRFakeScrollView *scrollView;
    __block BPRRefreshView *refreshView;
    
    beforeEach(^{
        scrollView = [[BPRFakeScrollView alloc] init];
        refreshView = [[BPRRefreshView alloc] initWithLocationType:BPRRefreshViewLocationTypeFixedTop];
        sut = [[BPRPullToRefresh alloc] initWithRefreshView:refreshView scrollView:(id)scrollView actionHandler:nil];
    });
    
    it(@"should be enabled by default", ^{
        expect(sut.enabled).to.beTruthy;
    });
    
    it(@"should be idle on initialisation", ^{
        expect(sut.state).to.equal(BPRPullToRefreshStateIdle);
    });
    
});

describe(@"bob pull to refresh basic transitions", ^{
    
    __block BPRPullToRefresh *sut;
    __block BPRFakeScrollView *scrollView;
    __block BPRRefreshView *refreshView;
    
    beforeEach(^{
        scrollView = [[BPRFakeScrollView alloc] init];
        refreshView = [[BPRRefreshView alloc] initWithLocationType:BPRRefreshViewLocationTypeFixedTop];
        sut = [[BPRPullToRefresh alloc] initWithRefreshView:refreshView scrollView:(id)scrollView actionHandler:nil];
    });
    
    it(@"should transition to loading after crossing threshold", ^{
        [scrollView simulateToOffsetDragging:CGPointMake(0, -refreshView.thresholdHeight)];
        [scrollView simulateToOffsetNoDragging:CGPointMake(0, -refreshView.thresholdHeight)];
        
        expect(sut.state).to.equal(BPRPullToRefreshStateLoading);
    });
    
    it(@"should transition to tiggered when crossing threshold", ^{
        [scrollView simulateToOffsetDragging:CGPointMake(0, -refreshView.thresholdHeight)];
        
        expect(sut.state).to.equal(BPRPullToRefreshStateTriggered);
    });
    
    it(@"should not transition to tiggered when not crossing threshold", ^{
        [scrollView simulateToOffsetDragging:CGPointMake(0, -refreshView.thresholdHeight + 1)];
        
        expect(sut.state).to.equal(BPRPullToRefreshStateIdle);
    });

});

describe(@"bob pull to refresh state string returns", ^{
    
    it(@"should return loading for loading state", ^{
        NSString *text = NSStringFromBPRPullToRefreshState(BPRPullToRefreshStateLoading);
        expect(text).to.equal(@"Loading");
    });
    it(@"should return ide for idle state", ^{
        NSString *text = NSStringFromBPRPullToRefreshState(BPRPullToRefreshStateIdle);
        expect(text).to.equal(@"Idle");
    });
    it(@"should return triggered for triggered state", ^{
        NSString *text = NSStringFromBPRPullToRefreshState(BPRPullToRefreshStateTriggered);
        expect(text).to.equal(@"Triggered");
    });
    
});
    

describe(@"bob pull to refresh view frames", ^{
    
    __block BPRPullToRefresh *sut;
    __block BPRFakeScrollView *scrollView;
    __block BPRRefreshView *refreshView;
    
    beforeEach(^{
        scrollView = [[BPRFakeScrollView alloc] init];
        scrollView.frame = CGRectMake(0, 0, 280, 100);
        scrollView.bounds = CGRectMake(0, 0, 280, 100);
    });
   
    it(@"should set the starting frame for fixed top to 0 y and threshold height", ^{
        refreshView = [[BPRRefreshView alloc] initWithLocationType:BPRRefreshViewLocationTypeFixedTop];
        sut = [[BPRPullToRefresh alloc] initWithRefreshView:refreshView scrollView:(id)scrollView actionHandler:nil];
        
        expect(refreshView.frame).to.equal(CGRectMake(0, 0, 280, refreshView.thresholdHeight));
    });
    
    it(@"should set the starting frame for fixed bottom to -height y and threshold height", ^{
        refreshView = [[BPRRefreshView alloc] initWithLocationType:BPRRefreshViewLocationTypeFixedBottom];
        sut = [[BPRPullToRefresh alloc] initWithRefreshView:refreshView scrollView:(id)scrollView actionHandler:nil];
        
        expect(refreshView.frame).to.equal(CGRectMake(0, -refreshView.thresholdHeight, 280, refreshView.thresholdHeight));
    });
    
    it(@"should set the starting frame for fixed bottom to -height y and threshold height even with custom height", ^{
        refreshView = [[BPRRefreshView alloc] initWithLocationType:BPRRefreshViewLocationTypeFixedBottom];
        refreshView.thresholdHeight = 34;
        sut = [[BPRPullToRefresh alloc] initWithRefreshView:refreshView scrollView:(id)scrollView actionHandler:nil];
        
        expect(refreshView.frame).to.equal(CGRectMake(0, -34, 280, 34));
    });
    
    it(@"should set the starting frame for scale to 0", ^{
        refreshView = [[BPRRefreshView alloc] initWithLocationType:BPRRefreshViewLocationTypeScale];
        sut = [[BPRPullToRefresh alloc] initWithRefreshView:refreshView scrollView:(id)scrollView actionHandler:nil];
        
        expect(refreshView.frame).to.equal(CGRectMake(0, 0, 280, 0));
    });
    
    it(@"should set the frame for scale to match offset when dragging", ^{
        refreshView = [[BPRRefreshView alloc] initWithLocationType:BPRRefreshViewLocationTypeScale];
        sut = [[BPRPullToRefresh alloc] initWithRefreshView:refreshView scrollView:(id)scrollView actionHandler:nil];
        
        [scrollView simulateToOffsetDragging:CGPointMake(0, -90)];
        
        expect(refreshView.frame).to.equal(CGRectMake(0, -90, 280, 90));
    });
    
    it(@"should set the frame for fixed top to match offset when dragging", ^{
        refreshView = [[BPRRefreshView alloc] initWithLocationType:BPRRefreshViewLocationTypeFixedTop];
        sut = [[BPRPullToRefresh alloc] initWithRefreshView:refreshView scrollView:(id)scrollView actionHandler:nil];
        
        [scrollView simulateToOffsetDragging:CGPointMake(0, -90)];
        
        expect(refreshView.frame).to.equal(CGRectMake(0, -90, 280, refreshView.thresholdHeight));
    });

    it(@"should set the frame for fixed top to match offset when dragging", ^{
        [scrollView simulateToOffsetDragging:CGPointMake(0, -90)];
        
        refreshView = [[BPRRefreshView alloc] initWithLocationType:BPRRefreshViewLocationTypeFixedBottom];
        sut = [[BPRPullToRefresh alloc] initWithRefreshView:refreshView scrollView:(id)scrollView actionHandler:nil];
        
        expect(refreshView.frame).to.equal(CGRectMake(0, -refreshView.thresholdHeight, 280, refreshView.thresholdHeight));
    });
    
    it(@"should set the content insets after triggering load", ^{
        refreshView = [[BPRRefreshView alloc] initWithLocationType:BPRRefreshViewLocationTypeFixedBottom];
        sut = [[BPRPullToRefresh alloc] initWithRefreshView:refreshView scrollView:(id)scrollView actionHandler:nil];
        
        [scrollView simulateToOffsetDragging:CGPointMake(0, -90)];
        [scrollView simulateToOffsetNoDragging:CGPointMake(0, -90)];
        
        expect(scrollView.contentInset).to.equal(UIEdgeInsetsMake(refreshView.thresholdHeight, 0, 0, 0));
    });
    
    it(@"should set the content offsets after triggering load", ^{
        refreshView = [[BPRRefreshView alloc] initWithLocationType:BPRRefreshViewLocationTypeFixedBottom];
        sut = [[BPRPullToRefresh alloc] initWithRefreshView:refreshView scrollView:(id)scrollView actionHandler:nil];
        
        [scrollView simulateToOffsetDragging:CGPointMake(0, -90)];
        [scrollView simulateToOffsetNoDragging:CGPointMake(0, -90)];
        
        expect(scrollView.contentOffset).to.equal(CGPointMake(0, -refreshView.thresholdHeight));
    });
    
    it(@"should reset the content offsets after triggering action dismiss", ^{
        refreshView = [[BPRRefreshView alloc] initWithLocationType:BPRRefreshViewLocationTypeFixedBottom];
        sut = [[BPRPullToRefresh alloc] initWithRefreshView:refreshView scrollView:(id)scrollView actionHandler:nil];
        
        [scrollView simulateToOffsetDragging:CGPointMake(0, -90)];
        [scrollView simulateToOffsetNoDragging:CGPointMake(0, -90)];
        
        [sut dismiss];
        
        expect(scrollView.contentOffset).to.equal(CGPointMake(0, 0));
    });
    
    it(@"should reset the content insets after triggering action dismiss", ^{
        refreshView = [[BPRRefreshView alloc] initWithLocationType:BPRRefreshViewLocationTypeFixedBottom];
        sut = [[BPRPullToRefresh alloc] initWithRefreshView:refreshView scrollView:(id)scrollView actionHandler:nil];
        
        [scrollView simulateToOffsetDragging:CGPointMake(0, -90)];
        [scrollView simulateToOffsetNoDragging:CGPointMake(0, -90)];
        
        [sut dismiss];
        
        expect(scrollView.contentInset).to.equal(UIEdgeInsetsMake(0, 0, 0, 0));
    });
    
    it(@"should reset the original content insets after triggering action dismiss", ^{
        refreshView = [[BPRRefreshView alloc] initWithLocationType:BPRRefreshViewLocationTypeFixedBottom];
        
        scrollView.contentInset = UIEdgeInsetsMake(1, 2, 3, 4);
        
        sut = [[BPRPullToRefresh alloc] initWithRefreshView:refreshView scrollView:(id)scrollView actionHandler:nil];
        
        
        [scrollView simulateToOffsetDragging:CGPointMake(0, -90)];
        [scrollView simulateToOffsetNoDragging:CGPointMake(0, -90)];
        
        [sut dismiss];
        
        expect(scrollView.contentInset).to.equal(UIEdgeInsetsMake(1, 2, 3, 4));
    });
});


    
SpecEnd
