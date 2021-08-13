//
//  SearchSonViewController.h
//  天气预报
//
//  Created by haoqianbiao on 2021/8/10.
//  Copyright © 2021 haoqianbiao. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^TransDataBlock)(NSMutableArray* array);
NS_ASSUME_NONNULL_BEGIN

@interface SearchSonViewController : UIViewController
<UITableViewDelegate,
UITableViewDataSource>
@property (nonatomic, strong) UITableView* tableView;
@property (nonatomic, strong) NSString* cityName;
@property (nonatomic, strong) NSMutableData* data;
@property (nonatomic, strong) NSMutableArray* timeArray;
@property (nonatomic, strong) NSString* todayStr;
@property (nonatomic, strong) NSString* weatherStrCurrent;
@property (nonatomic, strong) NSString* weatherStr;
@property (nonatomic, strong) NSMutableArray* hoursArray;
@property (nonatomic, strong) NSMutableArray* hoursImageArray;
@property (nonatomic, strong) NSMutableArray* hoursTemperatureArray;
@property (nonatomic, strong) NSMutableArray* dayArray;
@property (nonatomic, strong) NSMutableArray* dayArrayOne;
@property (nonatomic, strong) NSMutableArray* dayImageArray;
@property (nonatomic, strong) NSMutableArray* dayTemArrayLow;
@property (nonatomic, strong) NSMutableArray* dayTemArrayHigh;
@property (nonatomic, strong) NSString* dayImageStr;
@property (nonatomic, strong) NSString* dayTemStrLow;
@property (nonatomic, strong) NSString* dayTemStrHigh;
@property (nonatomic, strong) NSString* sunRiserStr;
@property (nonatomic, strong) NSString* sunSetStr;
@property (nonatomic, strong) NSString* humidityStr;
@property (nonatomic, strong) NSString* airStr;
@property (nonatomic, strong) NSMutableArray* winArray;
@property (nonatomic, strong) NSString* winSpeedStr;
@property (nonatomic, strong) NSString* winStr;
@property (nonatomic, strong) NSString* visibilityStr;
@property (nonatomic, strong) NSString* pressureStr;
@property (nonatomic, strong) NSMutableArray* nameArray;
@property (nonatomic, strong) NSMutableArray* arrayPersonal;
@property (copy, nonatomic) TransDataBlock transDataBlock;
@end

NS_ASSUME_NONNULL_END
