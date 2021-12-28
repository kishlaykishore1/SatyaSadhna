//
//  NewDonationFormViewController.m
//  SatyaSadhna
//
//  Created by Roshan Bisht on 15/02/18.
//  Copyright © 2018 Roshan Singh Bisht. All rights reserved.
//
#import <UIKit/UIKit.h>
#import "NewDonationFormViewController.h"
#import "HomeService.h"
#import "Constants.h"

@interface NewDonationFormViewController ()<UIWebViewDelegate>
{
  NSString *strin;
}
@property (weak, nonatomic) IBOutlet UIWebView *webView;
@property (strong, nonatomic) UIButton *donateButton;
@property (weak, nonatomic) IBOutlet UIButton *btnDonate;


@end

@implementation NewDonationFormViewController


- (void)load {
  [mserviceHandler.homeService bankDetailHindi:^(id response) {
    strin = response;
    [_webView loadHTMLString:strin baseURL:nil];
  } failure:^(NSError *error) {
    [activityIndicatorView stopAnimating];
  }];
}


- (void)viewDidLoad {
  [super viewDidLoad];
  [self setAddRightBarBarBackButtonEnabled:YES];
  //strin = @"";
  self.navigationItem.title = kLangualString(@"Donation");
  self.addLeftBarBarBackButtonEnabled = YES;
  _webView.opaque = NO;
  _btnDonate.layer.cornerRadius = 8.0;
  [_btnDonate setTitle:kLangualString(@"Donate") forState:UIControlStateNormal];
  [self.view setBackgroundColor:kBgImage];
  self.view.layer.contents = (id)[UIImage imageNamed:@"loginBg"].CGImage;
}

- (void)viewWillAppear:(BOOL)animated{
  
  [self.view addSubview:activityIndicatorView];
  [activityIndicatorView startAnimating];
  //  if (mserviceHandler.homeService.bankdetaildata.length > 0 && mserviceHandler.homeService.bankdetaildata != nil) {
  //      strin = mserviceHandler.homeService.bankdetaildata;
  //      [_webView loadHTMLString:strin baseURL:nil];
  [self load];
  //  } else {
  //      [activityIndicatorView startAnimating];
  //      [self load];
  //  }
}


- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}

- (void)webViewDidStartLoad:(UIWebView *)webView {
  
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
  [activityIndicatorView stopAnimating];
  CGFloat contentHeight = webView.scrollView.contentSize.height;
  [_donateButton addTarget:self action:@selector(payButton:) forControlEvents:UIControlEventTouchUpInside];
  [_donateButton setFrame:CGRectMake(20, contentHeight - 50 ,[UIScreen mainScreen].bounds.size.width - 40, 50)];
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
  [activityIndicatorView stopAnimating];
}

- (IBAction)btnDonate_Action:(UIButton *)sender {
  UIViewController *vc = [SecondStoryBoard instantiateViewControllerWithIdentifier:@"panViewVC"];
  [self.navigationController pushViewController:vc animated:YES];
}


- (void)payButton:(UIButton *)sender {
  UIViewController *vc = [SecondStoryBoard instantiateViewControllerWithIdentifier:@"panViewVC"];
  [self.navigationController pushViewController:vc animated:YES];
}

//MARK: Add Right Navigation Bar Button
- (void)setAddRightBarBarBackButtonEnabled:(BOOL)addRightBarBarBackButtonEnabled {
  //This is for add Right button
  UIButton *btnBack = [UIButton buttonWithType:UIButtonTypeCustom];
  [btnBack setFrame:CGRectMake(0, 0, 30, 90)];
  [btnBack setImage:[UIImage imageNamed:@"dashboardSlide"] forState:UIControlStateNormal];
  [btnBack addTarget:self action:@selector(actionRightBarButton:) forControlEvents:UIControlEventTouchUpInside];
  UIBarButtonItem *barButton =[[UIBarButtonItem alloc] initWithCustomView:btnBack];
  self.navigationItem.rightBarButtonItem = barButton;
}

- (void)actionRightBarButton:(UIButton *)btn {
  
  [self.navigationController popToRootViewControllerAnimated:true];
  
}

@end
