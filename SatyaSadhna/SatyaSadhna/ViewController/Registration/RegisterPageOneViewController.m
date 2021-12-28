//
//  RegisterPageOneViewController.m
//  SatyaSadhna
//
//  Created by Roshan Singh Bisht on 21/05/17.
//  Copyright © 2017 Roshan Singh Bisht. All rights reserved.
//

#import "HomeService.h"
#import "RegisterPageOneViewController.h"
#import "MHWAlertView.h"
#import "UITextField+TextCustomize.h"
#import "UIButton+Layout.h"
#import "StepTwoViewController.h"

@interface RegisterPageOneViewController () <UIPickerViewDataSource,UIPickerViewDelegate,MHWAlertDelegate>{
    
}
@property (weak, nonatomic) IBOutlet UILabel        *professionalDetailsLabel;
@property (weak, nonatomic) IBOutlet UILabel        *otherLanguagesLabel;
@property (weak, nonatomic) IBOutlet UILabel        *genderLabel;
@property (weak, nonatomic) IBOutlet UIButton       *maleButton;
@property (weak, nonatomic) IBOutlet UIButton       *femaleButton;
@property (weak, nonatomic) IBOutlet UITextField    *maritalstatusTextField;
@property (weak, nonatomic) IBOutlet UITextField    *dobTextField;
@property (weak, nonatomic) IBOutlet UITextField    *ageTextField;
@property (weak, nonatomic) IBOutlet UITextField    *educationTextFied;
@property (weak, nonatomic) IBOutlet UITextField    *emailAddressTextField;
@property (weak, nonatomic) IBOutlet UITextField    *phoneTextField;
@property (weak, nonatomic) IBOutlet UITextField    *mobileTextField;
@property (weak, nonatomic) IBOutlet UITextField    *motherToungeTextField;
@property (weak, nonatomic) IBOutlet UIButton       *hindiButton;
@property (weak, nonatomic) IBOutlet UIButton       *englishButton;
@property (weak, nonatomic) IBOutlet UITextField    *addressTextField;
@property (weak, nonatomic) IBOutlet UITextField    *nativeCountryTextField;
@property (weak, nonatomic) IBOutlet UITextField    *designationTextField;
@property (weak, nonatomic) IBOutlet UITextField    *departmentTextField;
@property (weak, nonatomic) IBOutlet UITextField    *companyTextField;
@property (weak, nonatomic) IBOutlet UITextField    *officeAdreddTextField;
@property (weak, nonatomic) IBOutlet UITextField    *pincodeTextField;
@property (weak, nonatomic) IBOutlet UIButton       *saveContinueButton;
@property (weak, nonatomic) IBOutlet UIImageView    *hindiImageView;
@property (weak, nonatomic) IBOutlet UIImageView    *englishImageView;
@property (weak, nonatomic) IBOutlet UIView         *mainView;
@property (strong, nonatomic) NSDateFormatter       *formatter;
@property (strong, nonatomic) UIDatePicker          *datePicker;
@property (strong, nonatomic) UIPickerView          *pickerView;
@property (strong, nonatomic) NSArray               *pickerData;
@property (strong, nonatomic) NSString               *gender;
@property (strong, nonatomic) NSString               *otherLanguge;
@property (strong, nonatomic) NSString               *otherLanguge1;
@property (strong, nonatomic) NSMutableDictionary               *dict1;


@end

@implementation RegisterPageOneViewController

@synthesize nameTextField,fathertextField;


- (void)viewWillAppear:(BOOL)animated {
    [_maritalstatusTextField drawPaddingLess];
    [_dobTextField drawPaddingLess];
    [_ageTextField drawPaddingLess];
    [nameTextField drawPaddingLess];
    [fathertextField drawPaddingLess];
    [_educationTextFied drawPaddingLess];
    [_emailAddressTextField drawPaddinWithoutImage];
    [_phoneTextField drawPaddinWithoutImage];
    [_mobileTextField drawPaddinWithoutImage];
    [_motherToungeTextField drawPaddingLess];
    [_addressTextField drawPaddingLess];
    [_nativeCountryTextField drawPaddingLess];
    [_designationTextField drawPaddingLess];
    [_departmentTextField drawPaddinWithoutImage];
    [_companyTextField drawPaddinWithoutImage];
    [_officeAdreddTextField drawPaddinWithoutImage];
    [_pincodeTextField drawPaddingLess];
    [_saveContinueButton roundButton];
    
    id<GAITracker> tracker = [GAI sharedInstance].defaultTracker;
    [tracker set:kGAIScreenName value:@"Register View"];
    [tracker send:[[GAIDictionaryBuilder createScreenView] build]];
    
    [self addToolBar];
    _datePicker    = [[UIDatePicker alloc ]init];
    _datePicker.maximumDate = [NSDate date];
    [_datePicker addTarget:self action:@selector(dobDatePickerMethod) forControlEvents:UIControlEventValueChanged];
    _datePicker.datePickerMode  = UIDatePickerModeDate;
    [_dobTextField setInputView:_datePicker];
    [_datePicker setMaximumDate:[NSDate date]];
    _formatter = [[NSDateFormatter alloc] init];
    _formatter.dateFormat = @"dd MMM yyyy";
    nameTextField.text = [UserDefaultManager getUserName].length > 0 ? [UserDefaultManager getUserName] : @"";
    _emailAddressTextField.text = [UserDefaultManager getEmailID].length > 0 ? [UserDefaultManager getEmailID] : @"";
    _phoneTextField.text = [UserDefaultManager getMobileNo].length > 0 ? [UserDefaultManager getMobileNo] : @"";
   
   
    _pincodeTextField.keyboardType = UIKeyboardTypePhonePad;
    _phoneTextField.keyboardType = UIKeyboardTypePhonePad;
    _mobileTextField.keyboardType = UIKeyboardTypePhonePad;
    _emailAddressTextField.keyboardType = UIKeyboardTypeEmailAddress;
    _ageTextField.keyboardType = UIKeyboardTypePhonePad;
    
    [self.view updateViewWithApplicationGlobalFont];
    
    
    [nameTextField setPlaceholder:kLangualString(@"Name")];
    [_dobTextField setPlaceholder:kLangualString(@"Date of Birth")];
    [_ageTextField setPlaceholder:kLangualString(@"Age")];
    [_maritalstatusTextField setPlaceholder:kLangualString(@"Marital Status")];
    [fathertextField setPlaceholder:kLangualString(@"Father / Husband's Name")];
    [_educationTextFied setPlaceholder:kLangualString(@"Education")];
    [_emailAddressTextField setPlaceholder:kLangualString(@"Email")];
    [_phoneTextField setPlaceholder:kLangualString(@"Phone")];
    [_mobileTextField setPlaceholder:kLangualString(@"Mobile (In Case Of Emergency)")];
    [_motherToungeTextField setPlaceholder:kLangualString(@"Mother Tounge")];
    [_addressTextField setPlaceholder:kLangualString(@"Address (Street, City, State)")];
    [_pincodeTextField setPlaceholder:kLangualString(@"Pin Code")];
    [_nativeCountryTextField setPlaceholder:kLangualString(@"Native Country")];
    [_designationTextField setPlaceholder:kLangualString(@"Designation")];
    [_departmentTextField setPlaceholder:kLangualString(@"Department")];
    [_companyTextField setPlaceholder:kLangualString(@"Company's Name")];
    [_officeAdreddTextField setPlaceholder:kLangualString(@"Office Address (Street, City, State)")];
    [_saveContinueButton setTitle:kLangualString(@"Save & Continue") forState:UIControlStateNormal];
    [_genderLabel setText:kLangualString(@"Gender")];
    [_professionalDetailsLabel setText:kLangualString(@"Professional Details")];
    [_otherLanguagesLabel setText:kLangualString(@"Other languages you understand well")];
    [_maleButton setTitle:kLangualString(@"Male") forState:UIControlStateNormal];
    [_maleButton setTitle:kLangualString(@"Male") forState:UIControlStateSelected];
    
    [_femaleButton setTitle:kLangualString(@"Female") forState:UIControlStateNormal];
    
    [_femaleButton setTitle:kLangualString(@"Female") forState:UIControlStateSelected];
    
    [_hindiButton setTitle:kLangualString(@"Hindi") forState:UIControlStateNormal];
    
    [_englishButton setTitle:kLangualString(@"English") forState:UIControlStateNormal];
    
//    if (_dict != nil) {
//        [self setData];
//    }
}

- (void)setData {
    [nameTextField setText:_dict[@"firstname"]];
    [fathertextField setText:_dict[@"fathername"]];
    [_dobTextField setText:_dict[@"dateofbirth"]];
    [_ageTextField setText:_dict[@"age"]];
    [_educationTextFied setText:_dict[@"education"]];
    [_emailAddressTextField setText:_dict[@"emailaddress"]];
    [_mobileTextField setText:_dict[@"mobile"]];
    [_phoneTextField setText:_dict[@"mobile"]];
    [_motherToungeTextField setText:_dict[@"mothertongue"]];
    [_addressTextField setText:_dict[@"addressstreercitystate"]];
    [_pincodeTextField setText:_dict[@"pincode"]];
    [_nativeCountryTextField setText:_dict[@"pincode"]];
    [_designationTextField setText:_dict[@"department"]];
    [_departmentTextField setText:_dict[@"desigantion"]];
    [_companyTextField setText:_dict[@"companyname"]];
    [_maritalstatusTextField setText:_dict[@"maritalstatus"]];
    [_officeAdreddTextField setText:_dict[@"officeaddress"]];
    if ([_dict[@"gander"] isEqualToString:@"Male"]) {
        _maleButton.selected = YES;
        _gender = @"male";
        _femaleButton.selected = NO;
        
    } else {
        _maleButton.selected = NO;
        _gender = @"female";
        _femaleButton.selected = YES;
    }
}

- (void) dobDatePickerMethod {
    _dobTextField.text = [NSString stringWithFormat:@"%@",[_formatter stringFromDate:_datePicker.date]];
    NSDate *date1 = _datePicker.date;
    NSDate *date2 = [NSDate date];
    
    NSTimeInterval secondsBetween = [date2 timeIntervalSinceDate:date1];
    
    int numberOfDays = secondsBetween / (86400 *365);
    [_ageTextField setText:[NSString stringWithFormat:@"%d",numberOfDays]];
    NSLog(@"There are %d days in between the two dates.", numberOfDays);
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:kBgImage];
    self.view.layer.contents = (id)[UIImage imageNamed:@"loginBg"].CGImage;
    [_ageTextField setUserInteractionEnabled:NO];
    [UserDefaultManager setPreview:@"False"];
    self.navigationItem.title = @"Step 1";
    [self addLeftButton];
    if(_pickerView == nil) {
        _pickerView = [UIPickerView new];
        _pickerView.dataSource = self;
        _pickerView.delegate = self;
        _pickerView.showsSelectionIndicator = YES;
    }
    _pickerData = @[kLangualString(@"Single"),kLangualString(@"Married"),kLangualString(@"Widower"),kLangualString(@"Widow"),kLangualString(@"Seprated"),kLangualString(@"Divorced")];
    [_maritalstatusTextField setInputView:_pickerView];
   
    if ([[UserDefaultManager getIsOldStudent] isEqualToString:@"New"]) {
        
    } else {
       [self setOldData];
    }
    
    
}

- (void)addLeftButton {
    //This is for add back button and it should be called from viewWillAppear
    UIButton *btnBack = [UIButton buttonWithType:UIButtonTypeCustom];
    [btnBack setFrame:CGRectMake(0, 0, 20, 20)];
    [btnBack setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    [btnBack addTarget:self action:@selector(actionLeftBarButton:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *barButton =[[UIBarButtonItem alloc] initWithCustomView:btnBack];
    self.navigationItem.leftBarButtonItem = barButton;
    
}
- (void)actionLeftBarButton:(UIButton*)sender {
    MHWAlertView *alert = [[MHWAlertView alloc] initWithTitle:kLangualString(@"Exit") message:kLangualString(@"Do you want to cancel the Registration?") delegate:self cancelButtonTitle:kLangualString(@"Yes") otherButtonTitles:kLangualString(@"No"), nil];
    [alert show];
}

- (void)addToolBar {
    //add tool bar on the keyboard with done button for the textFields
    UIToolbar * keyboardToolBar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, 320, 50)];
    keyboardToolBar.barStyle = UIBarStyleBlack;
    keyboardToolBar.tintColor = [UIColor whiteColor];
    [keyboardToolBar setItems: [NSArray arrayWithObjects:
                                [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil],
                                [[UIBarButtonItem alloc]initWithTitle:@"Done" style:UIBarButtonItemStyleDone target:self action:@selector(doneClicked)],nil]];
    _dobTextField.inputAccessoryView = keyboardToolBar;
    _maritalstatusTextField.inputAccessoryView = keyboardToolBar;
    _pincodeTextField.inputAccessoryView  =keyboardToolBar;
    _mobileTextField.inputAccessoryView = keyboardToolBar;
    _phoneTextField.inputAccessoryView = keyboardToolBar;
    _ageTextField.inputAccessoryView = keyboardToolBar;
}

- (void)doneClicked {
    [self.view endEditing:YES];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)genderSelectAction:(UIButton *)sender {
    if (sender.tag == 1) {
        _maleButton.selected = YES;
        _gender = @"male";
        _femaleButton.selected = NO;
        
    } else {
        _maleButton.selected = NO;
        _gender = @"female";
        _femaleButton.selected = YES;
    }
}

- (void)setOtherLanguageSelection:(UIButton *)sender {
    switch (sender.tag) {
        case 3: {
            if (sender.selected == YES) {
                sender.selected = NO;
                _otherLanguge = @"";
                [_hindiImageView setImage:[UIImage imageNamed:@"unselectedCheckBox"]];
            } else {
                sender.selected = YES;
                [_hindiImageView setImage:[UIImage imageNamed:@"selectedCheckBox"]];
                _otherLanguge = @"hindi";
            }
        }
            break;
        case 4:{
            if (sender.selected == YES) {
                sender.selected = NO;
                _otherLanguge1 = @"";
                [_englishImageView setImage:[UIImage imageNamed:@"unselectedCheckBox"]];
            } else {
                sender.selected = YES;
                _otherLanguge1 = @"english";
                [_englishImageView setImage:[UIImage imageNamed:@"selectedCheckBox"]];
            }
        }
        default:
            break;
    }
}
- (IBAction)languageSelectionAction:(UIButton *)sender {
    [self setOtherLanguageSelection:sender];
}

- (BOOL)performValidation {
    if ([nameTextField.text length]  ==  0 || fathertextField.text.length == 0 || _maritalstatusTextField.text.length == 0 || _dobTextField.text.length == 0 || _ageTextField.text.length == 0 || _educationTextFied.text.length == 0 ||  _motherToungeTextField.text.length  == 0 || _addressTextField.text.length == 0 || _pincodeTextField.text.length == 0 || _nativeCountryTextField.text.length == 0 ||  _designationTextField.text.length ==0 ||   _phoneTextField.text.length == 0) {
        [self createAlertwithTitle:kLangualString(@"Alert") andMessage:kLangualString(@"Please fill all fields.")];
        return NO;
    } else if (![_emailAddressTextField isEmailCorrect]) {
        [self createAlertwithTitle:kLangualString(@"Alert") andMessage:kLangualString(@"Please enter correct Email Id.")];
        return NO;
    } else if (![_mobileTextField isCorrectPhoneNo]) {
        [self createAlertwithTitle:kLangualString(@"Alert") andMessage:kLangualString(@"Please enter correct mobile no.")];
        return NO;
    } else if (![_phoneTextField isCorrectPhoneNo]) {
        [self createAlertwithTitle:kLangualString(@"Alert") andMessage:kLangualString(@"Please enter correct phone no.")];
        return NO;
    }  else if (_gender.length == 0){
        [self createAlertwithTitle:kLangualString(@"Alert") andMessage:kLangualString(@"Please enter your gender.")];
        return NO;
    } else if ([_ageTextField.text integerValue] < 5){
        [self createAlertwithTitle:kLangualString(@"Alert") andMessage:kLangualString(@"Please enter age above 5.")];
        return NO;
    }
    else {
        return YES;
    }
   
}


- (IBAction)saveContinueAction:(id)sender {
    [self.view endEditing:YES];
    if ([Internet checkNetConnection] && [self performValidation]) {

        _dict1 = [NSMutableDictionary new];
        [_dict1 setObject:nameTextField.text forKey:@"firstname"];
        [_dict1 setObject:fathertextField.text forKey:@"fathername"];
        [_dict1 setObject:_gender forKey:@"gander"];
        [_dict1 setObject:_maritalstatusTextField.text forKey:@"maritalstatus"];
        [_dict1 setObject:_dobTextField.text forKey:@"dateofbirth"];
        [_dict1 setObject:_ageTextField.text forKey:@"age"];
        [_dict1 setObject:_educationTextFied.text forKey:@"education"];
        [_dict1 setObject:_emailAddressTextField.text forKey:@"emailaddress"];
        [_dict1 setObject:_phoneTextField.text forKey:@"phonehomework"];
        [_dict1 setObject:_mobileTextField.text forKey:@"mobile"];
        [_dict1 setObject:_motherToungeTextField.text forKey:@"mothertongue"];
        [_otherLanguge isEqualToString:@"hindi"] ? [_dict1 setObject:@"hindi" forKey:@"languagehindi"] : [_dict1 setObject:@"" forKey:@"languagehindi"];
        [_otherLanguge isEqualToString:@"english"] ? [_dict1 setObject:@"english" forKey:@"languagehindien"] : [_dict1 setObject:@"" forKey:@"languagehindien"];
        [_dict1 setObject:_addressTextField.text forKey:@"addressstreercitystate"];
        [_dict1 setObject:_pincodeTextField.text forKey:@"pincode"];
        [_dict1 setObject:_nativeCountryTextField.text forKey:@"nativecountry"];
        [_dict1 setObject:_designationTextField.text forKey:@"desigantion"];
        [_dict1 setObject:_departmentTextField.text forKey:@"department"];
        [_dict1 setObject:_companyTextField.text forKey:@"companyname"];
        [_dict1 setObject:_officeAdreddTextField.text forKey:@"officeAddress"];
     
        
        StepTwoViewController *vc = [SecondStoryBoard instantiateViewControllerWithIdentifier:@"steptwoVC"];
        vc.dct = [NSMutableDictionary new];
        vc.dct = _dict1;
        vc.oldDict = _dict;
        if ([[UserDefaultManager getPreview] isEqualToString:@"True"]) {
        vc.allDataDict = _allDataDict;
        } else {
        
        }
       
        [self.navigationController pushViewController:vc animated:YES];
        
    }

}


- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return  1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return  _pickerData.count;
}
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    NSString *title = [_pickerData objectAtIndex:row];
    return title;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    [_maritalstatusTextField setText:[_pickerData objectAtIndex:row]];

}

- (void)createAlertwithTitle:(NSString *)title andMessage:(NSString *)message {
    MHWAlertView *alert = [[MHWAlertView alloc] initWithTitle:title message:message delegate:nil cancelButtonTitle:kLangualString(@"OK") otherButtonTitles:nil, nil];
    [alert show];
}

- (void)MHWAlertView:(MHWAlertView *)mhwAlertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 0) {
        [UserDefaultManager setIndexPath:nil];
        AppDelegate *app = (AppDelegate *)[UIApplication sharedApplication].delegate;
        [app transitionToSlideMenu];
    }
}

- (void)setOldData {
     // NSString *userID = [UserDefaultManager getUserID];
    NSDictionary *param = @{@"user_id": [UserDefaultManager getUserID]};
    
    if ([Internet checkNetConnection]) {
        [self.view addSubview:activityIndicatorView];
        [activityIndicatorView startAnimating];
        [mserviceHandler.homeService getOldUserData:param success:^(id response) {
            _dict = response[@"page_result"];
            if (_dict != nil) {
                   [self setData];
               }
            [activityIndicatorView stopAnimating];
        } failure:^(NSError *error) {
            [activityIndicatorView stopAnimating];
        }];
    }
}

@end
