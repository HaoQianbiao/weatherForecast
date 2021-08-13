//
//  HomeTableViewCell.m
//  天气预报
//
//  Created by haoqianbiao on 2021/8/9.
//  Copyright © 2021 haoqianbiao. All rights reserved.
//

#import "HomeTableViewCell.h"

@implementation HomeTableViewCell

-(instancetype) initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    
    
    if ([reuseIdentifier isEqualToString:@"0"]) {
        _view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 415, 350)];
        _view.backgroundColor = [UIColor clearColor];
        [_view addSubview:_headLabel];
        _headLabel = [[UILabel alloc] initWithFrame:CGRectMake(135, 50, 150, 70)];
        _headLabel.font = [UIFont systemFontOfSize:40];
        _headLabel.textColor = [UIColor whiteColor];
        _headLabel.textAlignment = NSTextAlignmentCenter;
        _detailedLabel = [[UILabel alloc] initWithFrame:CGRectMake(135, 120, 150, 40)];
        _detailedLabel.font = [UIFont systemFontOfSize:23];
        _detailedLabel.textColor = [UIColor whiteColor];
        _detailedLabel.textAlignment = NSTextAlignmentCenter;
        _weatherHeadLabel = [[UILabel alloc] initWithFrame:CGRectMake(135, 160, 150, 100)];
        _weatherHeadLabel.font = [UIFont systemFontOfSize:70];
        _weatherHeadLabel.textColor = [UIColor whiteColor];
        _weatherHeadLabel.textAlignment = NSTextAlignmentCenter;
        _timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 300, 150, 50)];
        _timeLabel.font = [UIFont systemFontOfSize:23];
        _timeLabel.textColor = [UIColor whiteColor];
        _todayLabel = [[UILabel alloc] initWithFrame:CGRectMake(100, 300, 100, 50)];
        _todayLabel.font = [UIFont systemFontOfSize:20];
        _todayLabel.textColor = [UIColor whiteColor];
        _todayLabel.text = @"今天";
        _weatherLabelHigh = [[UILabel alloc] initWithFrame:CGRectMake(300, 300, 50, 50)];
        _weatherLabelHigh.font = [UIFont systemFontOfSize:25];
        _weatherLabelHigh.textColor = [UIColor whiteColor];
        _weatherLabelLow = [[UILabel alloc] initWithFrame:CGRectMake(360, 300, 50, 50)];
        _weatherLabelLow.font = [UIFont systemFontOfSize:25];
        _weatherLabelLow.textColor = [UIColor colorWithWhite:0.8 alpha:0.7];
        [_view addSubview:_headLabel];
        [_view addSubview:_detailedLabel];
        [_view addSubview:_weatherHeadLabel];
        [_view addSubview:_timeLabel];
        [_view addSubview:_todayLabel];
        [_view addSubview:_weatherLabelLow];
        [_view addSubview:_weatherLabelHigh];
        
        self.backgroundColor = [UIColor clearColor];
        [self.contentView addSubview:_view];
        return self;
    } else if ([reuseIdentifier isEqualToString:@"1"]) {
        _weatherScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, 414, 150)];
        _weatherScrollView.userInteractionEnabled = YES;
        _weatherScrollView.contentSize = CGSizeMake(414 * 3, 150);
        _weatherScrollView.delegate = self;
        _weatherScrollView.showsHorizontalScrollIndicator = NO;
        [self.contentView addSubview:_weatherScrollView];
        return self;
    } else if ([reuseIdentifier isEqualToString:@"2"]) {
        return self;
    } else if ([reuseIdentifier isEqualToString:@"3"]) {
        _headLabel = [[UILabel alloc] initWithFrame:CGRectMake(30, 0, 360, 100)];
        _headLabel.font = [UIFont systemFontOfSize:20];
        _headLabel.textColor = [UIColor whiteColor];
        _headLabel.textAlignment = NSTextAlignmentLeft;
        _headLabel.lineBreakMode =  NSLineBreakByWordWrapping;
        _headLabel.numberOfLines = 0;
        [self.contentView addSubview:_headLabel];
        return self;
    } else {
        _leftLabel = [[UILabel alloc] initWithFrame:CGRectMake(30, 10, 200, 30)];
        _leftLabel.textColor = [UIColor colorWithWhite:0.9 alpha:0.7];
        _leftLabel.font = [UIFont systemFontOfSize:18];
        _leftLabel.textAlignment = NSTextAlignmentLeft;
        [self.contentView addSubview:_leftLabel];
        _leftLabelOne = [[UILabel alloc] initWithFrame:CGRectMake(30, 40, 200, 60)];
        _leftLabelOne.textColor = [UIColor whiteColor];
        _leftLabelOne.font = [UIFont systemFontOfSize:30];
        _leftLabelOne.textAlignment = NSTextAlignmentLeft;
        [self.contentView addSubview:_leftLabelOne];
        _rightLabel = [[UILabel alloc] initWithFrame:CGRectMake(230, 10, 190, 30)];
        _rightLabel.textColor = [UIColor colorWithWhite:0.9 alpha:0.7];
        _rightLabel.font = [UIFont systemFontOfSize:18];
        _rightLabel.textAlignment = NSTextAlignmentLeft;
        [self.contentView addSubview:_rightLabel];
        _rightLabelOne = [[UILabel alloc] initWithFrame:CGRectMake(230, 40, 190, 60)];
        _rightLabelOne.textColor = [UIColor whiteColor];
        _rightLabelOne.font = [UIFont systemFontOfSize:30];
        _rightLabelOne.textAlignment = NSTextAlignmentLeft;
        [self.contentView addSubview:_rightLabelOne];
        return self;
    }
}




@end
