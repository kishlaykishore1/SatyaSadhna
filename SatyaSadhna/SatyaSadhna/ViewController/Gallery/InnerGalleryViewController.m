//
//  InnerGalleryViewController.m
//  SatyaSadhna
//
//  Created by Roshan Singh Bisht on 06/05/17.
//  Copyright © 2017 Roshan Singh Bisht. All rights reserved.
//

#import "InnerGalleryViewController.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "UIImageView+MHFacebookImageViewer.h"
#import "GalleryImageVC.h"


#define TRY_AN_ANIMATED_GIF 0

@interface InnerGalleryViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,MHFacebookImageViewerDatasource> {
    NSArray *imageArray;
}
@property (weak, nonatomic) IBOutlet UICollectionView *collection;

@end

@implementation InnerGalleryViewController
@synthesize imageString;
- (void)viewDidLoad {
    [super viewDidLoad];
    imageArray = [imageString componentsSeparatedByString:@","];
    
    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated {
    self.addLeftBarBarBackButtonEnabled = YES;
    self.navigationItem.title = kLangualString(@"Gallery");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
    UIImageView *imageView = (UIImageView *)[cell.contentView viewWithTag:1];
    imageView.contentMode = UIViewContentModeScaleToFill;
    [imageView sd_setImageWithURL:[imageArray objectAtIndex:indexPath.row] placeholderImage:[UIImage imageNamed:@"logo"] options:SDWebImageProgressiveDownload];
  //  [imageView setupImageViewer];
  //  [self displayImage:imageView withImageUrl:[imageArray objectAtIndex:indexPath.row] atIndex:indexPath.row];
    return cell;
    
}

- (void) collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
  GalleryImageVC *vc = [MainStoryBoard instantiateViewControllerWithIdentifier:@"GalleryImageVC"];
  vc.imgStr = [imageArray objectAtIndex:indexPath.row];
  [self.navigationController pushViewController:vc animated:YES];
}

- (UIEdgeInsets)collectionView:(UICollectionView*)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(0, 0, 0, 0); // top, left, bottom, right
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    
    return 10.0;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 10.0;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    CGSize mElementSize = CGSizeMake(182, 182);
    return mElementSize;
}

- (void)displayImage:(UIImageView*)imageView withImageUrl:(NSString*)imageUrlString atIndex:(NSInteger)index  {
  
  
  
  
  
    [imageView setupImageViewerWithDatasource:self initialIndex:index onOpen:^{
      [imageView sd_setImageWithPreviousCachedImageWithURL:[NSURL URLWithString:imageUrlString] placeholderImage:[UIImage imageNamed:@"logo"] options:SDWebImageRefreshCached progress:^(NSInteger receivedSize, NSInteger expectedSize) {
          
      } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
          [imageView setImage:image];
      }];
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
    return [UIImage imageNamed:@"logo"];
}

- (NSString *)captionForImageAtIndex:(NSInteger)index {
    return @"";
}




@end
