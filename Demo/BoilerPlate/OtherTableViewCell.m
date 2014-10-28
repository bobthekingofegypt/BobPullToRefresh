//
//  OtherTableViewCell.m
//  BobPullToRefresh
//
//  Created by Richard Martin on 27/10/2014.
//  Copyright (c) 2014 Richard Martin. All rights reserved.
//

#import "OtherTableViewCell.h"

@implementation OtherTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        UIView *circle = [[UIView alloc] initWithFrame:CGRectMake(10, 10, 40, 40)];
        circle.layer.cornerRadius = 20;
        circle.backgroundColor = [UIColor colorWithRed:28/255.0 green:82/255.0 blue:162/255.0 alpha:1.0];
        
        [self addSubview:circle];
        
        UILabel *title = [[UILabel alloc] initWithFrame:CGRectZero];
        title.text = @"Something Interesting";
        title.numberOfLines = 0;
        title.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:18];
        title.frame = CGRectMake(70, 10, 200, 24);
        title.textColor = [UIColor colorWithRed:28/255.0 green:82/255.0 blue:162/255.0 alpha:1.0];
        
        [self addSubview:title];
        
        UILabel *subTitle = [[UILabel alloc] initWithFrame:CGRectZero];
        subTitle.text = @"Not really";
        subTitle.numberOfLines = 0;
        subTitle.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:12];
        subTitle.frame = CGRectMake(70, 30, 300, 20);
        subTitle.textColor = [UIColor blackColor];
        
        [self addSubview:subTitle];
    }
    
    return self;
}

@end
