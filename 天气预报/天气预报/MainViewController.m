//
//  MainViewController.m
//  天气预报
//
//  Created by haoqianbiao on 2021/8/8.
//  Copyright © 2021 haoqianbiao. All rights reserved.
//

#import "MainViewController.h"
#import "MainTableViewCell.h"
#import "SearchViewController.h"
#import "HomeViewController.h"
#import "SearchSonViewController.h"
@interface MainViewController ()

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Do any additional setup after loading the view.
    UIImageView* imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"/Users/haoqianbiao/Desktop/test1/UI/天气预报/素材/main_background.jpeg"]];
    [self.view insertSubview:imageView atIndex:0];
    _labelArray = [[NSMutableArray alloc] initWithObjects:@"西安", nil];
    self.arrayAll = [[NSMutableArray alloc] init];
    _cityName = [_labelArray objectAtIndex:0];
    [self createURLCity];
    [self createTableView];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(notiReceived:)name:@"TransDataNoti" object: nil];
}


- (void) notiReceived:(NSNotification*)sender {
    [_arrayAll addObject: sender.userInfo[@"array"]];
    [_tableView reloadData];
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)createTableView {
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height)];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.backgroundColor = [UIColor clearColor];
    [_tableView registerClass:[MainTableViewCell class] forCellReuseIdentifier:@"0"];
    [self.view addSubview:_tableView];
}

- (UIView*)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    _footView = [[UIView alloc] init];
    UIButton* addButton = [UIButton buttonWithType:UIButtonTypeCustom];
    addButton.frame = CGRectMake(360, 10, 35, 35);
    [addButton setImage:[UIImage imageNamed:@"/Users/haoqianbiao/Desktop/test1/UI/天气预报/素材/add.png"] forState:UIControlStateNormal];
    [addButton addTarget:self action:@selector(press) forControlEvents:UIControlEventTouchUpInside];
    [_footView addSubview:addButton];
    return _footView;
}

-  (void)press {
    SearchViewController* search = [[SearchViewController alloc] init];
    [self presentViewController:search animated:YES completion:nil];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (_arrayAll.count > 8) {
        UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"不可添加！" preferredStyle:UIAlertControllerStyleAlert];
        [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIActionSheetStyleDefault handler:nil]];
        [self presentViewController:alert animated:true completion:nil];
    }
    return _arrayAll.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return (self.view.bounds.size.height - 40) / 8;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MainTableViewCell* cell = [_tableView dequeueReusableCellWithIdentifier:@"0" forIndexPath:indexPath];
    if (indexPath.row < _arrayAll.count) {
        cell.label.text = _arrayAll[indexPath.row][1];
        cell.textLabel.text = _arrayAll[indexPath.row][0];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    cell.textLabel.textColor = [UIColor whiteColor];
    cell.textLabel.font = [UIFont systemFontOfSize:35];
    cell.backgroundColor = [UIColor clearColor];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    HomeViewController* home = [[HomeViewController alloc] init];
    home.index = (int)indexPath.row;
    home.arrayAll = self.arrayAll;
    [self presentViewController:home animated:YES completion:nil];
}




- (void)createURLCity {
    NSString* urlString = [NSString stringWithFormat:@"https://tianqiapi.com/api?version=v1&appid=53565129&appsecret=UxG1fJH5&city=%@", _cityName];
    urlString = [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    NSURL* url = [NSURL URLWithString:urlString];
    
    NSURLRequest* request = [NSURLRequest requestWithURL:url];
    NSURLSession* session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration] delegate:self delegateQueue:[NSOperationQueue mainQueue]];
    NSURLSessionDataTask* dataTask = [session dataTaskWithRequest:request];
    [dataTask resume];
}


- (void)URLSession:(NSURLSession *)session dataTask:(nonnull NSURLSessionDataTask *)dataTask didReceiveResponse:(nonnull NSURLResponse *)response completionHandler:(nonnull void (^)(NSURLSessionResponseDisposition))completionHandler {
    if (self.data == nil) {
        self.data = [[NSMutableData alloc] init];
    } else {
        self.data.length = 0;
    }
    completionHandler(NSURLSessionResponseAllow);
}

- (void)URLSession:(NSURLSession *)session dataTask:(nonnull NSURLSessionDataTask *)dataTask didReceiveData:(nonnull NSData *)data {
    [self.data appendData:data];
}

- (void)URLSession:(NSURLSession *)session task:(nonnull NSURLSessionTask *)task didCompleteWithError:(nullable NSError *)error {
    if (error == nil) {
        NSMutableDictionary* cityDictionary = [NSJSONSerialization JSONObjectWithData:_data options:kNilOptions error:nil];
        self.dayArray = [[NSMutableArray alloc] init];
        self.hoursArray = [[NSMutableArray alloc] init];
        self.timeArray = [[NSMutableArray alloc] initWithObjects:@"现在", nil];
        self.hoursImageArray = [[NSMutableArray alloc] init];
        self.hoursTemperatureArray = [[NSMutableArray alloc] init];
        self.dayArrayOne = [[NSMutableArray alloc] init];
        self.dayTemArrayLow = [[NSMutableArray alloc] init];
        self.dayTemArrayHigh = [[NSMutableArray alloc] init];
        self.dayImageArray = [[NSMutableArray alloc] init];
        self.nameArray = [[NSMutableArray alloc] init];
        self.arrayPersonal = [[NSMutableArray alloc] init];
        
        _dayArray = cityDictionary[@"data"];
        NSString* weatherStrCurOne = cityDictionary[@"data"][0][@"tem"];
        _weatherStrCurrent = [weatherStrCurOne substringToIndex:2];
        _weatherStr = cityDictionary[@"data"][0][@"wea"];
        _hoursArray = cityDictionary[@"data"][0][@"hours"];
        _winArray = cityDictionary[@"data"][0][@"win"];
        
        for (int i = 1; i < _hoursArray.count; i++) {
            NSString* str = [NSString stringWithFormat:@"%@", _hoursArray[i][@"hours"]];
            [_timeArray addObject:str];
        }
        for (int i = 0; i < _hoursArray.count; i++) {
            NSString* strOne = [NSString stringWithFormat:@"%@", _hoursArray[i][@"wea_img"]];
            NSString* strTwo = [NSString stringWithFormat:@"%@", _hoursArray[i][@"tem"]];
            [_hoursImageArray addObject:strOne];
            [_hoursTemperatureArray addObject:strTwo];
        }
        for (int i = 0; i < 7; i++) {
            NSString* todayString = _dayArray[i][@"day"];
            NSString* todayStringOne = [todayString substringFromIndex:4];
            _todayStr = [todayStringOne substringToIndex:3];
            _dayImageStr = cityDictionary[@"data"][i][@"wea_img"];
            _dayTemStrLow = cityDictionary[@"data"][i][@"tem2"];
            _dayTemStrLow = [_dayTemStrLow substringToIndex:2];
            _dayTemStrHigh = cityDictionary[@"data"][i][@"tem1"];
            _dayTemStrHigh = [_dayTemStrHigh substringToIndex:2];
            [_dayArrayOne addObject:_todayStr];
            [_dayTemArrayHigh addObject:_dayTemStrHigh];
            [_dayTemArrayLow addObject:_dayTemStrLow];
            [_dayImageArray addObject:_dayImageStr];
        }
        _sunRiserStr = cityDictionary[@"data"][0][@"sunrise"];
        [self.nameArray addObject:@"日出"];
        [self.nameArray addObject:_sunRiserStr];
        _sunSetStr = cityDictionary[@"data"][0][@"sunset"];
        [self.nameArray addObject:@"日落"];
        [self.nameArray addObject:_sunSetStr];
        _airStr = cityDictionary[@"data"][0][@"air"];
        [self.nameArray addObject:@"空气质量"];
        [self.nameArray addObject:_airStr];
        _visibilityStr = cityDictionary[@"data"][0][@"visibility"];
        [self.nameArray addObject:@"能见度"];
        [self.nameArray addObject:_visibilityStr];
        _pressureStr = cityDictionary[@"data"][0][@"pressure"];
        [self.nameArray addObject:@"气压"];
        [self.nameArray addObject:_pressureStr];
        _humidityStr = cityDictionary[@"data"][0][@"humidity"];
        [self.nameArray addObject:@"湿度"];
        [self.nameArray addObject:_humidityStr];
        _winStr = [NSString stringWithFormat:@"%@/%@", [_winArray objectAtIndex:0], [_winArray objectAtIndex:1]];
        [self.nameArray addObject:@"风向"];
        [self.nameArray addObject:_winStr];
        _winSpeedStr = cityDictionary[@"data"][0][@"win_speed"];
        [self.nameArray addObject:@"风速"];
        [self.nameArray addObject:_winSpeedStr];
        
        self.arrayPersonal = [[NSMutableArray alloc] init];
        [self.arrayPersonal addObject:self.cityName];
        [self.arrayPersonal addObject:self.weatherStrCurrent];
        [self.arrayPersonal addObject:self.weatherStr];
        [self.arrayPersonal addObject:self.timeArray];
        [self.arrayPersonal addObject:self.hoursImageArray];
        [self.arrayPersonal addObject:self.hoursTemperatureArray];
        [self.arrayPersonal addObject:self.dayArrayOne];
        [self.arrayPersonal addObject:self.dayTemArrayLow];
        [self.arrayPersonal addObject:self.dayTemArrayHigh];
        [self.arrayPersonal addObject:self.dayImageArray];
        [self.arrayPersonal addObject:self.nameArray];
        [self.arrayAll addObject:self.arrayPersonal];
    } else {
        NSLog(@"error = %@", error);
    }
    [[NSOperationQueue mainQueue] addOperationWithBlock:^{
        [self->_tableView reloadData];
    }];
}


@end
