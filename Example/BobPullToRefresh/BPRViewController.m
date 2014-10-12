//
//  BPRViewController.m
//  BobPullToRefresh
//
//  Created by bob on 10/01/2014.
//  Copyright (c) 2014 bob. All rights reserved.
//

#import "BPRViewController.h"

#import <UIScrollView+BobPullToRefresh.h>
#import <BPRPullToRefresh.h>
#import "BPRArrowRefreshView.h"

@interface BPRViewController ()

@end

@implementation BPRViewController

- (void)loadView {
    [super loadView];
    
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    self.view.autoresizingMask = (UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight);
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:self.view.bounds];
    tableView.autoresizingMask = (UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight);
    [self.view addSubview:tableView];
    
    BPRRefreshView *refreshView = [[BPRArrowRefreshView alloc] initWithLocationType:BPRRefreshViewLocationTypeFixedBottom];
    [tableView addPullToRefreshView:refreshView withActionHandler:^(BPRPullToRefresh *pullToRefresh){
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [pullToRefresh dismiss];
        });
    }];
    
}


@end
