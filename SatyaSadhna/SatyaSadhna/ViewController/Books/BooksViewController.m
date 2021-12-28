//
//  BooksViewController.m
//  SatyaSadhna
//
//  Created by Roshan Bisht on 01/07/17.
//  Copyright © 2017 Roshan Singh Bisht. All rights reserved.
//

#import "BooksViewController.h"
#import "HomeService.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "IntroductionViewController.h"

@interface BooksViewController ()<UICollectionViewDelegate,UICollectionViewDataSource> {
  NSArray *dataArray;
}
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

@end

@implementation BooksViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  [self setAddRightBarBarBackButtonEnabled:YES];
  if (mserviceHandler.homeService.booksData.count > 0) {
    dataArray = mserviceHandler.homeService.booksData;
    [_collectionView reloadData];
    [self getDAta];
  } else {
    [self.view addSubview:activityIndicatorView];
    [activityIndicatorView startAnimating];
    [self getDAta];
  }
}


- (void)getDAta {
  if ([Internet checkNetConnection]) {
    [mserviceHandler.homeService books:^(id response) {
      [activityIndicatorView stopAnimating];
      dataArray = response;
      [_collectionView reloadData];
    } failure:^(NSError *error) {
      [activityIndicatorView stopAnimating];
    }];
  }
}
- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated {
  self.addLeftBarMenuButtonEnabled = YES;
  [self.view setBackgroundColor:kBgImage];
  self.view.layer.contents = (id)[UIImage imageNamed:@"loginBg"].CGImage;
  self.navigationItem.title = kLangualString(@"Books");
  
  id<GAITracker> tracker = [GAI sharedInstance].defaultTracker;
  [tracker set:kGAIScreenName value:@"Books"];
  [tracker send:[[GAIDictionaryBuilder createScreenView] build]];
}


- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
  return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
  
  return dataArray.count;
}

-(UICollectionViewCell*)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
  UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
  [cell setBackgroundColor:RGB(251, 227, 197)];
  
  UIImageView *imageView = (UIImageView *)[cell.contentView viewWithTag:1];
  UILabel *titleLabel = (UILabel *)[cell.contentView viewWithTag:2];
  UILabel *priceLabel = (UILabel *)[cell.contentView viewWithTag:3];
  
  if (dataArray.count > 0) {
    NSDictionary *dict = [dataArray objectAtIndex:indexPath.row];
    if ([dict[@"ext"] isEqual: @"image"]) {
      imageView.contentMode = UIViewContentModeScaleAspectFill;
      [imageView sd_setImageWithURL:[NSURL  URLWithString:dict[@"image"]]];
      [titleLabel setText:dict[@"title"]];
      [priceLabel setText:[NSString stringWithFormat:@"Rs %@",dict[@"price"]]];
    } else {
      imageView.contentMode = UIViewContentModeScaleAspectFit;
      imageView.image = [UIImage imageNamed:@"pdf_icon"];
      [titleLabel setText:dict[@"title"]];
      [priceLabel setText:[NSString stringWithFormat:@"Rs %@",dict[@"price"]]];
    }    
  }
  return cell;
}

- (void) collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
  NSDictionary *dict = [dataArray objectAtIndex:indexPath.row];
  if ([dict[@"ext"] isEqual: @"pdf"]) {
    IntroductionViewController *vc = [MainStoryBoard instantiateViewControllerWithIdentifier:@"introVC"];
    vc.isFromView = @"satya";
    vc.currentView = @"Books";
    vc.theTitle = dict[@"title"];
    vc.htmlUrl = dict[@"image"];
    [self.navigationController pushViewController:vc animated:YES];
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
  
  CGSize mElementSize = CGSizeMake(180, 250);
  return mElementSize;
}

//MARK: Add Right Navigation Bar Button
- (void)setAddRightBarBarBackButtonEnabled:(BOOL)addRightBarBarBackButtonEnabled {
  //This is for add Right button
  if (addRightBarBarBackButtonEnabled) {
    UIButton *btnBack = [UIButton buttonWithType:UIButtonTypeCustom];
    [btnBack setFrame:CGRectMake(0, 0, 30, 90)];
    [btnBack setImage:[UIImage imageNamed:@"dashboardSlide"] forState:UIControlStateNormal];
    [btnBack addTarget:self action:@selector(actionRightBarButton:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *barButton =[[UIBarButtonItem alloc] initWithCustomView:btnBack];
    self.navigationItem.rightBarButtonItem = barButton;
  } else {
    [self.navigationItem setHidesBackButton:YES];
  }
}

- (void)actionRightBarButton:(UIButton *)btn {
  
  UIViewController *vc = [MainStoryBoard instantiateViewControllerWithIdentifier:@"homeVC"];
  [self.navigationController pushViewController:vc animated:YES];
}



@end
