//
//  AcharyjiViewController.m
//  SatyaSadhna
//
//  Created by Roshan Singh Bisht on 01/05/17.
//  Copyright © 2017 Roshan Singh Bisht. All rights reserved.
//

#import "AcharyjiViewController.h"
#import "HomeService.h"
#import <SDWebImage/UIImageView+WebCache.h>

@interface AcharyjiViewController ()<UITableViewDelegate,UITableViewDataSource> {
    NSMutableArray *rowdata;
    NSMutableArray *imageArray;
    NSMutableArray *nameData;
}
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation AcharyjiViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    [self setAddRightBarBarBackButtonEnabled:YES];
    [self.tableView setDelegate:self];
    [self.tableView setDataSource:self];
    rowdata = [NSMutableArray new];
    imageArray = [NSMutableArray new];
    nameData = [NSMutableArray new];
    if (mserviceHandler.homeService.achrayjiData) {
        
        
        [mserviceHandler.homeService acharyaji:^(id response) {
            for (NSDictionary *dict in response) {
                [imageArray addObject:dict[@"page_Image"]];
                [nameData addObject:dict[@"page_title"]];
                [rowdata addObject:dict[@"page_content"]];
            }
            [_tableView reloadData];
        } failure:^(NSError *error) {
            
        }];
    } else {
        [self.view addSubview:activityIndicatorView];
        [activityIndicatorView startAnimating];
        [mserviceHandler.homeService acharyaji:^(id response) {
            for (NSDictionary *dict in response) {
                [imageArray addObject:dict[@"page_Image"]];
                [nameData addObject:dict[@"page_title"]];
                [rowdata addObject:dict[@"page_content"]];
            }
            [_tableView reloadData];
            [activityIndicatorView stopAnimating];
        } failure:^(NSError *error) {
            [activityIndicatorView stopAnimating];
        }];
    }
    
}

- (void)viewWillAppear:(BOOL)animated{
    self.addLeftBarBarBackButtonEnabled = YES;
    [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"loginBg"]]];
    self.view.layer.contents = (id)[UIImage imageNamed:@"loginBg"].CGImage;
    self.navigationItem.title = kLangualString(@"Acharyaji");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 540;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return rowdata.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    [cell setBackgroundColor:RGB(251, 227, 197)];
    UIImageView *userImage = (UIImageView *)[cell.contentView viewWithTag:1];
    userImage.layer.borderWidth = 1.0f;
    userImage.layer.borderColor = [UIColor clearColor].CGColor;
    userImage.layer.cornerRadius = userImage.frame.size.height /2;
    userImage.clipsToBounds = YES;

    [userImage sd_setImageWithURL:[NSURL URLWithString:[imageArray objectAtIndex:indexPath.row]]];
    
    UILabel *nameLabel = (UILabel *)[cell.contentView viewWithTag:2];
    nameLabel.text = [nameData objectAtIndex:indexPath.row];
    
    UILabel *showLabel = (UILabel *)[cell.contentView viewWithTag:3];
    showLabel.layer.cornerRadius = 0.5f;
    showLabel.clipsToBounds = YES;
    
    UILabel *dataLabel = (UILabel *)[cell.contentView viewWithTag:4];
    dataLabel.text = [NSAttributedString.alloc
                      initWithData:[[rowdata objectAtIndex:indexPath.row] dataUsingEncoding:NSUnicodeStringEncoding]
                           options:@{NSDocumentTypeDocumentOption: NSHTMLTextDocumentType}
                documentAttributes:nil error:nil].string;
   // [rowdata objectAtIndex:indexPath.row];
    
    return cell;
}

- (void)dealloc {
    rowdata = nil;
    imageArray = nil;
    nameData = nil;
    
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
@implementation NSString (CSExtension)

    - (NSString *)htmlToText {
        return [NSAttributedString.alloc
                initWithData:[self dataUsingEncoding:NSUnicodeStringEncoding]
                     options:@{NSDocumentTypeDocumentOption: NSHTMLTextDocumentType}
          documentAttributes:nil error:nil].string;
    }

@end



