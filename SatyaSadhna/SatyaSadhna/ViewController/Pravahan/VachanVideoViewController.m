//
//  VachanVideoViewController.m
//  SatyaSadhna
//
//  Created by Roshan Singh Bisht on 20/05/17.
//  Copyright © 2017 Roshan Singh Bisht. All rights reserved.
//

#import "VachanVideoViewController.h"
#import "HomeService.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "YouTubeLiveModal.h"
#import "VideoViewController.h"

#import "JVYoutubePlayerView.h"

@interface VachanVideoViewController ()<UITableViewDelegate,UITableViewDataSource,JVYoutubePlayerDelegate> {
    NSArray *youtubeData;
    YouTubeLiveModal  *youtube;
}
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *constrainLayout;
@property (weak, nonatomic) IBOutlet JVYoutubePlayerView *playerView;

@end

@implementation VachanVideoViewController

- (void)getVideos {
    [mserviceHandler.homeService getYoutubeListing:^(id response) {
        youtubeData = response;
        [activityIndicatorView stopAnimating];
        [_tableView reloadData];
    } failure:^(NSError *error) {
        [activityIndicatorView stopAnimating];
    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setAddRightBarBarBackButtonEnabled:YES];
    youtube  =[YouTubeLiveModal new];
    [self.view addSubview:activityIndicatorView];
    [_tableView setTableFooterView:[UIView new]];
    [_tableView setBackgroundColor:[UIColor whiteColor]];
    _playerView.hidden = YES;
    _constrainLayout.priority = 997;
    self.addLeftBarBarBackButtonEnabled = YES;
    self.navigationItem.title = @"Pravachan";
    if ([Internet checkNetConnection]) {
        if (mserviceHandler.homeService.youtubeArray.count > 0) {
            youtubeData = mserviceHandler.homeService.youtubeArray;
            [_tableView reloadData];
            [self getVideos];
        } else {
            [activityIndicatorView startAnimating];
            [self getVideos];
        }
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return youtubeData.count;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 135;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell;
    cell = [_tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    youtube = [youtubeData objectAtIndex:indexPath.row];
    UIView *conte = (UIView *)[cell.contentView viewWithTag:4];
    [conte cornerradius];
    UIImageView *image = (UIImageView *)[cell.contentView viewWithTag:1];
    UILabel *titleLabel = (UILabel *)[cell.contentView viewWithTag:2];
    UILabel *descLabel = (UILabel *)[cell.contentView viewWithTag:3];
    image.contentMode = UIViewContentModeScaleToFill;
    [image sd_setImageWithURL:[NSURL URLWithString:youtube.thumbnailImage]];
    [titleLabel setText:youtube.videoTitle];
    [descLabel setText:youtube.videoDescription];
    return cell;
    
}


- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    youtube = [youtubeData objectAtIndex:indexPath.row];
    _constrainLayout.priority = 999;
    [UIView animateWithDuration:0.3 animations:^{
        [self.view layoutIfNeeded];
        _playerView.hidden = NO;
    } completion:^(BOOL finished) {
            [self.playerView loadPlayerWithVideoId:youtube.videoId];
            self.playerView.autoplay  = NO;
    }];
    
    
    
    
}

- (JVYoutubePlayerView *)playerView {
    if(!_playerView) {
        
        _playerView.backgroundColor = [UIColor clearColor];
        _playerView.delegate = self;
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
