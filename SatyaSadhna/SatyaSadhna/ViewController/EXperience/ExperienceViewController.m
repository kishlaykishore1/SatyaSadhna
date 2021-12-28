//
//  ExperienceViewController.m
//  SatyaSadhna
//
//  Created by Roshan Singh Bisht on 20/05/17.
//  Copyright © 2017 Roshan Singh Bisht. All rights reserved.
//

#import "ExperienceViewController.h"
#import "HomeService.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "YouTubeLiveModal.h"
#import "VideoViewController.h"
#import "JVYoutubePlayerView.h"

@interface ExperienceViewController ()<UITableViewDelegate,UITableViewDataSource,JVYoutubePlayerDelegate> {
    NSArray             *youtubeData;
    NSArray             *youtubeNameData;
    NSMutableArray      *nameList;
    NSMutableArray      *textArray;
    NSMutableArray      *textTitleArray;
    NSInteger           selectedIndexForSection;
    BOOL                isCellExpand;
    CGFloat             labelHeight;
}
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *constraint;
@property (weak, nonatomic) IBOutlet JVYoutubePlayerView *playerView;

@end

@implementation ExperienceViewController

- (void)getVideos {
    [mserviceHandler.homeService getExp:^(id response) {
        youtubeData = [self updateComppletedVideo:response[@"user_array"]];
        [activityIndicatorView stopAnimating];
        [_tableView reloadData];
    } failure:^(NSError *error) {
        [activityIndicatorView stopAnimating];
    }];
}

- (NSArray *)updateComppletedVideo :(NSArray *)response{
    NSMutableArray *videoIdList = [[NSMutableArray alloc] init];
    textArray = [NSMutableArray new];
    textTitleArray = [NSMutableArray new];
    for (NSDictionary *dict in response) {
        NSString *str = dict[@"description"];
        NSArray *temp = [str componentsSeparatedByString:@"v="];
        NSString *tempstr = [temp lastObject];
        if (tempstr.length > 15) {
            [textArray addObject:tempstr];
            [textTitleArray addObject:dict[@"page_title"]];
        } else {
            [videoIdList addObject:tempstr];
            [nameList addObject:dict[@"page_title"]];
        }
        
    }
    return videoIdList;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setAddRightBarBarBackButtonEnabled:YES];
    _playerView.hidden = YES;
    selectedIndexForSection = -1;
    nameList = [NSMutableArray new];
    [self.view addSubview:activityIndicatorView];
    [_tableView setBackgroundColor:[UIColor whiteColor]];
    if ([_isFromView isEqualToString:@"exp"]) {
        self.addLeftBarBarBackButtonEnabled = YES;
    } else {
        self.addLeftBarMenuButtonEnabled = YES;
    }
    self.navigationItem.title = kLangualString(@"Experience");
    [_tableView setTableFooterView:[UIView new]];
    if ([Internet checkNetConnection]) {
        [activityIndicatorView startAnimating];
        [self getVideos];
    }
    
    id<GAITracker> tracker = [GAI sharedInstance].defaultTracker;
    [tracker set:kGAIScreenName value:@"Experrince Holder"];
    [tracker send:[[GAIDictionaryBuilder createScreenView] build]];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return youtubeData.count;
    } else {
        return textArray.count;
    }
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.section) {
        case 0:{
            return 135;
        } break;
        case 1:{
            if (selectedIndexForSection == 1) {
                isCellExpand = YES;
                return labelHeight;
            } else {
                isCellExpand = NO;
                return 135;
            }
        }
        default:
            break;
    }
    return 0;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell;
    UITableViewCell *cell1;
    if (indexPath.section == 0) {
        cell = [_tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
        
        UIImageView *image = (UIImageView *)[cell.contentView viewWithTag:1];
        UILabel *titleLabel = (UILabel *)[cell.contentView viewWithTag:2];
        [titleLabel sizeToFit];
        [titleLabel setNumberOfLines:0];
        image.contentMode = UIViewContentModeScaleToFill;
        [image setImage:[UIImage imageNamed:@"youtube"]];
        [titleLabel setText:[nameList objectAtIndex:indexPath.row]];
        
        return cell;
    } else if(indexPath.section == 1) {
        cell1 = [_tableView dequeueReusableCellWithIdentifier:@"cell1" forIndexPath:indexPath];
        UILabel *titleLabel = (UILabel *)[cell1.contentView viewWithTag:5];
        if (textArray.count > 0) {
            [titleLabel setText:[NSString stringWithFormat:@"%@ %@",[textTitleArray objectAtIndex:indexPath.row],[textArray objectAtIndex:indexPath.row]]];
        }
        
        CGSize constraint = CGSizeMake(titleLabel.frame.size.width, CGFLOAT_MAX);
        CGSize size;
        NSStringDrawingContext *context = [[NSStringDrawingContext alloc] init];
        CGSize boundingBox = [titleLabel.text boundingRectWithSize:constraint
                                                           options:NSStringDrawingUsesLineFragmentOrigin
                                                        attributes:@{NSFontAttributeName:titleLabel.font}
                                                           context:context].size;
        size = CGSizeMake(ceil(boundingBox.width), ceil(boundingBox.height));
        
        labelHeight = size.height;
        return cell1;
        
    }
    return cell;
}


- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        _constraint.priority = 999;
        [UIView animateWithDuration:0.3 animations:^{
            [self.view layoutIfNeeded];
            _playerView.hidden = NO;
        } completion:^(BOOL finished) {
            [self.playerView loadPlayerWithVideoId:[youtubeData objectAtIndex:indexPath.row]];
            self.playerView.autoplay  = NO;
        }];
    } else {
        _constraint.priority = 997;
        [UIView animateWithDuration:0.3 animations:^{
            [self.view layoutIfNeeded];
            _playerView.hidden = YES;
        } completion:^(BOOL finished) {
        }];
        if (selectedIndexForSection == 1) {
            selectedIndexForSection = -1;
            [tableView reloadSections:[NSIndexSet indexSetWithIndex:1] withRowAnimation:UITableViewRowAnimationFade];
        } else {
            selectedIndexForSection = 1;
            [tableView reloadSections:[NSIndexSet indexSetWithIndex:1] withRowAnimation:UITableViewRowAnimationFade];
        }
    }
    
}

- (void)viewWillAppear:(BOOL)animated {
    SWRevealViewController *reveal = self.revealViewController;
    reveal.panGestureRecognizer.enabled = YES;
}
- (void)viewDidAppear:(BOOL)animated {
    //    youtubeData = nil;
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
    if ([_isFromView isEqualToString:@"exp"]) {
        [self.navigationController popToRootViewControllerAnimated:true];
    } else {
        UIViewController *vc = [MainStoryBoard instantiateViewControllerWithIdentifier:@"homeVC"];
        [self.navigationController pushViewController:vc animated:YES];
    }
    
    
}

@end

