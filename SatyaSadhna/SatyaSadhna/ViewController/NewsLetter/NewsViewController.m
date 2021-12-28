//
//  NewsViewController.m
//  SatyaSadhna
//
//  Created by Roshan Singh Bisht on 17/05/17.
//  Copyright © 2017 Roshan Singh Bisht. All rights reserved.
//

#import "NewsViewController.h"
#import "MHWAlertView.h"

@interface NewsViewController ()<UIWebViewDelegate>
@property (weak, nonatomic) IBOutlet UIWebView *webview;

@end

@implementation NewsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setAddRightBarBarBackButtonEnabled:YES];
    _webview.opaque = NO;
    _webview.backgroundColor = [UIColor clearColor];
    if ([Internet checkNetConnection]) {
        [self.view addSubview:activityIndicatorView];
        [activityIndicatorView startAnimating];
     _str = [_str stringByReplacingOccurrencesOfString:@" " withString:@"%20"];
     [_webview loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:_str]]];
    }

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
   
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    [activityIndicatorView stopAnimating];
}
- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
    [activityIndicatorView stopAnimating];
    MHWAlertView *alert = [[MHWAlertView alloc] initWithTitle:@"Alert" message:error.localizedDescription delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    [alert show];
    
}

- (void)viewWillAppear:(BOOL)animated{
    self.navigationItem.title = kLangualString(@"News");
    self.addLeftBarBarBackButtonEnabled = YES;
    [self.view setBackgroundColor:kBgImage];
    self.view.layer.contents = (id)[UIImage imageNamed:@"loginBg"].CGImage;
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
    
      //  UIViewController *vc = [MainStoryBoard instantiateViewControllerWithIdentifier:@"homeVC"];
        [self.navigationController popToRootViewControllerAnimated:YES];
 
}


@end
