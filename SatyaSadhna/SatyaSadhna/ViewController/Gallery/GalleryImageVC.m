//
//  GalleryImageVC.m
//  SatyaSadhna
//
//  Created by kishlay kishore on 18/06/21.
//  Copyright © 2021 Roshan Singh Bisht. All rights reserved.
//

#import "GalleryImageVC.h"
#import <SDWebImage/UIImageView+WebCache.h>

@interface GalleryImageVC ()<UIScrollViewDelegate> {
  
}

@property (weak, nonatomic) IBOutlet UIScrollView *scrolView;
@property (weak, nonatomic) IBOutlet UIImageView *zoomImageView;

@end

@implementation GalleryImageVC

- (void)viewWillAppear:(BOOL)animated {
    self.addLeftBarBarBackButtonEnabled = YES;
  if ([_fromView isEqual: @"Quote"]) {
     self.navigationItem.title = kLangualString(@"Quotation");
   } else {
     self.navigationItem.title = kLangualString(@"Gallery");
   }
//    [self.view setBackgroundColor:kBgImage];
//    self.view.layer.contents = (id)[UIImage imageNamed:@"loginBg"].CGImage;
    [_scrolView.delegate self];
    _scrolView.minimumZoomScale = 1.0;
    _scrolView.maximumZoomScale = 10.0;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setAddRightBarBarBackButtonEnabled:YES];
    if ([_imgStr length] == 0) {
      _zoomImageView.image = nil;
    } else {
      [_zoomImageView sd_setImageWithURL:[NSURL URLWithString:_imgStr] placeholderImage:[UIImage imageNamed:@"logo"]];
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
 
    [self.navigationController popToRootViewControllerAnimated:true];
}

@end
