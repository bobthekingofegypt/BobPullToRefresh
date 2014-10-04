//
//  BPRRefreshView.m
//  Pods
//
//  Created by Richard Martin on 01/10/2014.
//
//

#import "BPRRefreshView.h"

@implementation BPRRefreshView

- (id)initWithLocationType:(BPRRefreshViewLocationType)locationType {
    self = [super init];
    if (self) {
        _locationType = locationType;
        _thresholdHeight = 60;
    }
    
    return self;
}

@end
