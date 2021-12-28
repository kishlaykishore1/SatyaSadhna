//
//  CourseViewController.m
//  SatyaSadhna
//
//  Created by Roshan Singh Bisht on 04/06/17.
//  Copyright © 2017 Roshan Singh Bisht. All rights reserved.
//

#import "CourseViewController.h"
#import "HomeService.h"
#import "UIButton+Layout.h"
#import "UIView+Loading.h"
#import "RevealViewController.h"
#import "SWRevealViewController.h"
#import "RegisterPageOneViewController.h"


@interface CourseViewController ()<UITableViewDelegate,UITableViewDataSource>{
    NSArray *tableData;
}
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIView     *buttonView;
@property (weak, nonatomic) IBOutlet UIButton   *oldStudent;
@property (weak, nonatomic) IBOutlet UIButton   *newwtudentButton;
@property (weak, nonatomic) IBOutlet UILabel    *bottomLabel;
@property (nonatomic,strong)NSMutableArray *fromDate;
@property (nonatomic,strong)NSMutableArray *toDate;
@property (nonatomic,strong)NSMutableArray *location;
@property (nonatomic,strong)NSMutableArray *idArray;
@property (nonatomic,strong)NSMutableArray *pickerData;
@property (nonatomic,strong)NSMutableArray *tagArray;

@end

@implementation CourseViewController

- (void)getdata {
    [mserviceHandler.homeService getCourse:^(id response) {
        tableData = response;
        
        _fromDate = [NSMutableArray new];
        _toDate = [NSMutableArray new];
        _location = [NSMutableArray new];
        _idArray = [NSMutableArray new];
        _pickerData = [NSMutableArray new];
        for (NSDictionary *dict in tableData) {
            if ([dict[@"status"] isEqualToString:@"OPEN"]) {
                NSString *str = [NSString stringWithFormat:@"%@ to  %@ , %@",dict[@"date_from"],dict[@"date_to"],dict[@"location"]];
                [_pickerData addObject:str];
                [_fromDate addObject:dict[@"date_from"]];
                [_location addObject:dict[@"location"]];
                [_toDate addObject:dict[@"date_to"]];
                [_idArray addObject:dict[@"id"]];
            }
        }
        [_tableView reloadData];
        [activityIndicatorView  stopAnimating];
    } failure:^(NSError *error) {
        [activityIndicatorView  stopAnimating];
    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setAddRightBarBarBackButtonEnabled:YES];
    if (mserviceHandler.homeService.courseData.count > 0) {
        tableData = mserviceHandler.homeService.courseData;
        [_tableView reloadData];
        [self getdata];
    } else {
        [activityIndicatorView  startAnimating];
        [self getdata];
    }
    
}

- (void)viewWillAppear:(BOOL)animated {
    [self.view setBackgroundColor:kBgImage];
    self.view.layer.contents = (id)[UIImage imageNamed:@"loginBg"].CGImage;
    self.navigationItem.title = kLangualString(@"Courses");
    if ([_fromView isEqualToString:@"course"]) {
        self.addLeftBarBarBackButtonEnabled = YES;
    } else {
        self.addLeftBarMenuButtonEnabled = YES;
    }
    [_oldStudent setTitle:kLangualString(@"Join Old Student") forState:UIControlStateNormal];
    [_oldStudent setTitle:kLangualString(@"Join Old Student") forState:UIControlStateSelected];
    [_newwtudentButton setTitle:kLangualString(@"Join New Student") forState:UIControlStateNormal];
    [_newwtudentButton setTitle:kLangualString(@"Join New Student") forState:UIControlStateSelected];
    _oldStudent.selected = YES;
    _newwtudentButton.selected = NO;
    
    id<GAITracker> tracker = [GAI sharedInstance].defaultTracker;
    [tracker set:kGAIScreenName value:@"Course View"];
    [tracker send:[[GAIDictionaryBuilder createScreenView] build]];
    SWRevealViewController *reveal = self.revealViewController;
    reveal.panGestureRecognizer.enabled = NO;
    
    UISwipeGestureRecognizer * swipeleft=[[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(swipeleft:)];
    swipeleft.direction=UISwipeGestureRecognizerDirectionLeft;
    [self.view addGestureRecognizer:swipeleft];
    
    
    UISwipeGestureRecognizer * swiperight=[[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(swiperight:)];
    swiperight.direction=UISwipeGestureRecognizerDirectionRight;
    [self.view addGestureRecognizer:swiperight];
}

-(void)swipeleft:(UISwipeGestureRecognizer*)gestureRecognizer
{
    //Do what you want here
    if (_newwtudentButton.selected == NO) {
        [_tableView reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationLeft];
        [UIView animateWithDuration:0.5 animations:^{
            [self.view layoutIfNeeded];
            _bottomLabel.frame = CGRectMake(_newwtudentButton.frame.origin.x, _newwtudentButton.frame.origin.y+60, _newwtudentButton.frame.size.width, 2);
        }];
    }
    _oldStudent.selected = NO;
    _newwtudentButton.selected = YES;
    
    
}

-(void)swiperight:(UISwipeGestureRecognizer*)gestureRecognizer
{
    //Do what you want here
    if (_oldStudent.selected == NO) {
        [_tableView reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationRight];
        [UIView animateWithDuration:0.5 animations:^{
            [self.view layoutIfNeeded];
            _bottomLabel.frame = CGRectMake(_oldStudent.frame.origin.x, _oldStudent.frame.origin.y+60, _oldStudent.frame.size.width, 2);
        }];
    }
    _oldStudent.selected = YES;
    _newwtudentButton.selected = NO;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return tableData.count;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell;
    cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    
    UIView *content = (UIView *)[cell.contentView viewWithTag:1];
    [content cornerradius];
    [content updateViewWithApplicationGlobalFont];
    
    UILabel *titleLabel = (UILabel *)[cell.contentView viewWithTag:2];
    UILabel *SubtitleLabel = (UILabel *)[cell.contentView viewWithTag:3];
    UILabel *label = (UILabel *)[cell.contentView viewWithTag:4];
    UIButton *applyButton = (UIButton *)[cell.contentView viewWithTag:5];
    
        NSDictionary *dict = [tableData objectAtIndex:indexPath.row];
        [titleLabel setText:[NSString stringWithFormat:@"%@ to %@",dict[@"date_from"],dict[@"date_to"]]];
        NSDateFormatter * dateFormatter = [[NSDateFormatter alloc]init];
        [dateFormatter setDateFormat:@"dd/MM/yyyy"];
        NSDate *date1 = [dateFormatter dateFromString:dict[@"date_from"]];
        NSDate *date2 = [dateFormatter dateFromString:dict[@"date_to"]];
        NSTimeInterval secondsBetween = [date2 timeIntervalSinceDate:date1];
        int numberOfDays = secondsBetween / (86400);
        [SubtitleLabel setText:[NSString stringWithFormat:@"%d Days",numberOfDays]];
        [label setText:dict[@"location"]];
    
    
    [applyButton roundButton];
    applyButton.tag = indexPath.row;
    [applyButton setTitle:kLangualString(@"Apply") forState:UIControlStateNormal];
    [applyButton addTarget:self action:@selector(appleAction1:) forControlEvents:UIControlEventTouchUpInside];
    
    return cell;
    
}

- (void)appleAction1:(UIButton *)btn {
        [UserDefaultManager setIndexPath:[NSString stringWithFormat:@"%ld",btn.tag]];
        RegisterPageOneViewController *vc = [SecondStoryBoard instantiateViewControllerWithIdentifier:@"registeroneVC"];
        [self.navigationController pushViewController:vc animated:YES];
}
- (IBAction)oldAction:(id)sender {
    if (_oldStudent.selected == NO) {
        [_tableView reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationRight];
        [UIView animateWithDuration:0.5 animations:^{
            [self.view layoutIfNeeded];
            _bottomLabel.frame = CGRectMake(_oldStudent.frame.origin.x, _oldStudent.frame.origin.y+60, _oldStudent.frame.size.width, 2);
        }];
    }
    _oldStudent.selected = YES;
    _newwtudentButton.selected = NO;
    [UserDefaultManager setIsOldStudent:@"Old"];
    
    
}
- (IBAction)newAction:(id)sender {
    if (_newwtudentButton.selected == NO) {
        [_tableView reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationLeft];
        [UIView animateWithDuration:0.5 animations:^{
            [self.view layoutIfNeeded];
            _bottomLabel.frame = CGRectMake(_newwtudentButton.frame.origin.x, _newwtudentButton.frame.origin.y+60, _newwtudentButton.frame.size.width, 2);
        }];
    }
    _oldStudent.selected = NO;
    _newwtudentButton.selected  = YES;
    [UserDefaultManager setIsOldStudent:@"New"];
    
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
    if ([_fromView isEqualToString:@"course"]) {
       [self.navigationController popToRootViewControllerAnimated:true];
    } else {
        UIViewController *vc = [MainStoryBoard instantiateViewControllerWithIdentifier:@"homeVC"];
        [self.navigationController pushViewController:vc animated:YES];
    }
 
    
}



@end
