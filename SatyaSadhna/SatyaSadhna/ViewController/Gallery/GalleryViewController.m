//
//  GalleryViewController.m
//  SatyaSadhna
//
//  Created by Roshan Singh Bisht on 06/05/17.
//  Copyright © 2017 Roshan Singh Bisht. All rights reserved.
//

#import "GalleryViewController.h"
#import "GalleryService.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "InnerGalleryViewController.h"


@interface GalleryViewController ()<UITableViewDelegate,UITableViewDataSource> {
    NSMutableArray *imageArray;
    NSMutableArray *NameArray;
    NSMutableArray *innerGalleryImages;
    NSMutableArray *firstImages;
}

@property (weak, nonatomic) IBOutlet UITableView *imageTableView;

@end

@implementation GalleryViewController

- (void)viewWillAppear:(BOOL)animated {
    self.addLeftBarBarBackButtonEnabled = YES;
    self.navigationItem.title = kLangualString(@"Gallery");
    [self.view setBackgroundColor:kBgImage];
    self.view.layer.contents = (id)[UIImage imageNamed:@"loginBg"].CGImage;
    [_imageTableView setTableFooterView:[UIView new]];
    
    id<GAITracker> tracker = [GAI sharedInstance].defaultTracker;
    [tracker set:kGAIScreenName value:@"Gallery View"];
    [tracker send:[[GAIDictionaryBuilder createScreenView] build]];

}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setAddRightBarBarBackButtonEnabled:YES];
    imageArray = [NSMutableArray new];
    NameArray  = [NSMutableArray new];
    innerGalleryImages  = [NSMutableArray new];
    firstImages  = [NSMutableArray new];
    [_imageTableView setBackgroundColor:[UIColor clearColor]];
    [self getData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)getData {
    if (mserviceHandler.galleryService.galleryImages.count > 0) {
        for (NSDictionary *dict in mserviceHandler.galleryService.galleryImages) {
            [imageArray addObject:dict[@"fristimage"]];
            [innerGalleryImages addObject:dict[@"gallery_image"]];
            [NameArray addObject:dict[@"title"]];
            
        }
        [_imageTableView reloadData];
        [mserviceHandler.galleryService gallery:^(id response) {
            if ([response[@"status"] isEqualToString:@"SUCCESS"]) {
                if (imageArray.count > 0 && innerGalleryImages.count > 0 && NameArray.count > 0) {
                    imageArray = [NSMutableArray new];
                    NameArray  = [NSMutableArray new];
                    innerGalleryImages  = [NSMutableArray new];
                }
                for (NSDictionary *dict in response[@"plan_result"]) {
                    [imageArray addObject:dict[@"fristimage"]];
                    [innerGalleryImages addObject:dict[@"gallery_image"]];
                    [NameArray addObject:dict[@"title"]];
                }
                [_imageTableView reloadData];
            } else {
                [Utils showAlertMessage:response[@"msg"] withTitle:@"Alert"];
            }
            
        } failure:^(NSError *error) {
            
        }];
    } else {
        [self.view addSubview:activityIndicatorView];
        [activityIndicatorView startAnimating];
        [mserviceHandler.galleryService gallery:^(id response) {
            [activityIndicatorView stopAnimating];
            if ([response[@"status"] isEqualToString:@"SUCCESS"]) {
                for (NSDictionary *dict in response[@"plan_result"]) {
                    [imageArray addObject:dict[@"fristimage"]];
                    [innerGalleryImages addObject:dict[@"gallery_image"]];
                    [NameArray addObject:dict[@"title"]];
                   
                }
                 [_imageTableView reloadData];
            } else {
                [Utils showAlertMessage:response[@"msg"] withTitle:@"Alert"];
            }
            
        } failure:^(NSError *error) {
            [activityIndicatorView stopAnimating];
            [Utils showAlertMessage:error.localizedDescription withTitle:@"Alert"];
        }];
    }
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return imageArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    UIImageView *image = (UIImageView *)[cell.contentView viewWithTag:1];
    NSString *str = [innerGalleryImages objectAtIndex:indexPath.row];
    image.contentMode = UIViewContentModeScaleAspectFill;
    firstImages = [str componentsSeparatedByString:@","].mutableCopy;
    [image sd_setImageWithURL:[NSURL  URLWithString:[firstImages objectAtIndex:0]]];
    UILabel *textLabel = (UILabel *)[cell.contentView viewWithTag:2];
    [textLabel setBackgroundColor:RGB(241, 187, 120)];
    [textLabel setAlpha:0.9];
    textLabel.text = [NSString stringWithFormat:@"%@ \n %lu Photos",[NameArray objectAtIndex:indexPath.row],(unsigned long)firstImages.count];
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    InnerGalleryViewController *vc = [MainStoryBoard instantiateViewControllerWithIdentifier:@"innerGalleryVC"];
    vc.imageString = [innerGalleryImages objectAtIndex:indexPath.row];
    [self.navigationController pushViewController:vc animated:YES];
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 150;
}

-(void)dealloc {
    imageArray = nil;
    NameArray  = nil;
    innerGalleryImages  = nil;
    firstImages  = nil;
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
