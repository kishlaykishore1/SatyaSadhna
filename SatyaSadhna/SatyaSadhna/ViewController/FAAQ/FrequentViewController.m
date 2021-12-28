//
//  FrequentViewController.m
//  SatyaSadhna
//
//  Created by Roshan Bisht on 26/06/17.
//  Copyright © 2017 Roshan Singh Bisht. All rights reserved.
//

#import "FrequentViewController.h"
#import "HomeService.h"
#import "SCLAlertView.h"

@interface FrequentViewController ()<UITableViewDelegate,UITableViewDataSource,UIAlertViewDelegate> {
    NSArray *dataArray;
    UITextView *textView;
}
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIButton *askQuestionButton;

@end

@implementation FrequentViewController

- (void)data {
    [activityIndicatorView startAnimating];
    [mserviceHandler.homeService faq:^(id response) {
        [activityIndicatorView stopAnimating];
        dataArray = response;
        [_tableView reloadData];
    } failure:^(NSError *error) {
        [activityIndicatorView stopAnimating];
    }];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setAddRightBarBarBackButtonEnabled:YES];
    [self.view addSubview:activityIndicatorView];
    [_askQuestionButton setTitle:kLangualString(@"Ask a Question") forState:UIControlStateNormal];
    if (_isFromSlide) {
        self.addLeftBarMenuButtonEnabled= YES;
        // [self setAddRightBarBarBackButtonEnabled:NO];
    } else {
        self.addLeftBarBarBackButtonEnabled = YES;
        // [self setAddRightBarBarBackButtonEnabled:YES];
    }
    if (mserviceHandler.homeService.faqData.count > 0) {
        dataArray = mserviceHandler.homeService.faqData;
        [_tableView reloadData];
        [self data];
    } else {
        [activityIndicatorView startAnimating];
        [self data];
    }
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)askAction:(UIButton *)sender {
//    SCLAlertView *alert = [[SCLAlertView alloc] init];
//    [alert setHorizontalButtons:YES];
//    
//    SCLTextView *textField = [alert addTextField:kLangualString(@"Enter your Question...")];
//    [textField setTextColor:[UIColor blackColor]];
//    alert.hideAnimationType = SCLAlertViewHideAnimationSimplyDisappear;
//    [alert addButton:kLangualString(@"Ask") actionBlock:^(void) {
//        NSLog(@"Text value: %@", textField.text);
//        if (textField.text.length > 0) {
//            NSDictionary *param = @{@"name":textField.text,
//                                    @"user_id":[UserDefaultManager getUserID]
//                                    };
//            [mserviceHandler.homeService askQuestion:param success:^(id response) {
//                MHWAlertView *alert = [[MHWAlertView alloc] initWithTitle:kLangualString(@"Success") message:kLangualString(@"Your question has been submitted.") delegate:nil cancelButtonTitle:kLangualString(@"OK") otherButtonTitles:nil, nil];
//                [alert show];
//            } failure:^(NSError *error) {
//                
//            }];
//        } else {
//            MHWAlertView *alert = [[MHWAlertView alloc] initWithTitle:kLangualString(@"Error") message:kLangualString(kLangualString(@"Please enter your related query first.")) delegate:nil cancelButtonTitle:kLangualString(@"OK") otherButtonTitles:nil, nil];
//            [alert show];
//        }
//        
//    }];
    
//    [alert showEdit:self title:kLangualString(@"Ask a Question") subTitle:@"" closeButtonTitle:kLangualString(@"Cancel") duration:0.0f];
    UIAlertView *testAlert = [[UIAlertView alloc] initWithTitle:@"Enter your Question..."
                                                        message:@""
                                                       delegate:self
                                              cancelButtonTitle:@"Cancel"
                                              otherButtonTitles:@"Done", nil];
    textView = [UITextView new];
   

    [testAlert setValue:textView forKey:@"accessoryView"];
    [testAlert show];
    
}

- (void)viewWillAppear:(BOOL)animated {
    self.navigationItem.title = kLangualString(@"Question and Answer with Guru Ji");
    [self.view setBackgroundColor:kBgImage];
    
    
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 70;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    UILabel *questionLabel = (UILabel *)[cell.contentView viewWithTag:1];
    UILabel *ansLabel = (UILabel *)[cell.contentView viewWithTag:2];
    NSDictionary *dict =   [dataArray objectAtIndex:indexPath.row];
        [questionLabel setText:[NSString stringWithFormat:@"Q %@",dict[@"query"]]];
        [ansLabel setText:[NSString stringWithFormat:@"A %@",dict[@"reply"]]];
    
    return cell;
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return dataArray.count;
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 1) {
        NSString *name = textView.text;
        if (name.length > 0) {
            NSDictionary *param = @{@"name":name,
                                    @"user_id":[UserDefaultManager getUserID]
                                    };
            [mserviceHandler.homeService askQuestion:param success:^(id response) {
                MHWAlertView *alert = [[MHWAlertView alloc] initWithTitle:kLangualString(@"Success") message:kLangualString(@"Your question has been submitted.") delegate:nil cancelButtonTitle:kLangualString(@"OK") otherButtonTitles:nil, nil];
                [alert show];
            } failure:^(NSError *error) {
                
            }];
        } else {
            MHWAlertView *alert = [[MHWAlertView alloc] initWithTitle:kLangualString(@"Error") message:kLangualString(kLangualString(@"Please enter your related query first.")) delegate:nil cancelButtonTitle:kLangualString(@"OK") otherButtonTitles:nil, nil];
            [alert show];
        }
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
     if (_isFromSlide) {
         UIViewController *vc = [MainStoryBoard instantiateViewControllerWithIdentifier:@"homeVC"];
         [self.navigationController pushViewController:vc animated:YES];
     } else {
         [self.navigationController popToRootViewControllerAnimated:true];
     }
   // [self.navigationController popToRootViewControllerAnimated:true];
}


@end
