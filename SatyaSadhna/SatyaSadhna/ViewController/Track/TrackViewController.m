//
//  TrackViewController.m
//  SatyaSadhna
//
//  Created by Roshan Singh Bisht on 20/05/17.
//  Copyright © 2017 Roshan Singh Bisht. All rights reserved.
//

#import "TrackViewController.h"
#import "HomeService.h"
#import <AVFoundation/AVFoundation.h>
#import "STKAudioPlayer.h"

#define kPrevButton         1
#define kPauseButton        2
#define kNextButton         3

@interface TrackViewController ()<UITableViewDelegate,UITableViewDataSource,AVAudioPlayerDelegate,STKAudioPlayerDelegate> {
    NSMutableArray  *songs;
    NSMutableArray  *songTitle;
    NSMutableArray   *track;
    NSInteger       first;
    NSMutableArray  *songData;
    NSInteger       currentIndex;
    NSIndexPath *selectedRowIndexPath;
   // NSString *navTitle;
}
@property (weak, nonatomic) IBOutlet UILabel        *trackLabel;

@property (weak, nonatomic) IBOutlet UITableView    *tableView;
@property (strong,nonatomic) STKAudioPlayer         *audioPlayer;
@property (weak, nonatomic) IBOutlet UISlider       *seekbar;
@property (weak, nonatomic) IBOutlet UILabel        *durationLabel;
@property (weak, nonatomic) IBOutlet UILabel        *progressLabel;
@property (nonatomic, strong) NSTimer               *updateTimer;
@property (weak, nonatomic) IBOutlet UIButton       *playButton;
@end

@implementation TrackViewController

- (void)gettrack {
    [mserviceHandler.homeService getTrack:^(id response) {
        track = response;
        if (songData.count > 0) {
            songData  = [NSMutableArray new];
        }
        for (NSDictionary *dict in track) {
            if ([dict[_identifiew] boolValue]) {
                [songData addObject:dict] ;
            }
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
    track = [NSMutableArray new];
    songs  = [NSMutableArray new];
    songTitle = [NSMutableArray new];
    songData = [NSMutableArray new];
    [self.view  setBackgroundColor:kBgImage];
    self.view.layer.contents = (id)[UIImage imageNamed:@"loginBg"].CGImage;
    if ([_isFromView isEqualToString:@"track"]) {
        self.addLeftBarBarBackButtonEnabled = YES;
    } else {
        self.addLeftBarMenuButtonEnabled = YES;
    }
    [_tableView setBackgroundColor:[UIColor clearColor]];
    [_tableView setTableFooterView:[UIView new]];
    self.navigationItem.title = kLangualString(_navTitle);
    _audioPlayer = [[STKAudioPlayer alloc] init];
    
    first = 0;
    currentIndex = 0;
    _seekbar.minimumValue = 0.0;
    _durationLabel.text = @"-:-";
    _progressLabel.text = @"-:-";
    _trackLabel.text = @"";
    _seekbar.tintColor = [UIColor darkGrayColor];
    [_trackLabel setText:@"-- - --"];
    [_trackLabel setTextColor:[UIColor whiteColor]];
    
    
    if ([Internet checkNetConnection]) {
        if (mserviceHandler.homeService.trackData.count > 0) {
            [_tableView reloadData];
            track = mserviceHandler.homeService.trackData;
            for (NSDictionary *dict in track) {
                if ([dict[_identifiew] boolValue]) {
                    [songData addObject:dict];
                }
            }
            [self gettrack];
        } else {
            [self.view addSubview:activityIndicatorView];
            [activityIndicatorView startAnimating];
            [self gettrack];
            
        }
    }
    _audioPlayer.delegate = self;
    
    id<GAITracker> tracker = [GAI sharedInstance].defaultTracker;
    [tracker set:kGAIScreenName value:@"TrackView"];
    [tracker send:[[GAIDictionaryBuilder createScreenView] build]];
    
    [[AVAudioSession sharedInstance] setCategory:AVAudioSessionCategoryAmbient error:nil];
    [[AVAudioSession sharedInstance] setActive:YES error:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)viewWillDisappear:(BOOL)animated {
    [_audioPlayer stop];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return songData.count;
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 55;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    UILabel *label = [cell.contentView viewWithTag:2];
    UILabel *countLabel = [cell.contentView viewWithTag:10];
    [cell setBackgroundColor:[UIColor clearColor]];
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    [cell.contentView cornerradius];
    if (songData.count > 0) {
        for (NSDictionary *dict in songData) {
                [songs addObject:dict[@"song"]];
                [songTitle addObject:dict[@"title"]];
            
        }
        [countLabel setText:[NSString stringWithFormat:@"  %ld",(long)indexPath.row + 1]];
        [label setText:[NSString stringWithFormat:@" %@",[songTitle objectAtIndex:indexPath.row]]];
        [label setBackgroundColor:kCelllColor];
        [countLabel setBackgroundColor:kCelllColor];
        
    }
    if (selectedRowIndexPath.row >= 0) {
        [[_tableView cellForRowAtIndexPath:selectedRowIndexPath] setBackgroundColor:[UIColor clearColor]];
        [[_tableView cellForRowAtIndexPath:selectedRowIndexPath] setBackgroundColor:kSelectedCellBGColor];
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *str = [songs objectAtIndex:indexPath.row];
    str = [str stringByReplacingOccurrencesOfString:@" " withString:@"%20"];
    
    currentIndex = indexPath.row;
    [[_tableView cellForRowAtIndexPath:selectedRowIndexPath] setBackgroundColor:[UIColor clearColor]];
    [[_tableView cellForRowAtIndexPath:indexPath] setBackgroundColor:kSelectedCellBGColor];
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
        _seekbar.minimumValue = 0.0;
        _seekbar.maximumValue = audioDurationSeconds / 60;
        dispatch_sync(dispatch_get_main_queue(), ^{
            
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
        case kPrevButton: {
            
            if (_audioPlayer.state == STKAudioPlayerStatePaused || _audioPlayer.state == STKAudioPlayerStatePlaying) {
                
                [_audioPlayer stop];
                _audioPlayer  = [STKAudioPlayer new];
                _audioPlayer.delegate = self;
                
                NSIndexPath *path = [NSIndexPath indexPathForRow:currentIndex inSection:0];
                [[_tableView cellForRowAtIndexPath:path] setBackgroundColor:[UIColor clearColor]];
                
                
                currentIndex = currentIndex - 1;
                
                NSIndexPath *path1 = [NSIndexPath indexPathForRow:currentIndex inSection:0];
                [[_tableView cellForRowAtIndexPath:path1] setBackgroundColor:kSelectedCellBGColor];
                selectedRowIndexPath  = path1;
                
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
                        
                        NSIndexPath *path = [NSIndexPath indexPathForRow:currentIndex inSection:0];
                        [[_tableView cellForRowAtIndexPath:path] setBackgroundColor:[UIColor clearColor]];
                        [_audioPlayer play:str];
                        
                        _playButton.selected = YES;
                        currentIndex = currentIndex - 1;
                    });
                });
            }
            
        }
            break;
            
        case kPauseButton:{
            
            if (_audioPlayer.state == STKAudioPlayerStateReady || _audioPlayer.state == STKAudioPlayerStateRunning) {

            } else if (_audioPlayer.state == STKAudioPlayerStatePaused) {
                _playButton.selected = YES;
                [_audioPlayer resume];
            } else if (_audioPlayer.state == STKAudioPlayerStatePlaying) {
                _playButton.selected = NO;
                [_audioPlayer pause];
            }
            
        } break;
        case kNextButton: if (_audioPlayer.state == STKAudioPlayerStatePaused || _audioPlayer.state == STKAudioPlayerStatePlaying) {
            
            [_audioPlayer stop];
            _audioPlayer  = [STKAudioPlayer new];
            _audioPlayer.delegate = self;
            
            
            // setting the bg color accordingly
            NSIndexPath *path = [NSIndexPath indexPathForRow:currentIndex inSection:0];
            [[_tableView cellForRowAtIndexPath:path] setBackgroundColor:[UIColor clearColor]];
            
            
            currentIndex = currentIndex + 1;
            
            NSIndexPath *path1 = [NSIndexPath indexPathForRow:currentIndex inSection:0];
            [[_tableView cellForRowAtIndexPath:path1] setBackgroundColor:kSelectedCellBGColor];
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
                    
                    NSIndexPath *path = [NSIndexPath indexPathForRow:currentIndex inSection:0];
                    [[_tableView cellForRowAtIndexPath:path] setBackgroundColor:[UIColor clearColor]];
                    [_audioPlayer play:str];
                    _playButton.selected = YES;
                    currentIndex = currentIndex + 1;
                });
            });
        }
    break;
            
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

-(void) audioPlayer:(STKAudioPlayer*)audioPlayer didStartPlayingQueueItemId:(NSObject*)queueItemId{
    
}
/// Raised when an item has finished buffering (may or may not be the currently playing item)
/// This event may be raised multiple times for the same item if seek is invoked on the player
-(void) audioPlayer:(STKAudioPlayer*)audioPlayer didFinishBufferingSourceWithQueueItemId:(NSObject*)queueItemId {
    
}
/// Raised when the state of the player has changed
-(void) audioPlayer:(STKAudioPlayer*)audioPlayer stateChanged:(STKAudioPlayerState)state previousState:(STKAudioPlayerState)previousState {
    [self.view addSubview:activityIndicatorView];
    if (state == STKAudioPlayerStateBuffering) {
        [activityIndicatorView startAnimating];
    } else {
        [activityIndicatorView stopAnimating];
    }
    
}
/// Raised when an item has finished playing
-(void) audioPlayer:(STKAudioPlayer*)audioPlayer didFinishPlayingQueueItemId:(NSObject*)queueItemId withReason:(STKAudioPlayerStopReason)stopReason andProgress:(double)progress andDuration:(double)duration {
    
    if (stopReason == STKAudioPlayerStopReasonNone || stopReason == STKAudioPlayerStopReasonEof) {
        [_audioPlayer stop];
        _audioPlayer  = [STKAudioPlayer new];
        _audioPlayer.delegate = self;
        
        
        // setting the bg color accordingly
        NSIndexPath *path = [NSIndexPath indexPathForRow:currentIndex inSection:0];
        [[_tableView cellForRowAtIndexPath:path] setBackgroundColor:[UIColor clearColor]];
        
        
        currentIndex = currentIndex + 1;
        
        NSIndexPath *path1 = [NSIndexPath indexPathForRow:currentIndex inSection:0];
        [[_tableView cellForRowAtIndexPath:path1] setBackgroundColor:kSelectedCellBGColor];
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
// Raised when an unexpected and possibly unrecoverable error has occured (usually best to recreate the STKAudioPlauyer)


- (void)dealloc {
    _audioPlayer = nil;
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
