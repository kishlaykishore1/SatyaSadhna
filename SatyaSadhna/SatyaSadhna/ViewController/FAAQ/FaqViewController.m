//
//  FaqViewController.m
//  SatyaSadhna
//
//  Created by Roshan Singh Bisht on 08/06/17.
//  Copyright © 2017 Roshan Singh Bisht. All rights reserved.
//

#import "FaqViewController.h"
#import "HomeService.h"

@interface FaqViewController ()<UIWebViewDelegate>
@property (weak, nonatomic) IBOutlet UITextView *textView;

@end

@implementation FaqViewController


- (void)fq {
    [mserviceHandler.homeService faq:^(id response) {
        [activityIndicatorView stopAnimating];
       NSDictionary *dict = [mserviceHandler.homeService.faqData firstObject];
        NSString *str = dict[@"page_content"];
        str = [str stringByReplacingOccurrencesOfString:@"<p>" withString:@""];
        str = [str stringByReplacingOccurrencesOfString:@"</p>" withString:@""];
        [_textView setText:str];
    } failure:^(NSError *error) {
        [activityIndicatorView stopAnimating];
        MHWAlertView *alert = [[MHWAlertView alloc] initWithTitle:@"Alert" message:error.localizedDescription delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
    }];
}

- (void)terms {
    [mserviceHandler.homeService termsCondition:^(id response) {
        [activityIndicatorView stopAnimating];
        NSDictionary *dict = [mserviceHandler.homeService.faqData firstObject];
        NSString *str = dict[@"page_content"];
        str = [str stringByReplacingOccurrencesOfString:@"<p>" withString:@""];
        str = [str stringByReplacingOccurrencesOfString:@"</p>" withString:@""];
        [_textView setText:str];
    } failure:^(NSError *error) {
        [activityIndicatorView stopAnimating];
        MHWAlertView *alert = [[MHWAlertView alloc] initWithTitle:@"Alert" message:error.localizedDescription delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
    }];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setAddRightBarBarBackButtonEnabled:YES];
    [_textView setText:@""];
    _textView.userInteractionEnabled = NO;
    if (_isFaq) {
        if (mserviceHandler.homeService.faqData.count > 0) {
            NSDictionary *dict = [mserviceHandler.homeService.faqData firstObject];
            NSString *str = dict[@"page_content"];
            str = [str stringByReplacingOccurrencesOfString:@"<p>" withString:@""];
            str = [str stringByReplacingOccurrencesOfString:@"</p>" withString:@""];
            [_textView setText:str];
            [self fq];
        } else {
            [self.view addSubview:activityIndicatorView];
            [activityIndicatorView startAnimating];
            [self fq];
            
        }

    } else {
        if (mserviceHandler.homeService.faqData.count > 0) {
            NSDictionary *dict = [mserviceHandler.homeService.faqData firstObject];
            NSString *str = dict[@"page_content"];
            str = [str stringByReplacingOccurrencesOfString:@"<p>" withString:@""];
            str = [str stringByReplacingOccurrencesOfString:@"</p>" withString:@""];
            [_textView setText:str];
            [self terms];
        } else {
            [self.view addSubview:activityIndicatorView];
            [activityIndicatorView startAnimating];
            [self terms];
            
        }

    }
    
    id<GAITracker> tracker = [GAI sharedInstance].defaultTracker;
    [tracker set:kGAIScreenName value:@"FAQ"];
    [tracker send:[[GAIDictionaryBuilder createScreenView] build]];
    
   }

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated {
    [self.view setBackgroundColor:kBgImage];
    self.view.layer.contents = (id)[UIImage imageNamed:@"loginBg"].CGImage;
    if (_isFromSlide) {
        self.addLeftBarBarBackButtonEnabled = YES;
    } else {
        self.addLeftBarMenuButtonEnabled = YES;
    }
    if (_isFaq) {
        self.navigationItem.title = kLangualString(@"FAQ");
    } else {
        self.navigationItem.title = kLangualString(@"Terms & Conditions");
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
    
        UIViewController *vc = [MainStoryBoard instantiateViewControllerWithIdentifier:@"homeVC"];
        [self.navigationController pushViewController:vc animated:YES];
 
}



@end
