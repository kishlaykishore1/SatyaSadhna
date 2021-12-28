//
//  PlayListVideoVC.m
//  SatyaSadhna
//
//  Created by kishlay kishore on 18/12/20.
//  Copyright © 2020 Roshan Singh Bisht. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HomeService.h"
#import "PlayListVideoVC.h"
#import <UIKit/UIKit.h>
#import "UIImageView+AFNetworking.h"
#import "VideoListVC.h"

//@property (weak, nonatomic) IBOutlet UITableView *videoTableView;

@implementation PlayListVideoVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:activityIndicatorView];
    [self getdata];
}

- (void)viewWillAppear:(BOOL)animated {
    self.addLeftBarBarBackButtonEnabled = YES;
    [self.view setBackgroundColor:kBgImage];
    self.view.layer.contents = (id)[UIImage imageNamed:@"loginBg"].CGImage;
    self.navigationItem.title = kLangualString(@"YouTube");
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [videoData count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *videoTableIdentifier = @"VideoListCell";
 
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:videoTableIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:videoTableIdentifier];
    }
    UIImageView *image = (UIImageView *)[cell.contentView viewWithTag:1];
    [image setImageWithURL:[_videoImage objectAtIndex:indexPath.row]];
    UILabel *nameLabel = (UILabel *)[cell.contentView viewWithTag:2];
    [nameLabel setText:[_videoName objectAtIndex:indexPath.row]];
    UILabel *countLabel = (UILabel *)[cell.contentView viewWithTag:3];
    [countLabel setText:[NSString stringWithFormat:@"%@",[_videoCount objectAtIndex:indexPath.row]]];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 84;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    VideoListVC *vc = [MainStoryBoard instantiateViewControllerWithIdentifier:@"VideoListVC"];
    vc.playListID = [_idArray objectAtIndex:indexPath.row];
    vc.chanelId = [_channel objectAtIndex:indexPath.row];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)getdata{
        [activityIndicatorView  startAnimating];
        [mserviceHandler.homeService newPlaylist:^(id response) {
            videoData = response;
            _videoName = [NSMutableArray new];
            _videoImage = [NSMutableArray new];
            _videoCount = [NSMutableArray new];
            _idArray = [NSMutableArray new];
            _channel = [NSMutableArray new];
            for (NSDictionary *dict in videoData) {
                    [_videoName addObject:dict[@"playlist_title"]];
                    [_videoImage addObject:dict[@"thumbnails"]];
                    [_videoCount addObject:dict[@"video_total"]];
                    [_idArray addObject:dict[@"playlistId"]];
                    [_channel addObject:dict[@"chanel"]];
            }
            [_videoTableView reloadData];
            [activityIndicatorView  stopAnimating];
        } failure:^(NSError *error) {
            [activityIndicatorView  stopAnimating];
        }];
}



@end

