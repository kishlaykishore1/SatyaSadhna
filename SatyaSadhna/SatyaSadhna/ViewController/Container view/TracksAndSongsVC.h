//
//  TracksAndSongsVC.h
//  SatyaSadhna
//
//  Created by kishlay kishore on 16/06/20.
//  Copyright © 2020 Roshan Singh Bisht. All rights reserved.
//


#import "SatyaSadhnaViewController.h"
#import "TrackViewController.h"
#import "SongsViewController.h"
#import "ChoiceViewController.h"

@interface TracksAndSongsVC : SatyaSadhnaViewController

@property (weak, nonatomic) IBOutlet UISegmentedControl *segmentControll;
@property (weak, nonatomic) IBOutlet UIView *trackscontainerView;


@end
ChoiceViewController* VC1;
SongsViewController* VC2;
UIViewController *current_controller;
