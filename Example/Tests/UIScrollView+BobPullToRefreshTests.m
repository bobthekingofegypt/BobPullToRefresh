//
//  UIScrollView+BobPullToRefreshTests.m
//  BobPullToRefresh
//
//  Created by Richard Martin on 04/10/2014.
//  Copyright (c) 2014 bob. All rights reserved.
//

//- (void)addPullToRefreshView:(BPRRefreshView *)view withActionHandler:(void (^)(void))actionHandler

#import "UIScrollView+BobPullToRefresh.h"
#import "BPRRefreshView.h"

SpecBegin(UIScrollViewBPR)

describe(@"scrollview category", ^{
    
    __block UIScrollView *sut;
    
    beforeEach(^{
        sut = [[UIScrollView alloc] init];
    });
    
    it(@"should have nil pull to refresh control by default", ^{
        expect(sut.pullToRefresh).to.beNil;
    });
    
    it(@"should set pull to refresh control on add", ^{
        BPRRefreshView *refreshView = [[BPRRefreshView alloc] initWithLocationType:BPRRefreshViewLocationTypeFixedTop];
        
        [sut addPullToRefreshView:refreshView withActionHandler:^{
            //noop
        }];
        
        expect(sut.pullToRefresh).notTo.beNil;
    });
    
});

SpecEnd