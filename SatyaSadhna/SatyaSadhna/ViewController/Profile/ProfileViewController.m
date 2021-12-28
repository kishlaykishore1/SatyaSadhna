//
//  ProfileViewController.m
//  SatyaSadhna
//
//  Created by Roshan Singh Bisht on 14/05/17.
//  Copyright © 2017 Roshan Singh Bisht. All rights reserved.
//

#import "ProfileViewController.h"
#import "UITextField+TextCustomize.h"
#import "MHWAlertView.h"
#import "LoginService.h"
#import "UserDataModal.h"

@interface ProfileViewController ()<UITextFieldDelegate,MHWAlertDelegate>
@property (weak, nonatomic) IBOutlet UIView         *updateView;
@property (weak, nonatomic) IBOutlet UITextField    *nametextField;
@property (weak, nonatomic) IBOutlet UITextField    *emailTextField;
@property (weak, nonatomic) IBOutlet UITextField    *mobileTextField;
@property (weak, nonatomic) IBOutlet UIButton       *cancelButton;
@property (weak, nonatomic) IBOutlet UIButton       *updateButton;
@property (weak, nonatomic) IBOutlet UIView         *profileView;
@property (weak, nonatomic) IBOutlet UILabel        *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel        *mobileLabel;
@property (weak, nonatomic) IBOutlet UILabel        *emailLabel;
@property (weak, nonatomic) IBOutlet UIButton       *updateProfileButton;
@property (weak, nonatomic) IBOutlet UIButton       *changePasswordButton;
@property (weak, nonatomic) IBOutlet UIView         *changePasswordView;
@property (weak, nonatomic) IBOutlet UITextField    *oldPasswordtext;
@property (weak, nonatomic) IBOutlet UITextField    *reenterNewPasswordText;
@property (weak, nonatomic) IBOutlet UIButton       *changeButtonOfcancelView;
@property (weak, nonatomic) IBOutlet UIButton       *updateButtonOfUpdateView;
@property (weak, nonatomic) IBOutlet UITextField    *passPasswordTextFieldField;

@end

@implementation ProfileViewController

- (void)updatePrfoile {
    [_nametextField setText:[UserDefaultManager getUserName]];
    [_emailTextField setText:[UserDefaultManager getEmailID]];
    [_mobileTextField setText:[UserDefaultManager getMobileNo]];
    
    [_nameLabel setText:[UserDefaultManager getUserName]];
    [_emailLabel setText:[UserDefaultManager getEmailID]];
    [_mobileLabel setText:[UserDefaultManager getMobileNo]];
}

- (void)keyboard {
    [self.view endEditing:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setAddRightBarBarBackButtonEnabled:YES];
    [self updatePrfoile];
    _mobileTextField.keyboardType = UIKeyboardTypePhonePad;
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(keyboard)];
    [self.view addGestureRecognizer:tap];
    tap.numberOfTapsRequired = 1;
    _oldPasswordtext.secureTextEntry = YES;
    _reenterNewPasswordText.secureTextEntry = YES;
    _passPasswordTextFieldField.secureTextEntry = YES;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


- (void)viewWillAppear:(BOOL)animated {
    _nametextField.layer.borderWidth = 1.0f;
    _nametextField.layer.borderColor = [UIColor whiteColor].CGColor;
    _nametextField.layer.cornerRadius = _nametextField.frame.size.height / 2;
    _nametextField.clipsToBounds = YES;
    [_nametextField drawPadding];
    _nametextField.delegate  = self;
    
    id<GAITracker> tracker = [GAI sharedInstance].defaultTracker;
    [tracker set:kGAIScreenName value:@"Profile View"];
    [tracker send:[[GAIDictionaryBuilder createScreenView] build]];
    
    _emailTextField.layer.borderWidth = 1.0f;
    _emailTextField.layer.borderColor = [UIColor whiteColor].CGColor;
    _emailTextField.layer.cornerRadius = _emailTextField.frame.size.height / 2;
    _emailTextField.clipsToBounds = YES;
    [_emailTextField drawPadding];
    _emailTextField.delegate  = self;
    
    _mobileTextField.layer.borderWidth = 1.0f;
    _mobileTextField.layer.borderColor = [UIColor whiteColor].CGColor;
    _mobileTextField.layer.cornerRadius = _mobileTextField.frame.size.height / 2;
    _mobileTextField.clipsToBounds = YES;
    [_mobileTextField drawPadding];
    _mobileTextField.delegate  = self;
    
    _oldPasswordtext.layer.borderWidth = 1.0f;
    _oldPasswordtext.layer.borderColor = [UIColor whiteColor].CGColor;
    _oldPasswordtext.layer.cornerRadius = _oldPasswordtext.frame.size.height / 2;
    _oldPasswordtext.clipsToBounds = YES;
    [_oldPasswordtext drawPadding];
    _oldPasswordtext.delegate  = self;
    
    
    _passPasswordTextFieldField.layer.borderWidth = 1.0f;
    _passPasswordTextFieldField.layer.borderColor = [UIColor whiteColor].CGColor;
    _passPasswordTextFieldField.layer.cornerRadius = _passPasswordTextFieldField.frame.size.height / 2;
    _passPasswordTextFieldField.clipsToBounds = YES;
    [_passPasswordTextFieldField drawPadding];
    _oldPasswordtext.delegate  = self;
    
    _reenterNewPasswordText.layer.borderWidth = 1.0f;
    _reenterNewPasswordText.layer.borderColor = [UIColor whiteColor].CGColor;
    _reenterNewPasswordText.layer.cornerRadius = _oldPasswordtext.frame.size.height / 2;
    _reenterNewPasswordText.clipsToBounds = YES;
    [_reenterNewPasswordText drawPadding];
    _reenterNewPasswordText.delegate  = self;
    
    self.navigationItem.title = @"Profile";
    self.addLeftBarMenuButtonEnabled = YES;
    
    _cancelButton.layer.cornerRadius = _cancelButton.frame.size.height / 2;
    _cancelButton.clipsToBounds = YES;
    
    _updateButton.layer.cornerRadius = _updateButton.frame.size.height / 2;
    _updateButton.clipsToBounds = YES;
    
    _updateProfileButton.layer.cornerRadius = _updateProfileButton.frame.size.height / 2;
    _updateProfileButton.clipsToBounds = YES;
    
    _changePasswordButton.layer.cornerRadius = _changePasswordButton.frame.size.height / 2;
    _changePasswordButton.clipsToBounds = YES;
    
    _changeButtonOfcancelView.layer.cornerRadius = _changeButtonOfcancelView.frame.size.height / 2;
    _changeButtonOfcancelView.clipsToBounds = YES;
    
    _updateButtonOfUpdateView.layer.cornerRadius = _updateButtonOfUpdateView.frame.size.height / 2;
    _updateButtonOfUpdateView.clipsToBounds = YES;
    
    _changePasswordButton.layer.cornerRadius = _changePasswordButton.frame.size.height / 2;
    _changePasswordButton.clipsToBounds = YES;
    
    [self.profileView setBackgroundColor:kBgImage];
     self.profileView.layer.contents = (id)[UIImage imageNamed:@"loginBg"].CGImage;
    [self.updateView setBackgroundColor:kBgImage];
    self.updateView.layer.contents = (id)[UIImage imageNamed:@"loginBg"].CGImage;
    [self.changePasswordView setBackgroundColor:kBgImage];
    self.changePasswordView.layer.contents = (id)[UIImage imageNamed:@"loginBg"].CGImage;
    
    SWRevealViewController *reveal = self.revealViewController;
    reveal.panGestureRecognizer.enabled = YES;
    
    
    
}

- (IBAction)updateProfileButtonAction:(id)sender {
    
    [UIView transitionWithView:self.view
                      duration:0.6
                       options:UIViewAnimationOptionTransitionFlipFromLeft
                    animations:^{
                        _changePasswordView.hidden = YES;
                        _profileView.hidden = YES;
                        _updateView.hidden = NO;
                    } completion:nil
     ];
}

- (IBAction)changePaswordAction:(id)sender {
    
    [UIView transitionWithView:self.view
                      duration:0.6
                       options:UIViewAnimationOptionTransitionFlipFromTop
                    animations:^{
                        _changePasswordView.hidden = NO;
                        _profileView.hidden = YES;
                        _updateView.hidden = YES;
                    } completion:nil
     ];
}
- (IBAction)cancelButton:(id)sender {
    
    [UIView transitionWithView:self.view
                      duration:0.6
                       options:UIViewAnimationOptionTransitionFlipFromRight
                    animations:^{
                        _changePasswordView.hidden = YES;
                        _profileView.hidden = NO;
                        _updateView.hidden = YES;
                    } completion:nil
     ];
}

- (BOOL)performValidations {
    if ([_nametextField.text isEqualToString:[UserDefaultManager getUserName]] && [_mobileTextField.text isEqualToString:[UserDefaultManager getMobileNo]] && [_emailTextField.text isEqualToString:[UserDefaultManager getEmailID]]) {
        MHWAlertView *alert = [[MHWAlertView alloc] initWithTitle:@"Alert" message:@"Oops..its seems you have't change anything." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
        return NO;
    } else if(![_emailTextField isEmailCorrect]){
        MHWAlertView *alert = [[MHWAlertView alloc] initWithTitle:@"Alert" message:@"Please enter valid email-id" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
        return NO;
    } else if (![_mobileTextField isCorrectPhoneNo]) {
        MHWAlertView *alert = [[MHWAlertView alloc] initWithTitle:@"Alert" message:@"please enter correct phone no." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
        return NO;
    } else {
        return YES;
    }
    
}
- (IBAction)updateButton:(id)sender {
    
    if ([self performValidations]) {
        [self.view addSubview:activityIndicatorView];
        [activityIndicatorView startAnimating];
        UserDataModal *data = [UserDataModal new];
        data.emailID = _emailTextField.text;
        data.phoneNo = _mobileTextField.text;
        data.userName = _nametextField.text;
        
        
        [mserviceHandler.loginservice updateProfile:data success:^(id response) {
            NSLog(@"%@", response);
            if ([response[@"success"] boolValue]) {
                [activityIndicatorView stopAnimating];
                [UserDefaultManager setEmailID:data.emailID];
                [UserDefaultManager setMobileNo:data.phoneNo];
                [UserDefaultManager setUserName:data.userName];
                [_emailLabel setText:data.emailID];
                [_mobileLabel setText:data.phoneNo];
                [_nameLabel setText:data.userName];
                MHWAlertView *alert = [[MHWAlertView alloc] initWithTitle:@"Success" message:@"Your Profile has been updated." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                alert.tag = 1;
                [alert show];
                
            }
        } failure:^(NSError *error) {
            [activityIndicatorView stopAnimating];
            
        }];
    }
    
}
- (IBAction)cancelButtonOFPasswordAction:(id)sender {
    [UIView transitionWithView:self.view
                      duration:0.6
                       options:UIViewAnimationOptionTransitionFlipFromBottom
                    animations:^{
                        _changePasswordView.hidden = YES;
                        _profileView.hidden = NO;
                        _updateView.hidden = YES;
                    } completion:nil
     ];
}

- (BOOL)checkPassword {
    if (!(_oldPasswordtext.text.length > 0) && !(_passPasswordTextFieldField.text.length > 0) && !(_reenterNewPasswordText.text.length > 0)) {
        return NO;
    } else if([_oldPasswordtext.text isEqualToString:_passPasswordTextFieldField.text]) {
        return NO;
    } else if (![_passPasswordTextFieldField.text isEqualToString:_reenterNewPasswordText.text]) {
        return NO;
    } else {
        return YES;
    }
    
}
- (IBAction)updateOfChnagePassword:(id)sender {
    [self.view endEditing:YES];
    if ([self checkPassword]) {
        [self.view addSubview:activityIndicatorView];
        [activityIndicatorView startAnimating];
        [mserviceHandler.loginservice changepassword:_oldPasswordtext.text new:_reenterNewPasswordText.text con:nil success:^(id response) {
            [activityIndicatorView stopAnimating];
            if ([response[@"success"] boolValue]) {
                [self.view endEditing:YES];
                MHWAlertView *alert = [[MHWAlertView alloc] initWithTitle:@"Success" message:@"password has been changed." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                alert.tag = 2;
                [alert show];
            } else {
                MHWAlertView *alert = [[MHWAlertView alloc] initWithTitle:@"Error" message:response[@"msg"] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                [alert show];
                
            }
        } failure:^(NSError *error) {
            [activityIndicatorView stopAnimating];
        }];
    } else {
        MHWAlertView *alert = [[MHWAlertView alloc] initWithTitle:@"Alert" message:@"Your password does not match." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
    }
    
}

-(BOOL) textFieldShouldReturn:(UITextField *)textField{
    
    [textField resignFirstResponder];
    return YES;
}

- (void)MHWAlertView:(MHWAlertView *)mhwAlertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (mhwAlertView.tag == 1) {
        if (buttonIndex == 0) {
            [UIView transitionWithView:self.view
                              duration:0.6
                               options:UIViewAnimationOptionTransitionFlipFromBottom
                            animations:^{
                                _changePasswordView.hidden = YES;
                                _profileView.hidden = NO;
                                _updateView.hidden = YES;
                            } completion:^(BOOL finished) {
                                
                            }
             ];
            [_nametextField setText:[UserDefaultManager getUserName]];
            [_emailTextField setText:[UserDefaultManager getEmailID]];
            [_mobileTextField setText:[UserDefaultManager getMobileNo]];
        }
    } else if (mhwAlertView.tag == 2){
        if (buttonIndex == 0) {
            [UIView transitionWithView:self.view
                              duration:0.6
                               options:UIViewAnimationOptionTransitionFlipFromBottom
                            animations:^{
                                _changePasswordView.hidden = YES;
                                _profileView.hidden = NO;
                                _updateView.hidden = YES;
                            } completion:^(BOOL finished) {
                                
                            }
             ];

        }
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
