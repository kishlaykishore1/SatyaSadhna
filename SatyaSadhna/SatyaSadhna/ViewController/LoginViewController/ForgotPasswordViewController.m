//
//  ForgotPasswordViewController.m
//  SatyaSadhna
//
//  Created by Roshan Singh Bisht on 11/06/17.
//  Copyright © 2017 Roshan Singh Bisht. All rights reserved.
//

#import "ForgotPasswordViewController.h"
#import "UIButton+Layout.h"
#import "LoginService.h"
#import "UITextField+TextCustomize.h"

@interface ForgotPasswordViewController ()<UITextFieldDelegate,MHWAlertDelegate>
@property (weak, nonatomic) IBOutlet UITextField *codetextFiekd;
@property (weak, nonatomic) IBOutlet UITextField *passTextField;
@property (weak, nonatomic) IBOutlet UITextField *confirmPassword;
@property (weak, nonatomic) IBOutlet UIButton *verifyButton;

@end

@implementation ForgotPasswordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)];
    tap.numberOfTapsRequired = 1;
    
    id<GAITracker> tracker = [GAI sharedInstance].defaultTracker;
    [tracker set:kGAIScreenName value:@"Forgot Password View"];
    [tracker send:[[GAIDictionaryBuilder createScreenView] build]];
    [self.view addGestureRecognizer:tap];
    // Do any additional setup after loading the view.
}

- (void)tap:(UIGestureRecognizer *)ges {
    [self.view endEditing:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (BOOL)validation {
    
    if (_codetextFiekd.text.length == 0 || _confirmPassword.text.length == 0 || _passTextField.text.length == 0) {
        MHWAlertView *alert = [[MHWAlertView alloc] initWithTitle:@"Error" message:@"Please fill all fields." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
        return NO;
    } else if (![_codetextFiekd.text isEqualToString:[UserDefaultManager getOtp]]){
        MHWAlertView *alert = [[MHWAlertView alloc] initWithTitle:@"Error" message:@"Verification code does not match please try again." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
        return NO;
    } else if (![_confirmPassword.text isEqualToString:_passTextField.text]){
        MHWAlertView *alert = [[MHWAlertView alloc] initWithTitle:@"Error" message:@"Password does not match please try again." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
        return NO;
    }
    return YES;
}

- (IBAction)verifyAction:(id)sender {
    [self.view endEditing:YES];
    if ([Internet checkNetConnection] && [self validation]) {
        [self.view addSubview:activityIndicatorView];
        [activityIndicatorView startAnimating];
        [mserviceHandler.loginservice password:@{@"password":_confirmPassword.text, @"mobilenumber":_mobileNO} success:^(id response) {
            [activityIndicatorView stopAnimating];
            if ([response[@"success"] boolValue]) {
                MHWAlertView *alert = [[MHWAlertView alloc] initWithTitle:@"Success" message:@"Password has been changed successfully, please login again." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                [alert show];
            } else {
                MHWAlertView *alert = [[MHWAlertView alloc] initWithTitle:@"Error" message:@"Something went wrong please try again later." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                [alert show];
            }
        } failure:^(NSError *error) {
            [activityIndicatorView stopAnimating];
            MHWAlertView *alert = [[MHWAlertView alloc] initWithTitle:@"Error" message:error.localizedDescription delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alert show];
        }];
    }
}

- (void)viewWillAppear:(BOOL)animated {
    [_codetextFiekd drawPaddingWithImage:[UIImage imageNamed:@"passwordImage"]];
    [_passTextField drawPaddingWithImage:[UIImage imageNamed:@"passwordImage"]];
    [_confirmPassword drawPaddingWithImage:[UIImage imageNamed:@"passwordImage"]];
    [_verifyButton roundButton];
    self.addLeftBarBarBackButtonEnabled = YES;
    [self.view setBackgroundColor:kBgImage];
    self.view.layer.contents = (id)[UIImage imageNamed:@"loginBg"].CGImage;
    self.navigationItem.title = @"Forgot Password";
    _confirmPassword.delegate = self;
    _codetextFiekd.delegate = self;
    _passTextField.delegate = self;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [self.view endEditing:YES];
    return YES;
}

- (void)MHWAlertView:(MHWAlertView *)mhwAlertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    [self.navigationController popViewControllerAnimated:YES];
}
@end
