//
//  HomeViewController.m
//  SatyaSadhna
//
//  Created by Roshan Singh Bisht on 23/04/17.
//  Copyright © 2017 Roshan Singh Bisht. All rights reserved.
//

#import "HomeViewController.h"
#import "LiveEventsViewController.h"
#import "LatestNewsViewController.h"
#import "TracksAndSongsVC.h"
#import "PlayListVideoVC.h"
#import "UserDefaultManager.h"
#import "PostsVC.h"
#import "DonationViewController.h"

//#define kAcharyaji          1
//#define kPravachan          4
//#define KSatyaSadhna        0
//#define kNews               6
//#define kGallery            8
//#define kSongs              9
//#define kRegistration       2
//#define kDonation           7
//#define kLiveEvents         5
//#define kAppointment        3

#define kAcharyaji          3
#define kPravachan          7
#define KSatyaSadhna        0
#define kNews               4
#define kGallery            6
#define kSongs              1
#define kRegistration       2
#define kDonation           5
//#define kLiveEvents         5
//#define kAppointment        3



@interface HomeViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,MHWAlertDelegate> {
    NSArray *homeImages;
    NSArray *nameArray;
}
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setAddLeftBarButtonEnabled:YES];
       
     homeImages = [[NSArray alloc] initWithObjects:@"logo",@"songs",@"registration",@"acharayaImage",@"ic_post",@"donation",@"gallery",@"ic_youtube",nil];
    
    nameArray = [[NSArray alloc] initWithObjects:@"Satya Sadhna",@"Tracks & Songs",@"Registration",@"Acharyaji",@"Post",@"Donation",@"Gallery",@"Youtube",nil];
    [self setAddRightBarBarBackButtonEnabled:YES];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated {
   // self.addLeftBarMenuButtonEnabled = YES;
    [self.view setBackgroundColor:RGB(251, 227, 197)];
    self.navigationItem.title = kLangualString(@" Satya Sadhna ");
    [self.view updateViewWithApplicationGlobalFont];
    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName: [UIColor whiteColor]};
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return nameArray.count;
}

-(UICollectionViewCell*)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"nameCell" forIndexPath:indexPath];
    [cell setBackgroundColor:RGB(251, 227, 197)];
    UIImageView *image = (UIImageView *)[cell.contentView viewWithTag:1];
    image.layer.cornerRadius = image.frame.size.height / 2;
    image.clipsToBounds = YES;
    image.layer.borderWidth = 4.0f;
    image.layer.borderColor = RGB(244, 180, 101).CGColor;
    image.contentMode = UIViewContentModeScaleAspectFit;
    image.image = [UIImage imageNamed:[homeImages objectAtIndex:indexPath.row]];
    UILabel *textLabel = (UILabel *)[cell.contentView viewWithTag:2];
    textLabel.text = kLangualString([nameArray objectAtIndex:indexPath.row]);
    
    return cell;
    
}

- (void) collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.row) {
        case kAcharyaji: {
            UIViewController *vc = [MainStoryBoard instantiateViewControllerWithIdentifier:@"acharVC"];
            [self.navigationController pushViewController:vc animated:YES];
        } break;
        case kPravachan:{
            UIViewController *vc = [MainStoryBoard instantiateViewControllerWithIdentifier:@"PlayListVideoVC"];
            [self.navigationController pushViewController:vc animated:YES];
        } break;
        case KSatyaSadhna:{
            UIViewController *vc = [MainStoryBoard instantiateViewControllerWithIdentifier:@"meditationVC"];
            [self.navigationController pushViewController:vc animated:YES];
        } break;
        case kGallery: {
            UIViewController *vc = [MainStoryBoard instantiateViewControllerWithIdentifier:@"galleryVC"];
            [self.navigationController pushViewController:vc animated:YES];
        } break;
        case kSongs: {
            UIViewController *vc = [MainStoryBoard instantiateViewControllerWithIdentifier:@"TracksAndSongsVC"];
            [self.navigationController pushViewController:vc animated:YES];
        }break;
        case kRegistration:{
            MHWAlertView *alert = [[MHWAlertView alloc] initWithTitle:kLangualString(@"Alert") message:kLangualString(@"Are you an old student?") delegate:self cancelButtonTitle:kLangualString(@"Yes") otherButtonTitles:kLangualString(@"No"), nil];
            alert.tag = 189;
            [alert show];
        } break;
        
        case kNews: {
          PostsVC *vc = [MainStoryBoard instantiateViewControllerWithIdentifier:@"PostsVC"];
          [self.navigationController pushViewController:vc animated:YES];
        } break;
        case kDonation:{
         // donationVC
          //panViewVC
          UIViewController *vc = [SecondStoryBoard instantiateViewControllerWithIdentifier:kNewDonationVC];
          [self.navigationController pushViewController:vc animated:YES];
//            UIViewController *vc = [SecondStoryBoard instantiateViewControllerWithIdentifier:@"donationVC"];
//            [self.navigationController pushViewController:vc animated:YES];
        }break;
        default:
            break;
    }
}

- (UIEdgeInsets)collectionView:(UICollectionView*)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(0, 0, 0, 0); // top, left, bottom, right
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    
    return 0.0;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 0.0;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    CGSize mElementSize = CGSizeMake(182, 180);
    return mElementSize;
}


- (void)MHWAlertView:(MHWAlertView *)mhwAlertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (mhwAlertView.tag == 189) {
        if (buttonIndex == 0) {
            [UserDefaultManager setIsOldStudent:@"Old"];
        } else {
            [UserDefaultManager setIsOldStudent:@"New"];
        }
        UIViewController *vc = [SecondStoryBoard instantiateViewControllerWithIdentifier:@"registeroneVC"];
        vc.navigationController.navigationBar.barTintColor = RGB(244, 180, 101);
        vc.navigationController.navigationBar.translucent = YES;
        [self.navigationController pushViewController:vc animated:YES];
    }
}
- (void)setAddRightBarBarBackButtonEnabled:(BOOL)addRightBarBarBackButtonEnabled {
    //This is for add back button and it should be called from viewWillAppear
    if (addRightBarBarBackButtonEnabled) {
//        UIButton *btnBack = [UIButton buttonWithType:UIButtonTypeCustom];
//        [btnBack setFrame:CGRectMake(0, 0, 30, 90)];
//        [btnBack setImage:[UIImage imageNamed:@"live1"] forState:UIControlStateNormal];
//        [btnBack addTarget:self action:@selector(actionLeftBarButton:) forControlEvents:UIControlEventTouchUpInside];
//        UIBarButtonItem *barButton =[[UIBarButtonItem alloc] initWithCustomView:btnBack];
        
        UIButton *languageButton = [UIButton buttonWithType:UIButtonTypeCustom];
        languageButton.selected = NO;
        [languageButton setFrame:CGRectMake(0, 0, 80, 90)];
        [languageButton addTarget:self action:@selector(actionLeft:) forControlEvents:UIControlEventTouchUpInside];
            [languageButton setTitle:@"हिंदी" forState:UIControlStateNormal];
            [languageButton setTitle:@"ENGLISH" forState:UIControlStateSelected];
       
        UIBarButtonItem *barButton1 =[[UIBarButtonItem alloc] initWithCustomView:languageButton];
        
        self.navigationItem.rightBarButtonItem = barButton1;
        if ( [[UserDefaultManager getLanguage]  isEqual: @"Hindi"]) {
            languageButton.selected = YES;
        } else {
            languageButton.selected = NO;
        }
    } else {
        [self.navigationItem setHidesBackButton:YES];
    }
    
}
- (void)actionLeft:(UIButton *)btn{
    if (btn.selected == NO) {
        btn.selected = YES;
        [UserDefaultManager setLanguage:@"Hindi"];
        [self viewWillAppear:YES];
        
    } else {
        btn.selected = NO;
        [UserDefaultManager setLanguage:@"English"];
        [self viewWillAppear:YES];
    }
    [_collectionView reloadData];
}

- (void)actionLeftBarButton:(UIButton *)btn {
    LiveEventsViewController *vc = [SecondStoryBoard instantiateViewControllerWithIdentifier:@"liveVC"];
    vc.isfromHome = YES;
    [self.navigationController pushViewController:vc animated:YES];
    vc.isfromHome = YES;
}

- (void)setAddLeftBarButtonEnabled:(BOOL)addLeftBarButtonEnabled {
    if (addLeftBarButtonEnabled) {
        UIButton *btnMenu = [UIButton buttonWithType:UIButtonTypeCustom];
        [btnMenu setFrame:CGRectMake(0, 0, 19, 16)];
        [btnMenu setImage:[UIImage imageNamed:@"menubar"] forState:UIControlStateNormal];
        [btnMenu addTarget:self action:@selector(actionLeftMenuBarButton) forControlEvents:UIControlEventTouchUpInside];
        UIBarButtonItem *barButton = [[UIBarButtonItem alloc] initWithCustomView:btnMenu];
        
        UIButton *btnBack = [UIButton buttonWithType:UIButtonTypeCustom];
        [btnBack setFrame:CGRectMake(0, 0, 30, 90)];
        [btnBack setImage:[UIImage imageNamed:@"live1"] forState:UIControlStateNormal];
        [btnBack addTarget:self action:@selector(actionLeftBarButton:) forControlEvents:UIControlEventTouchUpInside];
        UIBarButtonItem *barButton1 =[[UIBarButtonItem alloc] initWithCustomView:btnBack];
       
        NSArray *arr = @[barButton,barButton1];
        self.navigationItem.leftBarButtonItems = arr;
    } else {
        [self.navigationItem setHidesBackButton:YES];
    }
}

- (void)actionLeftMenuBarButton {
    [self.revealViewController revealToggleAnimated:YES];
}

@end
