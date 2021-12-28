//
//  ChoiceViewController.m
//  SatyaSadhna
//
//  Created by Roshan Singh Bisht on 11/06/17.
//  Copyright © 2017 Roshan Singh Bisht. All rights reserved.
//

#import "ChoiceViewController.h"
#import "TrackViewController.h"

@interface ChoiceViewController ()<UITableViewDelegate,UITableViewDataSource> {
    NSArray *data;
}
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation ChoiceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setAddRightBarBarBackButtonEnabled:YES];
    self.navigationItem.title = kLangualString(@"Tracks");
    //if ([_str isEqualToString:@"left"]) {
        self.addLeftBarBarBackButtonEnabled = YES;
        
  //  } else {
    //    self.addLeftBarMenuButtonEnabled = YES;
        
  //  }
    [self.view setBackgroundColor:kBgImage];
    self.view.layer.contents = (id)[UIImage imageNamed:@"loginBg"].CGImage;
    data = @[@"Children", @"New Student",@"Old Student",@"One Day Course"];
    
    id<GAITracker> tracker = [GAI sharedInstance].defaultTracker;
    [tracker set:kGAIScreenName value:@"Choice View"];
    [tracker send:[[GAIDictionaryBuilder createScreenView] build]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 51;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [_tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    UILabel *label = (UILabel *)[cell.contentView viewWithTag:1];
    label.layer.cornerRadius = 5.0f;
    label.clipsToBounds = YES;
    label.text = [NSString stringWithFormat:@"  %@",kLangualString([data objectAtIndex:indexPath.row])];
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.row) {
        case 0:{
            TrackViewController *vc = [MainStoryBoard instantiateViewControllerWithIdentifier:@"trackVC"];
            vc.isFromView = @"track";
            vc.identifiew = @"children";
            vc.navTitle =@"Children";
            [self.navigationController pushViewController:vc animated:YES];
        } break;
        case 1:{
            TrackViewController *vc = [MainStoryBoard instantiateViewControllerWithIdentifier:@"trackVC"];
            vc.isFromView = @"track";
            vc.identifiew = @"student";
            vc.navTitle =@"New Student";
            [self.navigationController pushViewController:vc animated:YES];
        } break;
        case 2:{
            TrackViewController *vc = [MainStoryBoard instantiateViewControllerWithIdentifier:@"trackVC"];
            vc.isFromView = @"track";
            vc.identifiew = @"old_student";
            vc.navTitle =@"Old Student";
            [self.navigationController pushViewController:vc animated:YES];
        } break;
//        case 3:{
//           // vc.identifiew = @"old_student";
//            vc.navTitle =@"One Day Course";
//        } break;
        default:
            break;
    }
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
    if ([_str isEqualToString:@"left"]) {
        [self.navigationController popToRootViewControllerAnimated:true];
    } else {
        UIViewController *vc = [MainStoryBoard instantiateViewControllerWithIdentifier:@"homeVC"];
        [self.navigationController pushViewController:vc animated:YES];
    }
}

@end
