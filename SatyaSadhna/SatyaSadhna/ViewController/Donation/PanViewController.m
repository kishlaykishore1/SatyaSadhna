//
//  PanViewController.m
//  SatyaSadhna
//
//  Created by Roshan Bisht on 07/07/18.
//  Copyright © 2018 Roshan Singh Bisht. All rights reserved.
//

#import "PanViewController.h"
#import "UITextField+TextCustomize.h"
#import "HomeService.h"
#import "UIButton+Layout.h"
#import "PaymentWebView.h"

@interface PanViewController ()
@property (strong, nonatomic) IBOutlet UIView *superView;
@property (weak, nonatomic) IBOutlet UITextField *nameTxtField;
@property (weak, nonatomic) IBOutlet UITextField *addressTxtField;
@property (weak, nonatomic) IBOutlet UITextField *phoneTxtField;
@property (weak, nonatomic) IBOutlet UITextField *emailTxtField;
@property (weak, nonatomic) IBOutlet UITextField *panTxtFeield;
@property (weak, nonatomic) IBOutlet UITextField *amountTxtfeild;
@property (weak, nonatomic) IBOutlet UITextField *wordAmountTxtField;
@property (weak, nonatomic) IBOutlet UITextField *paymentTypeTxtField;
@property (weak, nonatomic) IBOutlet UIButton *donateButton;

@end

@implementation PanViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setAddRightBarBarBackButtonEnabled:YES];
    [_nameTxtField drawPaddingLess];
    [_addressTxtField drawPaddingLess];
    [_phoneTxtField drawPaddingLess];
    [_emailTxtField drawPaddingLess];
    [_panTxtFeield drawPaddingLess];
    [_amountTxtfeild drawPaddingLess];
    [_wordAmountTxtField drawPaddingLess];
    [_paymentTypeTxtField drawPaddingLess];
    [_donateButton roundButton];
    [self addLeftBarBarBackButtonEnabled];
    self.navigationItem.title = kLangualString(@"PAN");
    self.addLeftBarBarBackButtonEnabled = YES;
    
    [self.superView setBackgroundColor:kBgImage];
    self.view.layer.contents = (id)[UIImage imageNamed:@"loginBg"].CGImage;
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(yourUpdateMethodGoesHere:)
                                                 name:UIApplicationWillEnterForegroundNotification
                                               object:nil];
    [_nameTxtField setPlaceholder:kLangualString(@"Name")];
    [_addressTxtField setPlaceholder:kLangualString(@"Address")];
    [_phoneTxtField setPlaceholder:kLangualString(@"Contact No")];
    [_emailTxtField setPlaceholder:kLangualString(@"Email")];
    [_panTxtFeield setPlaceholder:kLangualString(@"Pan No")];
    [_amountTxtfeild setPlaceholder:kLangualString(@"Amount")];
    [_wordAmountTxtField setPlaceholder:kLangualString(@"Amount in Word")];
    [_paymentTypeTxtField setPlaceholder:kLangualString(@"Payment Type")];
    [_donateButton setTitle:kLangualString(@"Donate") forState:UIControlStateNormal];
    // Do any additional setup after loading the view.
}
- (void) yourUpdateMethodGoesHere:(NSNotification *) note {
    [self.navigationController popToRootViewControllerAnimated:YES];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
- (void)createAlertwithTitle:(NSString *)title andMessage:(NSString *)message {
    MHWAlertView *alert = [[MHWAlertView alloc] initWithTitle:title message:message delegate:nil cancelButtonTitle:kLangualString(@"OK") otherButtonTitles:nil, nil];
    [alert show];
}

- (BOOL)performValidation {
    if ((_nameTxtField.text.length == 0) || (_addressTxtField.text.length == 0) || (_phoneTxtField.text.length == 0) || (_emailTxtField.text.length == 0) || (_panTxtFeield.text.length == 0) || (_amountTxtfeild.text.length == 0) || (_wordAmountTxtField.text.length == 0) || (_paymentTypeTxtField.text.length == 0)) {
        [self createAlertwithTitle:kLangualString(@"Alert") andMessage:kLangualString(@"Please fill all fields.")];
        return NO;
    } else if (![_emailTxtField isEmailCorrect]) {
        MHWAlertView *alert = [[MHWAlertView alloc] initWithTitle:@"Alert" message:@"Please enter valid E-Mail address." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
        return NO;
    } else if (![_phoneTxtField isCorrectPhoneNo]) {
        MHWAlertView *alert = [[MHWAlertView alloc] initWithTitle:@"Alert" message:@"Please enter valid phone number." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
        return NO;
    } else if (_amountTxtfeild.text.floatValue < 50) {
        MHWAlertView *alert = [[MHWAlertView alloc] initWithTitle:@"Alert" message:@"Please enter amount more than 50." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
        return NO;
    } else {
        return YES;
    }
}

- (IBAction)donateAction:(id)sender {
    [self.view endEditing:YES];
    if ([Internet checkNetConnection] && [self performValidation]) {
        
        NSDictionary *param = @{@"name": _nameTxtField.text,
                                @"address": _addressTxtField.text,
                                @"contact_no": _phoneTxtField.text,
                                @"email": _emailTxtField.text,
                                @"pan_no": _panTxtFeield.text,
                                @"amount":_amountTxtfeild.text,
                                @"amount_word": _wordAmountTxtField.text
                                };
        [self.view addSubview:activityIndicatorView];
        [activityIndicatorView startAnimating];
        [mserviceHandler.homeService sendPanCardNumber:param success:^(id response) {
            [activityIndicatorView stopAnimating];
//            UIViewController *vc = [SecondStoryBoard instantiateViewControllerWithIdentifier:kNewDonationVC];
//            [self.navigationController pushViewController:vc animated:YES];
            NSString *strurl = [NSString stringWithFormat:@"https://www.satyasadhna.com/payment-gateway/submit.php?user_id=%@&amt=%@",[UserDefaultManager getUserID],_amountTxtfeild.text];
            NSURL *url = [NSURL URLWithString:strurl];
//            PaymentWebView *vc = [MainStoryBoard instantiateViewControllerWithIdentifier:@"PaymentWebView"];
//            vc.targetURL = url;
//            [self.navigationController pushViewController:vc animated:YES];
            if (![[UIApplication sharedApplication] openURL:url]) {
                NSLog(@"%@%@",@"Failed to open url:",[url description]);
            }
        } failure:^(NSError *error) {
            [activityIndicatorView stopAnimating];
        }];
     
        
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
