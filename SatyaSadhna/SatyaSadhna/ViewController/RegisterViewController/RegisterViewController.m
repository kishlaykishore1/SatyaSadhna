//
//  RegisterViewController.m
//  SatyaSadhna
//
//  Created by Roshan Singh Bisht on 23/04/17.
//  Copyright © 2017 Roshan Singh Bisht. All rights reserved.
//

#import "UITextField+TextCustomize.h"
#import "UIButton+Layout.h"
#import "RegisterViewController.h"
#import "UserDataModal.h"
#import "LoginService.h"

@interface RegisterViewController ()
@property (weak, nonatomic) IBOutlet UITextField *nameTextField;
@property (weak, nonatomic) IBOutlet UITextField *emailtextField;
@property (weak, nonatomic) IBOutlet UITextField *mobileTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;
@property (weak, nonatomic) IBOutlet UITextField *confirmPasswordTextField;
@property (weak, nonatomic) IBOutlet UIButton    *signUpButton;

@end

@implementation RegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated {
    [_nameTextField drawPaddingWithImage:[UIImage imageNamed:@"userImage"]];
    [_emailtextField drawPaddingWithImage:[UIImage imageNamed:@"emailImage"]];
    [_mobileTextField drawPaddingWithImage:[UIImage imageNamed:@"mobile"]];
    [_passwordTextField drawPaddingWithImage:[UIImage imageNamed:@"passwordImage"]];
    [_confirmPasswordTextField drawPaddingWithImage:[UIImage imageNamed:@"passwordImage"]];
    [_signUpButton roundButton];
    self.navigationBarMakeTransparent = YES;
    [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"loginBg"]]];
    self.view.layer.contents = (id)[UIImage imageNamed:@"loginBg"].CGImage;
    self.addLeftBarBarBackButtonEnabled = YES;
    _passwordTextField.secureTextEntry = YES;
    _confirmPasswordTextField.secureTextEntry = YES;
    [self.view updateViewWithApplicationGlobalFont];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)signUpAction:(id)sender {
    if ([Internet checkNetConnection]) {
        if ([self performValidations]) {
            [self.view addSubview:activityIndicatorView];
            [activityIndicatorView startAnimating];
            
            UserDataModal *userData = [UserDataModal new];
            userData.emailID = _emailtextField.text;
            userData.password = _passwordTextField.text;
            userData.userName = _nameTextField.text;
            userData.phoneNo = _mobileTextField.text;
            
            [mserviceHandler.loginservice doRegister:userData success:^(id response) {
                [activityIndicatorView stopAnimating];
                if ([response[@"success"] boolValue]) {
                    [UserDefaultManager setUserID:[response valueForKeyPath:@"user_array.user_id"]];
                    [UserDefaultManager setUserName:[response valueForKeyPath:@"user_array.name"]];
                    [UserDefaultManager setEmailID:[response valueForKeyPath:@"user_array.email_address"]];
                    [UserDefaultManager setMobileNo:[response valueForKeyPath:@"user_array.mobile_number"]];
                    
                    AppDelegate *app = (AppDelegate *)[UIApplication sharedApplication].delegate;
                    [app transitionToSlideMenu];
                }
            } failure:^(NSError *error) {
                [activityIndicatorView stopAnimating];
                [Utils showAlertMessage:error.localizedDescription withTitle:@"Error"];
            }];
            
        }
    }
}
- (IBAction)alreadyRegisteredAction:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (BOOL)performValidations {
    if (!_nameTextField.hasText && !_emailtextField.hasText && ![_mobileTextField hasText] && ![_passwordTextField hasText] && ![_confirmPasswordTextField hasText]) {
        MHWAlertView *alert = [[MHWAlertView alloc] initWithTitle:@"Alert" message:@"Please fill all the fields." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
        return NO;
    } else if (![_emailtextField isEmailCorrect]) {
        MHWAlertView *alert = [[MHWAlertView alloc] initWithTitle:@"Alert" message:@"Please enter valid E-Mail address." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
        return NO;
    } else if (![_mobileTextField isCorrectPhoneNo]) {
        MHWAlertView *alert = [[MHWAlertView alloc] initWithTitle:@"Alert" message:@"Please enter valid phone number." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
        return NO;
    } else if (![_passwordTextField.text isEqualToString:_confirmPasswordTextField.text]) {
        MHWAlertView *alert = [[MHWAlertView alloc] initWithTitle:@"Alert" message:@"Passwords should match." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
        return NO;
    }
    return YES;
}



@end
