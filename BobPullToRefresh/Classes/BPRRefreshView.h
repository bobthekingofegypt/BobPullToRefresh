//
//  BPRRefreshView.h
//  Pods
//
//  Created by Richard Martin on 01/10/2014.
//
//

#import <UIKit/UIKit.h>

#import "BPRPullToRefresh.h"

typedef NS_ENUM(NSUInteger, BPRRefreshViewLocationType) {
    BPRRefreshViewLocationTypeFixedTop = 0,
    BPRRefreshViewLocationTypeFixedBottom,
    BPRRefreshViewLocationTypeScale
};

@interface BPRRefreshView : UIView

@property (nonatomic, readonly, assign) BPRRefreshViewLocationType locationType;
@property (nonatomic, assign) NSInteger thresholdHeight;

- (id)initWithLocationType:(BPRRefreshViewLocationType)locationType;

/**
 *  Called by the pull to refresh controller everytime the main owning scrollview position
 *  is updated.  
 *
 *  Progress is unbounded value, 0 means the control is completely hidden, 1.0
 *  means the controls threshold value is completely visible.  The progress value 
 *  will continue to increase the further the user pulls down the control.  If the 
 *  scrollview is over scrolled by twice the height of the threshold value the progress
 *  will be 2.0 for example.
 *
 *  @param progress float value representing the progress of displaying the refresh view
 *  @param state    the current state of the refresh control
 */
- (void)updateForProgress:(CGFloat)progress withState:(BPRPullToRefreshState)state;

@end
