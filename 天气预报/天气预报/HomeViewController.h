//
//  HomeViewController.h
//  天气预报
//
//  Created by haoqianbiao on 2021/8/9.
//  Copyright © 2021 haoqianbiao. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN


@interface HomeViewController : UIViewController
<UITableViewDelegate,
UITableViewDataSource,
UIScrollViewDelegate
>

@property (nonatomic, strong) NSString* cityName;
@property (nonatomic, strong) UITableView* tableView;
@property (nonatomic, strong) UIScrollView* scrollView;
@property (nonatomic, strong) NSMutableArray* arrayAll;
@property (nonatomic, strong) UIView* footView;
@property int leng;
@property int index;
@property (nonatomic, strong) NSMutableArray* signArray;
@end

NS_ASSUME_NONNULL_END
