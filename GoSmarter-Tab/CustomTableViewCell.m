//
//  CustomTableViewCell.m
//  GoSmarter-Tab
//
//  Created by MAC on 11/24/12.
//  Copyright (c) 2012 MAC. All rights reserved.
//

#import "CustomTableViewCell.h"

@implementation CustomTableViewCell

@synthesize label1;
@synthesize label2;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
