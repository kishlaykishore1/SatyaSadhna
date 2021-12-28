//
//  AppointMentViewController.m
//  SatyaSadhna
//
//  Created by Roshan Singh Bisht on 08/06/17.
//  Copyright © 2017 Roshan Singh Bisht. All rights reserved.
//

#import "AppointMentViewController.h"
#import "HomeService.h"
#import "UITextView+customize.h"
#import "UITextField+TextCustomize.h"
#import "UIButton+Layout.h"
#import "UserDataModal.h"

@interface AppointMentViewController ()<UITextViewDelegate,MHWAlertDelegate,UIPickerViewDelegate,UIPickerViewDataSource>
@property (weak, nonatomic) IBOutlet UITextField *nameTextField;
@property (weak, nonatomic) IBOutlet UITextField *phoneTextField;
@property (weak, nonatomic) IBOutlet UITextView *textView;
@property (weak, nonatomic) IBOutlet UILabel    *label;
@property (weak, nonatomic) IBOutlet UIButton   *submitButon;
@property (strong, nonatomic) UIPickerView        *namePicker;
@property (strong, nonatomic) NSArray             *nameArray;
@property (weak, nonatomic) IBOutlet UITextField *appointmentWithTextField;

@end

@implementation AppointMentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _textView.delegate = self;
    [_nameTextField drawPaddingLess];
    [_nameTextField setPlaceholder:kLangualString(@"Name")];
    [_phoneTextField drawPaddingLess];
    [_phoneTextField setPlaceholder:@"Phone"];
    [_appointmentWithTextField drawPaddingLess];
    [_appointmentWithTextField setPlaceholder:kLangualString(@"Appointment With")];
    [_textView cornerradius];
    [_label setText:kLangualString(@" Appointment Reason")];
    [_submitButon roundButton];
    [_submitButon setTitle:kLangualString(@"Submit") forState:UIControlStateNormal];
    _nameArray = @[@"Jin Chandra Suri Maharaj",@"Surendra Daga",@"Shalini Lodha",@"Vikas Chopra"];
    
    if(_namePicker == nil) {
        _namePicker = [UIPickerView new];
        _namePicker.dataSource = self;
        _namePicker.delegate = self;
        _namePicker.showsSelectionIndicator = YES;
    }
    [_appointmentWithTextField setInputView:_namePicker];
    [self addToolBar];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated {
    [self.view setBackgroundColor:kBgImage];
    self.view.layer.contents = (id)[UIImage imageNamed:@"loginBg"].CGImage;
    self.addLeftBarBarBackButtonEnabled = YES;
    self.navigationItem.title = kLangualString(@"Appointment");
    [UserDefaultManager getUserName].length > 0 ? [_nameTextField setText:[UserDefaultManager getUserName]] : @"";
    [UserDefaultManager getMobileNo].length > 0 ? [_phoneTextField setText:[UserDefaultManager getMobileNo]] : @"";
    [self.view updateViewWithApplicationGlobalFont];
    
    id<GAITracker> tracker = [GAI sharedInstance].defaultTracker;
    [tracker set:kGAIScreenName value:@"Appointment"];
    [tracker send:[[GAIDictionaryBuilder createScreenView] build]];
}

- (void)textViewDidBeginEditing:(UITextView *)textView {
    _label.hidden = YES;
}

- (void)textViewDidEndEditing:(UITextView *)textView {
    if (textView.text.length > 0) {
        _label.hidden = YES;
    } else {
        _label.hidden = NO;
    }
}

- (BOOL)perform {
    
    if (_nameTextField.text.length == 0 || _phoneTextField.text.length == 0 || _appointmentWithTextField.text.length == 0 ) {
        MHWAlertView *alert = [[MHWAlertView alloc]initWithTitle:kLangualString(@"Alert") message:kLangualString(@"Please fill all fields.") delegate:nil cancelButtonTitle:kLangualString(@"OK") otherButtonTitles:nil, nil];
        [alert show];
        [_submitButon setUserInteractionEnabled:YES];
        return NO;
    } else {
        return YES;
        
    }
}
- (IBAction)submitaction:(id)sender {
    [_submitButon setUserInteractionEnabled:NO];
    [self.view endEditing:YES];
    if ([Internet checkNetConnection]) {
        if ([self perform]) {
            [activityIndicatorView startAnimating];
            UserDataModal *data = [UserDataModal new];
            data.userName = _nameTextField.text;
            data.phoneNo = _phoneTextField.text;
            data.password = _textView.text;
            data.confirmPassword = _appointmentWithTextField.text;
            [mserviceHandler.homeService appointment:data success:^(id response) {
                [activityIndicatorView stopAnimating];
                if ([response[@"success"] boolValue]) {
                    [_textView setText:@""];
                    MHWAlertView *alert = [[MHWAlertView alloc]initWithTitle:kLangualString(@"Alert") message:kLangualString(@"Thanks for scheduling appointment. We will get back to you ASAP.") delegate:self cancelButtonTitle:kLangualString(@"OK") otherButtonTitles:nil, nil];
                    [alert show];
                    [_submitButon setUserInteractionEnabled:YES];
                }
               
            } failure:^(NSError *error) {
                [activityIndicatorView stopAnimating];
                MHWAlertView *alert = [[MHWAlertView alloc]initWithTitle:kLangualString(@"Alert") message:error.localizedDescription delegate:nil cancelButtonTitle:kLangualString(@"OK") otherButtonTitles:nil, nil];
                [alert show];
                [_submitButon setUserInteractionEnabled:YES];
            }];
        }
    } else {
        [_submitButon setUserInteractionEnabled:YES];
    }
}

- (void)addToolBar {
    //add tool bar on the keyboard with done button for the textFields
    UIToolbar * keyboardToolBar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, 320, 50)];
    keyboardToolBar.barStyle = UIBarStyleBlack;
    keyboardToolBar.tintColor = [UIColor whiteColor];
    [keyboardToolBar setItems: [NSArray arrayWithObjects:
                                [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil],
                                [[UIBarButtonItem alloc]initWithTitle:@"Done" style:UIBarButtonItemStyleDone target:self action:@selector(doneClicked)],nil]];
    _appointmentWithTextField.inputAccessoryView = keyboardToolBar;
}
- (void) doneClicked {
    [self.view endEditing:YES];
}

- (void)MHWAlertView:(MHWAlertView *)mhwAlertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 0) {
        [self.navigationController popViewControllerAnimated:YES];
    }
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return  1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return  _nameArray.count;
}
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    [_appointmentWithTextField setText:kLangualString([_nameArray objectAtIndex:row])];
    NSString *title = kLangualString([_nameArray objectAtIndex:row]);
    return title;
}

@end
