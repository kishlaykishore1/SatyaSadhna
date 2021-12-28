//
//  DonateFormViewController.m
//  SatyaSadhna
//
//  Created by Roshan Singh Bisht on 10/06/17.
//  Copyright © 2017 Roshan Singh Bisht. All rights reserved.
//

#import "DonateFormViewController.h"
#import "HomeService.h"
#import "UITextField+TextCustomize.h"
#import "UIButton+Layout.h"


@interface DonateFormViewController ()<UIPickerViewDelegate,UIPickerViewDataSource>
@property (weak, nonatomic) IBOutlet UITextField *nameTextField;
@property (weak, nonatomic) IBOutlet UITextField *addressTextField;
@property (weak, nonatomic) IBOutlet UITextField *phoneTextField;
@property (weak, nonatomic) IBOutlet UITextField *emailtextField;
@property (weak, nonatomic) IBOutlet UITextField *panTextField;
@property (weak, nonatomic) IBOutlet UITextField *amountTextField;
@property (weak, nonatomic) IBOutlet UITextField *modetextField;
@property (weak, nonatomic) IBOutlet UIButton       *submitButton;
@property (strong, nonatomic) UIPickerView          *pickerView;
@property (strong, nonatomic) NSArray               *pickerData;

@end

@implementation DonateFormViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _pickerData = [NSArray arrayWithObjects:kLangualString(@"Cash"),kLangualString(@"Cheque"),kLangualString(@"Online Transfer"),kLangualString(@"Other"), nil];
    // Do any additional setup after loading the view.
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
    _modetextField.inputAccessoryView = keyboardToolBar;
    _phoneTextField.inputAccessoryView = keyboardToolBar;
}

- (void)doneClicked {
    [_modetextField resignFirstResponder];
    [_phoneTextField resignFirstResponder];
}

- (void)viewWillAppear:(BOOL)animated {
    
    id<GAITracker> tracker = [GAI sharedInstance].defaultTracker;
    [tracker set:kGAIScreenName value:@"Appointment"];
    [tracker send:[[GAIDictionaryBuilder createScreenView] build]];
    [self.view setBackgroundColor:kBgImage];
    self.view.layer.contents = (id)[UIImage imageNamed:@"loginBg"].CGImage;
    self.navigationItem.title = kLangualString(@"Donation Form");
    self.addLeftBarBarBackButtonEnabled = YES;
    [_nameTextField drawPaddingLess];
    [_addressTextField drawPaddingLess];
    [_phoneTextField drawPaddingLess];
    [_emailtextField drawPaddingLess];
    [_panTextField drawPaddinWithoutImage];
    [_amountTextField drawPaddinWithoutImage];
    [_modetextField drawPaddinWithoutImage];
    [_submitButton cornerradiusforButton];
    _amountTextField.keyboardType = UIKeyboardTypeNumberPad;
    [self addToolBar];
    if(_pickerView == nil) {
        _pickerView = [UIPickerView new];
        _pickerView.dataSource = self;
        _pickerView.delegate = self;
        _pickerView.showsSelectionIndicator = YES;
    }
    [_modetextField setInputView:_pickerView];
    if ([UserDefaultManager getEmailID].length > 0 && [UserDefaultManager getEmailID] != nil ) {
        [_nameTextField setText:[UserDefaultManager getUserName]];
        [_phoneTextField setText:[UserDefaultManager getMobileNo]];
        _emailtextField.text = [UserDefaultManager getEmailID];
    }
    
    [_nameTextField setPlaceholder:kLangualString(@"Name")];
    [_addressTextField setPlaceholder:kLangualString(@"Address")];
    [_phoneTextField setPlaceholder:kLangualString(@"Phone")];
    [_emailtextField setPlaceholder:kLangualString(@"Email")];
    [_panTextField setPlaceholder:kLangualString(@"PAN No.")];
    [_amountTextField setPlaceholder:kLangualString(@"How much like to Donate.")];
    [_modetextField setPlaceholder:kLangualString(@"Payment-Mode")];
    [_submitButton setTitle:kLangualString(@"Submit") forState:UIControlStateNormal];
}

- (BOOL)perform {
    if (_emailtextField.text.length == 0 || _addressTextField.text.length == 0 || _phoneTextField.text.length == 0 || _nameTextField.text.length == 0 ) {
        [self createAlertwithTitle:kLangualString(@"Empty Values") andMessage:kLangualString(@"Please fill all fields.")];
        return NO;
    } else if(![_emailtextField isEmailCorrect]) {
        [self createAlertwithTitle:kLangualString(@"Email Error") andMessage:kLangualString(@"Please enter valid Email Id.")];
        return NO;
    } else if ( ![_phoneTextField isCorrectPhoneNo]) {
        [self createAlertwithTitle:kLangualString(@"Phone No Error") andMessage:kLangualString(@"Please enter valid Phone no.")];
        return NO;
    } else {
        return YES;
    }
}

- (void)createAlertwithTitle:(NSString *)title andMessage:(NSString *)message {
    MHWAlertView *alert = [[MHWAlertView alloc] initWithTitle:title message:message delegate:nil cancelButtonTitle:kLangualString(@"OK") otherButtonTitles:nil, nil];
    [alert show];
}

- (IBAction)submitAction:(UIButton *)sender {
    [self.view endEditing:YES];
    if ([self perform]) {
        if ([Internet checkNetConnection]) {
            [self.view addSubview:activityIndicatorView];
            [activityIndicatorView startAnimating];
            NSDictionary *param = @{@"name":_nameTextField.text,
                                    @"address":_addressTextField.text,
                                    @"contact_no":_phoneTextField.text,
                                    @"email":_emailtextField.text,
                                    @"pan_no":_panTextField.text,
                                    @"amount":_amountTextField.text,
                                    @"payment_type":_modetextField.text
                                    };
            [mserviceHandler.homeService donationForm:param success:^(id response) {
                [activityIndicatorView stopAnimating];
                
                [self createAlertwithTitle:kLangualString(@"Success") andMessage:kLangualString(@"Your form has been submitted successfully.")];
            } failure:^(NSError *error) {
                [activityIndicatorView stopAnimating];
                [self createAlertwithTitle:kLangualString(@"Error") andMessage:error.localizedDescription];
            }];
            
            
        }
    }
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return  1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return  _pickerData.count;
}
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    [_modetextField setText:[_pickerData objectAtIndex:row]];
    NSString *title = [_pickerData objectAtIndex:row];
    return title;
}

@end
