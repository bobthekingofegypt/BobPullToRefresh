//
//  BPRDotsLoadingIndicatorView.h
//  BobPullToRefresh
//
//  Created by Richard Martin on 28/10/2014.
//  Copyright (c) 2014 Richard Martin. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 *  A pulsing dots loading indicator view.  Uses its height to set the size
 *  of the dots, centering the three of them inside its width.
 *
 *  Creates a simple pulse effect along the line before repeating
 */
@interface BPRDotsLoadingIndicatorView : UIView

/**
 *  Starts the pulsing animation, this animation will continue until stopAnimating is called
 */
- (void)startAnimating;

/**
 *  Stops the pulsing animation
 */
- (void)stopAnimating;

@end
