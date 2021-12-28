//
//  SatyaSadhnaViewController.m
//  SatyaSadhna
//
//  Created by Roshan Singh Bisht on 22/04/17.
//  Copyright © 2017 Roshan Singh Bisht. All rights reserved.
//

#import "SatyaSadhnaViewController.h"
#import "RevealViewController.h"
#import <SDWebImage/SDImageCache.h>



@interface SatyaSadhnaViewController ()

@end

@implementation SatyaSadhnaViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    mserviceHandler = [ServiceHandler sharedInstance];
    activityIndicatorView = [[DGActivityIndicatorView alloc] initWithType:DGActivityIndicatorAnimationTypeDoubleBounce tintColor:[UIColor whiteColor] size:60.0f];
    activityIndicatorView.frame = CGRectMake(self.view.frame.size.width / 2 - 40, self.view.frame.size.height / 2 - 40, 80.0f, 80.0f);
}
    
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setNavigationBarMakeTransparent:(BOOL)navigationBarMakeTransparent {
    if (navigationBarMakeTransparent) {
        [self.navigationController.navigationBar setBackgroundImage:[UIImage new]
                                                      forBarMetrics:UIBarMetricsDefault];
        self.navigationController.navigationBar.translucent = YES;
        self.navigationController.navigationBar.shadowImage = [UIImage new];
        self.navigationController.navigationBar.backgroundColor = [UIColor clearColor];
    } else {
        self.navigationController.navigationBar.translucent = YES;
        self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName: RGB(244, 180, 101)};
    }
}

- (void)setAddLeftBarBarBackButtonEnabled:(BOOL)addLeftBarBarBackButtonEnabled {
    //This is for add back button and it should be called from viewWillAppear
    if (addLeftBarBarBackButtonEnabled) {
        UIButton *btnBack = [UIButton buttonWithType:UIButtonTypeCustom];
        [btnBack setFrame:CGRectMake(0, 0, 20, 20)];
        [btnBack setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
        [btnBack addTarget:self action:@selector(actionLeftBarButton:) forControlEvents:UIControlEventTouchUpInside];
        UIBarButtonItem *barButton =[[UIBarButtonItem alloc] initWithCustomView:btnBack];
        self.navigationItem.leftBarButtonItem = barButton;
    } else {
        [self.navigationItem setHidesBackButton:YES];
    }
    
}
- (void)actionLeftBarButton:(UIButton*)sender {
    UIViewController *topController = [UIApplication sharedApplication].keyWindow.rootViewController;
    [topController.view endEditing:YES];
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)setAddLeftBarMenuButtonEnabled:(BOOL)addLeftBarMenuButtonEnabled {
    if (addLeftBarMenuButtonEnabled) {
        UIButton *btnMenu = [UIButton buttonWithType:UIButtonTypeCustom];
        [btnMenu setFrame:CGRectMake(0, 0, 19, 16)];
        [btnMenu setImage:[UIImage imageNamed:@"menubar"] forState:UIControlStateNormal];
        [btnMenu addTarget:self action:@selector(actionLeftMenuBarButton) forControlEvents:UIControlEventTouchUpInside];
        UIBarButtonItem *barButton = [[UIBarButtonItem alloc] initWithCustomView:btnMenu];
        self.navigationItem.leftBarButtonItem = barButton;
    } else {
        [self.navigationItem setHidesBackButton:YES];
    }
}

- (void)actionLeftMenuBarButton {
    [self.revealViewController revealToggleAnimated:YES];
}




@end
