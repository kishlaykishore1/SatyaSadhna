//
//  StepTwoViewController.m
//  SatyaSadhna
//
//  Created by Roshan Singh Bisht on 21/05/17.
//  Copyright © 2017 Roshan Singh Bisht. All rights reserved.
//

#import "StepTwoViewController.h"
#import "UITextField+TextCustomize.h"
#import "UIButton+Layout.h"
#import "StepThreeViewController.h"
#import "StepFourViewController.h"
#import "UIKit+AFNetworking.h"
#import "AFHTTPRequestOperationManager.h"
#import "AFHTTPSessionManager.h"
#import "BaseService.h"
#import "Internet.h"
#import "NetworkManager.h"
#import <AssetsLibrary/AssetsLibrary.h>
#import "UIImageView+AFNetworking.h"



@interface StepTwoViewController () <MHWAlertDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,NSURLSessionDelegate,NSURLSessionTaskDelegate,NSURLSessionDataDelegate>

// is any know person attending this course section and check button
@property (weak, nonatomic) IBOutlet UIButton *yesCheckButton1;
@property (weak, nonatomic) IBOutlet UIButton *noCheckButton1;
@property (weak, nonatomic) IBOutlet UITextField *relationTextField;
@property (weak, nonatomic) IBOutlet UITextField *nameTextField;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *familyMemberDoneACourseToknowPerson; // isko high karne se relation and name hide ho jayenge


// has anyone is family done teh course section

@property (weak, nonatomic) IBOutlet UITextField *relationTextField2;
@property (weak, nonatomic) IBOutlet UIButton *yesCheckButton2;
@property (weak, nonatomic) IBOutlet UIButton *noCheckButton2;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *physcicalAligmentToDoneAnyCourse;
@property (weak, nonatomic) IBOutlet UIImageView *img1;


// any Physical aliment
@property (weak, nonatomic) IBOutlet UIButton *yesCheckButton3;
@property (weak, nonatomic) IBOutlet UIButton *noCheckButton3;
@property (weak, nonatomic) IBOutlet UITextField *inPastTextField;
@property (weak, nonatomic) IBOutlet UITextField *inPresentTextField;
@property (weak, nonatomic) IBOutlet UITextField *tfDoctorsName;
@property (weak, nonatomic) IBOutlet UITextField *tfDoctorsPhoneNo;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *physcologicalToPhysical;
@property (weak, nonatomic) IBOutlet UILabel *lblPhysicalFitnessCer;

@property (weak, nonatomic) IBOutlet UIImageView *imgPhysological;


// and phsycological aliment
@property (weak, nonatomic) IBOutlet UIButton *yesCheckButton4;
@property (weak, nonatomic) IBOutlet UIButton *noCheckButton4;
@property (weak, nonatomic) IBOutlet UITextField *inPasttextField2;
@property (weak, nonatomic) IBOutlet UITextField *inPresenttextField2;
@property (weak, nonatomic) IBOutlet UITextField *tfDoctorsName2;
@property (weak, nonatomic) IBOutlet UITextField *tfDoctorsPhoneNo2;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bringCertiToPhyscological;
@property (weak, nonatomic) IBOutlet UILabel *lblPsychologicalCer;



// medice regularly
@property (weak, nonatomic) IBOutlet UIButton *yesCheckButton5;
@property (weak, nonatomic) IBOutlet UIButton *noCheckButtton5;
@property (weak, nonatomic) IBOutlet UITextField *medicineNameTextField;
@property (weak, nonatomic) IBOutlet UITextField *medicineDose;
@property (weak, nonatomic) IBOutlet UITextField *howdidYouLearn;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *briefDiscussion;

@property (weak, nonatomic) IBOutlet UIButton *yesCheckButton6;
@property (weak, nonatomic) IBOutlet UIButton *nocheckButton6;

@property (weak, nonatomic) IBOutlet UIButton *prevButton;

@property (weak, nonatomic) IBOutlet UIButton *nextButton;
@property (weak, nonatomic) IBOutlet UIScrollView *scroll;

@property (weak, nonatomic) IBOutlet UITextView *textViewtext;




@property (weak, nonatomic) IBOutlet UILabel *isAnyKnownPersonAttendingLabel;
@property (weak, nonatomic) IBOutlet UILabel *hasAnyoneinFamilyLabel;
@property (weak, nonatomic) IBOutlet UILabel *anyPhysicalAlitmentLabel;
@property (weak, nonatomic) IBOutlet UILabel *anyPhyscologicalLabel;
@property (weak, nonatomic) IBOutlet UILabel *isYesCertiLabel;
@property (weak, nonatomic) IBOutlet UILabel *ifTakingAnyMedicineLabel;
@property (weak, nonatomic) IBOutlet UILabel *beignProfessionalLabel;

#define POST_BODY_BOURDARY  @"boundary"

@end

@implementation StepTwoViewController

NSInteger checkImage = 1;
NSString *apiData = @"";
NSString *apiData1 = @"";
NSMutableData  *receiveData ;
- (void)viewDidLoad {
    [super viewDidLoad];
//    [self.view addSubview:activityIndicatorView];
//    [activityIndicatorView startAnimating];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(physicalPrescription:)];
    UITapGestureRecognizer *tap1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(physcologicalPrescription:)];
    tap.numberOfTapsRequired = 1; //You can change this is double tap ect..
    tap1.numberOfTapsRequired = 1;
    _img1.userInteractionEnabled = YES;
    _imgPhysological.userInteractionEnabled = YES;
    [_img1 addGestureRecognizer:tap];
    [_imgPhysological addGestureRecognizer:tap1];
    
    _yesCheckButton1.selected = YES;
    _yesCheckButton2.selected = YES;
    _yesCheckButton3.selected = YES;
    _yesCheckButton4.selected = YES;
    _yesCheckButton5.selected = YES;
    _yesCheckButton6.selected = YES;
    [self.view updateViewWithApplicationGlobalFont];
    
    [_relationTextField setPlaceholder:kLangualString(@"Relation")];
    [_nameTextField setPlaceholder:kLangualString(@"Name")];
    [_relationTextField2 setPlaceholder:kLangualString(@"Relation")];
    [_inPastTextField setPlaceholder:kLangualString(@"In Past")];
    [_inPresentTextField setPlaceholder:kLangualString(@"In Present")];
    [_tfDoctorsName setPlaceholder:kLangualString(@"Doctor's name")];
    [_tfDoctorsPhoneNo setPlaceholder:kLangualString(@"Doctor's mobile number")];
    [_inPasttextField2 setPlaceholder:kLangualString(@"In Past")];
    [_inPresenttextField2 setPlaceholder:kLangualString(@"In Present")];
    [_tfDoctorsName2 setPlaceholder:kLangualString(@"Doctor's name")];
    [_tfDoctorsPhoneNo2 setPlaceholder:kLangualString(@"Doctor's mobile number")];
    [_medicineNameTextField setPlaceholder:kLangualString(@"Medicine Name")];
    [_medicineDose setPlaceholder:kLangualString(@"Medicine Dose")];
    [_howdidYouLearn setPlaceholder:kLangualString(@"How did you learn about the course?")];
    [_nextButton setTitle:kLangualString(@"Next") forState:UIControlStateNormal];
    [_prevButton setTitle:kLangualString(@"Previous") forState:UIControlStateNormal];
    [_isAnyKnownPersonAttendingLabel setText:kLangualString(@"Is any know person attending this coure with you?")];
    [_hasAnyoneinFamilyLabel setText:kLangualString(@"Has anyone in the family done a course?")];
    [_anyPhysicalAlitmentLabel setText:kLangualString(@"Any physical aliment (use separet ,if needed)?")];
    [_anyPhyscologicalLabel setText:kLangualString(@"Any psychological aliment/addiction (Give details on seprate sheet)?")];
    [_isYesCertiLabel setText:kLangualString(@"if yes, kindly bring a fitness cerificate from doctor.")];
    [_ifTakingAnyMedicineLabel setText:kLangualString(@"if taking any medicine regularly have you bought it with you.")];
    [_beignProfessionalLabel setText:kLangualString(@"Brief personal background Aim of joining the course ( present mental state, any special incident,family,social background etc.)")];
    [_lblPsychologicalCer setText:kLangualString(@"Please Select Your Psychological Fitness Certificate From Doctor")];
    [_lblPhysicalFitnessCer setText:kLangualString(@"Please Select Your Physical Fitness Certificate From Doctor")];
    [_yesCheckButton1 setTitle:kLangualString(@"Yes") forState:UIControlStateNormal];
    [_yesCheckButton1 setTitle:kLangualString(@"Yes") forState:UIControlStateSelected];
    
    [_yesCheckButton2 setTitle:kLangualString(@"Yes") forState:UIControlStateNormal];
    [_yesCheckButton2 setTitle:kLangualString(@"Yes") forState:UIControlStateSelected];
    
    [_yesCheckButton3 setTitle:kLangualString(@"Yes") forState:UIControlStateNormal];
    [_yesCheckButton3 setTitle:kLangualString(@"Yes") forState:UIControlStateSelected];
    
    [_yesCheckButton4 setTitle:kLangualString(@"Yes") forState:UIControlStateNormal];
    [_yesCheckButton4 setTitle:kLangualString(@"Yes") forState:UIControlStateSelected];
    
    [_yesCheckButton5 setTitle:kLangualString(@"Yes") forState:UIControlStateNormal];
    [_yesCheckButton5 setTitle:kLangualString(@"Yes") forState:UIControlStateSelected];
    
    [_yesCheckButton6 setTitle:kLangualString(@"Yes") forState:UIControlStateNormal];
    [_yesCheckButton6 setTitle:kLangualString(@"Yes") forState:UIControlStateSelected];
    
    
    [_noCheckButton1 setTitle:kLangualString(@"No") forState:UIControlStateNormal];
    [_noCheckButton1 setTitle:kLangualString(@"No") forState:UIControlStateSelected];
    
    [_noCheckButton2 setTitle:kLangualString(@"No") forState:UIControlStateNormal];
    [_noCheckButton2 setTitle:kLangualString(@"No") forState:UIControlStateSelected];
    
    [_noCheckButton3 setTitle:kLangualString(@"No") forState:UIControlStateNormal];
    [_noCheckButton3 setTitle:kLangualString(@"No") forState:UIControlStateSelected];
    
    [_noCheckButton4 setTitle:kLangualString(@"No") forState:UIControlStateNormal];
    [_noCheckButton4 setTitle:kLangualString(@"No") forState:UIControlStateSelected];
    
    [_noCheckButtton5 setTitle:kLangualString(@"No") forState:UIControlStateNormal];
    [_noCheckButtton5 setTitle:kLangualString(@"No") forState:UIControlStateSelected];
    
    [_nocheckButton6 setTitle:kLangualString(@"No") forState:UIControlStateNormal];
    [_nocheckButton6 setTitle:kLangualString(@"No") forState:UIControlStateSelected];
    
    if (_oldDict != nil) {
        [self setData];
    }
    if ([[UserDefaultManager getPreview] isEqualToString:@"True"]) {
        [self setPreviewData];
    }
}

- (void)setData {
    if ([_oldDict[@"anyKnowpersonattending"] boolValue]) {
        [self setDataForAnyKnownPersonAttendingThecourse:1];
    } else {
        [self setDataForAnyKnownPersonAttendingThecourse:2];
    }
    
    if ([_oldDict[@"relationname1"] length] > 0 && _oldDict[@"relationname1"] != nil) {
        [self setDataForAnyMemberDoneTheCourse:3];
    } else {
        [self setDataForAnyMemberDoneTheCourse:4];
    }
    
    if ([_oldDict[@"physical_alignment"] boolValue]) {
        [_inPresentTextField setText:_oldDict[@"Physicalalignmantinprsent"]];
        [_inPastTextField setText:_oldDict[@"Physicalalignmantinpast"]];
        [_tfDoctorsName setText:_oldDict[@"physical_doctor_name"]];
        [_tfDoctorsPhoneNo setText:_oldDict[@"physical_doctor_mobile"]];
        [_img1 setImageWithURL:_oldDict[@"physical_doctor_prescription"]];
        
        [self setDataForPastPhysicalAlighment:5];
    } else {
        [self setDataForPastPhysicalAlighment:6];
    }
    
    if ([_oldDict[@"psychological_alignment"] boolValue]) {
        [_inPasttextField2 setText:_oldDict[@"givedetailonsepratesheetpast"]];
        [_inPresenttextField2 setText:_oldDict[@"givedetailonsepratesheetinprsent"]];
        [_tfDoctorsName2 setText:_oldDict[@"psychological_doctor_name"]];
        [_tfDoctorsPhoneNo2 setText:_oldDict[@"psychological_doctor_mobile"]];
        [_imgPhysological setImageWithURL:_oldDict[@"psychological_doctor_prescription"]];
        
        [self setDataForPastPsycologyAlighment:7];
    } else {
        [self setDataForPastPsycologyAlighment:8];
    }
    
    if ([_oldDict[@"kindlybringafitnesscertificat"] boolValue]) {
        _yesCheckButton6.selected = YES;
        _nocheckButton6.selected = NO;
    } else {
        _nocheckButton6.selected = YES;
        _yesCheckButton6.selected = NO;
    }
    
    if ([_oldDict[@"anymedicineregularlyhav"] boolValue]) {
        [_medicineDose setText:_oldDict[@"madicinedose"]];
        [_medicineNameTextField setText:_oldDict[@"madicinename"]];
        [self setDataForMedicineDose:9];
    } else {
        [self setDataForMedicineDose:10];
    }
    
    if ([_oldDict[@"howdidulearnaboutcourse"] length] > 0  && _oldDict[@"howdidulearnaboutcourse"] != nil) {
        [_howdidYouLearn setText:_oldDict[@"howdidulearnaboutcourse"]];
    }
    
    if ([_oldDict[@"brefpersonalbackgroungaimjoingcourse"] length] > 0  && _oldDict[@"brefpersonalbackgroungaimjoingcourse"] != nil) {
        [_textViewtext setText:_oldDict[@"brefpersonalbackgroungaimjoingcourse"]];
    }
}

- (void)setPreviewData {
    if ([_allDataDict[@"anyKnowpersonattending"] boolValue]) {
        [self setDataForAnyKnownPersonAttendingThecourse:1];
    } else {
        [self setDataForAnyKnownPersonAttendingThecourse:2];
    }
    
    if ([_allDataDict[@"relationname1"] length] > 0 && _allDataDict[@"relationname1"] != nil) {
        [self setDataForAnyMemberDoneTheCourse:3];
    } else {
        [self setDataForAnyMemberDoneTheCourse:4];
    }
    
    if ([_allDataDict[@"physical_alignment"] boolValue]) {
        [_inPresentTextField setText:_allDataDict[@"Physicalalignmantinprsent"]];
        [_inPastTextField setText:_allDataDict[@"Physicalalignmantinpast"]];
        [_tfDoctorsName setText:_allDataDict[@"physical_doctor_name"]];
        [_tfDoctorsPhoneNo setText:_allDataDict[@"physical_doctor_mobile"]];
        [_img1 setImageWithURL:_oldDict[@"physical_doctor_prescription"]];
        [self setDataForPastPhysicalAlighment:5];
    } else {
        [self setDataForPastPhysicalAlighment:6];
    }
    
    if ([_allDataDict[@"psychological_alignment"] boolValue]) {
        [_inPasttextField2 setText:_allDataDict[@"givedetailonsepratesheetpast"]];
        [_inPresenttextField2 setText:_allDataDict[@"givedetailonsepratesheetinprsent"]];
        [_tfDoctorsName2 setText:_allDataDict[@"psychological_doctor_name"]];
        [_tfDoctorsPhoneNo2 setText:_allDataDict[@"psychological_doctor_mobile"]];
        [_imgPhysological setImageWithURL:_oldDict[@"psychological_doctor_prescription"]];
        [self setDataForPastPsycologyAlighment:7];
    } else {
        [self setDataForPastPsycologyAlighment:8];
    }
    
    if ([_allDataDict[@"kindlybringafitnesscertificat"] boolValue]) {
        _yesCheckButton6.selected = YES;
        _nocheckButton6.selected = NO;
    } else {
        _nocheckButton6.selected = YES;
        _yesCheckButton6.selected = NO;
    }
    
    if ([_allDataDict[@"anymedicineregularlyhav"] boolValue]) {
        [_medicineDose setText:_allDataDict[@"madicinedose"]];
        [_medicineNameTextField setText:_allDataDict[@"madicinename"]];
        [self setDataForMedicineDose:9];
    } else {
        [self setDataForMedicineDose:10];
    }
    
    if ([_allDataDict[@"howdidulearnaboutcourse"] length] > 0  && _allDataDict[@"howdidulearnaboutcourse"] != nil) {
        [_howdidYouLearn setText:_allDataDict[@"howdidulearnaboutcourse"]];
    }
    
    if ([_allDataDict[@"brefpersonalbackgroungaimjoingcourse"] length] > 0  && _allDataDict[@"brefpersonalbackgroungaimjoingcourse"] != nil) {
        [_textViewtext setText:_allDataDict[@"brefpersonalbackgroungaimjoingcourse"]];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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

- (void)viewWillAppear:(BOOL)animated {
    [self.view setBackgroundColor:kBgImage];
    self.view.layer.contents = (id)[UIImage imageNamed:@"loginBg"].CGImage;
    self.navigationItem.title = kLangualString(@"Step 2");
    [self  addLeftButton];
    
    [_relationTextField drawPaddingLess];
    [_nameTextField drawPaddingLess];
    
    [_relationTextField2 drawPaddingLess];
    [_inPastTextField drawPaddingLess];
    [_inPresentTextField drawPaddingLess];
    [_tfDoctorsName drawPaddinWithoutImage];
    [_tfDoctorsPhoneNo drawPaddinWithoutImage];
    
    [_inPresenttextField2 drawPaddingLess];
    [_inPasttextField2 drawPaddingLess];
    [_tfDoctorsName2 drawPaddinWithoutImage];
    [_tfDoctorsPhoneNo2 drawPaddinWithoutImage];
    [_medicineDose drawPaddingLess];
    [_medicineNameTextField drawPaddingLess];
    [_howdidYouLearn drawPaddingLess];
    
    [_prevButton roundButton];
    [_nextButton roundButton];
    
}

-(void)setDataForAnyKnownPersonAttendingThecourse:(NSInteger)tag {
    
    switch (tag) {
        case 1:{
            _yesCheckButton1.selected = YES;
            _noCheckButton1.selected = NO;
            _familyMemberDoneACourseToknowPerson.priority = 997;
            [UIView animateWithDuration:0.5 animations:^{
                [self.view layoutIfNeeded];
            } completion:^(BOOL finished) {
                _nameTextField.hidden = NO;
                _relationTextField.hidden = NO;
            }];
            
            
        } break;
        case 2:{
            _yesCheckButton1.selected = NO;
            _noCheckButton1.selected = YES;
            _familyMemberDoneACourseToknowPerson.priority = 999;
            [UIView animateWithDuration:0.5 animations:^{
                [self.view layoutIfNeeded];
                _nameTextField.hidden = YES;
                _relationTextField.hidden = YES;
            } completion:^(BOOL finished) {
                
            }];
            
        } break;
        default:
            break;
    }
}


- (IBAction)actionMethod1:(UIButton *)sender {
    [self setDataForAnyKnownPersonAttendingThecourse:sender.tag];
}

- (void)setDataForAnyMemberDoneTheCourse:(NSInteger)sender {
    switch (sender) {
        case 3: {
            _yesCheckButton2.selected = YES;
            _noCheckButton2.selected  = NO;
            _physcicalAligmentToDoneAnyCourse.priority = 997;
            [UIView animateWithDuration:0.5 animations:^{
                [self.view layoutIfNeeded];
            } completion:^(BOOL finished) {
                _relationTextField2.hidden = NO;
            }];
            
        }
            break;
        case 4:{
            
            _yesCheckButton2.selected = NO;
            _noCheckButton2.selected  = YES;
            _physcicalAligmentToDoneAnyCourse.priority = 999;
            [UIView animateWithDuration:0.5 animations:^{
                [self.view layoutIfNeeded];
                _relationTextField2.hidden = YES;
            } completion:^(BOOL finished) {
                
            }];
            
        } break;
        default:
            break;
    }
}

-(void)physicalPrescription:(UITapGestureRecognizer *)sender
{
    checkImage = 2;
    [self showImagePickerView];
    
}

-(void)physcologicalPrescription:(UITapGestureRecognizer *)sender
{
    checkImage = 1;
    [self showImagePickerView];
}

- (IBAction)actionMethod2:(UIButton *)sender {
    [self setDataForAnyMemberDoneTheCourse:sender.tag];
}

- (void)setDataForPastPhysicalAlighment:(NSInteger)sender {
    switch (sender) {
        case 5:{
            _yesCheckButton3.selected = YES;
            _noCheckButton3.selected = NO;
            _physcologicalToPhysical.priority = 997;
            [UIView animateWithDuration:0.5 animations:^{
                [self.view layoutIfNeeded];
            } completion:^(BOOL finished) {
                _inPastTextField.hidden = NO;
                _inPresentTextField.hidden = NO;
                _tfDoctorsName.hidden = NO;
                _tfDoctorsPhoneNo.hidden = NO;
                _img1.hidden = NO;
                _lblPhysicalFitnessCer.hidden = NO;
            }];
        }
            break;
        case 6:{
            _yesCheckButton3.selected = NO;
            _noCheckButton3.selected = YES;
            _physcologicalToPhysical.priority = 999;
            [UIView animateWithDuration:0.5 animations:^{
                [self.view layoutIfNeeded];
                _inPastTextField.hidden = YES;
                _inPresentTextField.hidden = YES;
                _tfDoctorsName.hidden = YES;
                _tfDoctorsPhoneNo.hidden = YES;
                _img1.hidden = YES;
                _lblPhysicalFitnessCer.hidden = YES;
            } completion:^(BOOL finished) {
                
            }];
            
        }
        default:
            break;
    }
}

- (IBAction)actionMethod3:(UIButton *)sender {
    [self setDataForPastPhysicalAlighment:sender.tag];
}

- (void)setDataForPastPsycologyAlighment:(NSInteger)sender {
    switch (sender) {
        case 7: {
            _yesCheckButton4.selected = YES;
            _noCheckButton4.selected = NO;
            _bringCertiToPhyscological.priority = 997;
            [UIView animateWithDuration:0.5 animations:^{
                [self.view layoutIfNeeded];
            } completion:^(BOOL finished) {
                _inPasttextField2.hidden = NO;
                _inPresenttextField2.hidden = NO;
                _tfDoctorsName2.hidden = NO;
                _tfDoctorsPhoneNo2.hidden = NO;
                _imgPhysological.hidden = NO;
                _lblPsychologicalCer.hidden = NO;
            }];
        }
            break;
        case 8: {
            _yesCheckButton4.selected = NO;
            _noCheckButton4.selected = YES;
            _bringCertiToPhyscological.priority = 999;
            [UIView animateWithDuration:0.5 animations:^{
                [self.view layoutIfNeeded];
                _inPasttextField2.hidden = YES;
                _inPresenttextField2.hidden = YES;
                _tfDoctorsName2.hidden = YES;
                _tfDoctorsPhoneNo2.hidden = YES;
                _imgPhysological.hidden = YES;
                _lblPsychologicalCer.hidden = YES;
            } completion:^(BOOL finished) {
                
            }];
            
            
        }
        default:
            break;
    }
}
- (IBAction)actionMethod4:(UIButton *)sender {
    [self setDataForPastPsycologyAlighment:sender.tag];
}

- (void)setDataForMedicineDose:(NSInteger)sender {
    switch (sender) {
        case 9:{
            _yesCheckButton5.selected = YES;
            _noCheckButtton5.selected = NO;_briefDiscussion.priority = 997;
            [UIView animateWithDuration:0.5 animations:^{
                [self.view layoutIfNeeded];
            } completion:^(BOOL finished) {
                _medicineNameTextField.hidden = NO;
                _medicineDose.hidden = NO;
            }];
            
            
        }
            break;
        case 10:{
            _yesCheckButton5.selected = NO;
            _noCheckButtton5.selected = YES;_briefDiscussion.priority = 999;
            [UIView animateWithDuration:0.5 animations:^{
                [self.view layoutIfNeeded];
                _medicineNameTextField.hidden = YES;
                _medicineDose.hidden = YES;
            } completion:^(BOOL finished) {
                
            }];
            
        } break;
        default:
            break;
    }
}
- (IBAction)actionMethod5:(UIButton *)sender {
    [self setDataForMedicineDose:sender.tag];
    
}

- (IBAction)actionMethod6:(UIButton *)sender {
    
    switch (sender.tag) {
        case 11:{
            _yesCheckButton6.selected = YES;
            _nocheckButton6.selected = NO;
        }
            break;
        case 12:{
            _yesCheckButton6.selected = NO;
            _nocheckButton6.selected = YES;
            
        } break;
        default:
            break;
    }
}


- (IBAction)prevButtonAction:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}


- (void)createAlertwithTitle:(NSString *)title andMessage:(NSString *)message {
    MHWAlertView *alert = [[MHWAlertView alloc] initWithTitle:title message:message delegate:nil cancelButtonTitle:kLangualString(@"OK") otherButtonTitles:nil, nil];
    [alert show];
}

- (BOOL)validation {
    if ([_yesCheckButton1 isSelected]) {
        if (_relationTextField.text.length == 0) {
            [self createAlertwithTitle:kLangualString(@"Error") andMessage:kLangualString(@"Please enter your relation.")];
            return NO;
        } else if (_nameTextField.text.length == 0) {
            [self createAlertwithTitle:kLangualString(@"Error") andMessage:kLangualString(@"Please enter his / her name.")];
            return NO;
        }
    }
    
    if ([_yesCheckButton2 isSelected]) {
        if (_relationTextField2.text.length == 0) {
            [self createAlertwithTitle:kLangualString(@"Error") andMessage:kLangualString(@"Please enter your relation.")];
            return NO;
        }
    }
    
    if ([_yesCheckButton3 isSelected]) {
        if (_inPastTextField.text.length == 0) {
            [self createAlertwithTitle:kLangualString(@"Error") andMessage:kLangualString(@"Please enter your past aliment.")];
            return NO;
        } else if (_inPresentTextField.text.length == 0) {
            [self createAlertwithTitle:kLangualString(@"Error") andMessage:kLangualString(@"Please enter your present aliment.")];
            return NO;
        } else if (_img1.image == nil) {
            [self createAlertwithTitle:kLangualString(@"Error") andMessage:kLangualString(@"Please input your Doctor's Certificate for Physical aliment.")];
            return NO;
        }
    }
    
    if ([_yesCheckButton4 isSelected]) {
        if (_inPasttextField2.text.length == 0) {
            [self createAlertwithTitle:kLangualString(@"Error") andMessage:kLangualString(@"Please enter your past psychological aliment.")];
            return NO;
        } else if (_inPresenttextField2.text.length == 0) {
            [self createAlertwithTitle:kLangualString(@"Error") andMessage:kLangualString(@"Please enter your present psychological aliment.")];
            return NO;
        } else if (_imgPhysological.image == nil) {
            [self createAlertwithTitle:kLangualString(@"Error") andMessage:kLangualString(@"Please Select your Doctor's Certificate for psychological aliment.")];
            return NO;
        }
    }
    if ([_yesCheckButton5 isSelected]) {
        if (_medicineNameTextField.text.length == 0) {
            [self createAlertwithTitle:kLangualString(@"Error") andMessage:kLangualString(@"Please enter medicine name.")];
            return NO;
        } else if (_medicineDose.text.length == 0) {
            [self createAlertwithTitle:kLangualString(@"Error") andMessage:kLangualString(@"Please enter dose.")];
            return NO;
        }
    }
    
    if (_howdidYouLearn.text.length == 0) {
        [self createAlertwithTitle:kLangualString(@"Error") andMessage:kLangualString(@"Please enter your course referance.")];
        return NO;
    }
    
    if (_textViewtext.text.length == 0) {
        [self createAlertwithTitle:kLangualString(@"Error") andMessage:kLangualString(@"Please enter your personal background.")];
        return NO;
    }
    
    return YES;
}

- (IBAction)nextButtonAction:(id)sender {
    [self.view endEditing:YES];
    if ([Internet checkNetConnection] && [self validation]) {
        if (_dct.allKeys.count > 20) {
            NSArray *array = @[@"anyKnowpersonattending",
                               @"relation",
                               @"relationname",
                               @"relationfonecours",
                               @"relationname1",
                               @"physical_alignment",
                               @"Physicalalignmantinpast",
                               @"Physicalalignmantinprsent",
                               @"physical_doctor_name",
                               @"physical_doctor_mobile",
                               @"physical_doctor_prescription",
                               @"psychological_alignment",
                               @"givedetailonsepratesheetpast",
                               @"givedetailonsepratesheetinprsent",
                               @"psychological_doctor_name",
                               @"psychological_doctor_mobile",
                               @"psychological_doctor_prescription",
                               @"anymedicineregularlyhav",
                               @"madicinename",
                               @"madicinedose",
                               @"howdidulearnaboutcourse",
                               @"briefPersonal",
                               @"brefpersonalbackgroungaimjoingcourse",
                               @"kindlybringafitnesscertificat"];
            [_dct removeObjectsForKeys:array];
        }
        
        NSDictionary *tmo =  @{@"anyKnowpersonattending": [_yesCheckButton1 isSelected] ? @"Yes": @"No",
                               @"relation": [_yesCheckButton1 isSelected] ? _relationTextField.text : @"",
                               @"relationname": [_yesCheckButton1 isSelected] ? _nameTextField.text : @"",
                               @"relationfonecours" : [_yesCheckButton2 isSelected] ? @"Yes" : @"No",
                               @"relationname1": [_yesCheckButton2 isSelected] ? _relationTextField2.text : @"",
                               @"physical_alignment": [_yesCheckButton3 isSelected] ? @"Yes" : @"No",
                               @"Physicalalignmantinpast":[_yesCheckButton3 isSelected] ? _inPastTextField.text : @"",
                               @"Physicalalignmantinprsent": [_yesCheckButton3 isSelected] ? _inPresentTextField.text : @"",
                               @"physical_doctor_name": [_yesCheckButton3 isSelected] ? _tfDoctorsName.text : @"",
                               @"physical_doctor_mobile": [_yesCheckButton3 isSelected] ? _tfDoctorsPhoneNo.text : @"",
                               @"physical_doctor_prescription": [_yesCheckButton3 isSelected] ? apiData : @"",
                               @"psychological_alignment": [_yesCheckButton4 isSelected] ? @"Yes": @"No",
                               @"givedetailonsepratesheetpast": [_yesCheckButton4 isSelected] ? _inPasttextField2.text : @"",
                               @"givedetailonsepratesheetinprsent": [_yesCheckButton4 isSelected] ? _inPresenttextField2.text : @"",
                               @"psychological_doctor_name": [_yesCheckButton4 isSelected] ? _tfDoctorsName2.text : @"",
                               @"psychological_doctor_mobile": [_yesCheckButton4 isSelected] ? _tfDoctorsPhoneNo2.text : @"",
                               @"psychological_doctor_prescription": [_yesCheckButton4 isSelected] ? apiData1 : @"",
                               @"anymedicineregularlyhav": [_yesCheckButton5 isSelected]? @"Yes": @"No",
                               @"madicinename": [_yesCheckButton5 isSelected] ? _medicineNameTextField.text : @"",
                               @"madicinedose": [_yesCheckButton5 isSelected] ? _medicineDose.text : @"",
                               @"howdidulearnaboutcourse": _howdidYouLearn.text,
                               @"kindlybringafitnesscertificat":[_yesCheckButton6 isSelected] ? @"Yes" : @"No",
                               @"brefpersonalbackgroungaimjoingcourse":_textViewtext.text
        };
        
        
        [_dct addEntriesFromDictionary:tmo];
        if ([[UserDefaultManager getIsOldStudent] isEqualToString:@"New"]) {
            StepFourViewController *vc = [SecondStoryBoard instantiateViewControllerWithIdentifier:@"stepFourVC"];
            vc.dict = [NSMutableDictionary new];
            vc.dict = _dct;
            [self.navigationController pushViewController:vc animated:YES];
        } else {
            StepThreeViewController *vc = [SecondStoryBoard instantiateViewControllerWithIdentifier:@"stepthreeVC"];
            vc.dict = [NSMutableDictionary new];
            vc.oldDict = _oldDict;
            vc.dict = _dct;
            if ([[UserDefaultManager getPreview] isEqualToString:@"True"]) {
                vc.allDataDict = _allDataDict;
            }
            [self.navigationController pushViewController:vc animated:YES];
        }
        
    }
    
    
}

- (void)MHWAlertView:(MHWAlertView *)mhwAlertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 0) {
        [UserDefaultManager setIndexPath:nil];
        AppDelegate *app = (AppDelegate *)[UIApplication sharedApplication].delegate;
        [app transitionToSlideMenu];
    }
}

-(void)openCamera {
    if([UIImagePickerController isSourceTypeAvailable:(UIImagePickerControllerSourceTypeCamera)])  {
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
        picker.delegate = self;
        picker.allowsEditing = YES;
        picker.sourceType = UIImagePickerControllerSourceTypeCamera;
        [self presentViewController:picker animated:YES completion:nil];
    } else {
        printf("No Camera Available");
    }
}

-(void)openGallery {
    
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.allowsEditing = YES;
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    [self presentViewController:picker animated:YES completion:nil];
    
}

-(void)showImagePickerView {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:kLangualString(@"Select Your Preference") message:kLangualString(@"Choose Image For Prescreption") preferredStyle:UIAlertControllerStyleActionSheet];
    
    [alert addAction:[UIAlertAction actionWithTitle:kLangualString(@"Gallery") style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        [self openGallery];
        
    }]];
    [alert addAction:[UIAlertAction actionWithTitle:kLangualString(@"Camera") style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        [self openCamera];
        
    }]];
    
    [alert addAction:[UIAlertAction actionWithTitle:kLangualString(@"Cancel") style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
        
        // Cancel button tappped.
        [self dismissViewControllerAnimated:YES completion:^{
        }];
    }]];
    
    [self presentViewController:alert animated:YES completion:nil];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    
    if (checkImage == 2) {
        UIImage *chosenImage = info[UIImagePickerControllerEditedImage];
        self.img1.image = chosenImage;
        [self callWebserviceFor_upload_Sticker:chosenImage apiParam : @"physical_doctor_prescription"];
    } else if (checkImage == 1) {
        UIImage *chosenImage1 = info[UIImagePickerControllerEditedImage];
        self.imgPhysological.image = chosenImage1;
        [self callWebserviceFor_upload_Sticker:chosenImage1 apiParam : @"psychological_doctor_prescription"];
    }
    
    
    [picker dismissViewControllerAnimated:YES completion:nil];
}


-(void)callWebserviceToUploadImageWithParams:(NSMutableDictionary *)_params imgParams:(NSMutableDictionary *)_imgParams videoParms:(NSMutableDictionary *)_videoParams  success:(void (^)(id))_success failure:(void (^)(NSError *))_failure

{
    if ([[AFNetworkReachabilityManager sharedManager] isReachable]) {
        //Here BASE_URL is my URL of web service
        NSString *urlString = @"http://satyasadhna.com/managerarea/api/Booking_event/upload_image";
        NSLog(@"URL : %@",urlString);
        NSMutableURLRequest *urlRequest = [[NSMutableURLRequest alloc] init];
        [urlRequest setURL:[NSURL URLWithString:urlString]];
        [urlRequest setHTTPMethod:@"POST"];
        NSString *boundary = @"---------------------------14737809831466499882746641449";
        NSString *contentType = [NSString stringWithFormat:@"multipart/form-data; boundary=%@",boundary];
        [urlRequest addValue:contentType forHTTPHeaderField: @"Content-Type"];
       // [urlRequest setValue:contentType forHTTPHeaderField:@"Content-type: application/json"]
        NSMutableData *body = [NSMutableData data];
        [_params enumerateKeysAndObjectsUsingBlock: ^(NSString *key, NSString *object, BOOL *stop) {
            [body appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
            [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"%@\"\r\n\r\n",key] dataUsingEncoding:NSUTF8StringEncoding]];
            [body appendData:[[NSString stringWithFormat:@"%@",object] dataUsingEncoding:NSUTF8StringEncoding]];
        }];
        [_imgParams enumerateKeysAndObjectsUsingBlock: ^(NSString *key, NSData *object, BOOL *stop) {
            if ([object isKindOfClass:[NSData class]]) {
                if (object.length > 0) {
                    [body appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
                   // NSLog(@"Timestamp:%@",TimeStamp);
                    [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"%@\"; filename=\"@.jpg\"\r\n",key] dataUsingEncoding:NSUTF8StringEncoding]];
                    [body appendData:[[NSString stringWithFormat:@"Content-Type: application/octet-stream\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
                    [body appendData:[NSData dataWithData:object]];
                }

            }
        }];
        [_videoParams enumerateKeysAndObjectsUsingBlock: ^(NSString *key, NSData *object, BOOL *stop) {
            if (object.length > 0) {
                [body appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
              //  NSLog(@"Timestamp:%@",TimeStamp);
                [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"%@\"; filename=\"@.mp4\"\r\n",key] dataUsingEncoding:NSUTF8StringEncoding]];
                [body appendData:[[NSString stringWithFormat:@"Content-Type: application/octet-stream\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
                [body appendData:[NSData dataWithData:object]];
            }
        }];
        [body appendData:[[NSString stringWithFormat:@"\r\n--%@--\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
        [urlRequest setHTTPBody:body];
        AFHTTPSessionManager* manager = [AFHTTPSessionManager manager];
        manager.responseSerializer.acceptableContentTypes = nil;


        NSURLSessionDataTask *dataTask = [manager dataTaskWithRequest:urlRequest completionHandler:^(NSURLResponse *response, id responseObject, NSError *error) {
            if (error) {
                NSLog(@"Error: %@", error);
                if( _failure )
                {
                    _failure( error) ;
                }
            } else {
                if( _success )
                {
                    _success( responseObject ) ;
                }
            }
        }];
        [dataTask resume];
    }
    else
    {
       // [Utility showInterNetConnectionMessage];
        NSError *error;
        if( _failure )
        {
            _failure( error) ;
        }
    }
}

#pragma -mark callwebservice for login
  -(void)callWebserviceFor_upload_Sticker:(UIImage*)image apiParam:(NSString *)apiparam {
    
    NSMutableDictionary *imgParams = [[NSMutableDictionary alloc]init];
    [imgParams setValue:UIImageJPEGRepresentation(image, 0) forKey:apiparam];

    void ( ^successed )( id _responseObject ) = ^( id _responseObject )
    {
        NSLog(@"%@",_responseObject);
        _apiDict = _responseObject[@"data"];
        if (checkImage == 2) {
           apiData = _apiDict[@"physical_doctor_prescription"];
        } else if (checkImage == 1) {
           apiData1 = _apiDict[@"psychological_doctor_prescription"];
        }
    } ;
    void ( ^failure )( NSError* _error ) = ^( NSError* _error ) {
       // [SVProgressHUD showErrorWithStatus:@"Failed"];
    } ;

[ self callWebserviceToUploadImageWithParams:nil imgParams:imgParams videoParms:nil success:successed failure:failure];
}

@end




