//
//  QuotionViewController.m
//  SatyaSadhna
//
//  Created by Roshan Singh Bisht on 20/05/17.
//  Copyright © 2017 Roshan Singh Bisht. All rights reserved.
//

#import "QuotionViewController.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "GalleryService.h"
#import "UIImageView+MHFacebookImageViewer.h"
#import "GalleryImageVC.h"


#define TRY_AN_ANIMATED_GIF 0

@interface QuotionViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,MHFacebookImageViewerDatasource> {
    NSArray *imageArray;
    UIImageView *imageView1;
}
@property (weak, nonatomic) IBOutlet UICollectionView *collection;

@end

@implementation QuotionViewController


- (void)getimages {
    [mserviceHandler.galleryService quotion:^(id response) {
        imageArray = response;
        [_collection reloadData];
        stopLoader
    } failure:^(NSError *error) {
        stopLoader
    }];
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setAddRightBarBarBackButtonEnabled:YES];
    [self.view setBackgroundColor:kBgImage];
    self.view.layer.contents = (id)[UIImage imageNamed:@"loginBg"].CGImage;
    self.addLeftBarMenuButtonEnabled = YES;
    self.navigationItem.title = @"Quotation";
    if ([Internet checkNetConnection]) {
        if (mserviceHandler.galleryService.quotionImages.count > 0) {
            imageArray = mserviceHandler.galleryService.quotionImages;
            [_collection reloadData];
            [self getimages];
        } else {
            startLoader
            [self getimages];
        }
    }
    
    id<GAITracker> tracker = [GAI sharedInstance].defaultTracker;
    [tracker set:kGAIScreenName value:@"Quotation View"];
    [tracker send:[[GAIDictionaryBuilder createScreenView] build]];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return imageArray.count;
}

-(UICollectionViewCell*)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    [cell setBackgroundColor:RGB(251, 227, 197)];
    imageView1 = (UIImageView *)[cell.contentView viewWithTag:3];
    
    imageView1.contentMode = UIViewContentModeScaleToFill;
    [imageView1 sd_setImageWithURL:[imageArray objectAtIndex:indexPath.row] placeholderImage:[UIImage imageNamed:@"logo"] options:SDWebImageProgressiveDownload];
    //[imageView1 setupImageViewer];
    return cell;
}

- (void) collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
  GalleryImageVC *vc = [MainStoryBoard instantiateViewControllerWithIdentifier:@"GalleryImageVC"];
  vc.imgStr = [imageArray objectAtIndex:indexPath.row];
  vc.fromView = @"Quote";
  [self.navigationController pushViewController:vc animated:YES];
   // [self displayImage:imageView1 withImageUrl:[imageArray objectAtIndex:indexPath.row] atIndex:indexPath.row];
}



- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    CGSize mElementSize = CGSizeMake(182, 182);
    return mElementSize;
}


- (void)displayImage:(UIImageView*)imageView withImageUrl:(NSString*)imageUrlString atIndex:(NSInteger)index  {
    
    [imageView sd_setImageWithPreviousCachedImageWithURL:[NSURL URLWithString:imageUrlString] placeholderImage:[UIImage imageNamed:@"placeholder"] options:SDWebImageRefreshCached progress:^(NSInteger receivedSize, NSInteger expectedSize) {
        
    } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        [imageView setImage:image];
    }];
    
    
    [imageView1 setupImageViewerWithDatasource:self initialIndex:index onOpen:^{
        [imageView1 sd_setImageWithURL:[NSURL URLWithString:imageUrlString]];
    } onClose:^{
      [imageView removeImageViewer];
    }];
    
    
}

- (NSInteger) numberImagesForImageViewer:(MHFacebookImageViewer *)imageViewer {
    return imageArray.count;
}

-  (NSURL*) imageURLAtIndex:(NSInteger)index imageViewer:(MHFacebookImageViewer *)imageViewer {
    return [NSURL URLWithString:[imageArray objectAtIndex:index]];
}

- (UIImage*) imageDefaultAtIndex:(NSInteger)index imageViewer:(MHFacebookImageViewer *)imageViewer{
    NSLog(@"INDEX IS %li",(long)index);
    return [UIImage imageNamed:@"placeholder"];
}

- (NSString *)captionForImageAtIndex:(NSInteger)index {
    return @"";
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
