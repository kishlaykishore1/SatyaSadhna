//
//  SlideMenuViewController.m
//  SatyaSadhna
//
//  Created by Roshan Singh Bisht on 23/04/17.
//  Copyright © 2017 Roshan Singh Bisht. All rights reserved.
//

#import "SlideMenuViewController.h"
#import "SlideTableViewCell.h"
#import "RevealViewController.h"
#import "KushYalatanViewController.h"
#import "ContactUsViewController.h"
#import "IntroductionViewController.h"
#import "UIView+Loading.h"
#import "FaqViewController.h"
#import "QuotionViewController.h"
#import "TermsViewController.h"
#import "FrequentViewController.h"
#import "NewsLetterYearViewController.h"
#import "GypsyCoursesDataVC.h"

@interface SlideMenuViewController ()<UITableViewDelegate,UITableViewDataSource,MHWAlertDelegate>{
    
    NSArray             *slideMenu;
    NSArray             *slideMenuImages;
    NSInteger           selectedIndexForSection2;
    NSInteger           selectedIndexForSection3;
    NSInteger           selectedIndexForSection4;
    NSInteger           selectedIndexForSection5;
    NSArray             *secondCellArray;
    NSArray             *secondCellArrayImages;
    NSArray             *lastCellArray;
    NSArray             *lastCellArrayImages;
    BOOL                isThirdCellExpand;
    BOOL                isFourthCellExpand;
    BOOL                isFifthCellExpand;
    BOOL                isSixthCellExpand;
}
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation SlideMenuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    selectedIndexForSection2 = -1;
    selectedIndexForSection3 = -1;
    selectedIndexForSection4 = -1;
    selectedIndexForSection5 = -1;
    [_tableView setTableFooterView:[UIView new]];
    
}

- (void)viewWillAppear:(BOOL)animated {
    [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"loginBg"]]];
    self.view.layer.contents = (id)[UIImage imageNamed:@"loginBg"].CGImage;
    slideMenu = [[NSArray alloc] initWithObjects:@"HOME",@"Profile",@"Kushyalatan",@"Satya Sadhna",@"Publications",@"Contact Us",@"Quotation",@"Terms & Conditions",@"Share",@"Logout" ,nil];
    slideMenuImages = [[NSArray alloc] initWithObjects:@"DashboardImage",@"ProfileImage",@"KushyalatanImage",@"SatyaSadhnaMeditationImage",@"PublicationsImage",@"ContactUsImage",@"ContactUsImage",@"Terms&ConditionsImage",@"ContactUsImage",@"LogoutImage" ,nil];
    
    secondCellArray = [NSArray arrayWithObjects:@"HOME",@"Profile", nil];
    
    secondCellArrayImages = [NSArray arrayWithObjects:@"dashboardSlide",@"profileSlide", nil];
   // lastCellArray = [NSArray arrayWithObjects:@"Quotation",@"Previous Course",@"Terms & Conditions",@"Share",@"Logout", nil];
    lastCellArray = [NSArray arrayWithObjects:@"Quotation",@"Terms & Conditions",@"Share",@"Logout", nil];
   // lastCellArrayImages = [NSArray arrayWithObjects:@"quote",@"previousCourse",@"termsSlide",@"share",@"logoutSlide", nil];
    [_tableView reloadData];
    lastCellArrayImages = [NSArray arrayWithObjects:@"quote",@"termsSlide",@"share",@"logoutSlide", nil];
    [_tableView reloadData];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 7;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.section) {
        case 0: {
            return 100;
        } break;
        case 1: {
            return 60;
        } break;
        case 2:{
            if (selectedIndexForSection2 == 1) {
                isThirdCellExpand = YES;
                return 180;
            } else {
                isThirdCellExpand = NO;
                return 59;
            }
        } break;
        case 3:{
            if (selectedIndexForSection3 == 1) {
                isFourthCellExpand  = YES;
                return 467;
            } else {
                isFourthCellExpand  = NO;
                return 59;
            }
        } break;
        case 4:{
            if (selectedIndexForSection4 == 1) {
                isFifthCellExpand  = YES;
                return 180;
            } else {
                isFifthCellExpand  = NO;
                return 58;
            }
        } break;
        case 5:{
            if (selectedIndexForSection5 == 1) {
                isSixthCellExpand = YES;
                return 224;
            } else {
                isSixthCellExpand = NO;
                return 58;
            }
        }break;
        case 6:{
            return 60;
        }
        default:
            break;
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SlideTableViewCell *cell;
    SlideTableViewCell *cell1;
    SlideTableViewCell *cell2;
    SlideTableViewCell *cell3;
    SlideTableViewCell *cell4;
    SlideTableViewCell *cell5;
    SlideTableViewCell *cell6;
    switch (indexPath.section) {
        case 0:{
            cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
            [cell setBackgroundColor:[UIColor clearColor]];
            return cell;
        } break;
        case 1 :{
            cell1 = [tableView dequeueReusableCellWithIdentifier:@"cell1" forIndexPath:indexPath];
            [cell1 setBackgroundColor:[UIColor clearColor]];
            [cell1.secondCellLabel setText:kLangualString([secondCellArray objectAtIndex:indexPath.row])];
            [cell1.secondCellImageView setImage:[UIImage imageNamed:[secondCellArrayImages objectAtIndex:indexPath.row]]];
            return cell1;
        } break;
        case 2:{
            cell2 = [tableView dequeueReusableCellWithIdentifier:@"cell2" forIndexPath:indexPath];
            [cell2 setBackgroundColor:[UIColor clearColor]];
            [cell2.thirdCellLabel setText:kLangualString(@"Kushlayatan")];
            [cell2.visionLabel setText:kLangualString(@"   Vision")];
            [cell2.vidyapeethLabel setText:kLangualString(@"   Kushal Vidyapeeth")];
            [cell2.aushadhalayLabel setText:kLangualString(@"   Kushal Aushadhalay")];
            [cell2.visionButton addTarget:self action:@selector(vision) forControlEvents:UIControlEventTouchUpInside];
            [cell2.vidyaButton addTarget:self action:@selector(vidya) forControlEvents:UIControlEventTouchUpInside];
            [cell2.aushButton addTarget:self action:@selector(aush) forControlEvents:UIControlEventTouchUpInside];
            if (isThirdCellExpand) {
                [cell2.thirdCellExpnadImageview setImage:[UIImage imageNamed:@"minus"]];
            } else {
                [cell2.thirdCellExpnadImageview setImage:[UIImage imageNamed:@"plus"]];
            }
            return cell2;
        } break;
        case 3:{
            cell3 = [tableView dequeueReusableCellWithIdentifier:@"cell3" forIndexPath:indexPath];
            [cell3 setBackgroundColor:[UIColor clearColor]];
            [cell3.fourtCellLabel setText:kLangualString(@"Satya Sadhna")];
            [cell3.introDuctionLabel setText:kLangualString(@"   Introduction")];
            [cell3.guideLineLabel setText:kLangualString(@"   Guidelines")];
            [cell3.coursesLabel setText:kLangualString(@"   Courses")];
            [cell3.aftertheCourseLabel setText:kLangualString(@"   After the Course")];
            [cell3.trackLabel setText:kLangualString(@"   Introductory Session")];
            [cell3.qaLabel setText:kLangualString(@"   Question and Answer with Guru Ji")];
            [cell3.experienceLabel setText:kLangualString(@"   Experience")];
            [cell3.lblWhoisTeaching setText:kLangualString(@"   Who is Teaching?")];
            [cell3.lblSatyaSadnaForChild setText:kLangualString(@"   SatyaSadhna for Children")];
            [cell3.lblGypsyCourses setText:kLangualString(@"   Gypsy Courses")];
            [cell3.lblOnedayCourse setText:kLangualString(@"   One Day Course")];
            
            
            [cell3.introButton addTarget:self action:@selector(intro) forControlEvents:UIControlEventTouchUpInside];
            [cell3.guideLineButton addTarget:self action:@selector(guide) forControlEvents:UIControlEventTouchUpInside];
            [cell3.courseButton addTarget:self action:@selector(course) forControlEvents:UIControlEventTouchUpInside];
            [cell3.aftercourseButton addTarget:self action:@selector(aftercourse) forControlEvents:UIControlEventTouchUpInside];
            [cell3.trackButton addTarget:self action:@selector(track) forControlEvents:UIControlEventTouchUpInside];
            [cell3.experienceButton addTarget:self action:@selector(experince) forControlEvents:UIControlEventTouchUpInside];
            [cell3.btnWhoIsTeaching addTarget:self action:@selector(whoIsTeaching) forControlEvents:UIControlEventTouchUpInside];
            [cell3.btnSatyaSadhnaForChild addTarget:self action:@selector(forChildren) forControlEvents:UIControlEventTouchUpInside];
            [cell3.btnGypsyCourses addTarget:self action:@selector(gypsyCourses) forControlEvents:UIControlEventTouchUpInside];
            [cell3.btnOneDayCourse addTarget:self action:@selector(oneDayCourse) forControlEvents:UIControlEventTouchUpInside];
            
            if (isFourthCellExpand) {
                [cell3.fourthexpandCellImageView setImage:[UIImage imageNamed:@"minus"]];
            } else {
                [cell3.fourthexpandCellImageView setImage:[UIImage imageNamed:@"plus"]];
            }
            return cell3;
        } break;
        case 4 :{
            cell4 = [tableView dequeueReusableCellWithIdentifier:@"cell4" forIndexPath:indexPath];
            [cell4 setBackgroundColor:[UIColor clearColor]];
            [cell4.fifthCellLabel setText:kLangualString(@"Publications")];
            [cell4.booksLabel setText:kLangualString(@"   NewsLetter")];
            [cell4.newsletterButton addTarget:self action:@selector(newsLetter) forControlEvents:UIControlEventTouchUpInside];
            [cell4.newsLetterLabel setText:kLangualString(@"   Books")];
            [cell4.booksButton addTarget:self action:@selector(books) forControlEvents:UIControlEventTouchUpInside];
             [cell4.lblBrochure setText:kLangualString(@"   Brochure")];
            [cell4.cdButton addTarget:self action:@selector(cd) forControlEvents:UIControlEventTouchUpInside];
            if (isFifthCellExpand) {
                [cell4.fifthCellExpandCellImageView setImage:[UIImage imageNamed:@"minus"]];
            } else {
                [cell4.fifthCellExpandCellImageView setImage:[UIImage imageNamed:@"plus"]];
            }
            return cell4;
        } break;
        case 5:{
            cell5 = [tableView dequeueReusableCellWithIdentifier:@"cell5" forIndexPath:indexPath];
            [cell5 setBackgroundColor:[UIColor clearColor]];
            [cell5.sixThCellLabel setText:kLangualString(@"Contact Us")];
            [cell5.nalLabel setText:kLangualString(@"   Nal")];
            [cell5.bikanerLabe setText:kLangualString(@"   Bikaner")];
            [cell5.kolkataLabel setText:kLangualString(@"   Kolkata")];
            [cell5.mehndipurLabel setText:kLangualString(@"   Mehndipur")];
            [cell5.queryLabel setText:kLangualString(@"   Query")];
            [cell5.nalButton addTarget:self action:@selector(nal) forControlEvents:UIControlEventTouchUpInside];
            [cell5.bikanerButton addTarget:self action:@selector(bikaner) forControlEvents:UIControlEventTouchUpInside];
            [cell5.kolkataButton addTarget:self action:@selector(kolkata) forControlEvents:UIControlEventTouchUpInside];
            [cell5.mehndipurButton addTarget:self action:@selector(mehndipur) forControlEvents:UIControlEventTouchUpInside];
            [cell5.queryButton addTarget:self action:@selector(queryAction) forControlEvents:UIControlEventTouchUpInside];
            if (isSixthCellExpand) {
                [cell5.sixThCellImageViewEXpand setImage:[UIImage imageNamed:@"minus"]];
            } else {
                [cell5.sixThCellImageViewEXpand setImage:[UIImage imageNamed:@"plus"]];
            }
            return cell5;
        } break;
        case 6:{
            cell6 = [tableView dequeueReusableCellWithIdentifier:@"cell6" forIndexPath:indexPath];
            [cell6 setBackgroundColor:[UIColor clearColor]];
            [cell6.seventhLabel setText:kLangualString([lastCellArray objectAtIndex:indexPath.row])];
            [cell6.seventhCellImageView setImage:[UIImage imageNamed:[lastCellArrayImages objectAtIndex:indexPath.row]]];
            return cell6;
            
        } break;
        default:
            break;
    }
    return cell1;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.section) {
        case 0:{

        }break;
        case 1:{
            switch (indexPath.row) {
                case 0:{
                    UIViewController *vc = [MainStoryBoard instantiateViewControllerWithIdentifier:@"homeVC"];
                    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vc];
                    nav.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName: [UIColor whiteColor]
                                                              };
                    nav.navigationBar.barTintColor = RGB(244, 180, 101);
                    [self.revealViewController pushFrontViewController:nav animated:YES];
                } break;
                case 1:{
                    UIViewController *vc = [MainStoryBoard instantiateViewControllerWithIdentifier:@"profileVC"];
                    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vc];
                    nav.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName: [UIColor whiteColor]
                                                              };
                    nav.navigationBar.barTintColor = RGB(244, 180, 101);
                    [self.revealViewController pushFrontViewController:nav animated:YES];
                }break;
                    
                default:
                    break;
            }
        }break;
            
        case 2:{
            if (selectedIndexForSection2 == 1) {
                selectedIndexForSection2 = -1;
                [tableView reloadSections:[NSIndexSet indexSetWithIndex:2] withRowAnimation:UITableViewRowAnimationFade];
            } else {
                selectedIndexForSection2 = 1;
                [tableView reloadSections:[NSIndexSet indexSetWithIndex:2] withRowAnimation:UITableViewRowAnimationFade];
            }
        } break;
        case 3:{
            if (selectedIndexForSection3 == 1) {
                selectedIndexForSection3 = -1;
                [tableView reloadSections:[NSIndexSet indexSetWithIndex:3] withRowAnimation:UITableViewRowAnimationFade];
            } else {
                selectedIndexForSection3 = 1;
                [tableView reloadSections:[NSIndexSet indexSetWithIndex:3] withRowAnimation:UITableViewRowAnimationFade];
            }
            
        }break;
        case 4:{
            if (selectedIndexForSection4 == 1) {
                selectedIndexForSection4 = -1;
                [tableView reloadSections:[NSIndexSet indexSetWithIndex:4] withRowAnimation:UITableViewRowAnimationFade];
            } else {
                selectedIndexForSection4 = 1;
                [tableView reloadSections:[NSIndexSet indexSetWithIndex:4] withRowAnimation:UITableViewRowAnimationFade];
            }
            
        }break;
            
        case 5:{
            if (selectedIndexForSection5 == 1) {
                selectedIndexForSection5 = -1;
                [tableView reloadSections:[NSIndexSet indexSetWithIndex:5] withRowAnimation:UITableViewRowAnimationFade];
            } else {
                selectedIndexForSection5 = 1;
                [tableView reloadSections:[NSIndexSet indexSetWithIndex:5] withRowAnimation:UITableViewRowAnimationFade];
            }
        } break;
        case 6:{
            switch (indexPath.row) {
                case 1: { // Quotation
                    FaqViewController *vc = [SecondStoryBoard instantiateViewControllerWithIdentifier:@"faqVC"];
                    vc.isFaq = NO;
                    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vc];
                    nav.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName: [UIColor whiteColor]
                                                              };
                    nav.navigationBar.barTintColor = RGB(244, 180, 101);
                    [self.revealViewController pushFrontViewController:nav animated:YES];
                    
                } break;
                case 3:{
                    
                    MHWAlertView *alert = [[MHWAlertView alloc] initWithTitle:kLangualString(@"Logout?") message:kLangualString(@"Do you want to logout?") delegate:self cancelButtonTitle:kLangualString(@"OK") otherButtonTitles:kLangualString(@"Cancel"), nil];
                    [alert show];
                    
                } break;
                case 0:{
                    QuotionViewController *vc = [SecondStoryBoard instantiateViewControllerWithIdentifier:@"quotionVC"];
                    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vc];
                    nav.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName: [UIColor whiteColor]
                                                              };
                    nav.navigationBar.barTintColor = RGB(244, 180, 101);
                    [self.revealViewController pushFrontViewController:nav animated:YES];
                } break;
                case 2:{
                    
                    NSString *content = @"Download Satya Sadhna Mobile Application%20%20http://onelink.to/wapgjx";
                    
                    content = [content stringByReplacingOccurrencesOfString:@" " withString:@"%20"];
                    content = [content stringByReplacingOccurrencesOfString:@":" withString:@"%3A"];
                    content = [content stringByReplacingOccurrencesOfString:@"/" withString:@"%2F"];
                    content = [content stringByReplacingOccurrencesOfString:@"?" withString:@"%3F"];
                    content = [content stringByReplacingOccurrencesOfString:@"," withString:@"%2C"];
                    content = [content stringByReplacingOccurrencesOfString:@"=" withString:@"%3D"];
                    content = [content stringByReplacingOccurrencesOfString:@"&" withString:@"%26"];
                    content = [[content componentsSeparatedByCharactersInSet:[NSCharacterSet newlineCharacterSet]] componentsJoinedByString:@"%20"];
                    
                    NSString * urlWhats = [NSString stringWithFormat:@"whatsapp://send?text=%@",content];
                    NSURL * whatsappURL = [NSURL URLWithString:urlWhats];
                    if ([[UIApplication sharedApplication] canOpenURL: whatsappURL]) {
                        [[UIApplication sharedApplication] openURL: whatsappURL];
                    }
                    else
                    {
                        MHWAlertView *alert = [[MHWAlertView alloc] initWithTitle:kLangualString(@"WhatsApp not installed.") message:kLangualString(@"Your device has no WhatsApp installed.") delegate:nil cancelButtonTitle:kLangualString(@"OK") otherButtonTitles:nil, nil];
                        [alert show];
                    }
                } break;
//                case 1: {
//                    UIViewController *vc = [SecondStoryBoard instantiateViewControllerWithIdentifier:HistoryVC];
//                    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vc];
//                    nav.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName: [UIColor whiteColor]};
//                    nav.navigationBar.barTintColor = RGB(244, 180, 101);
//                    [self.revealViewController pushFrontViewController:nav animated:YES];
//                } break;
                default:
                    break;
            }
        }
        default:
            break;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    switch (section) {
        case 0:{
            return 1;
        } break;
        case 1:{
            return 2;
        } break;
        case 2:{
            return 1;
        }break;
        case 3:{
            return 1;
        } break;
        case 4:{
            return 1;
        } break;
        case 5:{
            return 1;
        }break;
        case 6:{
            return 4;
        } break;
            
        default:
            break;
    }
    return 0;
    
}

- (void) vision{
    KushYalatanViewController *vc = [MainStoryBoard instantiateViewControllerWithIdentifier:@"kushVC"];
    vc.titleString = @"Vision";
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vc];
    nav.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName: [UIColor whiteColor]
                                              };
    nav.navigationBar.barTintColor = RGB(244, 180, 101);
    [self.revealViewController pushFrontViewController:nav animated:YES];
    
}

- (void) vidya{
    KushYalatanViewController *vc = [MainStoryBoard instantiateViewControllerWithIdentifier:@"kushVC"];
    vc.titleString = @"Kushal Vidyapeeth";
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vc];
    nav.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName: [UIColor whiteColor]
                                              };
    nav.navigationBar.barTintColor = RGB(244, 180, 101);
    [self.revealViewController pushFrontViewController:nav animated:YES];
    
    
}

- (void) aush{
    KushYalatanViewController *vc = [MainStoryBoard instantiateViewControllerWithIdentifier:@"kushVC"];
    vc.titleString = @"Kushal Aushadhalay";
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vc];
    nav.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName: [UIColor whiteColor]
                                              };
    nav.navigationBar.barTintColor = RGB(244, 180, 101);
    [self.revealViewController pushFrontViewController:nav animated:YES];
    
}

- (void) intro{
    
    IntroductionViewController *vc = [MainStoryBoard instantiateViewControllerWithIdentifier:@"introVC"];
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vc];
    nav.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName: [UIColor whiteColor]
                                              };
    nav.navigationBar.barTintColor = RGB(244, 180, 101);
    vc.currentView = @"Introduction";
    [self.revealViewController pushFrontViewController:nav animated:YES];

    
}

- (void) guide{
    IntroductionViewController *vc = [MainStoryBoard instantiateViewControllerWithIdentifier:@"introVC"];
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vc];
    nav.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName: [UIColor whiteColor]
                                              };
    nav.navigationBar.barTintColor = RGB(244, 180, 101);
    vc.currentView = @"Guidelines";
    [self.revealViewController pushFrontViewController:nav animated:YES];
    
}

- (void) course{
    UIViewController *vc = [SecondStoryBoard instantiateViewControllerWithIdentifier:@"courseVC"];
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vc];
    nav.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName: [UIColor whiteColor]
                                              };
    nav.navigationBar.barTintColor = RGB(244, 180, 101);
    [self.revealViewController pushFrontViewController:nav animated:YES];
    
}
- (void) aftercourse{
    IntroductionViewController *vc = [MainStoryBoard instantiateViewControllerWithIdentifier:@"introVC"];
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vc];
    nav.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName: [UIColor whiteColor]
                                              };
    nav.navigationBar.barTintColor = RGB(244, 180, 101);
    vc.currentView = @"After The Course";
    [self.revealViewController pushFrontViewController:nav animated:YES];
    
}

- (void) track{
  GypsyCoursesDataVC *vc = [MainStoryBoard instantiateViewControllerWithIdentifier:@"GypsyCoursesDataVC"];
  UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vc];
  nav.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName: [UIColor whiteColor]};
  nav.navigationBar.barTintColor = RGB(244, 180, 101);
  vc.currentView = @"Introductory Session";
  [self.revealViewController pushFrontViewController:nav animated:YES];
    
}

- (void) experince{
    UIViewController *vc = [MainStoryBoard instantiateViewControllerWithIdentifier:@"experienceVC"];
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vc];
    nav.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName: [UIColor whiteColor]
                                              };
    nav.navigationBar.barTintColor = RGB(244, 180, 101);
    [self.revealViewController pushFrontViewController:nav animated:YES];
}

- (void) oneDayCourse{
  GypsyCoursesDataVC *vc = [MainStoryBoard instantiateViewControllerWithIdentifier:@"GypsyCoursesDataVC"];
  UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vc];
  nav.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName: [UIColor whiteColor]};
  nav.navigationBar.barTintColor = RGB(244, 180, 101);
  vc.currentView = @"One Day Course";
  [self.revealViewController pushFrontViewController:nav animated:YES];
}

- (void) gypsyCourses{
  GypsyCoursesDataVC *vc = [MainStoryBoard instantiateViewControllerWithIdentifier:@"GypsyCoursesDataVC"];
  UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vc];
  nav.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName: [UIColor whiteColor]};
  nav.navigationBar.barTintColor = RGB(244, 180, 101);
  vc.currentView = @"Gypsy Courses";
  [self.revealViewController pushFrontViewController:nav animated:YES];
}

- (void) whoIsTeaching{
  GypsyCoursesDataVC *vc = [MainStoryBoard instantiateViewControllerWithIdentifier:@"GypsyCoursesDataVC"];
  UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vc];
  nav.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName: [UIColor whiteColor]};
  nav.navigationBar.barTintColor = RGB(244, 180, 101);
  vc.currentView = @"Who is Teaching?";
  [self.revealViewController pushFrontViewController:nav animated:YES];
}

- (void) forChildren{
  GypsyCoursesDataVC *vc = [MainStoryBoard instantiateViewControllerWithIdentifier:@"GypsyCoursesDataVC"];
  UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vc];
  nav.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName: [UIColor whiteColor]};
  nav.navigationBar.barTintColor = RGB(244, 180, 101);
  vc.currentView = @"SatyaSadhna for children";
  [self.revealViewController pushFrontViewController:nav animated:YES];
}


// this is the method for Books VC
- (void) newletter{
    [self books];
}

- (void) newsLetter{
//  LatestNewsViewController *vc = [MainStoryBoard instantiateViewControllerWithIdentifier:@"latestVC"];
//  vc.str = @"news";
//  [self.navigationController pushViewController:vc animated:YES];
    UIViewController *vc = [MainStoryBoard instantiateViewControllerWithIdentifier:@"latestVC"];
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vc];
    nav.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName: [UIColor whiteColor]
                                              };
    nav.navigationBar.barTintColor = RGB(244, 180, 101);
    [self.revealViewController pushFrontViewController:nav animated:YES];
}

- (void) books{
    UIViewController *vc = [SecondStoryBoard instantiateViewControllerWithIdentifier:@"booksVC"];
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vc];
    nav.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName: [UIColor whiteColor]
                                              };
    nav.navigationBar.barTintColor = RGB(244, 180, 101);
    [self.revealViewController pushFrontViewController:nav animated:YES];
}

- (void) cd{
  IntroductionViewController *vc = [MainStoryBoard instantiateViewControllerWithIdentifier:@"introVC"];
  UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vc];
  nav.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName: [UIColor whiteColor]
                                            };
  nav.navigationBar.barTintColor = RGB(244, 180, 101);
  vc.currentView = @"Brochure";
  [self.revealViewController pushFrontViewController:nav animated:YES];
    
}


- (void) nal{
    
    ContactUsViewController *vc = [MainStoryBoard instantiateViewControllerWithIdentifier:@"contactUsVC"];
    vc.titleString = @"Nal";
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vc];
    nav.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName: [UIColor whiteColor]
                                              };
    nav.navigationBar.barTintColor = RGB(244, 180, 101);
    [self.revealViewController pushFrontViewController:nav animated:YES];
    
}

- (void) bikaner{
    
    ContactUsViewController *vc = [MainStoryBoard instantiateViewControllerWithIdentifier:@"contactUsVC"];
    vc.titleString = @"Bikaner";
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vc];
    nav.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName: [UIColor whiteColor]
                                              };
    nav.navigationBar.barTintColor = RGB(244, 180, 101);
    [self.revealViewController pushFrontViewController:nav animated:YES];
}


- (void) kolkata{
    
    ContactUsViewController *vc = [MainStoryBoard instantiateViewControllerWithIdentifier:@"contactUsVC"];
    vc.titleString = @"Kolkata";
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vc];
    nav.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName: [UIColor whiteColor]
                                              };
    nav.navigationBar.barTintColor = RGB(244, 180, 101);
    [self.revealViewController pushFrontViewController:nav animated:YES];
    
}

- (void) mehndipur{
    
    ContactUsViewController *vc = [MainStoryBoard instantiateViewControllerWithIdentifier:@"contactUsVC"];
    vc.titleString = @"Mehndipur";
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vc];
    nav.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName: [UIColor whiteColor]
                                              };
    nav.navigationBar.barTintColor = RGB(244, 180, 101);
    [self.revealViewController pushFrontViewController:nav animated:YES];
    
}

- (void) queryAction{
    UIViewController *vc = [SecondStoryBoard instantiateViewControllerWithIdentifier:@"queryVC"];
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vc];
    nav.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName: [UIColor whiteColor]
                                              };
    nav.navigationBar.barTintColor = RGB(244, 180, 101);
    [self.revealViewController pushFrontViewController:nav animated:YES];
    
}

- (void)MHWAlertView:(MHWAlertView *)mhwAlertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 0) {
        AppDelegate *app = (AppDelegate *)[UIApplication sharedApplication].delegate;
        [app transitionToLoginFromVC:self];
    }
}

- (IBAction)faqAction:(id)sender {
    FrequentViewController *vc = [SecondStoryBoard instantiateViewControllerWithIdentifier:@"frequentVC"];
    vc.isFromSlide = YES;
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vc];
    nav.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName: [UIColor whiteColor]
                                              };
    nav.navigationBar.barTintColor = RGB(244, 180, 101);
    [self.revealViewController pushFrontViewController:nav animated:YES];
}


@end
