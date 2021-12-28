//
//  CourseHistoryViewController.m
//  SatyaSadhna
//
//  Created by Roshan Bisht on 18/02/18.
//  Copyright © 2018 Roshan Singh Bisht. All rights reserved.
//

#import "CourseHistoryViewController.h"
#import "HomeService.h"
#import "RegisterPageOneViewController.h"

@interface CourseHistoryViewController ()<UITableViewDelegate,UITableViewDataSource> {
    NSArray *dataArray;
}
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation CourseHistoryViewController

- (void)getData {
    if ([Internet checkNetConnection]) {
        [self.view addSubview:activityIndicatorView];
        [activityIndicatorView startAnimating];
        [mserviceHandler.homeService bookingHistory:^(id response) {
            dataArray = response[@"page_result"];
            [_tableView reloadData];
            [activityIndicatorView stopAnimating];
        } failure:^(NSError *error) {
            [activityIndicatorView stopAnimating];
        }];
    }
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self getData];
    [self setAddRightBarBarBackButtonEnabled:YES];
    [_tableView  setTableFooterView:[UIView new]];
    [_tableView setBackgroundColor:[UIColor clearColor]];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated {
    self.addLeftBarMenuButtonEnabled = YES;
    [self.view setBackgroundColor:kBgImage];
    self.view.layer.contents = (id)[UIImage imageNamed:@"loginBg"].CGImage;
    self.navigationItem.title = kLangualString(@"Course History");
    id<GAITracker> tracker = [GAI sharedInstance].defaultTracker;
    [tracker set:kGAIScreenName value:@"course history"];
    [tracker send:[[GAIDictionaryBuilder createScreenView] build]];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 100;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell;
    cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    [cell setBackgroundColor:[UIColor clearColor]];
    
    UILabel *label1 = (UILabel *)[cell.contentView viewWithTag:1];
    UILabel *label2 = (UILabel *)[cell.contentView viewWithTag:2];
    NSDictionary *dict = dataArray[indexPath.row];
    
    NSString *start = dict[@"datefromeform"];
    NSString *end = dict[@"datetoform"];
    
    NSDateFormatter *f = [[NSDateFormatter alloc] init];
    [f setDateFormat:@"dd-MM-yyyy"];
    NSDate *startDate = [f dateFromString:start];
    NSDate *endDate = [f dateFromString:end];
    
    NSCalendar *gregorianCalendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *components = [gregorianCalendar components:NSCalendarUnitDay
                                                        fromDate:startDate
                                                          toDate:endDate
                                                         options:0];
    
    
    label1.layer.cornerRadius = label1.frame.size.height / 2;
    label1.clipsToBounds = YES;
    [label1 setText:[NSString stringWithFormat:@"%ld Days",[components day]+1]];
    
    
    NSDateFormatter *f1 = [[NSDateFormatter alloc] init];
    [f1 setDateFormat:@"dd MMM,yyyy"];
    
    NSString *startDate1 = [f1 stringFromDate:startDate];
    NSString *endDate1 = [f1 stringFromDate:endDate];
    [label2 setText:[NSString stringWithFormat:@"%@ - %@",startDate1,endDate1]];
    
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return dataArray.count;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Are you appying for a new course" message:@""    preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:@"No" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
    }]];
    
    [alert addAction:[UIAlertAction actionWithTitle:@"yes" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        RegisterPageOneViewController *vc = [SecondStoryBoard instantiateViewControllerWithIdentifier:@"registeroneVC"];
        NSDictionary *dict = dataArray[indexPath.row];
        vc.dict = dict;
        [UserDefaultManager setCourse:dict[@"id"]];
        [self.navigationController pushViewController:vc animated:YES];
        
    }]];
    [self presentViewController:alert animated:YES completion:nil];
    
}

//MARK: Add Right Navigation Bar Button
- (void)setAddRightBarBarBackButtonEnabled:(BOOL)addRightBarBarBackButtonEnabled {
    //This is for add Right button
    if (addRightBarBarBackButtonEnabled) {
        UIButton *btnBack = [UIButton buttonWithType:UIButtonTypeCustom];
        [btnBack setFrame:CGRectMake(0, 0, 30, 90)];
        [btnBack setImage:[UIImage imageNamed:@"dashboardSlide"] forState:UIControlStateNormal];
        [btnBack addTarget:self action:@selector(actionRightBarButton:) forControlEvents:UIControlEventTouchUpInside];
        UIBarButtonItem *barButton =[[UIBarButtonItem alloc] initWithCustomView:btnBack];
        self.navigationItem.rightBarButtonItem = barButton;
    } else {
        [self.navigationItem setHidesBackButton:YES];
    }
}

- (void)actionRightBarButton:(UIButton *)btn {
    
    UIViewController *vc = [MainStoryBoard instantiateViewControllerWithIdentifier:@"homeVC"];
    [self.navigationController pushViewController:vc animated:YES];
     
}
@end
