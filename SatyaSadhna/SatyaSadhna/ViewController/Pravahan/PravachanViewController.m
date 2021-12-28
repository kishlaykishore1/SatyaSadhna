//
//  PravachanViewController.m
//  SatyaSadhna
//
//  Created by Roshan Singh Bisht on 02/05/17.
//  Copyright © 2017 Roshan Singh Bisht. All rights reserved.
//

#import "PravachanViewController.h"
#import "HomeService.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "PravachanTableViewCell.h"

@interface PravachanViewController ()<UITableViewDelegate,UITableViewDataSource> {

        NSMutableArray  *linkArray;
        NSMutableArray  *headerArray;
        NSMutableArray  *textArray;
    NSMutableArray      *idArray;
    

}
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@end

@implementation PravachanViewController


- (void)data {
    
    [mserviceHandler.homeService pravachan:^(id response) {
        for (NSDictionary *dict in response[@"page_result"]) {
            [linkArray addObject:dict[@"videos_redirect_url"]];
            for (NSString *str in linkArray) {
                NSArray *arr = [str componentsSeparatedByString:@"/"];
                [idArray addObject:[arr lastObject]];
            }
            [headerArray addObject:dict[@"page_title"]];
        }
        [_tableView reloadData];
        [activityIndicatorView stopAnimating];
    } failure:^(NSError *error) {
        [activityIndicatorView stopAnimating];
    }];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setAddRightBarBarBackButtonEnabled:YES];
    linkArray = [NSMutableArray new];
    headerArray = [NSMutableArray new];
    textArray = [NSMutableArray new];
    idArray = [NSMutableArray new];
    if (mserviceHandler.homeService.pravachanData) {
        for (NSDictionary *dict in mserviceHandler.homeService.pravachanData) {
            [linkArray addObject:dict[@"videos_redirect_url"]];
            for (NSString *str in linkArray) {
                NSArray *arr = [str componentsSeparatedByString:@"/"];
                [idArray addObject:[arr lastObject]];
            }
            [headerArray addObject:dict[@"page_title"]];
        }
        [_tableView reloadData];
        [mserviceHandler.homeService pravachan:^(id response) {
            [activityIndicatorView stopAnimating];
            for (NSDictionary *dict in response[@"page_result"]) {
                [linkArray addObject:dict[@"videos_redirect_url"]];
                for (NSString *str in linkArray) {
                    NSArray *arr = [str componentsSeparatedByString:@"/"];
                    [idArray addObject:[arr lastObject]];
                }
                [headerArray addObject:dict[@"page_title"]];
            }
            [_tableView reloadData];
        } failure:^(NSError *error) {
            [activityIndicatorView stopAnimating];
        }];
        
    } else {
        [self.view addSubview:activityIndicatorView];
        [activityIndicatorView startAnimating];
        [self data];
        
        
        
    }
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
    self.navigationItem.title = kLangualString(@"Pravachan");
    
    id<GAITracker> tracker = [GAI sharedInstance].defaultTracker;
    [tracker set:kGAIScreenName value:@"Pravachan View"];
    [tracker send:[[GAIDictionaryBuilder createScreenView] build]];
}



- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 120;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return linkArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    PravachanTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    [cell.playerView loadWithVideoId:[idArray objectAtIndex:indexPath.row]];
    UILabel *nameLabel = (UILabel *)[cell.contentView viewWithTag:2];
    nameLabel.text = [headerArray objectAtIndex:indexPath.row];
    

    
//    UILabel *dataLabel = (UILabel *)[cell.contentView viewWithTag:3];
//    dataLabel.text = [rowdata objectAtIndex:indexPath.row];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}


- (void)dealloc {
    idArray = nil;
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
