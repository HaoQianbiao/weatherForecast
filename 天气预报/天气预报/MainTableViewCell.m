//
//  MainTableViewCell.m
//  天气预报
//
//  Created by haoqianbiao on 2021/8/9.
//  Copyright © 2021 haoqianbiao. All rights reserved.
//

#import "MainTableViewCell.h"

@implementation MainTableViewCell

-(instancetype) initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    self.backgroundColor = [UIColor clearColor];
    _label = [[UILabel alloc] initWithFrame:CGRectMake(350, 30, 50, 50)];
    _label.textColor = [UIColor whiteColor];
    _label.font = [UIFont systemFontOfSize:40];
    self.textLabel.textColor = [UIColor whiteColor];
    self.textLabel.font = [UIFont systemFontOfSize:30];
    [self.contentView addSubview:_label];
    return self;
}
-(void) layoutSubviews {
    [super layoutSubviews];
    CGRect adjustFrameOne = self.textLabel.frame;
    adjustFrameOne.origin.x += 20;
    self.textLabel.frame = adjustFrameOne;
}


@end
