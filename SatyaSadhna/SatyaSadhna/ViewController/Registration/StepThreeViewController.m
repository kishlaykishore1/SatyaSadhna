//
//  StepThreeViewController.m
//  SatyaSadhna
//
//  Created by Roshan Singh Bisht on 04/06/17.
//  Copyright © 2017 Roshan Singh Bisht. All rights reserved.
//

#import "StepThreeViewController.h"
#import "UITextField+TextCustomize.h"
#import "UIButton+Layout.h"
#import "UITextView+customize.h"
#import "StepFourViewController.h"

@interface StepThreeViewController ()<UIPickerViewDataSource,UIPickerViewDelegate,MHWAlertDelegate,UITextViewDelegate>

@property (weak, nonatomic) IBOutlet UITextField    *firstDateCourse;
@property (weak, nonatomic) IBOutlet UITextField    *firstPlaceTextFile;
@property (weak, nonatomic) IBOutlet UITextField    *assteacherTextField;
@property (weak, nonatomic) IBOutlet UITextField    *lastDateTextField;
@property (weak, nonatomic) IBOutlet UITextField    *lastPlaceTextField;
@property (weak, nonatomic) IBOutlet UITextField    *asst2TeachertextField;
@property (weak, nonatomic) IBOutlet UITextField    *courseDurationTextField;
@property (weak, nonatomic) IBOutlet UITextField    *coursestextField;
@property (weak, nonatomic) IBOutlet UITextView     *anyOtherCorseTextView;
@property (weak, nonatomic) IBOutlet UIButton       *btnYes;
@property (weak, nonatomic) IBOutlet UIButton       *btnNo;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *hideWhatElsePracticed;

@property (weak, nonatomic) IBOutlet UITextField    *tfWhatElsePracticed;
@property (weak, nonatomic) IBOutlet UIButton       *yesCheckButton;
@property (weak, nonatomic) IBOutlet UIButton       *noCheckButton;
@property (weak, nonatomic) IBOutlet UITextField    *hoursdailyTextField;
@property (weak, nonatomic) IBOutlet UITextField    *chnagesTextField;
@property (weak, nonatomic) IBOutlet UIButton       *previousButton;
@property (weak, nonatomic) IBOutlet UIButton       *nextbutton;
@property (weak, nonatomic) IBOutlet UITextField *tfCourse10Days;
@property (weak, nonatomic) IBOutlet UITextField *tfCourse20Days;
@property (weak, nonatomic) IBOutlet UITextField *tfCourse30Days;
@property (weak, nonatomic) IBOutlet UITextField *tfCourse50Days;
@property (weak, nonatomic) IBOutlet UITextField *tfCourse60Days;
@property (weak, nonatomic) IBOutlet UITextField *tfSelfCourse;
@property (weak, nonatomic) IBOutlet UITextField *tfServicesDone;
@property (weak, nonatomic) IBOutlet UITextField *tfTotalCourse;




@property (strong, nonatomic) UIDatePicker          *datePicker;
@property (strong, nonatomic) UIDatePicker          *datePicker2;
@property (strong , nonatomic)NSDateFormatter       *formatter;
@property (strong , nonatomic)UIPickerView          *durationPicker;
@property (strong , nonatomic)UIPickerView          *lifeStylePickerView;
@property (strong, nonatomic)NSArray                *durationData;
@property (strong, nonatomic)NSArray                *lifeStyleData;
@property (weak, nonatomic) IBOutlet UILabel *placeZHolderLabel;

@property (weak, nonatomic) IBOutlet UILabel *firstCourseLabel;
@property (weak, nonatomic) IBOutlet UILabel *lastCourseLabel;

@property (weak, nonatomic) IBOutlet UILabel *lastCourse2Label;
@property (weak, nonatomic) IBOutlet UILabel *doYouLabel;
@property (weak, nonatomic) IBOutlet UILabel *whatChangesLabel;
@property (weak, nonatomic) IBOutlet UILabel *haveYouTriedLabel;


@end

@implementation StepThreeViewController


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

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
     _btnYes.selected = YES;
    _durationData = [NSArray arrayWithObjects:kLangualString(@"10-Day"),kLangualString(@"20-Day"),kLangualString(@"30-Day"),kLangualString(@"50-Day"),kLangualString(@"60-Day"),kLangualString(@"Self-Course"),kLangualString(@"Service"),nil];
    _lifeStyleData = [NSArray arrayWithObjects:kLangualString(@"Life-Style"),kLangualString(@"Inter-personal relations"),kLangualString(@"Use of intoxicants"),kLangualString(@"Physical and mental health"),kLangualString(@"any other"), nil];
    
    if(_durationPicker == nil) {
        _durationPicker = [UIPickerView new];
        _durationPicker.dataSource = self;
        _durationPicker.delegate = self;
        _durationPicker.showsSelectionIndicator = YES;
        _durationPicker.tag = 3;
    }
    [_courseDurationTextField setInputView:_durationPicker];
    
    if(_lifeStylePickerView == nil) {
        _lifeStylePickerView = [UIPickerView new];
        _lifeStylePickerView.dataSource = self;
        _lifeStylePickerView.delegate = self;
        _lifeStylePickerView.showsSelectionIndicator = YES;
        _lifeStylePickerView.tag = 2;
    }
    [_chnagesTextField setInputView:_lifeStylePickerView];
    _yesCheckButton.selected = YES;
    [_hoursdailyTextField setPlaceholder:kLangualString(@"How many hours a daily?")];
    _anyOtherCorseTextView.delegate = self;
    
    
    [_firstCourseLabel setText:kLangualString(@"First Course")];
    [_haveYouTriedLabel setText:kLangualString(@"Have you tried any other practice since the last course?")];
    [_doYouLabel setText:kLangualString(@"Do you practice the techniques regularly?")];
    [_lastCourseLabel setText:kLangualString(@"Last Course")];
    [_lastCourse2Label setText:kLangualString(@"Course Details")];
    [_firstDateCourse setPlaceholder:kLangualString(@"First Course")];
    [_firstDateCourse setPlaceholder:kLangualString(@"Date First Course")];
    [_firstPlaceTextFile setPlaceholder:kLangualString(@"First Place")];
    [_assteacherTextField setPlaceholder:kLangualString(@"Conducting Asst. Teacher")];
    
    [_lastDateTextField setPlaceholder:kLangualString(@"Date Last Course")];
    [_lastPlaceTextField setPlaceholder:kLangualString(@"Last Place")];
    [_asst2TeachertextField setPlaceholder:kLangualString(@"Conducting Asst. Teacher")];
   // [_courseDurationTextField setPlaceholder:kLangualString(@"Course Duration")];
    [_tfCourse10Days setPlaceholder:kLangualString(@"No.Of Times Attended 10 Days Course")];
    [_tfCourse20Days setPlaceholder:kLangualString(@"No.Of Times Attended 20 Days Course")];
    [_tfCourse30Days setPlaceholder:kLangualString(@"No.Of Times Attended 30 Days Course")];
    [_tfCourse50Days setPlaceholder:kLangualString(@"No.Of Times Attended 50 Days Course")];
    [_tfCourse60Days setPlaceholder:kLangualString(@"No.Of Times Attended 60 Days Course")];
    [_tfSelfCourse setPlaceholder:kLangualString(@"No. Of  Self Course Practiced")];
    [_tfServicesDone setPlaceholder:kLangualString(@"Services Done")];
    [_tfTotalCourse setPlaceholder:kLangualString(@"Total No. Of Courses(Total shivir)")];
    //[_coursestextField setPlaceholder:kLangualString(@"Courses")];
    [_tfWhatElsePracticed setPlaceholder:kLangualString(@"What else did you practice?")];
    [_hoursdailyTextField setPlaceholder:kLangualString(@"How many hours daily?")];
    [_whatChangesLabel setText:kLangualString(@"What chnages have you noticed in yourself by the practice of meditation?")];
    [_chnagesTextField setPlaceholder:kLangualString(@"Select")];
    
    if(_oldDict != nil) {
        [self oldData];
    }
    
    if ([[UserDefaultManager getPreview] isEqualToString:@"True"]) {
        [self setPreviewData];
    }
}

- (void)oldData {
    [_firstDateCourse setText:_oldDict[@"datefromeform"]];
    [_firstPlaceTextFile setText:_oldDict[@"location"]];
    [_assteacherTextField setText:_oldDict[@"couductingasistteacher"]];
    [_lastDateTextField setText:_oldDict[@"datetoform"]];
    [_lastPlaceTextField setText:_oldDict[@"lastplace"]];
    [_asst2TeachertextField setText:_oldDict[@"couductingasistteacherlast"]];
  //  [_courseDurationTextField setText:_oldDict[@"dayofcourse"]];
   // [_coursestextField setText:_oldDict[@"Courses"]];
    [_tfCourse10Days setText:_oldDict[@"days_course_10"]];
    [_tfCourse20Days setText:_oldDict[@"days_course_20"]];
    [_tfCourse30Days setText:_oldDict[@"days_course_30"]];
    [_tfCourse50Days setText:_oldDict[@"days_course_50"]];
    [_tfCourse60Days setText:_oldDict[@"days_course_60"]];
    [_tfSelfCourse setText:_oldDict[@"self_course_practiced"]];
    [_tfServicesDone setText:_oldDict[@"service_done"]];
    [_tfTotalCourse setText:_oldDict[@"Courses"]];
    
    
    //[_anyOtherCorseTextView setText:_oldDict[@"triedanyotherpracticesinceInPast"]];
    
    if ([_oldDict[@"triedanyotherpractice"] boolValue]) {
        [_tfWhatElsePracticed setText:_oldDict[@"whatelsepracticed"]];
        [_btnYes setSelected:YES];
        [_btnNo setSelected:NO];
    } else {
        [_hoursdailyTextField setText:_oldDict[@"manyhoursdailyinpast"]];
        [_btnYes setSelected:NO];
        [_btnNo setSelected:YES];
    }
    
    if ([_oldDict[@"practicethistechniqueinfast"] boolValue]) {
        [_hoursdailyTextField setText:_oldDict[@"manyhoursdailyinpast"]];
        [_yesCheckButton setSelected:YES];
        [_noCheckButton setSelected:NO];
    } else {
        [_chnagesTextField setText:_oldDict[@"Whatisthereason"]];
        [_yesCheckButton setSelected:NO];
        [_noCheckButton setSelected:YES];
    }
    [_chnagesTextField setText:_oldDict[@"yourselfbyofmeditationinpast"]];
    
}

- (void)setPreviewData {
    [_firstDateCourse setText:_allDataDict[@"datefirstcourse"]];
    [_firstPlaceTextFile setText:_allDataDict[@"firstplace"]];
    [_assteacherTextField setText:_allDataDict[@"couductingasistteacher"]];
    [_lastDateTextField setText:_allDataDict[@"datelastcourse"]];
    [_lastPlaceTextField setText:_allDataDict[@"lastplace"]];
    [_asst2TeachertextField setText:_allDataDict[@"couductingasistteacherlast"]];
   // [_courseDurationTextField setText:_allDataDict[@"dayofcourse"]];
  //  [_coursestextField setText:_allDataDict[@"Courses"]];
    [_tfCourse10Days setText:_allDataDict[@"days_course_10"]];
    [_tfCourse20Days setText:_allDataDict[@"days_course_20"]];
    [_tfCourse30Days setText:_allDataDict[@"days_course_30"]];
    [_tfCourse50Days setText:_allDataDict[@"days_course_50"]];
    [_tfCourse60Days setText:_allDataDict[@"days_course_60"]];
    [_tfSelfCourse setText:_allDataDict[@"self_course_practiced"]];
    [_tfServicesDone setText:_allDataDict[@"service_done"]];
    [_tfTotalCourse setText:_allDataDict[@"Courses"]];
    
    
   // [_anyOtherCorseTextView setText:_allDataDict[@"triedanyotherpracticesinceInPast"]];
    
    if ([_allDataDict[@"triedanyotherpractice"] boolValue]) {
        [_tfWhatElsePracticed setText:_allDataDict[@"whatelsepracticed"]];
        [_btnYes setSelected:YES];
        [_btnNo setSelected:NO];
    } else {
        [_hoursdailyTextField setText:_allDataDict[@"manyhoursdailyinpast"]];
        [_btnYes setSelected:NO];
        [_btnNo setSelected:YES];
    }
    
    if ([_allDataDict[@"practicethistechniqueinfast"] boolValue]) {
        [_hoursdailyTextField setText:_allDataDict[@"manyhoursdailyinpast"]];
        [_yesCheckButton setSelected:YES];
        [_noCheckButton setSelected:NO];
    } else {
        [_chnagesTextField setText:_allDataDict[@"Whatisthereason"]];
        [_yesCheckButton setSelected:NO];
        [_noCheckButton setSelected:YES];
    }
    [_chnagesTextField setText:_allDataDict[@"yourselfbyofmeditationinpast"]];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated {
    [self addLeftButton];
    [self.view setBackgroundColor:kBgImage];
    self.view.layer.contents = (id)[UIImage imageNamed:@"loginBg"].CGImage;
    self.navigationItem.title = @"Step 3";
    
    [_firstDateCourse drawPaddingLess];
    [_firstPlaceTextFile drawPaddingLess];
    [_assteacherTextField drawPaddingLess];
    [_asst2TeachertextField drawPaddingLess];
    
    [_lastDateTextField drawPaddingLess];
    [_tfCourse10Days drawPaddingLess];
    [_tfCourse20Days drawPaddingLess];
    [_tfCourse30Days drawPaddingLess];
    [_tfCourse50Days drawPaddingLess];
    [_tfCourse60Days drawPaddingLess];
    [_tfSelfCourse drawPaddingLess];
    [_tfServicesDone drawPaddingLess];
    [_tfTotalCourse drawPaddingLess];
    [_lastPlaceTextField drawPaddingLess];
  //  [_courseDurationTextField drawPaddingLess];
   // [_coursestextField drawPaddingLess];
    [_tfWhatElsePracticed drawPaddingLess];
    [_hoursdailyTextField drawPaddingLess];
    [_chnagesTextField drawPaddingLess];
    [_anyOtherCorseTextView drawPaddingLess];
    [_nextbutton roundButton];
    [_previousButton roundButton];
    
    [_nextbutton setTitle:kLangualString(@"Next") forState:UIControlStateNormal];
    [_previousButton setTitle:kLangualString(@"Previous") forState:UIControlStateNormal];
    
    
    [self addToolBar];
    _datePicker    = [[UIDatePicker alloc ]init];
    _datePicker.maximumDate = [NSDate date];
    [_datePicker addTarget:self action:@selector(dobDatePickerMethod:) forControlEvents:UIControlEventValueChanged];
    _datePicker.datePickerMode  = UIDatePickerModeDate;
    [_firstDateCourse setInputView:_datePicker];
    [_datePicker setMaximumDate:[NSDate date]];
    
    _datePicker2    = [[UIDatePicker alloc ]init];
    _datePicker2.tag = 1;
    _datePicker2.maximumDate = [NSDate date];
    [_datePicker2 addTarget:self action:@selector(dobDatePickerMethod:) forControlEvents:UIControlEventValueChanged];
    _datePicker2.datePickerMode  = UIDatePickerModeDate;
    [_lastDateTextField setInputView:_datePicker2];
    [_datePicker2 setMaximumDate:[NSDate date]];
    _formatter = [[NSDateFormatter alloc] init];
    _formatter.dateFormat = @"dd MMM yyyy";
    [_anyOtherCorseTextView setTextColor:[UIColor blackColor]];
    [self.view updateViewWithApplicationGlobalFont];
    _hoursdailyTextField.keyboardType = UIKeyboardTypePhonePad;
    
    
}

- (void) dobDatePickerMethod:(UIDatePicker *)datePicker {
    if (datePicker.tag == 1) {
        _lastDateTextField.text = [NSString stringWithFormat:@"%@",[_formatter stringFromDate:_datePicker2.date]];
    } else {
        _firstDateCourse.text = [NSString stringWithFormat:@"%@",[_formatter stringFromDate:_datePicker.date]];
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
    _firstDateCourse.inputAccessoryView = keyboardToolBar;
    _lastDateTextField.inputAccessoryView = keyboardToolBar;
   // _courseDurationTextField.inputAccessoryView = keyboardToolBar;
    _tfCourse10Days.inputAccessoryView = keyboardToolBar;
    _tfCourse20Days.inputAccessoryView = keyboardToolBar;
    _tfCourse30Days.inputAccessoryView = keyboardToolBar;
    _tfCourse50Days.inputAccessoryView = keyboardToolBar;
    _tfCourse60Days.inputAccessoryView = keyboardToolBar;
    _tfSelfCourse.inputAccessoryView = keyboardToolBar;
    _tfServicesDone.inputAccessoryView = keyboardToolBar;
    _tfTotalCourse.inputAccessoryView = keyboardToolBar;
    _chnagesTextField.inputAccessoryView = keyboardToolBar;
    _hoursdailyTextField.inputAccessoryView = keyboardToolBar;
    
}

-(void) doneClicked {
    [self.view endEditing:YES];
}

- (IBAction)previousAction:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
    
    
}

- (void)createAlertwithTitle:(NSString *)title andMessage:(NSString *)message {
    MHWAlertView *alert = [[MHWAlertView alloc] initWithTitle:title message:message delegate:nil cancelButtonTitle:kLangualString(@"OK") otherButtonTitles:nil, nil];
    [alert show];
}

//_courseDurationTextField.text.length == 0 || _coursestextField.text.length == 0 ||


- (BOOL) validation {
    if (_firstDateCourse.text.length ==0 || _firstPlaceTextFile.text.length == 0 || _assteacherTextField.text.length == 0 || _lastDateTextField.text.length == 0 || _lastPlaceTextField.text.length == 0 || _asst2TeachertextField.text.length == 0 ||
        _tfCourse10Days.text.length == 0 || _tfCourse20Days.text.length == 0 || _tfCourse30Days.text.length == 0 || _tfCourse50Days.text.length == 0 || _tfCourse60Days.text.length == 0 || _tfSelfCourse.text.length == 0 || _tfServicesDone.text.length == 0 || _tfTotalCourse.text.length == 0 ||
          _hoursdailyTextField.text.length == 0 || _chnagesTextField.text.length == 0) {
        [self createAlertwithTitle:kLangualString(@"Alert") andMessage:kLangualString(@"Please fill all fields.")];
        return NO;
    } else if (![_btnYes isSelected] && ![_btnNo isSelected]) {
        [self createAlertwithTitle:kLangualString(@"Alert") andMessage:kLangualString(@"Please check if you tried any practice if you do or else select no.")];
        return NO;
    } else if (![_yesCheckButton isSelected] && ![_noCheckButton isSelected]) {
        [self createAlertwithTitle:kLangualString(@"Alert") andMessage:kLangualString(@"Please check your practice if you do or else select no.")];
        return NO;
    } else if ([_yesCheckButton isSelected]){
        if ([_hoursdailyTextField.text integerValue] > 24) {
            [self createAlertwithTitle:kLangualString(@"Alert") andMessage:kLangualString(@"Please check hours under 24.")];
            return NO;
        } else {
            return YES;
        }
    }
    else {
        return  YES;
    }
    
}
- (IBAction)nextAction:(id)sender {
    
    if ([self validation] && [Internet checkNetConnection]) {
        
        NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
        [dateFormat setDateFormat:@"dd MMM yyyy"];
        NSDate *date = [dateFormat dateFromString:_firstDateCourse.text];
        NSDate *date1 = [dateFormat dateFromString:_lastDateTextField.text];
        
        //,@"dayofcourse",@"Courses"
        //IF dates are equal and start date < end date
        if([date compare:date1] == NSOrderedAscending || [date compare:date1] == NSOrderedSame) {
            if (_dict.allKeys.count > 37) {
                NSArray *arr = @[@"datefirstcourse",@"firstplace",@"couductingasistteacher",@"datelastcourse",@"lastplace",@"couductingasistteacherlast",@"days_course_10",@"days_course_20",@"days_course_30",@"days_course_50",@"days_course_60",@"self_course_practiced",@"service_done",@"Courses",@"triedanyotherpracticesinceinpast",@"whatelsepracticed",@"practicethistechniqueinfast",@"manyhoursdailyinpast",@"Whatisthereason",@"yourselfbyofmeditationinpast"];
                [_dict removeObjectsForKeys:arr];
            }
            
            NSDictionary *temp = @{@"datefirstcourse": _firstDateCourse.text,
                                   @"firstplace":_firstPlaceTextFile.text,
                                   @"couductingasistteacher":_assteacherTextField.text,
                                   @"datelastcourse":_lastDateTextField.text,
                                   @"lastplace":_lastPlaceTextField.text,
                                   @"couductingasistteacherlast":_asst2TeachertextField.text,
                                   @"days_course_10":_tfCourse10Days.text,
                                   @"days_course_20":_tfCourse20Days.text,
                                   @"days_course_30":_tfCourse30Days.text,
                                   @"days_course_50":_tfCourse50Days.text,
                                   @"days_course_60":_tfCourse60Days.text,
                                   @"self_course_practiced":_tfSelfCourse.text,
                                   @"service_done":_tfServicesDone.text,
                                   @"Courses":_tfTotalCourse.text,
                                  // @"dayofcourse":_courseDurationTextField.text,
                                  // @"Courses":_coursestextField.text,
                                   @"triedanyotherpracticesinceinpast":[_btnYes isSelected] ? @"Yes": @"No",
                                   @"whatelsepracticed":[_btnYes isSelected] ? _tfWhatElsePracticed.text : @"",
                                   //@"triedanyotherpracticesinceInPast":_anyOtherCorseTextView.text,
                                   @"practicethistechniqueinfast":[_yesCheckButton isSelected] ? @"Yes": @"No",
                                   @"manyhoursdailyinpast":[_yesCheckButton isSelected] ? _hoursdailyTextField.text : @"",
                                   @"Whatisthereason":[_noCheckButton isSelected]? _hoursdailyTextField.text : @"",
                                   @"yourselfbyofmeditationinpast":_chnagesTextField.text
            };
            [_dict addEntriesFromDictionary:temp];
            
            StepFourViewController *vc = [SecondStoryBoard instantiateViewControllerWithIdentifier:@"stepFourVC"];
            vc.dict = [NSMutableDictionary new];
            vc.dict = _dict;
            [self.navigationController pushViewController:vc animated:YES];
            
        } else if([date compare:date1] == NSOrderedDescending) {
            MHWAlertView *alertView = [[MHWAlertView alloc] initWithTitle:kLangualString(@"Error") message:kLangualString(@"End date cannot be greater than start date.") delegate:nil cancelButtonTitle:kLangualString(@"OK") otherButtonTitles:nil, nil];
            [alertView show];
        }
        
    }
}

- (IBAction)buttonActionMethods:(UIButton *)sender {
    [self.view endEditing:YES];
    if (sender.tag == 12) {
        _btnYes.selected = YES;
        _btnNo.selected = NO;
        _hideWhatElsePracticed.priority = 997;
        [UIView animateWithDuration:0.5 animations:^{
            [self.view layoutIfNeeded];
        } completion:^(BOOL finished) {
            _tfWhatElsePracticed.text = @"";
            _tfWhatElsePracticed.hidden = NO;
        }];
    } else {
        _btnYes.selected = NO;
        _btnNo.selected = YES;
        _hideWhatElsePracticed.priority = 999;
        [UIView animateWithDuration:0.5 animations:^{
            [self.view layoutIfNeeded];
            _tfWhatElsePracticed.hidden = YES;
        } completion:^(BOOL finished) {
            
        }];
    }
}

- (IBAction)actionMethod:(UIButton *)sender {
    [self.view endEditing:YES];
    if (sender.tag == 7) {
        _hoursdailyTextField.text = @"";
        _hoursdailyTextField.keyboardType = UIKeyboardTypePhonePad;
        [_hoursdailyTextField setPlaceholder:kLangualString(@"How many hours a daily?")];
        _yesCheckButton.selected = YES;
        _noCheckButton.selected = NO;
        
    } else {
        _hoursdailyTextField.text = @"";
        _hoursdailyTextField.keyboardType = UIKeyboardTypeDefault;
        [_hoursdailyTextField setPlaceholder:kLangualString(@"if No, what is the reason?")];
        _yesCheckButton.selected = NO;
        _noCheckButton.selected = YES;
    }
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    if (pickerView.tag == 3) {
        return  _durationData.count;
    } else {
        return _lifeStyleData.count;
    }
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    switch (pickerView.tag) {
        case 3: {
            NSString *title = [_durationData objectAtIndex:row];
            //            [_courseDurationTextField setText:title];
            return title;
        }  break;
        case 2:{
            
            NSString *title = [_lifeStyleData objectAtIndex:row];
            //            [_chnagesTextField setText:title];
            return title;
        } break;
            
        default:
            break;
    }
    return 0;
}

- (void) pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    switch (pickerView.tag) {
        case 3: {
            NSString *title = [_durationData objectAtIndex:row];
            [_courseDurationTextField setText:title];
        }  break;
        case 2:{
            
            NSString *title = [_lifeStyleData objectAtIndex:row];
            [_chnagesTextField setText:title];
        } break;
            
        default:
            break;
    }
}

- (void)MHWAlertView:(MHWAlertView *)mhwAlertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 0) {
        [UserDefaultManager setIndexPath:nil];
        AppDelegate *app = (AppDelegate *)[UIApplication sharedApplication].delegate;
        [app transitionToSlideMenu];
    }
}

- (void)textViewDidBeginEditing:(UITextView *)textView {
    _placeZHolderLabel.hidden = YES;
}

- (void)textViewDidEndEditing:(UITextView *)textView {
    if (textView.text.length > 0) {
        _placeZHolderLabel.hidden = YES;
    } else {
        _placeZHolderLabel.hidden = NO;
    }
}

@end
