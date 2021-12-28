//
//  CDViewController.m
//  SatyaSadhna
//
//  Created by Roshan Singh Bisht on 19/05/17.
//  Copyright © 2017 Roshan Singh Bisht. All rights reserved.
//
#import "HomeService.h"
#import "CDViewController.h"
#import <SDWebImage/UIImageView+WebCache.h>

@interface CDViewController ()<UICollectionViewDelegate,UICollectionViewDataSource> {
    NSArray *dataArray;
}
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

@end

@implementation CDViewController


- (void) getCD {
    [mserviceHandler.homeService cd:^(id response) {
        dataArray = response;
        [_collectionView reloadData];
        [activityIndicatorView stopAnimating];
    } failure:^(NSError *error) {
        [activityIndicatorView stopAnimating];
    }];
}
- (void)viewDidLoad {
    [super viewDidLoad];
     [self setAddRightBarBarBackButtonEnabled:YES];
    if (mserviceHandler.homeService.cdArrayData.count > 0 && mserviceHandler.homeService.cdArrayData != nil) {
        dataArray = mserviceHandler.homeService.cdArrayData;
        [_collectionView reloadData];
        // reload data
        [self getCD];
        
    } else {
        if ([Internet checkNetConnection]) {
        
        [self.view addSubview:activityIndicatorView];
        [activityIndicatorView startAnimating];
            [self getCD];
        }
    }
  
    
}

- (void)viewWillAppear:(BOOL)animated {
    self.navigationItem.title = @"CD";
    self.addLeftBarMenuButtonEnabled = YES;
    [self.view setBackgroundColor:kBgImage];
    self.view.layer.contents = (id)[UIImage imageNamed:@"loginBg"].CGImage;
    [_collectionView setBackgroundColor:[UIColor clearColor]];
    
    id<GAITracker> tracker = [GAI sharedInstance].defaultTracker;
    [tracker set:kGAIScreenName value:@"CD View"];
    [tracker send:[[GAIDictionaryBuilder createScreenView] build]];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return dataArray.count;
}

-(UICollectionViewCell*)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"nameCell" forIndexPath:indexPath];
    UIImageView *image = (UIImageView *)[cell.contentView viewWithTag:1];
    image.layer.cornerRadius = image.frame.size.height / 2;
    image.clipsToBounds = YES;
    image.contentMode = UIViewContentModeScaleAspectFit;
    NSDictionary *temp = [dataArray objectAtIndex:indexPath.row];
    [image sd_setImageWithURL:[NSURL URLWithString:temp[@"image"]]
                 placeholderImage:[UIImage imageNamed:@"cd"]];
    UILabel *textLabel = (UILabel *)[cell.contentView viewWithTag:2];
    [textLabel setText:temp[@"title"]];
    UILabel *textLabel2 = (UILabel *)[cell.contentView viewWithTag:3];
    [textLabel2 setText:temp[@"price"]];
    return cell;
    
}

- (void) collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
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
