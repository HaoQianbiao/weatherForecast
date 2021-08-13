//
//  SearchViewController.h
//  天气预报
//
//  Created by haoqianbiao on 2021/8/8.
//  Copyright © 2021 haoqianbiao. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface SearchViewController : UIViewController
<UITableViewDataSource,
UITableViewDelegate,
NSURLSessionDelegate,
UITextFieldDelegate>
@property (nonatomic, strong) UITableView* tableView;
@property (nonatomic, strong) UITextField* textField;
@property (nonatomic, strong) NSMutableData* data;
@property (nonatomic, strong) NSMutableArray* timeArray;
@property (nonatomic, strong) NSMutableArray* cityArray;
@property (nonatomic, strong) NSMutableArray* cityNameArray;
@property (nonatomic, strong) NSURLSession* citySession;

@end

