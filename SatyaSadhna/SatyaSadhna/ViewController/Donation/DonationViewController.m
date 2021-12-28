//
//  DonationViewController.m
//  SatyaSadhna
//
//  Created by Roshan Singh Bisht on 10/06/17.
//  Copyright © 2017 Roshan Singh Bisht. All rights reserved.
//

#import "DonationViewController.h"
#import "HomeService.h"
#import "UIButton+Layout.h"
#import "AppDelegate.h"

@interface DonationViewController ()
@property (weak, nonatomic) IBOutlet UILabel *bankNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *accountNoLabel;
@property (weak, nonatomic) IBOutlet UILabel *ifscCodeLabel;
@property (weak, nonatomic) IBOutlet UILabel *branchNameLabel;
@property(nonatomic, strong)NSArray     *data;
@property (weak, nonatomic) IBOutlet UIButton *donateButton;

@property (weak, nonatomic) IBOutlet UILabel *informationLabel;
@property (weak, nonatomic) IBOutlet UILabel *satyamLabel;
@property (weak, nonatomic) IBOutlet UILabel *bankDetails;
@property (weak, nonatomic) IBOutlet UILabel *bankName;
@property (weak, nonatomic) IBOutlet UILabel *bankAccount;
@property (weak, nonatomic) IBOutlet UILabel *ifscCode;
@property (weak, nonatomic) IBOutlet UILabel *branchName;


@end

@implementation DonationViewController


- (void)getData {
    [mserviceHandler.homeService donation:^(id response) {
        _data = response[@"user_array"];
        [self updatwView];
        [activityIndicatorView stopAnimating];
    } failure:^(NSError *error) {
        [activityIndicatorView stopAnimating];
    }];
}

- (void)updatwView {
    NSDictionary *dict = [_data firstObject];
    [_bankNameLabel setText:dict[@"bank_name"]];
    [_accountNoLabel setText:dict[@"acc_nu"]];
    [_ifscCodeLabel setText:dict[@"ifsc_code"]];
    [_branchNameLabel setText:dict[@"branch_name"]];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [_bankNameLabel setText:@""];
    [_accountNoLabel setText:@""];
    [_ifscCodeLabel setText:@""];
    [_branchNameLabel setText:@""];
    if ([Internet checkNetConnection]) {
        if (mserviceHandler.homeService.donationData.count > 0) {
            _data = mserviceHandler.homeService.donationData;
            [self updatwView];
            [self getData];
        } else {
            [self.view addSubview:activityIndicatorView];
            [activityIndicatorView startAnimating];
            [self getData];
        }
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)viewWillAppear:(BOOL)animated {
    [self.view setBackgroundColor:kBgImage];
    self.view.layer.contents = (id)[UIImage imageNamed:@"loginBg"].CGImage;
    self.navigationItem.title = kLangualString(@"Bank Details");
    self.addLeftBarBarBackButtonEnabled = YES;
    [self.view updateViewWithApplicationGlobalFont];
    [_donateButton cornerradiusforButton];
    [_satyamLabel setText:kLangualString(@"Satyam Shodh Sansthan")];
    [_informationLabel setText:kLangualString(@"INFORMATION")];
    [_bankDetails  setText:kLangualString(@"BANK DETAILS")];
    [_bankName setText:kLangualString(@"Bank Name")];
    [_bankAccount setText:kLangualString(@"Bank Account No.")];
    [_ifscCode setText:kLangualString(@"IFSC Code")];
    [_branchName setText:kLangualString(@"Branch Name")];
    [_donateButton setTitle:kLangualString(@"Donate Now") forState:UIControlStateNormal];
    
    id<GAITracker> tracker = [GAI sharedInstance].defaultTracker;
    [tracker set:kGAIScreenName value:@"Donation"];
    [tracker send:[[GAIDictionaryBuilder createScreenView] build]];
    
}
- (IBAction)donateButtonAction:(UIButton *)sender {
    UIViewController *vc = [SecondStoryBoard instantiateViewControllerWithIdentifier:@"formVC"];
    [self.navigationController pushViewController:vc animated:YES];
}


@end
