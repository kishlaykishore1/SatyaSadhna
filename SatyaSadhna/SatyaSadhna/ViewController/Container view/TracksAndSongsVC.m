//
//  TracksAndSongsVC.m
//  SatyaSadhna
//
//  Created by kishlay kishore on 16/06/20.
//  Copyright © 2020 Roshan Singh Bisht. All rights reserved.
//

#import "TracksAndSongsVC.h"

@interface TracksAndSongsVC ()
    
@end


@implementation TracksAndSongsVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
   VC1 = [MainStoryBoard instantiateViewControllerWithIdentifier:@"choiceVC"];
   VC2 = [MainStoryBoard instantiateViewControllerWithIdentifier:@"songsVC"];
    // Do any additional setup after loading the view.
    [self bindToViewController:VC1];
    [self setAddRightBarBarBackButtonEnabled:YES];
}

- (void)viewWillAppear:(BOOL)animated {
    _segmentControll.selectedSegmentIndex = 0;
    [_segmentControll setTitle:kLangualString(@"Tracks") forSegmentAtIndex:0];
    [_segmentControll setTitle:kLangualString(@"Songs") forSegmentAtIndex:1];
    self.addLeftBarBarBackButtonEnabled = YES;
    [self.view setBackgroundColor:kBgImage];
    self.view.layer.contents = (id)[UIImage imageNamed:@"loginBg"].CGImage;
    self.navigationItem.title = kLangualString(@"Tracks & Songs");
}

-(void)removeViewController{
    [current_controller.view removeFromSuperview];
    [current_controller removeFromParentViewController];
}


-(void)bindToViewController: (UIViewController*)target_ViewController{
    if (current_controller != nil){
        [self removeViewController];
    }
    [self addChildViewController:target_ViewController];
    target_ViewController.view.frame = CGRectMake(0, 0, self.trackscontainerView.frame.size.width, self.trackscontainerView.frame.size.height);
    //target_ViewController.view.frame = _trackscontainerView.frame;
    [_trackscontainerView addSubview:target_ViewController.view];
    current_controller = target_ViewController;
}

-(IBAction)segmentAction:(UISegmentedControl*)sender {
    
    if(sender.selectedSegmentIndex == 0){
        [self bindToViewController:VC1];
    }
    else{
        [self bindToViewController:VC2];
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
 
    [self.navigationController popToRootViewControllerAnimated:true];
}

@end

