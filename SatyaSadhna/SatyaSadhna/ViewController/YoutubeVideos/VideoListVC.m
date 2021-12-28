//
//  VideoListVC.m
//  SatyaSadhna
//
//  Created by kishlay kishore on 22/12/20.
//  Copyright © 2020 Roshan Singh Bisht. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HomeService.h"
#import "VideoListVC.h"
#import <UIKit/UIKit.h>
#import "UIImageView+AFNetworking.h"
#import "VideoViewController.h"

@implementation VideoListVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:activityIndicatorView];
    [self getdata];
//    if (mserviceHandler.homeService.videoDataList.count > 0) {
//        listData = mserviceHandler.homeService.videoDataList;
//        [_tableView reloadData];
//        [self getdata];
//    } else {
//        [activityIndicatorView  startAnimating];
//        [self getdata];
//    }
}

- (void)viewWillAppear:(BOOL)animated {
    self.addLeftBarBarBackButtonEnabled = YES;
    [self.view setBackgroundColor:kBgImage];
    self.view.layer.contents = (id)[UIImage imageNamed:@"loginBg"].CGImage;
    self.navigationItem.title = kLangualString(@"Playlist Videos");
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [listData count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *videoTableIdentifier = @"PlayListCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:videoTableIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:videoTableIdentifier];
    }
    UIImageView *videoImage = (UIImageView *)[cell.contentView viewWithTag:1];
    [videoImage setImageWithURL:[_videoImage objectAtIndex:indexPath.row]];
    UILabel *videoName = (UILabel *)[cell.contentView viewWithTag:2];
    [videoName setText:[_videoNameList objectAtIndex:indexPath.row]];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 94;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    VideoViewController *vc = [MainStoryBoard instantiateViewControllerWithIdentifier:@"videoVC"];
    vc.videoID = [_videoID objectAtIndex:indexPath.row];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)getdata{
    [activityIndicatorView startAnimating];
    NSDictionary *param = @{@"playlistId":_playListID,
                            @"chanel": [NSNumber numberWithInt:[_chanelId intValue]] };
    [mserviceHandler.homeService videoList:param success:^(id response) {
        listData = response;
        _videoNameList = [NSMutableArray new];
        _videoImage = [NSMutableArray new];
        _videoID = [NSMutableArray new];
        for (NSDictionary *dict in listData) {
                [_videoNameList addObject:dict[@"title"]];
                [_videoImage addObject:dict[@"thumbnails"]];
                [_videoID addObject:dict[@"video_id"]];
        }
        [_tableView reloadData];
        [activityIndicatorView stopAnimating];
    } failure:^(NSError *error) {
        [activityIndicatorView  stopAnimating];
    }];
}

@end
