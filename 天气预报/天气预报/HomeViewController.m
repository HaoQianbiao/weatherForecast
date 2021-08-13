//
//  HomeViewController.m
//  天气预报
//
//  Created by haoqianbiao on 2021/8/9.
//  Copyright © 2021 haoqianbiao. All rights reserved.
//

#import "HomeViewController.h"
#import "HomeTableViewCell.h"

#define W self.view.bounds.size.width
#define H self.view.bounds.size.height
@interface HomeViewController ()

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UIImageView* imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"/Users/haoqianbiao/Desktop/test1/UI/天气预报/素材/home_background.jpeg"]];
    self.signArray = [[NSMutableArray alloc] init];
    for (int i = 0; i < _arrayAll.count; i++) {
        [self.signArray addObject:@"0"];
    }
    
    [self.view insertSubview:imageView atIndex:0];
    [self createScrollView];
    [self createTableView];
    _scrollView.contentOffset = CGPointMake(W * _index, 0) ;
    
    
}

-(void) createScrollView {
    _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, W, H)];
    _scrollView.delegate = self;
    _scrollView.contentSize = CGSizeMake(W  * _arrayAll.count, H);
    _scrollView.pagingEnabled = YES;
    _scrollView.userInteractionEnabled = YES;
    _scrollView.contentOffset = CGPointMake(0, 0) ;
    _scrollView.backgroundColor = [UIColor clearColor];
    _scrollView.tag = 1;
    
    [self.signArray replaceObjectAtIndex:0 withObject:@"1"];
    [self.view addSubview:_scrollView];
}

- (void)createTableView{
        self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, W, H) style:UITableViewStylePlain];
        self.tableView.delegate = self;
        self.tableView.dataSource = self;
        self.tableView.backgroundColor = [UIColor clearColor];
        self.tableView.tag = 0;
        [self.tableView registerClass:[HomeTableViewCell class] forCellReuseIdentifier:@"0"];
        [self.tableView registerClass:[HomeTableViewCell class] forCellReuseIdentifier:@"1"];
        [self.tableView registerClass:[HomeTableViewCell class] forCellReuseIdentifier:@"2"];
        [self.tableView registerClass:[HomeTableViewCell class] forCellReuseIdentifier:@"3"];
        [self.tableView registerClass:[HomeTableViewCell class] forCellReuseIdentifier:@"4"];
    [_scrollView addSubview:self.tableView];
    
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
        cell.headLabel.text = _arrayAll[tableView.tag][0];
        cell.timeLabel.text = _arrayAll[tableView.tag][6][0];
        cell.weatherLabelLow.text = _arrayAll[tableView.tag][7][0];
        cell.weatherLabelHigh.text = _arrayAll[tableView.tag][8][0];
        cell.weatherHeadLabel.text = _arrayAll[tableView.tag][1];
        cell.detailedLabel.text = _arrayAll[tableView.tag][2];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    } else if (indexPath.row == 1) {
        HomeTableViewCell* cell = [_tableView dequeueReusableCellWithIdentifier:@"1"];
        cell.backgroundColor = [UIColor clearColor];
        NSMutableArray* timeArray = [[NSMutableArray alloc] init];
        timeArray = _arrayAll[tableView.tag][3];
        NSMutableArray* hoursImageArray  = [[NSMutableArray alloc] init];
        hoursImageArray  = _arrayAll[tableView.tag][4];
        NSMutableArray* hoursTemperatureArray  = [[NSMutableArray alloc] init];
        hoursTemperatureArray  = _arrayAll[tableView.tag][5];
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
            label.text = [_arrayAll[tableView.tag][6] objectAtIndex:i];
            label.textColor = [UIColor whiteColor];
            label.font = [UIFont systemFontOfSize:20];
            NSString* str = [NSString stringWithFormat:@"/Users/haoqianbiao/Desktop/test1/UI/天气预报/素材/%@.png", [_arrayAll[tableView.tag][9] objectAtIndex:i]];
            UIImageView* imageView = [[UIImageView alloc] initWithFrame:CGRectMake(180, 10 + 50 * i, 40, 30)];
            imageView.image = [UIImage imageNamed:str];
            UILabel* temLabelHigh = [[UILabel alloc] initWithFrame:CGRectMake(300, 10 + 50 * i, 50, 30)];
            temLabelHigh.text = [_arrayAll[tableView.tag][8] objectAtIndex:i];
            temLabelHigh.textColor = [UIColor whiteColor];
            temLabelHigh.font = [UIFont systemFontOfSize:25];
            UILabel* temLabelLow = [[UILabel alloc] initWithFrame:CGRectMake(360, 10 + 50 * i, 50, 30)];
            temLabelLow.text = [_arrayAll[tableView.tag][7] objectAtIndex:i];
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
        NSString* str = [NSString stringWithFormat:@"今天：今日%@。当前气温：%@；最高气温：%@。", _arrayAll[tableView.tag][2], _arrayAll[tableView.tag][1], _arrayAll[tableView.tag][8][0]];
        cell.headLabel.text = str;
        return cell;
    } else {
         HomeTableViewCell* cell = [_tableView dequeueReusableCellWithIdentifier:@"4"];
        cell.backgroundColor = [UIColor clearColor];
        cell.selectionStyle = UITextBorderStyleNone;
        if (indexPath.row == 7) {
            NSString* str = [_arrayAll[tableView.tag][10] objectAtIndex:13];
            if (str.length > 6) {
                NSRange pos = [str rangeOfString:@"/"];
                str = [str substringToIndex:pos.location];
                [_arrayAll[tableView.tag][10] replaceObjectAtIndex:13 withObject:str];
            }
        }
        cell.leftLabel.text = [_arrayAll[tableView.tag][10] objectAtIndex:(indexPath.row - 4) * 4];
        cell.leftLabelOne.text = [_arrayAll[tableView.tag][10] objectAtIndex:(indexPath.row - 4) * 4 + 1];
        cell.rightLabel.text = [_arrayAll[tableView.tag][10] objectAtIndex:(indexPath.row - 4) * 4 + 2];
        cell.rightLabelOne.text = [_arrayAll[tableView.tag][10] objectAtIndex:(indexPath.row - 4) * 4 + 3];
        return cell;
    }
}

-(UIView*) tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    _footView = [[UIView alloc] init];
    UIButton* addButton = [UIButton buttonWithType:UIButtonTypeCustom];
    addButton.frame = CGRectMake(360, 10, 35, 35);
    [addButton setImage:[UIImage imageNamed:@"/Users/haoqianbiao/Desktop/test1/UI/天气预报/素材/liebiao.png"] forState:UIControlStateNormal];
    [addButton addTarget:self action:@selector(press) forControlEvents:UIControlEventTouchUpInside];
    [_footView addSubview:addButton];
    return _footView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 50;
}

- (void)press {
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void) scrollViewDidScroll:(UIScrollView *)scrollView {
    self.leng = scrollView.contentOffset.x / W;
    if (scrollView.tag == 1) {
        if ([self.signArray[self.leng] isEqualToString:@"0"]) {
            [self.signArray replaceObjectAtIndex:self.leng withObject:@"1"];
            self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(W * self.leng, 0, W, H) style:UITableViewStylePlain];
            self.tableView.delegate = self;
            self.tableView.dataSource = self;
            self.tableView.backgroundColor = [UIColor clearColor];
            self.tableView.tag = self.leng;
            [self.tableView registerClass:[HomeTableViewCell class] forCellReuseIdentifier:@"0"];
            [self.tableView registerClass:[HomeTableViewCell class] forCellReuseIdentifier:@"1"];
            [self.tableView registerClass:[HomeTableViewCell class] forCellReuseIdentifier:@"2"];
            [self.tableView registerClass:[HomeTableViewCell class] forCellReuseIdentifier:@"3"];
            [self.tableView registerClass:[HomeTableViewCell class] forCellReuseIdentifier:@"4"];
            [_scrollView addSubview:self.tableView];
        }
    }
}
@end
