//
//  VideoViewController.m
//  SatyaSadhna
//
//  Created by Roshan Singh Bisht on 20/05/17.
//  Copyright © 2017 Roshan Singh Bisht. All rights reserved.
//

#import "VideoViewController.h"
#import "JVYoutubePlayerView.h"

@interface VideoViewController ()<JVYoutubePlayerDelegate>


@end

@implementation VideoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.playerView loadPlayerWithVideoId:_videoID];
    [self.view addSubview:_playerView];
    self.playerView.autoplay  =YES;
    self.addLeftBarBarBackButtonEnabled = YES;
    [self.view setBackgroundColor:kBgImage];
    self.view.layer.contents = (id)[UIImage imageNamed:@"loginBg"].CGImage;
    self.navigationItem.title = @"Video";
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (JVYoutubePlayerView *)playerView {
    if(!_playerView) {
        
        _playerView = [[JVYoutubePlayerView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height)];
        _playerView.backgroundColor = [UIColor clearColor];
        _playerView.delegate = self;
        _playerView.allowLandscapeMode = NO;
        _playerView.forceBackToPortraitMode = YES;
        _playerView.allowAutoResizingPlayerFrame = YES;
        _playerView.fullscreen = YES;
        _playerView.playsinline = NO;
        _playerView.controls = NO;
        _playerView.showinfo = NO;
        _playerView.allowBackgroundPlayback = NO;
    }
    
    return _playerView;
}

- (void)viewDidDisappear:(BOOL)animated {
    
    
}



@end
