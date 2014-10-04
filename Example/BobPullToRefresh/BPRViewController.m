//
//  BPRViewController.m
//  BobPullToRefresh
//
//  Created by bob on 10/01/2014.
//  Copyright (c) 2014 bob. All rights reserved.
//

#import "BPRViewController.h"

#import <UIScrollView+BobPullToRefresh.h>
#import <BPRRefreshView.h>

@interface BPRViewController ()

@end

@implementation BPRViewController

- (void)loadView {
    [super loadView];
    
    self.view.autoresizingMask = (UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight);
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:tableView];
    
    BPRRefreshView *refreshView = [[BPRRefreshView alloc] initWithLocationType:BPRRefreshViewLocationTypeScale];
    refreshView.backgroundColor = [UIColor redColor];
    [tableView addPullToRefreshView:refreshView withActionHandler:^{
        //no-op
    }];
    
}


@end
