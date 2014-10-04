//
//  BPRRefreshView.h
//  Pods
//
//  Created by Richard Martin on 01/10/2014.
//
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, BPRRefreshViewLocationType) {
    BPRRefreshViewLocationTypeFixedTop = 0,
    BPRRefreshViewLocationTypeFixedBottom,
    BPRRefreshViewLocationTypeScale
};

@interface BPRRefreshView : UIView

@property (nonatomic, readonly, assign) BPRRefreshViewLocationType locationType;
@property (nonatomic, assign) NSInteger thresholdHeight;

- (id)initWithLocationType:(BPRRefreshViewLocationType)locationType;

@end
