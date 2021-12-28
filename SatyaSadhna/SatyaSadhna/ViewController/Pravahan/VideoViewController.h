//
//  VideoViewController.h
//  SatyaSadhna
//
//  Created by Roshan Singh Bisht on 20/05/17.
//  Copyright © 2017 Roshan Singh Bisht. All rights reserved.
//

#import "SatyaSadhnaViewController.h"
#import "JVYoutubePlayerView.h"

@interface VideoViewController : SatyaSadhnaViewController
@property (nonatomic,strong)NSString *videoID;
@property (nonatomic, strong) JVYoutubePlayerView *playerView;
@end
