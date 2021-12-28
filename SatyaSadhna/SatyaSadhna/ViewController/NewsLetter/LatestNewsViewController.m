//
//  LatestNewsViewController.m
//  SatyaSadhna
//
//  Created by Roshan Bisht on 11/09/17.
//  Copyright © 2017 Roshan Singh Bisht. All rights reserved.
//

#import "LatestNewsViewController.h"
#import "HomeService.h"
#import "NewsLetterYearViewController.h"

@interface LatestNewsViewController ()<UIWebViewDelegate> {
    NSString *stri;
    
}
@property (weak, nonatomic) IBOutlet UIWebView *webView;

@end

@implementation LatestNewsViewController


- (void)newsYear {
    [mserviceHandler.homeService latestNewsletter:^(id response) {
        if ([response[@"status"] boolValue]) {
            NSDateFormatter *dateFormatter = [NSDateFormatter new];
            dateFormatter.dateFormat = @"dd-MM-yyyy";
            NSArray *tempArrray = response[@"page_result"];
            NSArray *array = [tempArrray firstObject];
            NSDictionary *dict = [array lastObject];
            stri = dict[@"data"];
            stri = [stri stringByReplacingOccurrencesOfString:@" " withString:@"%20"];
            [_webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:stri]]];
        }
    } failure:^(NSError * error) {
        [activityIndicatorView stopAnimating];
    }];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    _webView.delegate  = self;
    _webView.opaque = NO;
    _webView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:activityIndicatorView];
    [activityIndicatorView startAnimating];
    [self newsYear];
    
    
    UIButton *btnBack = [UIButton buttonWithType:UIButtonTypeCustom];
    [btnBack setFrame:CGRectMake(0, 0, 85, 30)];
    [btnBack addTarget:self action:@selector(actionLeft:) forControlEvents:UIControlEventTouchUpInside];
    
    [btnBack setTitle:kLangualString(@"Archived") forState:UIControlStateNormal];
    btnBack.layer.borderWidth = 1.0;
    btnBack.layer.borderColor = [UIColor whiteColor].CGColor;
    btnBack.backgroundColor = [UIColor redColor];
    btnBack.layer.cornerRadius = 1.0;
    UIBarButtonItem *barButton =[[UIBarButtonItem alloc] initWithCustomView:btnBack];
    
    
   UIButton *btnHome = [UIButton buttonWithType:UIButtonTypeCustom];
   [btnHome setFrame:CGRectMake(0, 0, 30, 90)];
   [btnHome setImage:[UIImage imageNamed:@"dashboardSlide"] forState:UIControlStateNormal];
   [btnHome addTarget:self action:@selector(actionRightBarButton:) forControlEvents:UIControlEventTouchUpInside];
   UIBarButtonItem *barButton1 =[[UIBarButtonItem alloc] initWithCustomView:btnHome];
   NSArray *arr = @[barButton1,barButton];
   self.navigationItem.rightBarButtonItems = arr;
 

    // Do any additional setup after loading the view.
}

- (void)actionLeft :(UIButton *)sender {
    NewsLetterYearViewController *vc = [MainStoryBoard instantiateViewControllerWithIdentifier:@"newsYearVC"];
    vc.isFromView = @"Newsletter";
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated {
    [self.view setBackgroundColor:kBgImage];
    self.view.layer.contents = (id)[UIImage imageNamed:@"loginBg"].CGImage;
    self.navigationItem.title = kLangualString(@"Latest News");
    if ([_str  isEqualToString:@"news"]) {
        self.addLeftBarBarBackButtonEnabled = YES;
    } else {
        self.addLeftBarMenuButtonEnabled = YES;
        
    }
    _webView.scalesPageToFit = YES;

}

- (void)webViewDidStartLoad:(UIWebView *)webView {
    
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    [activityIndicatorView stopAnimating];
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
    [activityIndicatorView stopAnimating];
}

- (void)actionRightBarButton:(UIButton *)btn {
 
  UIViewController *vc = [MainStoryBoard instantiateViewControllerWithIdentifier:@"homeVC"];
  [self.navigationController pushViewController:vc animated:YES];
}
@end
