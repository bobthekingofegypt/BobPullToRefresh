//
//  BPRTopTableViewCell.m
//  BobPullToRefresh
//
//  Created by Richard Martin on 27/10/2014.
//  Copyright (c) 2014 Richard Martin. All rights reserved.
//

#import "BPRTopTableViewCell.h"

@implementation BPRTopTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundColor = [UIColor colorWithRed:28/255.0 green:82/255.0 blue:162/255.0 alpha:1.0];
        
        UILabel *title = [[UILabel alloc] initWithFrame:CGRectZero];
        title.text = @"Title of epic proportions. Made to amaze";
        title.numberOfLines = 0;
        title.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:25];
        title.frame = CGRectMake(20, 120, 300, 80);
        title.textColor = [UIColor whiteColor];
        
        [self addSubview:title];
        
        UILabel *subTitle = [[UILabel alloc] initWithFrame:CGRectZero];
        subTitle.text = @"Nobody";
        subTitle.numberOfLines = 0;
        subTitle.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:16];
        subTitle.frame = CGRectMake(20, 200, 300, 20);
        subTitle.textColor = [UIColor blackColor];
        
        [self addSubview:subTitle];
        
        
    }
    
    return self;
}

@end
