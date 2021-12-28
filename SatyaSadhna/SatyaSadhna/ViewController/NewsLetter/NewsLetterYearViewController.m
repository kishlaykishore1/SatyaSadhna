//
//  NewsLetterYearViewController.m
//  SatyaSadhna
//
//  Created by Roshan Singh Bisht on 15/05/17.
//  Copyright © 2017 Roshan Singh Bisht. All rights reserved.
//

#import "NewsLetterYearViewController.h"
#import "HomeService.h"
#import "InnerNewsViewController.h"

@interface NewsLetterYearViewController ()<UICollectionViewDelegate,UICollectionViewDataSource> {
  NSMutableArray *data;
  NSMutableArray *dateArray;
  NSMutableDictionary *completeDict;
  NSMutableArray *dates;
  NSNumber *year;
  NSString * count;
}
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (weak, nonatomic) IBOutlet UILabel *label;

@end

@implementation NewsLetterYearViewController


- (void)newsYear {
  [mserviceHandler.homeService newsletterYear:^(id response) {
    [activityIndicatorView stopAnimating];
    if ([response[@"status"] boolValue]) {
      NSDateFormatter *dateFormatter = [NSDateFormatter new];
      dateFormatter.dateFormat = @"dd-MM-yyyy";
      
      data = response[@"page_result"];
      [_collectionView reloadData];
//      for (NSArray *arr in data) {
//        [dateArray addObject:arr];
//      }
//      for (NSArray *arr in dateArray) {
//        NSDictionary *dict = [arr firstObject];
//        NSString *str = dict[@"createdAt"];
//        NSArray *temp2 = [str componentsSeparatedByString:@"-"];
//
//        if ([dates containsObject:[temp2 firstObject]]) {
//
//        } else {
//
//          [dates addObject:[temp2 firstObject]];
//        }
//      }
    // NSLog(@"response %@",dateArray);
    }
  } failure:^(NSError * error) {
    [activityIndicatorView stopAnimating];
  }];
}
- (void)viewDidLoad {
  [super viewDidLoad];
  [self setAddRightBarBarBackButtonEnabled:YES];
  if ([_isFromView isEqualToString:@"Newsletter"]) {
    self.addLeftBarBarBackButtonEnabled = YES;
  } else {
    self.addLeftBarMenuButtonEnabled = YES;
  }
  dates = [NSMutableArray new];
  data = [NSMutableArray new];
  dateArray = [NSMutableArray new];
  completeDict = [NSMutableDictionary new];
  [self.view addSubview:activityIndicatorView];
  [activityIndicatorView startAnimating];
  [self newsYear];
  
  
}

- (void)viewWillAppear:(BOOL)animated{
  self.navigationItem.title = kLangualString(@"Newsletter");
  
  //  self.addLeftBarBarBackButtonEnabled = YES;
  
  [self.view setBackgroundColor:kBgImage];
  self.view.layer.contents = (id)[UIImage imageNamed:@"loginBg"].CGImage;
  [_label setText:kLangualString(@"Click on year to check out news letter")];
  
  id<GAITracker> tracker = [GAI sharedInstance].defaultTracker;
  [tracker set:kGAIScreenName value:@"NewsLetter View"];
  [tracker send:[[GAIDictionaryBuilder createScreenView] build]];
}

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
  
  
  
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
  year = dict[@"year"];
  count = dict[@"count"];
  //NSString *datesData = [dates objectAtIndex: indexPath.row];
  textLabel.text = [NSString stringWithFormat:@"%@(%@)",year,count];
  //[NSString stringWithFormat:@"%@(%lu)",[temp2 firstObject],(unsigned long)temp.count];
  
  return cell;
  
}

- (void) collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
  //NSString *datesData = [dates objectAtIndex: indexPath.row];
  InnerNewsViewController *vc = [MainStoryBoard instantiateViewControllerWithIdentifier:@"innerNewsVC"];
//  vc.newsArray = dateArray;
//  vc.dateStr = datesData;
  NSDictionary *dict = [data objectAtIndex: indexPath.row];
  year = dict[@"year"];
  vc.dateStr = year;
  
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
