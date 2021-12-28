//
//  SongsViewController.m
//  SatyaSadhna
//
//  Created by Roshan Singh Bisht on 06/05/17.
//  Copyright © 2017 Roshan Singh Bisht. All rights reserved.
//

#import "SongsViewController.h"
#import "HomeService.h"
#import <AVFoundation/AVFoundation.h>
#import "STKAudioPlayer.h"

#define kPlayPauseButtonPressed         2
#define PrevButton                      1
#define kNextButton                     3

@interface SongsViewController ()<UITableViewDelegate,UITableViewDataSource,AVAudioPlayerDelegate,STKAudioPlayerDelegate,STKDataSourceDelegate> {
    NSArray         *songsArray;
    NSMutableArray  *songs;
    NSMutableArray  *songTitle;
    NSInteger       first;
    NSInteger       currentIndex;
    NSIndexPath *selectedRowIndexPath;
    
}
@property (weak, nonatomic) IBOutlet UITableView *songsTableView;
@property (strong,nonatomic) STKAudioPlayer         *audioPlayer;
@property (strong,nonatomic)AVPlayer                *player;
@property (weak, nonatomic) IBOutlet UIButton       *prevButton;
@property (weak, nonatomic) IBOutlet UIButton       *playButton;
@property (weak, nonatomic) IBOutlet UIButton       *nextButton;
@property (weak, nonatomic) IBOutlet UIView         *songsView;
@property (nonatomic, weak) IBOutlet UISlider       *seekbar;
@property (nonatomic, strong) NSTimer               *updateTimer;
@property (weak, nonatomic) IBOutlet UILabel *trackLabel;
@property (weak, nonatomic) IBOutlet UILabel *progressLabel;
@property (weak, nonatomic) IBOutlet UILabel *durationLabel;

@end

@implementation SongsViewController

- (void)getData {
    if (mserviceHandler.homeService.songsData.count > 0) {
        songsArray = mserviceHandler.homeService.songsData;
        [_songsTableView reloadData];
        [mserviceHandler.homeService songs:^(id response) {
            songsArray = response;
            
        } failure:^(NSError *error) {
            [Utils showAlertMessage:error.localizedDescription withTitle:@"Alert"];
        }];
        
    } else {
        [self.view addSubview:activityIndicatorView];
        [activityIndicatorView startAnimating];
        [mserviceHandler.homeService songs:^(id response) {
            songsArray = response;
            [activityIndicatorView stopAnimating];
            [_songsTableView reloadData];
        } failure:^(NSError *error) {
            [activityIndicatorView stopAnimating];
        }];
    }
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    songs = [NSMutableArray new];
    songTitle = [NSMutableArray new];
    [_songsTableView setBackgroundColor:[UIColor clearColor]];
    [self getData];
    _audioPlayer = [[STKAudioPlayer alloc] init];
    _audioPlayer.delegate = self;
    
    first = 0;
    currentIndex = 0;
    _seekbar.minimumValue = 0.0;
    _durationLabel.text = @"-:-";
    _progressLabel.text = @"-:-";
    _trackLabel.text = @"";
    _seekbar.tintColor = [UIColor darkGrayColor];
    [_trackLabel setText:@"-- - --"];
    [_trackLabel setTextColor:[UIColor whiteColor]];
    _playButton.selected = NO;
    [self.view addSubview:activityIndicatorView];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated {
    self.addLeftBarBarBackButtonEnabled = YES;
    [self.view setBackgroundColor:kBgImage];
    self.view.layer.contents = (id)[UIImage imageNamed:@"loginBg"].CGImage;
    [_songsTableView setBackgroundColor:[UIColor clearColor]];
    [_songsTableView setTableFooterView:[UIView new]];
    [_songsView setBackgroundColor:kBgImage];
    _songsView.layer.contents = (id)[UIImage imageNamed:@"loginBg"].CGImage;
    self.navigationItem.title = kLangualString(@"Tracks & Songs");
}

- (void)viewWillDisappear:(BOOL)animated {
    [_audioPlayer stop];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return songsArray.count;
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 70;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    UILabel *label = [cell.contentView viewWithTag:2];
    UILabel *countLabel = [cell.contentView viewWithTag:4];
    
    [cell setBackgroundColor:[UIColor clearColor]];
    [cell.contentView cornerradius];
//    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
//    [view setBackgroundColor:RGB(228, 78, 107)];
//    cell.selectedBackgroundView = view;
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    
    if (selectedRowIndexPath.row >= 0) {
        [[_songsTableView cellForRowAtIndexPath:selectedRowIndexPath] setBackgroundColor:[UIColor clearColor]];
        [[_songsTableView cellForRowAtIndexPath:selectedRowIndexPath] setBackgroundColor:kSelectedCellBGColor];
    }
    
    if (songs.count > 0) {
        songs  = [NSMutableArray new];
        songTitle = [NSMutableArray new];
    }
    if (songsArray.count > 0) {
        for (NSDictionary *dict in songsArray) {
            [songs addObject:dict[@"song"]];
            [songTitle addObject:dict[@"title"]];
        }
        [label setBackgroundColor:kCelllColor];
        [countLabel setBackgroundColor:kCelllColor];
        [countLabel setText:[NSString stringWithFormat:@"%ld",(long)indexPath.row + 1]];
        [label setText:[NSString stringWithFormat:@"   %@",[songTitle objectAtIndex:indexPath.row]]];
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *str = [songs objectAtIndex:indexPath.row];
    str = [str stringByReplacingOccurrencesOfString:@" " withString:@"%20"];
    
    
    currentIndex = indexPath.row;
    
    [[_songsTableView cellForRowAtIndexPath:selectedRowIndexPath] setBackgroundColor:[UIColor clearColor]];
    [[_songsTableView cellForRowAtIndexPath:indexPath] setBackgroundColor:kSelectedCellBGColor];
    
    selectedRowIndexPath = indexPath;
    if ( _audioPlayer.state  ==  STKAudioPlayerStatePlaying) {
        [_audioPlayer stop];
        _audioPlayer  = [STKAudioPlayer new];
        _audioPlayer.delegate = self;
        [activityIndicatorView startAnimating];
        
    }
    
    _playButton.selected = YES;
    
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0ul);
    dispatch_async(queue, ^{
        
        AVURLAsset* audioAsset = [AVURLAsset URLAssetWithURL:[NSURL URLWithString:str] options:nil];
        CMTime audioDuration = audioAsset.duration;
        float audioDurationSeconds = CMTimeGetSeconds(audioDuration);
        
        dispatch_sync(dispatch_get_main_queue(), ^{
            _seekbar.minimumValue = 0.0;
            _seekbar.maximumValue = audioDurationSeconds / 60;
            self.updateTimer =     [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(updateSeekBar) userInfo:nil repeats:YES];
            _durationLabel.text = [NSString stringWithFormat:@"%.2f",audioDurationSeconds / 60];
            [_trackLabel setText:[songTitle objectAtIndex:indexPath.row]];
            [activityIndicatorView stopAnimating];
            [_audioPlayer play:str];
        });
    });
    

    

}

- (void)updateSeekBar{
    double pro = _audioPlayer.progress / 60;
    float progress = pro;
    [self.seekbar setValue:progress];
    _progressLabel.text = [NSString stringWithFormat:@"%.2f",pro];
    
}
- (IBAction)playaction:(UIButton *)sender {
    
    switch (sender.tag) {
        case kPlayPauseButtonPressed:{
            if (currentIndex > 0) {
                if (_playButton.selected == YES) {
                    _playButton.selected  = NO;
                    [_audioPlayer pause];
                } else {
                    _playButton.selected = YES;
                    [_audioPlayer resume];
                }
            } else if(currentIndex == 0) {
                if (_playButton.selected == NO) {
                    _playButton.selected = YES;
                    NSString *str = [songs objectAtIndex:currentIndex];
                    
//                    NSIndexPath *path = [NSIndexPath indexPathForRow:currentIndex inSection:0];
//                    [[_songsTableView cellForRowAtIndexPath:path] setBackgroundColor:kSelectedCellBGColor];

                    
                    str = [str stringByReplacingOccurrencesOfString:@" " withString:@"%20"];
                    if (STKAudioPlayerStatePlaying) {
                        [_audioPlayer stop];
                    }
                    [_trackLabel setText:[songTitle objectAtIndex:currentIndex]];
                    AVURLAsset* audioAsset = [AVURLAsset URLAssetWithURL:[NSURL URLWithString:str] options:nil];
                    CMTime audioDuration = audioAsset.duration;
                    float audioDurationSeconds = CMTimeGetSeconds(audioDuration);
                    _seekbar.minimumValue = 0.0;
                    _seekbar.maximumValue = audioDurationSeconds / 60;
                    self.updateTimer =     [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(updateSeekBar) userInfo:nil repeats:YES];
                    _durationLabel.text = [NSString stringWithFormat:@"%.2f",audioDurationSeconds / 60];
                    [_audioPlayer play:str];
                    
                } else if (_playButton.selected == YES){
                    _playButton.selected = NO;
                    [_audioPlayer pause];
                }
                
            }
            
        } break;
        case kNextButton: {
            // The Audio Player is running a track
            if (_audioPlayer.state == STKAudioPlayerStatePlaying || _audioPlayer.state == STKAudioPlayerStatePaused) {
                [_audioPlayer stop];
                _audioPlayer  = [STKAudioPlayer new];
                _audioPlayer.delegate = self;
                
                
                // setting the bg color accordingly
                NSIndexPath *path = [NSIndexPath indexPathForRow:currentIndex inSection:0];
                [[_songsTableView cellForRowAtIndexPath:path] setBackgroundColor:[UIColor clearColor]];
                

                currentIndex = currentIndex + 1;
                
                NSIndexPath *path1 = [NSIndexPath indexPathForRow:currentIndex inSection:0];
                [[_songsTableView cellForRowAtIndexPath:path1] setBackgroundColor:kSelectedCellBGColor];
                selectedRowIndexPath = path1;
                
                
                
                NSString *str = [songs objectAtIndex:currentIndex];
                str = [str stringByReplacingOccurrencesOfString:@" " withString:@"%20"];
                [_trackLabel setText:[songTitle objectAtIndex:currentIndex]];
                
                
                
                
                dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0ul);
                dispatch_async(queue, ^{
                    AVURLAsset* audioAsset = [AVURLAsset URLAssetWithURL:[NSURL URLWithString:str] options:nil];
                    CMTime audioDuration = audioAsset.duration;
                    float audioDurationSeconds = CMTimeGetSeconds(audioDuration);
                    _seekbar.minimumValue = 0.0;
                    _seekbar.maximumValue = audioDurationSeconds / 60;
                    dispatch_sync(dispatch_get_main_queue(), ^{
                        self.updateTimer =     [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(updateSeekBar) userInfo:nil repeats:YES];
                        _durationLabel.text = [NSString stringWithFormat:@"%.2f",audioDurationSeconds / 60];
                        
                        [_audioPlayer play:str];
                        _playButton.selected = YES;
                    });
                });
                
            } else if(_audioPlayer.state == STKAudioPlayerStateRunning || _audioPlayer.state == STKAudioPlayerStateReady) {
                
                
                NSString *str = [songs objectAtIndex:currentIndex];
                str = [str stringByReplacingOccurrencesOfString:@" " withString:@"%20"];
                [_trackLabel setText:[songTitle objectAtIndex:currentIndex]];
                
                
                dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0ul);
                dispatch_async(queue, ^{
                    AVURLAsset* audioAsset = [AVURLAsset URLAssetWithURL:[NSURL URLWithString:str] options:nil];
                    CMTime audioDuration = audioAsset.duration;
                    float audioDurationSeconds = CMTimeGetSeconds(audioDuration);
                    _seekbar.minimumValue = 0.0;
                    _seekbar.maximumValue = audioDurationSeconds / 60;
                    
                    dispatch_sync(dispatch_get_main_queue(), ^{
                        self.updateTimer =     [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(updateSeekBar) userInfo:nil repeats:YES];
                        _durationLabel.text = [NSString stringWithFormat:@"%.2f",audioDurationSeconds / 60];
                        
//                        NSIndexPath *index = [NSIndexPath indexPathForRow:currentIndex inSection:0];
//                        UITableViewCell *cell = [_songsTableView cellForRowAtIndexPath:index];
//                        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
//                        [view setBackgroundColor:kCelllColor];
//                        cell.selectedBackgroundView = view;
//                        [cell setSelected:YES animated:YES];
                        
                        NSIndexPath *path = [NSIndexPath indexPathForRow:currentIndex inSection:0];
                        [[_songsTableView cellForRowAtIndexPath:path] setBackgroundColor:[UIColor clearColor]];

                        [_audioPlayer play:str];
                        _playButton.selected = YES;
                        currentIndex = currentIndex + 1;
                    });
                });
            }
            

            
        } break;
        case PrevButton:{
            
            {
                // The Audio Player is running a track
                if (_audioPlayer.state == STKAudioPlayerStatePlaying || _audioPlayer.state == STKAudioPlayerStatePaused) {
                    [_audioPlayer stop];
                    _audioPlayer  = [STKAudioPlayer new];
                    _audioPlayer.delegate = self;
                    
                    
//                    NSIndexPath *index = [NSIndexPath indexPathForRow:currentIndex inSection:0];
//                    UITableViewCell *cell = [_songsTableView cellForRowAtIndexPath:index];
//                    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
//                    [view setBackgroundColor:kCelllColor];
//                    cell.selectedBackgroundView = view;
//                    [cell setSelected:YES animated:YES];
                    
                    NSIndexPath *path = [NSIndexPath indexPathForRow:currentIndex inSection:0];
                    [[_songsTableView cellForRowAtIndexPath:path] setBackgroundColor:[UIColor clearColor]];

                    
                    currentIndex = currentIndex - 1;
                    
                    NSIndexPath *path1 = [NSIndexPath indexPathForRow:currentIndex inSection:0];
                    [[_songsTableView cellForRowAtIndexPath:path1] setBackgroundColor:kSelectedCellBGColor];
                    selectedRowIndexPath  = path1;

                    NSString *str = [songs objectAtIndex:currentIndex];
                    str = [str stringByReplacingOccurrencesOfString:@" " withString:@"%20"];
                    [_trackLabel setText:[songTitle objectAtIndex:currentIndex]];
                    
//                    NSIndexPath *index1 = [NSIndexPath indexPathForRow:currentIndex inSection:0];
//                    UITableViewCell *cell1 = [_songsTableView cellForRowAtIndexPath:index1];
//                    UIView *view1 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
//                    [view1 setBackgroundColor:RGB(228, 78, 107)];
//                    cell1.selectedBackgroundView = view1;
//                    [cell1 setSelected:YES animated:YES];
                    
                    
                    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0ul);
                    dispatch_async(queue, ^{
                        AVURLAsset* audioAsset = [AVURLAsset URLAssetWithURL:[NSURL URLWithString:str] options:nil];
                        CMTime audioDuration = audioAsset.duration;
                        float audioDurationSeconds = CMTimeGetSeconds(audioDuration);
                        _seekbar.minimumValue = 0.0;
                        _seekbar.maximumValue = audioDurationSeconds / 60;
                        dispatch_sync(dispatch_get_main_queue(), ^{
                            self.updateTimer =     [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(updateSeekBar) userInfo:nil repeats:YES];
                            _durationLabel.text = [NSString stringWithFormat:@"%.2f",audioDurationSeconds / 60];
                            
                            [_audioPlayer play:str];
                            _playButton.selected = YES;
                        });
                    });
                    
                } else if(_audioPlayer.state == STKAudioPlayerStateRunning || _audioPlayer.state == STKAudioPlayerStateReady) {
                    
                    
                    NSString *str = [songs objectAtIndex:currentIndex];
                    str = [str stringByReplacingOccurrencesOfString:@" " withString:@"%20"];
                    [_trackLabel setText:[songTitle objectAtIndex:currentIndex]];
                    
                    
                    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0ul);
                    dispatch_async(queue, ^{
                        AVURLAsset* audioAsset = [AVURLAsset URLAssetWithURL:[NSURL URLWithString:str] options:nil];
                        CMTime audioDuration = audioAsset.duration;
                        float audioDurationSeconds = CMTimeGetSeconds(audioDuration);
                        _seekbar.minimumValue = 0.0;
                        _seekbar.maximumValue = audioDurationSeconds / 60;
                        
                        dispatch_sync(dispatch_get_main_queue(), ^{
                            self.updateTimer =     [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(updateSeekBar) userInfo:nil repeats:YES];
                            _durationLabel.text = [NSString stringWithFormat:@"%.2f",audioDurationSeconds / 60];
                            
//                            NSIndexPath *index = [NSIndexPath indexPathForRow:currentIndex inSection:0];
//                            UITableViewCell *cell = [_songsTableView cellForRowAtIndexPath:index];
//                            UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
//                            [view setBackgroundColor:kCelllColor];
//                            cell.selectedBackgroundView = view;
//                            [cell setSelected:YES animated:YES];
                            
                            NSIndexPath *path = [NSIndexPath indexPathForRow:currentIndex inSection:0];
                            [[_songsTableView cellForRowAtIndexPath:path] setBackgroundColor:[UIColor clearColor]];

                            [_audioPlayer play:str];
                            _playButton.selected = YES;
                            currentIndex = currentIndex - 1;
                        });
                    });
                }


            }
        } break;
        default:
            break;
    }
}

- (void)slide {
    
}
- (IBAction)seek:(UISlider *)sender {
    if (_audioPlayer.state == STKAudioPlayerStatePlaying) {
        double d = sender.value * 60;
        [_audioPlayer seekToTime:d];
    }
}

- (void)viewDidAppear:(BOOL)animated {
    [self.view updateViewWithApplicationGlobalFont];
}

-(void) audioPlayer:(STKAudioPlayer*)audioPlayer didStartPlayingQueueItemId:(NSObject*)queueItemId{
    
}
/// Raised when an item has finished buffering (may or may not be the currently playing item)
/// This event may be raised multiple times for the same item if seek is invoked on the player
-(void) audioPlayer:(STKAudioPlayer*)audioPlayer didFinishBufferingSourceWithQueueItemId:(NSObject*)queueItemId {
    
}
/// Raised when the state of the player has changed
-(void) audioPlayer:(STKAudioPlayer*)audioPlayer stateChanged:(STKAudioPlayerState)state previousState:(STKAudioPlayerState)previousState {
    if (state == STKAudioPlayerStateBuffering) {
        [activityIndicatorView startAnimating];
    } else {
        [activityIndicatorView stopAnimating];
    }
    
}
/// Raised when an item has finished playing
-(void) audioPlayer:(STKAudioPlayer*)audioPlayer didFinishPlayingQueueItemId:(NSObject*)queueItemId withReason:(STKAudioPlayerStopReason)stopReason andProgress:(double)progress andDuration:(double)duration {
    
    if (stopReason == STKAudioPlayerStopReasonNone || stopReason ==  STKAudioPlayerStopReasonEof) {
        [_audioPlayer stop];
        _audioPlayer  = [STKAudioPlayer new];
        _audioPlayer.delegate = self;
        
        
        // setting the bg color accordingly
        NSIndexPath *path = [NSIndexPath indexPathForRow:currentIndex inSection:0];
        [[_songsTableView cellForRowAtIndexPath:path] setBackgroundColor:[UIColor clearColor]];
        
        
        currentIndex = currentIndex + 1;
        
        NSIndexPath *path1 = [NSIndexPath indexPathForRow:currentIndex inSection:0];
        [[_songsTableView cellForRowAtIndexPath:path1] setBackgroundColor:kSelectedCellBGColor];
        selectedRowIndexPath = path1;
        
        
        
        NSString *str = [songs objectAtIndex:currentIndex];
        str = [str stringByReplacingOccurrencesOfString:@" " withString:@"%20"];
        [_trackLabel setText:[songTitle objectAtIndex:currentIndex]];
        
        
        
        
        dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0ul);
        dispatch_async(queue, ^{
            AVURLAsset* audioAsset = [AVURLAsset URLAssetWithURL:[NSURL URLWithString:str] options:nil];
            CMTime audioDuration = audioAsset.duration;
            float audioDurationSeconds = CMTimeGetSeconds(audioDuration);
            _seekbar.minimumValue = 0.0;
            _seekbar.maximumValue = audioDurationSeconds / 60;
            dispatch_sync(dispatch_get_main_queue(), ^{
                self.updateTimer =     [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(updateSeekBar) userInfo:nil repeats:YES];
                _durationLabel.text = [NSString stringWithFormat:@"%.2f",audioDurationSeconds / 60];
                
                [_audioPlayer play:str];
                _playButton.selected = YES;
            });
        });
 
    }
}


@end
