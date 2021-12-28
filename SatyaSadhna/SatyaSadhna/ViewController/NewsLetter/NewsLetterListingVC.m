//
//  NewsLetterListingVC.m
//  SatyaSadhna
//
//  Created by kishlay kishore on 16/05/21.
//  Copyright © 2021 Roshan Singh Bisht. All rights reserved.
//

#import "NewsLetterListingVC.h"
#import "NewsViewController.h"
#import "HomeService.h"

@interface NewsLetterListingVC ()<UICollectionViewDataSource,UICollectionViewDelegate> {
  NSMutableArray *dataArray;
  NSMutableArray *data;
  NSString *months;
  NSString *count;
  NSMutableArray *extractedData;
}
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (weak, nonatomic) IBOutlet UILabel *label;

@end

@implementation NewsLetterListingVC

- (void)newsList {
  [mserviceHandler.homeService newsletterList:_yearStr :_monthStr success:^(id response) {
    [activityIndicatorView stopAnimating];
    if ([response[@"status"] boolValue]) {
      data = response[@"page_result"];
      for (NSArray *arr in data) {
        for (NSArray *array in arr) {
          [dataArray addObject:array];
        }
       }
      [_collectionView reloadData];
      //NSLog(@"response %lu",(unsigned long)[extractedData count]);
    }
  } failure:^(NSError * error) {
    [activityIndicatorView stopAnimating];
  }];
}



- (void)viewDidLoad {
    [super viewDidLoad];
  extractedData = [NSMutableArray new];
  dataArray = [NSMutableArray new];
  [self setAddRightBarBarBackButtonEnabled:YES];
  [self.view addSubview:activityIndicatorView];
  [activityIndicatorView startAnimating];
  [self newsList];
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
    [_label setText:kLangualString(@"Click on News letter to read")];
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return dataArray.count;
}

-(UICollectionViewCell*)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    [cell setBackgroundColor:[UIColor clearColor]];
  UIView *view = (UIView *)[cell.contentView viewWithTag:3];
  view.layer.cornerRadius = view.frame.size.height / 2;
  view.clipsToBounds = YES;
    UIImageView *image = (UIImageView *)[cell.contentView viewWithTag:1];
    //image.layer.cornerRadius = image.frame.size.height / 2;
    image.clipsToBounds = YES;
    
   // image.contentMode = UIViewContentModeScaleAspectFit;
    image.image = [UIImage imageNamed:@"pdf_icon"];
    UILabel *textLabel = (UILabel *)[cell.contentView viewWithTag:2];
   // NSArray *temp =
    NSDictionary *dict = [dataArray objectAtIndex:indexPath.row];
   // NSString *str = dict[@"createdAt"];
    NSString * createdAt = dict[@"createdAt"];
    textLabel.text = createdAt;

    
    return cell;
    
}

- (void) collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    NewsViewController *vc = [MainStoryBoard instantiateViewControllerWithIdentifier:@"newsViewVC"];
    NSDictionary *dict = [dataArray objectAtIndex:indexPath.row];
    NSString *str = dict[@"data"];
    vc.str = str;
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

