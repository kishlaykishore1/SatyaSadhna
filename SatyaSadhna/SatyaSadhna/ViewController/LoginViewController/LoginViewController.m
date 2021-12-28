//
//  LoginViewController.m
//  SatyaSadhna
//
//  Created by Roshan Singh Bisht on 22/04/17.
//  Copyright © 2017 Roshan Singh Bisht. All rights reserved.
//
#import "LoginService.h"
#import "LoginViewController.h"
#import "UITextField+TextCustomize.h"
#import "UIButton+Layout.h"
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <FBSDKLoginKit/FBSDKLoginKit.h>
#import "UserDataModal.h"
#import <Google/SignIn.h>
#import "UIView+Loading.h"
#import "ForgotPasswordViewController.h"

@interface LoginViewController ()<FBSDKLoginButtonDelegate,MHWAlertDelegate,GIDSignInUIDelegate, UIAlertViewDelegate,UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField    *loginTextField;
@property (weak, nonatomic) IBOutlet UITextField    *passwordTextField;
@property (weak, nonatomic) IBOutlet UIButton       *signInButton;
@property (strong,nonatomic) UserDataModal          *userDetails;
@property (strong, nonatomic) GIDSignInButton       *Googlebutton;
@property (weak, nonatomic) IBOutlet UIScrollView   *scrollView;


@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [GIDSignIn sharedInstance].uiDelegate = self;
    [self.view updateViewWithApplicationGlobalFont];
    _loginTextField.delegate = self;
    _passwordTextField.delegate = self;
//    _loginTextField.text = @"Shalinikothari11@gmail.com";
//    _passwordTextField.text = @"mango1234";
    /*_loginTextField.text = @"9829169991";
    _passwordTextField.text = @"mango1234";*/
    
    id<GAITracker> tracker = [GAI sharedInstance].defaultTracker;
    [tracker set:kGAIScreenName value:@"Login View"];
    [tracker send:[[GAIDictionaryBuilder createScreenView] build]];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)addToolBar {
    //add tool bar on the keyboard with done button for the textFields
    UIToolbar * keyboardToolBar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, 320, 50)];
    keyboardToolBar.barStyle = UIBarStyleBlack;
    keyboardToolBar.tintColor = [UIColor whiteColor];
    [keyboardToolBar setItems: [NSArray arrayWithObjects:
                                [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil],
                                [[UIBarButtonItem alloc]initWithTitle:@"Done" style:UIBarButtonItemStyleDone target:self action:@selector(doneClicked)],nil]];
    _loginTextField.inputAccessoryView = keyboardToolBar;
}
- (void)doneClicked {
    [_loginTextField resignFirstResponder];
}

- (void)viewWillAppear:(BOOL)animated {
    [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"loginBg"]]];
    self.view.layer.contents = (id)[UIImage imageNamed:@"loginBg"].CGImage;
    [_loginTextField drawPaddingWithImage:[UIImage imageNamed:@"userImage"]];
    [_passwordTextField drawPaddingWithImage:[UIImage imageNamed:@"passwordImage"]];
    [_signInButton roundButton];
    [self addToolBar];
    self.navigationBarMakeTransparent = YES;
}

- (IBAction)action:(id)sender {
    [self.view endEditing:YES];
    if ([Internet checkNetConnection]) {
        if ([self performvalidation]) {
            UserDataModal *data = [UserDataModal new];
            data.emailID = _loginTextField.text;
            data.password = _passwordTextField.text;
            [self.view addSubview:activityIndicatorView];
            [activityIndicatorView startAnimating];
            [mserviceHandler.loginservice login:data success:^(id response) {
                [activityIndicatorView stopAnimating];
                 if ([response[@"success"] boolValue]) {
                    [UserDefaultManager setUserID:[response valueForKeyPath:@"user_array.user_id"]];
                     [UserDefaultManager setUserName:[response valueForKeyPath:@"user_array.name"]];
                     [UserDefaultManager setMobileNo:[response valueForKeyPath:@"user_array.mobile_number"]];
                     [UserDefaultManager setEmailID:[response valueForKeyPath:@"user_array.email_address"]];
                    AppDelegate *app = (AppDelegate *)[UIApplication sharedApplication].delegate;
                    [app transitionToSlideMenu];
                    
                } else {
                    [Utils showAlertMessage:response[@"msg"] withTitle:@"Alert"];
                }
            } failure:^(NSError * error) {
                [activityIndicatorView stopAnimating];
                [Utils showAlertMessage:error.localizedDescription withTitle:@"Alert"];
            }];
        }
    }
    
}
- (IBAction)forGotPasswordAction:(id)sender {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Forgot Passowrd" message:@"Please enter your registered mobile  number to reset your password!" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:@"Cancel", nil];
    
    [alert setAlertViewStyle:UIAlertViewStylePlainTextInput];
    [alert textFieldAtIndex:0].keyboardType = UIKeyboardTypePhonePad;
    [alert show];
}
- (IBAction)googleSignInButton:(id)sender {
    [self.view addSubview:activityIndicatorView];
    [activityIndicatorView startAnimating];
    [[GIDSignIn sharedInstance] signIn];
    [GIDSignIn sharedInstance].delegate = self;
}
- (IBAction)facebookSignInButton:(id)sender {
    
    [self.view addSubview:activityIndicatorView];
    [activityIndicatorView startAnimating];
    
    
    FBSDKLoginButton *loginButton = [[FBSDKLoginButton alloc] init];
    loginButton.readPermissions =
    @[@"public_profile", @"email"];
    loginButton.delegate = self;
    
    [loginButton sendActionsForControlEvents:UIControlEventTouchUpInside];
}
- (IBAction)registerButton:(id)sender {
    UIViewController *registerVC = [MainStoryBoard instantiateViewControllerWithIdentifier:@"registerVC"];
    [self.navigationController pushViewController:registerVC animated:YES];
    
}

- (void) loginButton:(FBSDKLoginButton *)loginButton
didCompleteWithResult:(FBSDKLoginManagerLoginResult *)result
                error:(NSError *)error {
    if ([FBSDKAccessToken currentAccessToken]) {
        [[[FBSDKGraphRequest alloc] initWithGraphPath:@"me" parameters:@{@"fields": @"email,name,first_name"}]
         startWithCompletionHandler:^(FBSDKGraphRequestConnection *connection, id result, NSError *error) {
             if (!error) {
                 
                 _userDetails = [UserDataModal new];
                 _userDetails.emailID = result[@"email"];
                 _userDetails.password = @"passowrd";
                 _userDetails.userName = result[@"first_name"];
                 _userDetails.phoneNo = @"1234567890";
                 [UserDefaultManager setUserName:_userDetails.userName];
                 
                 [mserviceHandler.loginservice doRegister:_userDetails success:^(id response) {
                     [activityIndicatorView stopAnimating];
                     if ([response[@"success"] boolValue]) {
                         [UserDefaultManager setUserID:[response valueForKeyPath:@"user_array.user_id"]];
                         AppDelegate *app = (AppDelegate *)[UIApplication sharedApplication].delegate;
                         [app transitionToSlideMenu];
                     } else if ([response[@"msg"] isEqualToString:@"Email Address Alraedy Exit"]) {
                                 [mserviceHandler.loginservice login:_userDetails success:^(id response) {
                                     [activityIndicatorView stopAnimating];
                                     if ([response[@"success"] boolValue]) {
                                         [UserDefaultManager setUserID:[response valueForKeyPath:@"user_array.user_id"]];
                                         AppDelegate *app = (AppDelegate *)[UIApplication sharedApplication].delegate;
                                         [app transitionToSlideMenu];;
                                     } else {
                                         [Utils showAlertMessage:response[@"msg"] withTitle:@"Alert"];
                                         [FBSDKAccessToken setCurrentAccessToken:nil];
                                     }
                                 } failure:^(NSError * error) {
                                     [activityIndicatorView stopAnimating];
                                     [Utils showAlertMessage:error.localizedDescription withTitle:@"Alert"];
                                 }];
                     }
                 } failure:^(NSError *error) {
                     [activityIndicatorView stopAnimating];
                     [Utils showAlertMessage:error.localizedDescription withTitle:@"Error"];
                 }];
                 
                 
                 
             }
         }];
        
        

        
    }
    
}

/**
 Sent to the delegate when the button was used to logout.
 - Parameter loginButton: The button that was clicked.
 */
- (void)loginButtonDidLogOut:(FBSDKLoginButton *)loginButton {
    
}


- (BOOL)performvalidation {
    if (![_loginTextField hasText] && ![_passwordTextField hasText]) {
        MHWAlertView *alert = [[MHWAlertView alloc] initWithTitle:@"Alert" message:@"Please fill all fields." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
        return NO;
    } else {
       
        BOOL isEmail = [_loginTextField isEmailCorrect];
        BOOL isPhone = [_loginTextField isCorrectPhoneNo];
        if (isEmail || isPhone) {
            return YES;
        } else if (!isEmail) {
            MHWAlertView *alert = [[MHWAlertView alloc] initWithTitle:@"Alert" message:@"Please enter valid E-Mail Address." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alert show];
            return NO;
            
        } else if (!isPhone) {
            MHWAlertView *alert = [[MHWAlertView alloc] initWithTitle:@"Alert" message:@"Please enter valid phone no." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alert show];
            return NO;
        }
    }
    return YES;
}


- (void)signInWillDispatch:(GIDSignIn *)signIn error:(NSError *)error {
    [self.view addSubview:activityIndicatorView];
    [activityIndicatorView stopAnimating];
}

// Present a view that prompts the user to sign in with Google
- (void)signIn:(GIDSignIn *)signIn
    presentViewController:(UIViewController *)viewController {
    [self presentViewController:viewController animated:YES completion:nil];
}

// Dismiss the "Sign in with Google" view
- (void)signIn:(GIDSignIn *)signIn
    dismissViewController:(UIViewController *)viewController {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 0) {
        if([alertView textFieldAtIndex:0].text > 0) {
            [self.view addSubview:activityIndicatorView];
            [activityIndicatorView startAnimating];
            [mserviceHandler.loginservice forgotPasswordsuccess:[alertView textFieldAtIndex:0].text andSuccess:^(id response) {
                [activityIndicatorView stopAnimating];
                if ([response[@"status"] boolValue]) {
                    [UserDefaultManager setOtp:[NSString stringWithFormat:@"%ld",[[response valueForKeyPath:@"page_result.otpmessage"] integerValue]]];
                    ForgotPasswordViewController *vc = [SecondStoryBoard instantiateViewControllerWithIdentifier:@"forgotpassVC"];
                    vc.mobileNO = [response valueForKeyPath:@"page_result.mobile_number"];
                    [self.navigationController pushViewController:vc animated:YES];
                } else {
                    MHWAlertView *alert = [[MHWAlertView alloc] initWithTitle:@"Alert" message:@"Something went wrong please try again later." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                    [alert show];
                }
                
            } failure:^(NSError *error) {
                [activityIndicatorView stopAnimating];
                MHWAlertView *alert = [[MHWAlertView alloc] initWithTitle:@"Alert" message:error.localizedDescription delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                [alert show];
            }];
        } else {
            
        }
        
    }
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [self.view endEditing:YES];
    return YES;
}

@end
