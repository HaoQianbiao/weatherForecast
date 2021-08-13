//
//  SearchSonViewController.m
//  天气预报
//
//  Created by haoqianbiao on 2021/8/10.
//  Copyright © 2021 haoqianbiao. All rights reserved.
//

#import "SearchSonViewController.h"
#import "HomeTableViewCell.h"
#import "MainViewController.h"
#define W self.view.bounds.size.width
#define H self.view.bounds.size.height
@interface SearchSonViewController ()

@end

@implementation SearchSonViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UIImageView* imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"/Users/haoqianbiao/Desktop/test1/UI/天气预报/素材/home_background.jpeg"]];
    [self.view insertSubview:imageView atIndex:0];
    
    UIButton* leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
    leftButton.frame = CGRectMake(20, 50, 50, 50);
    [leftButton setTitle:@"取消" forState:UIControlStateNormal];
    [leftButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [leftButton addTarget:self action:@selector(pressToCancel) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:leftButton];
    UIButton* rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
    rightButton.frame = CGRectMake(350, 50, 50, 50);
    [rightButton setTitle:@"添加" forState:UIControlStateNormal];
    [rightButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [rightButton addTarget:self action:@selector(pressToAdd) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:rightButton];
    [self createURLCity];
    [self createTableView];
}


- (void)pressToCancel {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)pressToAdd {
    //发送通知回传数据，回传的数据格式自定义，这里定义为dictionary类型
    [[NSNotificationCenter defaultCenter] postNotificationName:@"TransDataNoti" object:nil userInfo:@{@"array":_arrayPersonal}];
    
    UIViewController *vc = self;
    while (vc.presentingViewController) {
        vc = vc.presentingViewController;
    }
    [vc dismissViewControllerAnimated:YES completion:nil];  
}

-(void) createTableView {
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 100, W, H - 100) style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.backgroundColor = [UIColor clearColor];
    [self.tableView registerClass:[HomeTableViewCell class] forCellReuseIdentifier:@"0"];
    [self.tableView registerClass:[HomeTableViewCell class] forCellReuseIdentifier:@"1"];
    [self.tableView registerClass:[HomeTableViewCell class] forCellReuseIdentifier:@"2"];
    [self.tableView registerClass:[HomeTableViewCell class] forCellReuseIdentifier:@"3"];
    [self.tableView registerClass:[HomeTableViewCell class] forCellReuseIdentifier:@"4"];
    [self.view addSubview:self.tableView];
}

- (void)createURLCity {
    NSString* urlString = [NSString stringWithFormat:@"https://tianqiapi.com/api?version=v1&appid=53565129&appsecret=UxG1fJH5&city=%@", _cityName];
    urlString = [urlString stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
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
    } else {
        NSLog(@"error = %@", error);
    }
    [[NSOperationQueue mainQueue] addOperationWithBlock:^{
        [self->_tableView reloadData];
    }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 8;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        return 350;
    } else if (indexPath.row == 1) {
        return 150;
    } else if (indexPath.row == 2) {
        return 370;
    } else {
        return 100;
    }
}

- (UITableViewCell*) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        HomeTableViewCell* cell = [_tableView dequeueReusableCellWithIdentifier:@"0"];
        cell.headLabel.text = _arrayPersonal[0];
        cell.timeLabel.text = _arrayPersonal[6][0];
        cell.weatherLabelLow.text = _arrayPersonal[7][0];
        cell.weatherLabelHigh.text = _arrayPersonal[8][0];
        cell.weatherHeadLabel.text = _arrayPersonal[1];
        cell.detailedLabel.text = _arrayPersonal[2];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    } else if (indexPath.row == 1) {
        HomeTableViewCell* cell = [_tableView dequeueReusableCellWithIdentifier:@"1"];
        cell.backgroundColor = [UIColor clearColor];
        NSMutableArray* timeArray = [[NSMutableArray alloc] init];
        timeArray = _arrayPersonal[3];
        NSMutableArray* hoursImageArray  = [[NSMutableArray alloc] init];
        hoursImageArray  = _arrayPersonal[4];
        NSMutableArray* hoursTemperatureArray  = [[NSMutableArray alloc] init];
        hoursTemperatureArray  = _arrayPersonal[5];
        for (int i = 0; i < timeArray.count; i++) {
            UIView* view = [[UIView alloc] initWithFrame:CGRectMake(414 * 3 / timeArray.count * i + 10, 0, 70, 150)];
            view.backgroundColor = [UIColor clearColor];
            UILabel* label = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 80, 30)];
            label.text = [timeArray objectAtIndex:i];
            label.textColor = [UIColor whiteColor];
            label.font = [UIFont systemFontOfSize:20];
            NSString* str = [NSString stringWithFormat:@"/Users/haoqianbiao/Desktop/test1/UI/天气预报/素材/%@.png", [hoursImageArray objectAtIndex:i]];
            UIImageView* imageView = [[UIImageView alloc] initWithFrame:CGRectMake(15, 55, 40, 30)];
            imageView.image = [UIImage imageNamed:str];
            UILabel* temLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 100, 60, 40)];
            temLabel.text = [hoursTemperatureArray objectAtIndex:i];
            temLabel.textColor = [UIColor whiteColor];
            temLabel.font = [UIFont systemFontOfSize:25];
            [view addSubview:label];
            [view addSubview:temLabel];
            [view addSubview:imageView];
            [cell.weatherScrollView addSubview:view];
        }
        [cell.contentView addSubview:cell.weatherScrollView];
        return cell;
    } else if (indexPath.row == 2) {
        HomeTableViewCell* cell = [_tableView dequeueReusableCellWithIdentifier:@"2"];
        cell.backgroundColor = [UIColor clearColor];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        for (int i = 0; i < 7; i++) {
            UILabel* label = [[UILabel alloc] initWithFrame:CGRectMake(20, 10 + 50 * i, 80, 30)];
            label.text = [_arrayPersonal[6] objectAtIndex:i];
            label.textColor = [UIColor whiteColor];
            label.font = [UIFont systemFontOfSize:20];
            NSString* str = [NSString stringWithFormat:@"/Users/haoqianbiao/Desktop/test1/UI/天气预报/素材/%@.png", [_arrayPersonal[9] objectAtIndex:i]];
            UIImageView* imageView = [[UIImageView alloc] initWithFrame:CGRectMake(180, 10 + 50 * i, 40, 30)];
            imageView.image = [UIImage imageNamed:str];
            UILabel* temLabelHigh = [[UILabel alloc] initWithFrame:CGRectMake(300, 10 + 50 * i, 50, 30)];
            temLabelHigh.text = [_arrayPersonal[8] objectAtIndex:i];
            temLabelHigh.textColor = [UIColor whiteColor];
            temLabelHigh.font = [UIFont systemFontOfSize:25];
            UILabel* temLabelLow = [[UILabel alloc] initWithFrame:CGRectMake(360, 10 + 50 * i, 50, 30)];
            temLabelLow.text = [_arrayPersonal[7] objectAtIndex:i];
            temLabelLow.textColor = [UIColor  colorWithWhite:0.8 alpha:0.7];
            temLabelLow.font = [UIFont systemFontOfSize:25];
            [cell.contentView addSubview:label];
            [cell.contentView addSubview:imageView];
            [cell.contentView addSubview:temLabelHigh];
            [cell.contentView addSubview:temLabelLow];
        }
        return cell;
    } else if (indexPath.row == 3) {
        HomeTableViewCell* cell = [_tableView dequeueReusableCellWithIdentifier:@"3"];
        cell.backgroundColor = [UIColor clearColor];
        cell.selectionStyle = UITextBorderStyleNone;
        NSString* str = [NSString stringWithFormat:@"今天：今日%@。当前气温：%@；最高气温：%@。", _arrayPersonal[2], _arrayPersonal[1], _arrayPersonal[8][0]];
        cell.headLabel.text = str;
        return cell;
    } else {
        HomeTableViewCell* cell = [_tableView dequeueReusableCellWithIdentifier:@"4"];
        cell.backgroundColor = [UIColor clearColor];
        cell.selectionStyle = UITextBorderStyleNone;
        if (indexPath.row == 7) {
            NSString* str = [_arrayPersonal[10] objectAtIndex:13];
            if (str.length > 6) {
                NSRange pos = [str rangeOfString:@"/"];
                str = [str substringToIndex:pos.location];
                [_arrayPersonal[10] replaceObjectAtIndex:13 withObject:str];
            }
        }
        cell.leftLabel.text = [_arrayPersonal[10] objectAtIndex:(indexPath.row - 4) * 4];
        cell.leftLabelOne.text = [_arrayPersonal[10] objectAtIndex:(indexPath.row - 4) * 4 + 1];
        cell.rightLabel.text = [_arrayPersonal[10] objectAtIndex:(indexPath.row - 4) * 4 + 2];
        cell.rightLabelOne.text = [_arrayPersonal[10] objectAtIndex:(indexPath.row - 4) * 4 + 3];
        return cell;
    }
}


@end
