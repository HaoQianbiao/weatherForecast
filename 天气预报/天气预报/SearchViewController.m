//
//  SearchViewController.m
//  天气预报
//
//  Created by haoqianbiao on 2021/8/8.
//  Copyright © 2021 haoqianbiao. All rights reserved.
//

#import "SearchViewController.h"
#import "MainViewController.h"
#import "SearchSonViewController.h"
@interface SearchViewController ()

@end

@implementation SearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor colorWithWhite:0.75 alpha:0.95];
    
    UILabel* label = [[UILabel alloc] initWithFrame:CGRectMake(80, 50, 250, 20)];
    label.text = @"输出城市、邮政编码或机场位置";
    label.font = [UIFont systemFontOfSize:15];
    label.textColor = [UIColor whiteColor];
    [self.view addSubview:label];
    _textField = [[UITextField alloc] initWithFrame:CGRectMake(30, 90, self.view.bounds.size.width - 120, 40)];
    _textField.delegate = self;
    _textField.backgroundColor = [UIColor colorWithWhite:0.7 alpha:0.93];
    _textField.borderStyle = UITextBorderStyleRoundedRect;
    _textField.tintColor = [UIColor whiteColor];
    _textField.textColor = [UIColor whiteColor];
    [_textField setValue:[NSNumber numberWithInt:35] forKey:@"paddingLeft"];
    UIImageView* userImageView = [[UIImageView alloc] initWithFrame:CGRectMake(5, 5, 30, 30)];
    userImageView.image = [UIImage imageNamed:@"/Users/haoqianbiao/Desktop/test1/UI/天气预报/素材/search.png"];
    [_textField addSubview:userImageView];
    [self.view addSubview:_textField];
    
    UIButton* cancelButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [cancelButton setTitle:@"取消" forState:UIControlStateNormal];
    [cancelButton setTintColor:[UIColor whiteColor]];
    cancelButton.frame = CGRectMake(self.view.bounds.size.width - 70, 90, 50, 40);
    [cancelButton addTarget:self action:@selector(pressToCancel) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:cancelButton];
    [self createTableView];
}


- (void)pressToCancel {
    [_textField endEditing:YES];
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)createTableView {
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(20, 150, 300, self.view.bounds.size.height - 100) style:UITableViewStylePlain];
    [self.view addSubview:_tableView];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.backgroundColor = [UIColor clearColor];
    [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"111"];
    UIView* view = [[UIView alloc] init];
    _tableView.tableFooterView = view;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [self createURLCity];
    return YES;
}

- (void)createURLCity {
    NSString* urlString = [NSString stringWithFormat:@"https://geoapi.heweather.net/v2/city/lookup?location=%@&key=b92646e0f4194731b50870798cfad1d0", _textField.text];
    urlString = [urlString stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    NSURL* url = [NSURL URLWithString:urlString];
    
    NSURLRequest* request = [NSURLRequest requestWithURL:url];
    _citySession = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration] delegate:self delegateQueue:[NSOperationQueue mainQueue]];
    NSURLSessionDataTask* dataTask = [_citySession dataTaskWithRequest:request];
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
            
        _timeArray = [[NSMutableArray alloc] init];
        _timeArray = cityDictionary[@"location"];
        _cityArray = [[NSMutableArray alloc] init];
        _cityNameArray = [[NSMutableArray alloc] init];
        for (int i = 0; i < _timeArray.count; i++) {
            NSString* str = [NSString stringWithFormat:@"%@-%@", _timeArray[i][@"name"], _timeArray[i][@"adm1"]];
            NSString* strName = [NSString stringWithFormat:@"%@", _timeArray[i][@"name"]];
            [_cityNameArray addObject:strName];
            [_cityArray addObject:str];
        }
    } else {
        NSLog(@"error = %@", error);
    }
    [[NSOperationQueue mainQueue] addOperationWithBlock:^{
        [self->_tableView reloadData];
    }];
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"111" forIndexPath:indexPath];
    while ([cell.contentView.subviews lastObject] != nil) {
        [(UIView *)[cell.contentView.subviews lastObject] removeFromSuperview];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.backgroundColor = [UIColor clearColor];
    cell.textLabel.text = _cityArray[indexPath.row];
    cell.textLabel.font = [UIFont systemFontOfSize:20];
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _cityArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 30;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self createURLCity];
    [_textField endEditing:YES];
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    SearchSonViewController* searchSon = [[SearchSonViewController alloc] init];
    searchSon.cityName = _cityNameArray[indexPath.row];
    [self presentViewController:searchSon animated:YES completion:nil];
}

@end
