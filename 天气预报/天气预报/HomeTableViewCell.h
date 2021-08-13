//
//  HomeTableViewCell.h
//  天气预报
//
//  Created by haoqianbiao on 2021/8/9.
//  Copyright © 2021 haoqianbiao. All rights reserved.
//

#import <UIKit/UIKit.h>



@interface HomeTableViewCell : UITableViewCell
<UIScrollViewDelegate>

@property (nonatomic, strong) UIScrollView* weatherScrollView;
@property (nonatomic, strong) UIView* view;
@property (nonatomic, strong) UILabel* headLabel;
@property (nonatomic, strong) UILabel* detailedLabel;
@property (nonatomic, strong) UILabel* weatherHeadLabel;
@property (nonatomic, strong) UILabel* timeLabel;
@property (nonatomic, strong) UILabel* todayLabel;
@property (nonatomic, strong) UILabel* weatherLabelLow;
@property (nonatomic, strong) UILabel* weatherLabelHigh;
@property (nonatomic, strong) UILabel* sunRiseLabel;
@property (nonatomic, strong) UILabel* sunSetLabel;
@property (nonatomic, strong) UILabel* leftLabel;
@property (nonatomic, strong) UILabel* leftLabelOne;
@property (nonatomic, strong) UILabel* rightLabel;
@property (nonatomic, strong) UILabel* rightLabelOne;
@end


