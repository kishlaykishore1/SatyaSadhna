//
//  IntroductionViewController.m
//  SatyaSadhna
//
//  Created by Roshan Singh Bisht on 20/05/17.
//  Copyright © 2017 Roshan Singh Bisht. All rights reserved.
//

#import "IntroductionViewController.h"
#import "HomeService.h"

@interface IntroductionViewController ()<UIWebViewDelegate> {
    NSString *strin;
}
@property (weak, nonatomic) IBOutlet UIWebView *webView;

@end

@implementation IntroductionViewController
@synthesize isFromView,currentView;

- (void)load {
    [mserviceHandler.homeService introduction:^(id response) {
            strin = response;
        [_webView loadHTMLString:strin baseURL:nil];
    } failure:^(NSError *error) {
        [activityIndicatorView stopAnimating];
    }];
}

- (void)loadguide {
    [mserviceHandler.homeService guideline:^(id response) {
        strin = response;
        [_webView loadHTMLString:strin baseURL:nil];
    } failure:^(NSError *error) {
        [activityIndicatorView stopAnimating];
    }];
}

-(void)loadafer {
    [mserviceHandler.homeService afterTheCourse:^(id response) {
        strin = response;
        [_webView loadHTMLString:strin baseURL:nil];
    } failure:^(NSError *error) {
        [activityIndicatorView stopAnimating];
    }];
}
-(void)loadBuffer {
    [mserviceHandler.homeService brochureApi:^(id response) {
        strin = response;
      strin = [strin stringByReplacingOccurrencesOfString:@" " withString:@"%20"];
      [_webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:strin]]];
    } failure:^(NSError *error) {
        [activityIndicatorView stopAnimating];
    }];
}
- (void)viewDidLoad {
    [super viewDidLoad];
   
    [self setAddRightBarBarBackButtonEnabled:YES];
    _webView.backgroundColor = [UIColor clearColor];
    if ([Internet checkNetConnection]) {
        [self.view addSubview:activityIndicatorView];
        
        if ([currentView isEqualToString:@"Guidelines"]) {
            self.navigationItem.title = kLangualString(@"Guidelines");
            if (mserviceHandler.homeService.guidelinedata.length > 0 && mserviceHandler.homeService.guidelinedata != nil) {
                strin = mserviceHandler.homeService.guidelinedata;
                [_webView loadHTMLString:strin baseURL:nil];
                [self loadguide];
            } else {
                [activityIndicatorView startAnimating];
                [self loadguide];
            }
            
        }else if([currentView isEqualToString:@"Introduction"]) {
                self.navigationItem.title = kLangualString(@"Introduction");
            if (mserviceHandler.homeService.introData.length > 0 && mserviceHandler.homeService.introData != nil) {
                strin = mserviceHandler.homeService.introData;
                [_webView loadHTMLString:strin baseURL:nil];
                [self load];
            } else {
                [activityIndicatorView startAnimating];
                [self load];
            }

        } else if ([currentView isEqualToString:@"After The Course"]) {
            self.navigationItem.title = kLangualString(@"After the Course");
            if (mserviceHandler.homeService.afterthecourseData.length > 0 && mserviceHandler.homeService.afterthecourseData != nil) {
                strin = mserviceHandler.homeService.afterthecourseData;
                [_webView loadHTMLString:strin baseURL:nil];
                [self loadafer];
            } else {
                [activityIndicatorView startAnimating];
                [self loadafer];
            }
        } else if ([currentView isEqualToString:@"Brochure"]) {
          self.navigationItem.title = kLangualString(@"Brochure");
          if (mserviceHandler.homeService.afterthecourseData.length > 0 && mserviceHandler.homeService.afterthecourseData != nil) {
              strin = mserviceHandler.homeService.brochureData;
            strin = [strin stringByReplacingOccurrencesOfString:@" " withString:@"%20"];
            [_webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:strin]]];
              [self loadBuffer];
          } else {
              [activityIndicatorView startAnimating];
              [self loadBuffer];
          }
      } else if ([currentView isEqualToString:@"Books"]) {
        self.navigationItem.title = _theTitle;
        [activityIndicatorView startAnimating];
          [_webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:_htmlUrl]]];
    }
        
        
    }
    _webView.opaque = NO;
    [self.view setBackgroundColor:kBgImage];
    self.view.layer.contents = (id)[UIImage imageNamed:@"loginBg"].CGImage;
    if ([isFromView isEqualToString:@"satya"]) {
        self.addLeftBarBarBackButtonEnabled = YES;
    } else {
        self.addLeftBarMenuButtonEnabled = YES;
    }
    id<GAITracker> tracker = [GAI sharedInstance].defaultTracker;
    [tracker set:kGAIScreenName value:@"Introduction"];
    [tracker send:[[GAIDictionaryBuilder createScreenView] build]];
    

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)webViewDidStartLoad:(UIWebView *)webView {
  
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    [activityIndicatorView stopAnimating];
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
    [activityIndicatorView stopAnimating];
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Alert" message:error.localizedDescription delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    [alert show];
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
    
    if ([isFromView isEqualToString:@"satya"]) {
        [self.navigationController popToRootViewControllerAnimated:true];
    } else {
       UIViewController *vc = [MainStoryBoard instantiateViewControllerWithIdentifier:@"homeVC"];
        [self.navigationController pushViewController:vc animated:YES];
    }
 
    
}


@end
