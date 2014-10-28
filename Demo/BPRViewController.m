//
//  BPRViewController.m
//  BobPullToRefresh
//
//  Created by bob on 10/01/2014.
//  Copyright (c) 2014 bob. All rights reserved.
//

#import "BPRViewController.h"

#import "UIScrollView+BobPullToRefresh.h"
#import "BPRPullToRefresh.h"
#import "BPRArrowRefreshView.h"
#import "BPRTopTableViewCell.h"
#import "OtherTableViewCell.h"

@interface BPRViewController () <UITableViewDataSource, UITableViewDelegate>

@end

@implementation BPRViewController

- (void)loadView {
    [super loadView];
    
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    self.view.autoresizingMask = (UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight);
    self.title = @"Demo";
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:self.view.bounds];
    tableView.autoresizingMask = (UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight);
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableView.delegate = self;
    tableView.dataSource = self;
    [self.view addSubview:tableView];
    
    BPRRefreshView *refreshView = [[BPRArrowRefreshView alloc] initWithLocationType:BPRRefreshViewLocationTypeFixedBottom];
    [tableView addPullToRefreshView:refreshView withActionHandler:^(BPRPullToRefresh *pullToRefresh){
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [pullToRefresh dismiss];
        });
    }];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        return 250.0f;
    }
    
    return 60.0f;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 30;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        static NSString *firstReuseIdentifier = @"first-reuse";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:firstReuseIdentifier];
        if (!cell) {
            cell = [[BPRTopTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:firstReuseIdentifier];
        }
        
        return cell;
    }
    
    static NSString *otherReuseIdentifier = @"other-reuse";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:otherReuseIdentifier];
    if (!cell) {
        cell = [[OtherTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:otherReuseIdentifier];
    }
    
    return cell;
}

@end
