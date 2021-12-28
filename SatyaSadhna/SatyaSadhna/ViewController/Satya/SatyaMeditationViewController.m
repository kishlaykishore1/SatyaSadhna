//
//  SatyaMeditationViewController.m
//  SatyaSadhna
//
//  Created by Roshan Singh Bisht on 03/05/17.
//  Copyright © 2017 Roshan Singh Bisht. All rights reserved.
//

#import "SatyaMeditationViewController.h"
#import "IntroductionViewController.h"
#import "TrackViewController.h"
#import "ExperienceViewController.h"
#import "FaqViewController.h"
#import "CourseViewController.h"
#import "ChoiceViewController.h"
#import "GypsyCoursesDataVC.h"

@interface SatyaMeditationViewController ()<UITableViewDataSource,UITableViewDelegate> {
    NSArray *dataArray;
}
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation SatyaMeditationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setAddRightBarBarBackButtonEnabled:YES];
    //   dataArray = [[NSArray alloc] initWithObjects:@"Introduction",@"Guidelines",@"Courses",@"After the Course",@"Tracks",@"Question and Answer with Guru Ji",@"Experience", nil];
    dataArray = [[NSArray alloc] initWithObjects:@"Courses",@"Introduction",@"Who is Teaching?",@"Guidelines",@"SatyaSadhna for Children",@"Gypsy Courses",@"One Day Course",@"Introductory Session",@"Question and Answer with Guru Ji",@"Experience", nil];
    [_tableView setTableFooterView:[UIView new]];
    [_tableView setBackgroundColor:[UIColor clearColor]];
    [self.view updateViewWithApplicationGlobalFont];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated {
    self.addLeftBarBarBackButtonEnabled = YES;
    [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"loginBg"]]];
    self.view.layer.contents = (id)[UIImage imageNamed:@"loginBg"].CGImage;
    self.navigationItem.title = kLangualString(@"Satya Sadhna");
    
    id<GAITracker> tracker = [GAI sharedInstance].defaultTracker;
    [tracker set:kGAIScreenName value:@""];
    [tracker send:[[GAIDictionaryBuilder createScreenView] build]];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return dataArray.count;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    UILabel *textLabell = (UILabel *)[cell.contentView viewWithTag:1];
    textLabell.text = [NSString stringWithFormat:@"  %@",kLangualString([dataArray objectAtIndex:indexPath.row])];
    textLabell.layer.cornerRadius = 5.0f;
    textLabell.clipsToBounds = YES;
    [cell setBackgroundColor:[UIColor clearColor]];
    [self.view updateViewWithApplicationGlobalFont];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.row) {
        case 0: {
            CourseViewController *vc = [SecondStoryBoard instantiateViewControllerWithIdentifier:@"courseVC"];
            vc.fromView = @"course";
            [self.navigationController pushViewController:vc animated:YES];
        } break;
        case 1: {
            IntroductionViewController *vc = [MainStoryBoard instantiateViewControllerWithIdentifier:@"introVC"];
            vc.isFromView = @"satya";
            vc.currentView = @"Introduction";
            [self.navigationController pushViewController:vc animated:YES];
        } break;
        case 2:{
          GypsyCoursesDataVC *vc = [MainStoryBoard instantiateViewControllerWithIdentifier:@"GypsyCoursesDataVC"];
           vc.isFromView = @"satya";
           vc.currentView = @"Who is Teaching?";
          [self.navigationController pushViewController:vc animated:YES];
        } break;
        case 3: {
            IntroductionViewController *vc = [MainStoryBoard instantiateViewControllerWithIdentifier:@"introVC"];
            vc.isFromView = @"satya";
            vc.currentView = @"Guidelines";
            [self.navigationController pushViewController:vc animated:YES];
        } break;
        case 4: {
          GypsyCoursesDataVC *vc = [MainStoryBoard instantiateViewControllerWithIdentifier:@"GypsyCoursesDataVC"];
           vc.isFromView = @"satya";
           vc.currentView = @"SatyaSadhna for children";
          [self.navigationController pushViewController:vc animated:YES];
        } break;
        case 5:{
          GypsyCoursesDataVC *vc = [MainStoryBoard instantiateViewControllerWithIdentifier:@"GypsyCoursesDataVC"];
           vc.isFromView = @"satya";
           vc.currentView = @"Gypsy Courses";
          [self.navigationController pushViewController:vc animated:YES];
        } break;
        case 6: {
          GypsyCoursesDataVC *vc = [MainStoryBoard instantiateViewControllerWithIdentifier:@"GypsyCoursesDataVC"];
           vc.isFromView = @"satya";
           vc.currentView = @"One Day Course";
          [self.navigationController pushViewController:vc animated:YES];
        } break;
//        case 7:{
//            IntroductionViewController *vc = [MainStoryBoard instantiateViewControllerWithIdentifier:@"introVC"];
//            vc.isFromView = @"satya";
//            vc.currentView = @"After The Course";
//            [self.navigationController pushViewController:vc animated:YES];
//        } break;
        case 7: {
          GypsyCoursesDataVC *vc = [MainStoryBoard instantiateViewControllerWithIdentifier:@"GypsyCoursesDataVC"];
           vc.isFromView = @"satya";
           vc.currentView = @"Introductory Session";
          [self.navigationController pushViewController:vc animated:YES];
        } break;
        case 8:{
            UIViewController *vc = [SecondStoryBoard instantiateViewControllerWithIdentifier:@"frequentVC"];
            [self.navigationController pushViewController:vc animated:YES];
        } break;
        case 9:{
            ExperienceViewController *vc = [MainStoryBoard instantiateViewControllerWithIdentifier:@"experienceVC"];
            vc.isFromView = @"exp";
            [self.navigationController pushViewController:vc animated:YES];
        } break;
            
            
            
        default:
            break;
    }
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
    
    [self.navigationController popToRootViewControllerAnimated:true];
}


@end
