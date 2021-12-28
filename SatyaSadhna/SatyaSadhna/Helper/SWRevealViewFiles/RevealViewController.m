//
//  RevealViewController.m
//  SatyaSadhna
//
//  Created by Roshan Singh Bisht on 23/04/17.
//  Copyright © 2017 Roshan Singh Bisht. All rights reserved.
//

#import "RevealViewController.h"

@interface RevealViewController ()<SWRevealViewControllerDelegate>

@end

@implementation RevealViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.revealViewController.rightViewRevealOverdraw = 10.0f;
    [self.view addGestureRecognizer:self.panGestureRecognizer];
    
    [self.navigationController.navigationBar addGestureRecognizer:self.revealViewController.panGestureRecognizer];
    [self setupViewControllers];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setupViewControllers {
    self.rearViewRevealWidth = self.view.frame.size.width - self.view.frame.size.width/4;
    self.rearViewRevealOverdraw = 10.0f;
}





@end
