//
//  StepFourViewController.m
//  SatyaSadhna
//
//  Created by Roshan Singh Bisht on 04/06/17.
//  Copyright © 2017 Roshan Singh Bisht. All rights reserved.
//

#import "StepFourViewController.h"
#import "HomeService.h"
#include "UIButton+Layout.h"
#import "UITextField+TextCustomize.h"
#import "RegisterPageOneViewController.h"

@interface StepFourViewController ()<MHWAlertDelegate,UIPickerViewDelegate,UIPickerViewDataSource> {
    NSInteger i;
}

@property (strong,nonatomic)UIPickerView      *pickerView;
@property (strong, nonatomic)NSArray                *data;
@property (strong, nonatomic)NSMutableArray                *fromDate;
@property (strong, nonatomic)NSMutableArray                *toDate;
@property (strong, nonatomic)NSMutableArray                *location;
@property (strong, nonatomic)NSMutableArray                *idArray;
@property (strong, nonatomic)NSMutableArray         *pickerData;
@property (weak, nonatomic) IBOutlet UITextField    *durationtextField;
@property (weak, nonatomic) IBOutlet UIButton       *prevButtn;
@property (weak, nonatomic) IBOutlet UIButton       *registerButton;
@property (assign,nonatomic ) BOOL var;
@property (weak, nonatomic) IBOutlet UILabel *fromToDateLabel;
@property (weak, nonatomic) IBOutlet UILabel *yesLabel;
@property (weak, nonatomic) IBOutlet UIButton *btnPreview;

@end

@implementation StepFourViewController

- (void)getCourse {
    [mserviceHandler.homeService getCourse:^(id response) {
        _data = response;
        _fromDate = [NSMutableArray new];
        _toDate = [NSMutableArray new];
        _location = [NSMutableArray new];
        _idArray = [NSMutableArray new];
        _pickerData = [NSMutableArray new];
        for (NSDictionary *dict in _data) {
                   NSString *str = [NSString stringWithFormat:@"%@ to  %@ , %@",dict[@"date_from"],dict[@"date_to"],dict[@"location"]];
                [_pickerData addObject:str];
                [_fromDate addObject:dict[@"date_from"]];
                [_location addObject:dict[@"location"]];
                [_toDate addObject:dict[@"date_to"]];
                [_idArray addObject:dict[@"id"]];
            
        }
        if ([UserDefaultManager getIndexPath].length > 0 && [UserDefaultManager getIndexPath] != nil && [UserDefaultManager getIndexPath] != NULL) {
            [UserDefaultManager setCourse:nil];
            _fromDate = [NSMutableArray new];
            _toDate = [NSMutableArray new];
            _location = [NSMutableArray new];
            _idArray = [NSMutableArray new];
            _pickerData = [NSMutableArray new];
            NSInteger t = [[UserDefaultManager getIndexPath] integerValue];
            NSDictionary *temp = _data[t];
            NSString *str = [NSString stringWithFormat:@"%@ to  %@ , %@",temp[@"date_from"],temp[@"date_to"],temp[@"location"]];
            [_pickerData addObject:str];
            [_fromDate addObject:temp[@"date_from"]];
            [_location addObject:temp[@"location"]];
            [_toDate addObject:temp[@"date_to"]];
            [_idArray addObject:temp[@"id"]];
            [UserDefaultManager setIndexPath:nil];
            
        }
        
        if ([UserDefaultManager getCourseID].length > 0 && [UserDefaultManager getCourseID] != nil && [UserDefaultManager getCourseID] != NULL) {
            [UserDefaultManager setIsOldStudent:@"Old"];
            NSString *str = [UserDefaultManager getCourseID];
            for (NSDictionary *dict in _data) {
                if ([str isEqualToString:dict[@"id"]]) {
                    _fromDate = [NSMutableArray new];
                    _toDate = [NSMutableArray new];
                    _location = [NSMutableArray new];
                    _idArray = [NSMutableArray new];
                    _pickerData = [NSMutableArray new];
                    NSDictionary *temp = dict;
                    NSString *str = [NSString stringWithFormat:@"%@ to  %@ , %@",temp[@"date_from"],temp[@"date_to"],temp[@"location"]];
                    [_pickerData addObject:str];
                    [_fromDate addObject:temp[@"date_from"]];
                    [_location addObject:temp[@"location"]];
                    [_toDate addObject:temp[@"date_to"]];
                    [_idArray addObject:temp[@"id"]];
                    [UserDefaultManager setCourse:nil];
                }
            }
        }
        [activityIndicatorView  stopAnimating];
    } failure:^(NSError *error) {
        [activityIndicatorView  stopAnimating];
    }];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    _var = NO;
    [self addLeftButton];
    [self.view addSubview:activityIndicatorView];
    [activityIndicatorView startAnimating];
    [_durationtextField drawPaddingLess];
    [_durationtextField setPlaceholder:kLangualString(@"Select Course Duration")];
    [_prevButtn roundButton];
    [_registerButton roundButton];
    [_btnPreview roundButton];
    if(_pickerView == nil) {
        _pickerView = [UIPickerView new];
        _pickerView.dataSource = self;
        _pickerView.delegate = self;
        _pickerView.showsSelectionIndicator = YES;
    }
    [_durationtextField setInputView:_pickerView];
    [self.view updateViewWithApplicationGlobalFont];
    [self addToolBar];
    [self getCourse];
}

- (void)addToolBar {
    //add tool bar on the keyboard with done button for the textFields
    UIToolbar * keyboardToolBar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, 320, 50)];
    keyboardToolBar.barStyle = UIBarStyleBlack;
    keyboardToolBar.tintColor = [UIColor whiteColor];
    [keyboardToolBar setItems: [NSArray arrayWithObjects:
                                [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil],
                                [[UIBarButtonItem alloc]initWithTitle:kLangualString(@"Done") style:UIBarButtonItemStyleDone target:self action:@selector(doneClicked)],nil]];
    _durationtextField.inputAccessoryView = keyboardToolBar;
    
}

-(void) doneClicked {
    [self.view endEditing:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)chekButtonAction:(UIButton *)sender {
    if (sender.selected == YES) {
        sender.selected = NO;
        _var = NO;
    } else {
        sender.selected = YES;
        _var = YES;
    }
    
}

- (void)viewWillAppear:(BOOL)animated {
    self.navigationItem.title = @"Step - Final";
    [self.view setBackgroundColor:kBgImage];
    self.view.layer.contents = (id)[UIImage imageNamed:@"loginBg"].CGImage;
    
    [_fromToDateLabel setText:kLangualString(@"Satya Sadhna Date(From - To)")];
    [ _yesLabel setText:kLangualString(@"Yes, I have understood all rules and I am prepared to strictly follw the time-table, rules till during and end of the stay. i will strictly keep away from any other type of meditation, rites, rituals, fasting, recitation of mantras and prayers and refrain from keeping any relegious / spiritual objects, as well as from all types of intoxicants & drugs for the entire duration of the stay.")];
    [_fromToDateLabel setNumberOfLines:0];
    
    [_prevButtn setTitle:kLangualString(@"< Previous") forState:UIControlStateNormal];
    [_registerButton setTitle:kLangualString(@"Register") forState:UIControlStateNormal];
    [_btnPreview setTitle:kLangualString(@"Preview") forState:UIControlStateNormal];
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


- (void)MHWAlertView:(MHWAlertView *)mhwAlertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 0) {
        [UserDefaultManager setIndexPath:nil];
        AppDelegate *app = (AppDelegate *)[UIApplication sharedApplication].delegate;
        [app transitionToSlideMenu];
    }
}
- (IBAction)registerButtonAction:(UIButton *)sender {
    if (_durationtextField.text.length == 0) {
        MHWAlertView *alert = [[MHWAlertView alloc] initWithTitle:kLangualString(@"Alert") message:kLangualString(@"please select the course duration.") delegate:nil cancelButtonTitle:kLangualString(@"OK") otherButtonTitles:nil, nil];
        [alert show];
        return;
    } if (!_var) {
        MHWAlertView *alert = [[MHWAlertView alloc] initWithTitle:kLangualString(@"Alert") message:kLangualString(@"please accept the terms and coditions first.") delegate:nil cancelButtonTitle:kLangualString(@"OK") otherButtonTitles:nil, nil];
        [alert show];
        return;
    }

    
    if ([[UserDefaultManager getIsOldStudent] isEqualToString:@"New"]) {
        NSDictionary *temp = @{@"datefirstcourse": @"",
                               @"firstplace":@"",
                               @"couductingasistteacher":@"",
                               @"datelastcourse":@"",
                               @"lastplace":@"",
                               @"couductingasistteacherlast":@"",
                               @"days_course_10":@"",
                               @"days_course_20":@"",
                               @"days_course_30":@"",
                               @"days_course_50":@"",
                               @"days_course_60":@"",
                               @"self_course_practiced":@"",
                               @"service_done":@"",
                               @"Courses":@"",
                               //@"dayofcourse":@"",
                              // @"Courses":@"",
                               @"triedanyotherpractice":@"",
                               @"whatelsepracticed":@"",
                               @"triedanyotherpracticesinceInPast":@"",
                               @"practicethistechniqueinfast":@"",
                               @"manyhoursdailyinpast":@"",
                               @"Whatisthereason":@"",
                               @"yourselfbyofmeditationinpast":@""
                               };
        [_dict addEntriesFromDictionary:temp];
        
    }
    
    NSDictionary *tmp = @{@"datefromeform":_fromDate[i],
                          @"datetoform":_toDate[i],
                          @"eventid":_idArray[i],
                          @"location":_location[i],
                          @"do_completed":[UserDefaultManager getIsOldStudent],
                          @"userid":[UserDefaultManager getUserID]
                          };
    [_dict addEntriesFromDictionary:tmp];
    [activityIndicatorView startAnimating];
    [mserviceHandler.homeService form:_dict success:^(id response) {
        
        if ([response[@"success"] boolValue]) {
            [activityIndicatorView stopAnimating];
            MHWAlertView *alert = [[MHWAlertView alloc] initWithTitle:kLangualString(@"Success") message:kLangualString(@"Your form has been submitted successfully.") delegate:self cancelButtonTitle:kLangualString(@"OK") otherButtonTitles:nil, nil];
            [alert show];
        }
    } failure:^(NSError *error) {
        [activityIndicatorView stopAnimating];
    }];
    
    
}
- (IBAction)btnPreviewPressed:(UIButton *)sender {
    [UserDefaultManager setPreview:@"True"];
    
    NSArray *viewControllers = [self.navigationController viewControllers];
    if ([[UserDefaultManager getIsOldStudent] isEqualToString:@"New"]) {
        RegisterPageOneViewController *vc = viewControllers[viewControllers.count - 3];
        vc.allDataDict = _dict;
        [self.navigationController popToViewController:vc animated:YES];
    } else {
        RegisterPageOneViewController *vc = viewControllers[viewControllers.count - 4];
        vc.allDataDict = _dict;
        [self.navigationController popToViewController:vc animated:YES];
    }
    
    
    
  
}

- (IBAction)prevButtonction:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return  _pickerData.count;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    NSString *title = [_pickerData objectAtIndex:row];
    [_durationtextField setText:title];
    i = row;
    return title;
    
}




@end
