//
//  LiveEventsViewController.m
//  SatyaSadhna
//
//  Created by Roshan Singh Bisht on 08/06/17.
//  Copyright © 2017 Roshan Singh Bisht. All rights reserved.
//

#import "LiveEventsViewController.h"
#import "HomeService.h"
#import "UIButton+Layout.h"
#import "JVYoutubePlayerView.h"


@interface LiveEventsViewController ()<UITableViewDelegate,UITableViewDataSource,JVYoutubePlayerDelegate,MHWAlertDelegate>
@property (weak, nonatomic) IBOutlet UITableView            *tableview;
@property(strong,nonatomic)NSArray                          *tableData;
@property(strong,nonatomic)NSMutableArray                  *idArray;
@property(strong,nonatomic)NSMutableArray                  *tagArray;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint     *heightConstraint;
@property (strong, nonatomic) IBOutlet JVYoutubePlayerView *playerView;
@property (strong, nonatomic) NSString                      *goToMeetingUrl;

@end

@implementation LiveEventsViewController

- (void)getData {
    [mserviceHandler.homeService liveEvents:^(id response) {
        [activityIndicatorView stopAnimating];
        if ([response[@"success"] boolValue]) {
            if (_isfromHome) {
                NSArray *array = response[@"user_array"];
                NSMutableArray *a = [NSMutableArray new];
                for (NSDictionary *dict in array) {
                    if ([dict[@"live_status"] boolValue]) {
                        [a addObject:dict];
                    }
                    _goToMeetingUrl = [dict objectForKey:@"goto_metting_url"];
                    _tableData = a;
                    
                }
            }else {
                _tableData = response[@"user_array"];
            }
            [_tableview reloadData];
        } else {
            MHWAlertView *alert = [[MHWAlertView alloc] initWithTitle:@"Oops." message:@"No Events Available." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alert show];
        }
    } failure:^(NSError *error) {
        [activityIndicatorView stopAnimating];
    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setAddRightBarBarBackButtonEnabled:YES];
    _heightConstraint.priority = 997;
    _playerView.hidden = YES;
    _playerView.delegate = self;
    
    _idArray = [NSMutableArray new];
    _tagArray = [NSMutableArray new];
    if ([Internet checkNetConnection]) {
        
        if (mserviceHandler.homeService.liveEventsData.count > 0) {
            if (_isfromHome) {
                NSArray *array = mserviceHandler.homeService.liveEventsData;
                NSMutableArray *a = [NSMutableArray new];
                for (NSDictionary *dict in array) {
                    if ([dict[@"live_status"] boolValue]) {
                       [a addObject:dict];
                    }
                    _tableData = a;
                    
                }
            } else {
                _tableData = mserviceHandler.homeService.liveEventsData;

            }
            [_tableview reloadData];
            [self getData];
        } else {
            [self.view addSubview:activityIndicatorView];
            [activityIndicatorView startAnimating];
            [self getData];
        }
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated {
    [self.view setBackgroundColor:kBgImage];
    self.view.layer.contents = (id)[UIImage imageNamed:@"loginBg"].CGImage;
    self.addLeftBarBarBackButtonEnabled = YES;
    if (_isfromHome) {
        self.navigationItem.title = kLangualString(@"Live Events");
    } else {
        self.navigationItem.title = kLangualString(@"Events");
    }
    
    id<GAITracker> tracker = [GAI sharedInstance].defaultTracker;
    [tracker set:kGAIScreenName value:@"Live events"];
    [tracker send:[[GAIDictionaryBuilder createScreenView] build]];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _tableData.count;
    
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
    UIButton *meetingButton = (UIButton *)[cell.contentView viewWithTag:8];
    UILabel *newLabel = (UILabel *)[cell.contentView viewWithTag:6];
    UILabel *timeLabel = (UILabel *)[cell.contentView viewWithTag:7];
    
    
    [applyButton roundButton];
    [meetingButton roundButton];
    [applyButton addTarget:self action:@selector(appleAction:) forControlEvents:UIControlEventTouchUpInside];
    [meetingButton addTarget:self action:@selector(goToMeeting:) forControlEvents:UIControlEventTouchUpInside];
    if (_isfromHome) {
        [applyButton setTitle:@"Live" forState:UIControlStateNormal];
        [meetingButton setTitle:@"Go To Meeting" forState:UIControlStateNormal];
    
    } else {
        [applyButton setTitle:@"Play" forState:UIControlStateNormal];
    }
    
        NSDictionary *dict = [_tableData objectAtIndex:indexPath.row];
        [titleLabel setText:dict[@"title"]];
        [SubtitleLabel setText:[NSString stringWithFormat:@"%@ to %@",dict[@"start_date"],dict[@"end_date"]]];
        if ([dict[@"live_status"] boolValue]) {
            applyButton.hidden = NO;
            meetingButton.hidden = NO;
        } else {
            applyButton.hidden = YES;
            meetingButton.hidden = YES;
        }
        [label setText:[NSString stringWithFormat:@"%@ Days",dict[@"days"]]];
        [newLabel setText:dict[@"venue"]];
        [_idArray addObject:dict[@"url"]];
    
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        dateFormatter.dateFormat = @"HH:mm:ss";
        NSDate *date = [dateFormatter dateFromString:dict[@"time"]];
    
        dateFormatter.dateFormat = @"hh:mm a";
        NSString *pmamDateString = [dateFormatter stringFromDate:date];
        [timeLabel setText:pmamDateString];
        applyButton.tag = indexPath.row;
    
    return cell;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 175;
}

- (void)appleAction:(UIButton *)button {
    _heightConstraint.priority = 999;
    [UIView animateWithDuration:0.3 animations:^{
        [self.view layoutIfNeeded];
        _playerView.hidden = NO;
    } completion:^(BOOL finished) {
        [self.playerView loadPlayerWithVideoURL:_idArray[button.tag]];
        self.playerView.autoplay  = NO;
    }];

    
}

//MARK: GotoMeeting Button Action
- (void)goToMeeting:(UIButton *)button {
    
  UIApplication *application = [UIApplication sharedApplication];
   NSURL *URL = [NSURL URLWithString:self.goToMeetingUrl];
   [application openURL:URL options:@{} completionHandler:^(BOOL success) {
       if (success) {
           NSLog(@"Opened url");
       }
   }];
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    
}

- (JVYoutubePlayerView *)playerView {
    if(!_playerView) {
        _playerView.backgroundColor = [UIColor clearColor];
        _playerView.autoplay = YES;
        _playerView.allowLandscapeMode = YES;
        _playerView.forceBackToPortraitMode = YES;
        _playerView.allowAutoResizingPlayerFrame = YES;
        _playerView.fullscreen = YES;
        _playerView.playsinline = YES;
        _playerView.controls = YES;
        _playerView.showinfo = YES;
        _playerView.allowBackgroundPlayback = YES;
    }
    
    return _playerView;
}

- (void)MHWAlertView:(MHWAlertView *)mhwAlertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 0) {
        [self.navigationController popViewControllerAnimated:YES];
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
    
        UIViewController *vc = [MainStoryBoard instantiateViewControllerWithIdentifier:@"homeVC"];
        [self.navigationController pushViewController:vc animated:YES];
 
}
@end
