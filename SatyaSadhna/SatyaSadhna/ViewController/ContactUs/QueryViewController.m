//
//  QueryViewController.m
//  SatyaSadhna
//
//  Created by Roshan Singh Bisht on 14/05/17.
//  Copyright © 2017 Roshan Singh Bisht. All rights reserved.
//

#import "QueryViewController.h"
#import "UITextView+customize.h"
#import "UITextField+TextCustomize.h"
#import "HomeService.h"
#import "UIButton+Layout.h"
#import "UserDataModal.h"

@interface QueryViewController ()<UITextViewDelegate,MHWAlertDelegate>
@property (weak, nonatomic) IBOutlet UITextField *nameTextField;
@property (weak, nonatomic) IBOutlet UITextField *emailTextField;
@property (weak, nonatomic) IBOutlet UITextField *subjectTextField;
@property (weak, nonatomic) IBOutlet UILabel        *messageLabel;
@property (weak, nonatomic) IBOutlet UITextView     *messageTextView;
@property (weak, nonatomic) IBOutlet UIButton       *sendButton;

@end

@implementation QueryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setAddRightBarBarBackButtonEnabled:YES];
    _messageLabel.hidden = NO;
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated {
    [self.view setBackgroundColor:kBgImage];
    self.view.layer.contents = (id)[UIImage imageNamed:@"loginBg"].CGImage;
    self.navigationItem.title = kLangualString(@"Contact Us");
    self.addLeftBarMenuButtonEnabled = YES;
    [_nameTextField drawPaddingLess];
    [_emailTextField drawPaddingLess];
    [_subjectTextField drawPaddingLess];
    [_messageTextView cornerradius];
    [_sendButton roundButton];
    
    id<GAITracker> tracker = [GAI sharedInstance].defaultTracker;
    [tracker set:kGAIScreenName value:@"Query View"];
    [tracker send:[[GAIDictionaryBuilder createScreenView] build]];
    
    [_nameTextField drawPadding];
    [_emailTextField drawPadding];
    [_subjectTextField drawPadding];
    _messageTextView.delegate = self;
    if ([UserDefaultManager getUserName].length > 0) {
        [_nameTextField setText:[UserDefaultManager getUserName]];
        [_emailTextField setText:[UserDefaultManager getEmailID]];
    }
    [_nameTextField setPlaceholder:kLangualString(@"Name")];
    [_emailTextField setPlaceholder:kLangualString(@"Email")];
    [_subjectTextField setPlaceholder:kLangualString(@"Subject")];
    [_messageLabel setText:kLangualString(@" Message")];
}

- (BOOL)performValidation {
    if ([_emailTextField.text length] == 0) {
        MHWAlertView *alert = [[MHWAlertView alloc] initWithTitle:kLangualString(@"Alert") message:kLangualString(@"Please enter your name.") delegate:nil cancelButtonTitle:kLangualString(@"OK") otherButtonTitles:nil, nil];
        [alert show];
        return NO;
    }
   else if ([_emailTextField.text length] == 0) {
        MHWAlertView *alert = [[MHWAlertView alloc] initWithTitle:kLangualString(@"Alert") message:kLangualString(@"Please enter your email-id.") delegate:nil cancelButtonTitle:kLangualString(@"OK") otherButtonTitles:nil, nil];
        [alert show];
        return NO;
    }
   else if ([_subjectTextField.text length] == 0) {
        MHWAlertView *alert = [[MHWAlertView alloc] initWithTitle:kLangualString(@"Alert") message:kLangualString(@"Please enter the subject.") delegate:nil cancelButtonTitle:kLangualString(@"OK") otherButtonTitles:nil, nil];
        [alert show];
        return NO;
    }
  else  if ([_messageTextView.text length] == 0) {
        MHWAlertView *alert = [[MHWAlertView alloc] initWithTitle:kLangualString(@"Alert") message:kLangualString(@"Please enter message.") delegate:nil cancelButtonTitle:kLangualString(@"OK") otherButtonTitles:nil, nil];
        [alert show];
        return NO;
  } else {
      return YES;
  }
    
    
}
- (IBAction)sendButtonAction:(id)sender {
    [self.view endEditing:YES];
    if ([self performValidation]) {
        [self.view addSubview:activityIndicatorView];
        [activityIndicatorView startAnimating];
        UserDataModal *user = [UserDataModal new];
        user.emailID = _emailTextField.text;
        user.userName = _nameTextField.text;
        user.password = _subjectTextField.text;
        user.confirmPassword = _messageTextView.text;
        
        [mserviceHandler.homeService query:user success:^(id response) {
            [activityIndicatorView stopAnimating];
                MHWAlertView *alert = [[MHWAlertView alloc] initWithTitle:kLangualString(@"Success") message:kLangualString(@"Your query has been submitted successfully.") delegate:self cancelButtonTitle:kLangualString(@"OK") otherButtonTitles:nil, nil];
                [alert show];
        } failure:^(NSError *error) {
            [activityIndicatorView stopAnimating];
            MHWAlertView *alert = [[MHWAlertView alloc] initWithTitle:kLangualString(@"Error") message:error.localizedDescription delegate:nil cancelButtonTitle:kLangualString(@"OK") otherButtonTitles:nil, nil];
            [alert show];
        } ];
        
    }
}

- (void)textViewDidBeginEditing:(UITextView *)textView {
    _messageLabel.hidden = YES;
    
}

- (void)textViewDidEndEditing:(UITextView *)textView {
    if (textView.text.length > 0) {
        _messageLabel.hidden = YES;
    } else {
        _messageLabel.hidden = NO;
    }
}

- (void)MHWAlertView:(MHWAlertView *)mhwAlertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 0) {
        _messageTextView.text = @"";
        _subjectTextField.text = @"";
        _messageLabel.hidden = NO;
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
