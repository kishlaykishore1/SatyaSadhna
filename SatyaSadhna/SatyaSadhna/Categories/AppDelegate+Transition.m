//
//  AppDelegate+Transition.m
//  SatyaSadhna
//
//  Created by Roshan Singh Bisht on 23/04/17.
//  Copyright © 2017 Roshan Singh Bisht. All rights reserved.
//

#import "AppDelegate+Transition.h"
#import "SlideMenuViewController.h"
#import "RevealViewController.h"
#import "UserDefaultManager.h"
#import "LoginViewController.h"

@implementation AppDelegate (Transition)


- (void)transitionToSlideMenu {
    RevealViewController *slideVC = [RevealViewController new];
    UIViewController  *Homevc = [MainStoryBoard instantiateViewControllerWithIdentifier:@"homeVC"];
    UINavigationController *navFront = [[UINavigationController alloc] initWithRootViewController:Homevc];
    UIViewController *moreOptionVC = [MainStoryBoard instantiateViewControllerWithIdentifier:@"slideVC"];
    
    navFront.navigationBar.barTintColor = RGB(244, 180, 101);
    
    navFront.navigationController.navigationBar.translucent = YES;
    
    slideVC.frontViewController = navFront;
    slideVC.rearViewController = moreOptionVC;
    self.window.rootViewController = slideVC;
    [UIView transitionWithView:self.window
                      duration:0.9
                       options:UIViewAnimationOptionTransitionFlipFromTop
                    animations:^{ self.window.rootViewController = slideVC; }
                    completion:nil];
}

- (void)login {
    RevealViewController *slideVC = [RevealViewController new];
    UIViewController  *Homevc = [MainStoryBoard instantiateViewControllerWithIdentifier:@"homeVC"];
    UINavigationController *navFront = [[UINavigationController alloc] initWithRootViewController:Homevc];
    UIViewController *moreOptionVC = [MainStoryBoard instantiateViewControllerWithIdentifier:@"slideVC"];
    
    navFront.navigationBar.barTintColor = RGB(244, 180, 101);
    
    navFront.navigationController.navigationBar.translucent = YES;
    
    slideVC.frontViewController = navFront;
    slideVC.rearViewController = moreOptionVC;
    self.window.rootViewController = slideVC;
    [UIView transitionWithView:self.window
                      duration:0.9
                       options:UIViewAnimationOptionTransitionFlipFromTop
                    animations:^{ self.window.rootViewController = slideVC; }
                    completion:nil];
}

- (void)transitionToLoginFromVC:(UIViewController *)vc {
    
    [UserDefaultManager setUserID:nil];
    [UserDefaultManager setMobileNo:nil];
    [UserDefaultManager setEmailID:nil];
    [UserDefaultManager setUserName:nil];
    [self.window endEditing:YES];
    LoginViewController *login = [MainStoryBoard instantiateViewControllerWithIdentifier:@"loginVC"];
    UINavigationController *nav= [[UINavigationController alloc]initWithRootViewController:login];
    [self transitionWithNavigation:nav fromVC:vc];
}

- (void)transitionWithNavigation:(UINavigationController *)nav fromVC:(UIViewController *)vc{
    nav.navigationBar.barTintColor = [UIColor blackColor];
    nav.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName: [UIColor whiteColor]};
    if (@available(iOS 13.0, *)) {
        [nav setModalPresentationStyle: UIModalPresentationFullScreen];
    }
    [vc presentViewController:nav animated:YES completion:nil];
}
@end
