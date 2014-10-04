//
//  BPRRefreshViewTests.m
//  BobPullToRefresh
//
//  Created by Richard Martin on 04/10/2014.
//  Copyright (c) 2014 bob. All rights reserved.
//

#import "BPRRefreshView.h"

SpecBegin(BPRRefreshView)

describe(@"initialisation", ^{
    
    __block BPRRefreshView *sut;
    
    it(@"should set the location type to fixed top", ^{
        sut = [[BPRRefreshView alloc] initWithLocationType:BPRRefreshViewLocationTypeFixedTop];
        expect(sut.locationType).to.equal(BPRRefreshViewLocationTypeFixedTop);
    });
    
    it(@"should set the location type to fixed bottom", ^{
        sut = [[BPRRefreshView alloc] initWithLocationType:BPRRefreshViewLocationTypeFixedBottom];
        expect(sut.locationType).to.equal(BPRRefreshViewLocationTypeFixedBottom);
    });
    
    it(@"should set the location type to scale", ^{
        sut = [[BPRRefreshView alloc] initWithLocationType:BPRRefreshViewLocationTypeScale];
        expect(sut.locationType).to.equal(BPRRefreshViewLocationTypeScale);
    });
    
    it(@"should set the threshold height to default", ^{
        sut = [[BPRRefreshView alloc] initWithLocationType:BPRRefreshViewLocationTypeScale];
        expect(sut.thresholdHeight).to.equal(60);
    });
    
});

SpecEnd