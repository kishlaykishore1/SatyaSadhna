//
//  InnerNewsViewController.m
//  SatyaSadhna
//
//  Created by Roshan Singh Bisht on 17/05/17.
//  Copyright © 2017 Roshan Singh Bisht. All rights reserved.
//

#import "InnerNewsViewController.h"
#import "NewsViewController.h"
#import "NewsLetterListingVC.h"
#import "HomeService.h"

@interface InnerNewsViewController ()<UICollectionViewDataSource,UICollectionViewDelegate> {
  //NSMutableArray *months;
  NSMutableArray *data;
  NSString *months;
  NSString *count;
}
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (weak, nonatomic) IBOutlet UILabel *label;

@end

@implementation InnerNewsViewController

- (void)newsYearMonth {
  [mserviceHandler.homeService newsletterMonth: _dateStr success:^(id response) {
    [activityIndicatorView stopAnimating];
    if ([response[@"status"] boolValue]) {
      data = response[@"page_result"];
      
      [_collectionView reloadData];
    }
  } failure:^(NSError * error) {
    [activityIndicatorView stopAnimating];
  }];
}



- (void)viewDidLoad {
    [super viewDidLoad];
 // months = [NSMutableArray new];
//  for (NSArray *arr in _newsArray) {
//      NSDictionary *dict = [arr firstObject];
//      NSString *str = dict[@"createdAt"];
//    if ([str rangeOfString:_dateStr].location == NSNotFound) {
//
//      } else {
//        [months addObject: dict];
//      }
//  }
  [self setAddRightBarBarBackButtonEnabled:YES];
  [self.view addSubview:activityIndicatorView];
  [activityIndicatorView startAnimating];
  [self newsYearMonth];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated{
    self.navigationItem.title = kLangualString(@"Newsletter");
    self.addLeftBarBarBackButtonEnabled = YES;
    [self.view setBackgroundColor:kBgImage];
    self.view.layer.contents = (id)[UIImage imageNamed:@"loginBg"].CGImage;
    [_label setText:kLangualString(@"Click on Month to check out news letter")];
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return data.count;
}

-(UICollectionViewCell*)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    [cell setBackgroundColor:[UIColor clearColor]];
    UIImageView *image = (UIImageView *)[cell.contentView viewWithTag:1];
    image.layer.cornerRadius = image.frame.size.height / 2;
    image.clipsToBounds = YES;
    image.contentMode = UIViewContentModeScaleAspectFit;
    image.image = [UIImage imageNamed:@"newsletter"];
    UILabel *textLabel = (UILabel *)[cell.contentView viewWithTag:2];
    NSDictionary *dict = [data objectAtIndex: indexPath.row];
    months = dict[@"month"];
    count = dict[@"count"];
    textLabel.text = [NSString stringWithFormat:@"%@(%@)",months,count];
    
//    NSDictionary *dict = [months objectAtIndex:indexPath.row];
//    NSString *temp = dict[@"createdAt"];
//    NSArray *tempArray = [temp componentsSeparatedByString:@"-"];
//    NSInteger month = [[tempArray objectAtIndex:1] integerValue];
//    switch (month) {
//        case 01: {
//            [textLabel setText:@"January(1)"];
//        } break;
//        case 02:{
//            [textLabel setText:@"Febuary(1)"];
//        } break;
//        case 03: {
//            [textLabel setText:@"March(1)"];
//        } break;
//        case 04: {
//            [textLabel setText:@"April(1)"];
//        } break;
//        case 05: {
//            [textLabel setText:@"May(1)"];
//        } break;
//        case 06: {
//            [textLabel setText:@"June(1)"];
//        } break;
//        case 07: {
//            [textLabel setText:@"July(1)"];
//        } break;
//        case 8: {
//            [textLabel setText:@"August(1)"];
//        } break;
//        case 9: {
//            [textLabel setText:@"September(1)"];
//        } break;
//        case 10: {
//            [textLabel setText:@"October(1)"];
//        } break;
//        case 11: {
//            [textLabel setText:@"November(1)"];
//        } break;
//        case 12: {
//            [textLabel setText:@"December(1)"];
//        } break;
//
//
//        default:
//            break;
//    }

    
    return cell;
    
}

- (void) collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
  NewsLetterListingVC *vc = [MainStoryBoard instantiateViewControllerWithIdentifier:@"NewsLetterListingVC"];
    //NSDictionary *dict = [months objectAtIndex:indexPath.row];
//    NSString *str = dict[@"data"];
//    vc.str = str;
    NSDictionary *dict = [data objectAtIndex: indexPath.row];
    months = dict[@"month"];
    count = dict[@"count"];
    NSString *year = dict[@"year"];
  vc.monthStr = months;
  vc.yearStr = year;
  [self.navigationController pushViewController:vc animated:YES];
    
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

//MARK: Add Right Navigation Bar Button
- (void)setAddRightBarBarBackButtonEnabled:(BOOL)addRightBarBarBackButtonEnabled {
  //This is for add Right button
    UIButton *btnBack = [UIButton buttonWithType:UIButtonTypeCustom];
    [btnBack setFrame:CGRectMake(0, 0, 30, 90)];
    [btnBack setImage:[UIImage imageNamed:@"dashboardSlide"] forState:UIControlStateNormal];
    [btnBack addTarget:self action:@selector(actionRightBarButton:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *barButton =[[UIBarButtonItem alloc] initWithCustomView:btnBack];
    self.navigationItem.rightBarButtonItem = barButton;
}

- (void)actionRightBarButton:(UIButton *)btn {
  
  UIViewController *vc = [MainStoryBoard instantiateViewControllerWithIdentifier:@"homeVC"];
  [self.navigationController pushViewController:vc animated:YES];
  
}



@end
