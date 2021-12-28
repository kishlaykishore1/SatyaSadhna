//
//  KushYalatanViewController.m
//  SatyaSadhna
//
//  Created by Roshan Singh Bisht on 14/05/17.
//  Copyright © 2017 Roshan Singh Bisht. All rights reserved.
//

#import "KushYalatanViewController.h"
#import "HomeService.h"

@interface KushYalatanViewController ()<MHWAlertDelegate>

@property (weak, nonatomic) IBOutlet UITextView *labeltext;

@end

@implementation KushYalatanViewController
@synthesize titleString;
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setAddRightBarBarBackButtonEnabled:YES];
    
    if ([titleString isEqualToString:@"Vision"]) {
        if (mserviceHandler.homeService.visionData.length > 0 && mserviceHandler.homeService.visionData !=nil) {
            //[_labeltext setText:mserviceHandler.homeService.visionData];
            [mserviceHandler.homeService vision:^(id response) {
                [activityIndicatorView stopAnimating];
                if ([response[@"status"] boolValue]) {
                    for (NSDictionary *dict in response[@"page_result"]) {
                        NSString *str = dict[@"page_content"];
                      NSAttributedString *htmlString =
                      [[NSAttributedString alloc] initWithData:[str dataUsingEncoding:NSUTF8StringEncoding] options:@{NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType, NSCharacterEncodingDocumentAttribute: [NSNumber numberWithInt:NSUTF8StringEncoding]} documentAttributes:nil error:nil];
                      NSString* plainString = htmlString.string;
                        [_labeltext setText:plainString];
                        
                        mserviceHandler.homeService.visionData = str;
                    }
                } else {
                    MHWAlertView *alert = [[MHWAlertView alloc] initWithTitle:@"Alert" message:response[@"msg"] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                    [alert show];
                }
                
            } failure:^(NSError *error) {
                [activityIndicatorView stopAnimating];
            }];
        } else {
            [self.view addSubview:activityIndicatorView];
            [activityIndicatorView startAnimating];
            [mserviceHandler.homeService vision:^(id response) {
                [activityIndicatorView stopAnimating];
                if ([response[@"status"] boolValue]) {
                    for (NSDictionary *dict in response[@"page_result"]) {
                        NSString *str = dict[@"page_content"];
                      NSAttributedString *htmlString =
                      [[NSAttributedString alloc] initWithData:[str dataUsingEncoding:NSUTF8StringEncoding] options:@{NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType, NSCharacterEncodingDocumentAttribute: [NSNumber numberWithInt:NSUTF8StringEncoding]} documentAttributes:nil error:nil];
                      NSString* plainString = htmlString.string;
                        [_labeltext setText:plainString];
                        mserviceHandler.homeService.visionData = str;
                    }
                } else {
                    MHWAlertView *alert = [[MHWAlertView alloc] initWithTitle:@"Alert" message:response[@"msg"] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                    [alert show];
                }
                
            } failure:^(NSError *error) {
                [activityIndicatorView stopAnimating];
            }];
        }
        
    } else if ([titleString isEqualToString:@"Kushal Vidyapeeth"]) {
        [self vidyaData];
        
    } else if ([titleString isEqualToString:@"Kushal Aushadhalay"]) {
        [self aush];
    }
    
    
    
}

- (void)aush {
    {
        
        if (mserviceHandler.homeService.aushData.length > 0 && mserviceHandler.homeService.aushData !=nil) {
           // [_labeltext setText:mserviceHandler.homeService.aushData];
            [mserviceHandler.homeService aush:^(id response) {
                [activityIndicatorView stopAnimating];
                if ([response[@"status"] boolValue]) {
                    for (NSDictionary *dict in response[@"page_result"]) {
                        NSString *str = [dict[@"page_content"] stringByReplacingOccurrencesOfString:@"<p>" withString:@""];
                      NSAttributedString *htmlString =
                      [[NSAttributedString alloc] initWithData:[str dataUsingEncoding:NSUTF8StringEncoding] options:@{NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType, NSCharacterEncodingDocumentAttribute: [NSNumber numberWithInt:NSUTF8StringEncoding]} documentAttributes:nil error:nil];
                      NSString* plainString = htmlString.string;
                        [_labeltext setText:plainString];
                        mserviceHandler.homeService.aushData = str;
                    }
                } else {
                    MHWAlertView *alert = [[MHWAlertView alloc] initWithTitle:@"Alert" message:response[@"msg"] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                    [alert show];
                }
                
            } failure:^(NSError *error) {
                [activityIndicatorView stopAnimating];
            }];
        } else {
            [self.view addSubview:activityIndicatorView];
            [activityIndicatorView startAnimating];
            [mserviceHandler.homeService aush:^(id response) {
                [activityIndicatorView stopAnimating];
                if ([response[@"status"] boolValue]) {
                    for (NSDictionary *dict in response[@"page_result"]) {
                        NSString *str = [dict[@"page_content"] stringByReplacingOccurrencesOfString:@"<p>" withString:@""];
                      NSAttributedString *htmlString =
                      [[NSAttributedString alloc] initWithData:[str dataUsingEncoding:NSUTF8StringEncoding] options:@{NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType, NSCharacterEncodingDocumentAttribute: [NSNumber numberWithInt:NSUTF8StringEncoding]} documentAttributes:nil error:nil];
                      NSString* plainString = htmlString.string;
                        [_labeltext setText:plainString];
                        mserviceHandler.homeService.aushData = str;
                    }
                } else {
                    MHWAlertView *alert = [[MHWAlertView alloc] initWithTitle:@"Alert" message:response[@"msg"] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                    [alert show];
                }
                
            } failure:^(NSError *error) {
                [activityIndicatorView stopAnimating];
            }];
        }
        
        
        
    }
}

- (void)vidyaData {
    
    if (mserviceHandler.homeService.vidyadata.length > 0 && mserviceHandler.homeService.vidyadata !=nil) {
        //[_labeltext setText:mserviceHandler.homeService.vidyadata];
        [mserviceHandler.homeService vidya:^(id response) {
            [activityIndicatorView stopAnimating];
            if ([response[@"status"] boolValue]) {
                for (NSDictionary *dict in response[@"page_result"]) {
                    NSString *str = [dict[@"page_content"] stringByReplacingOccurrencesOfString:@"<p>" withString:@""];
                    str = [str stringByReplacingOccurrencesOfString:@"</p>" withString:@""];
                  NSAttributedString *htmlString =
                  [[NSAttributedString alloc] initWithData:[str dataUsingEncoding:NSUTF8StringEncoding] options:@{NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType, NSCharacterEncodingDocumentAttribute: [NSNumber numberWithInt:NSUTF8StringEncoding]} documentAttributes:nil error:nil];
                  NSString* plainString = htmlString.string;
                    [_labeltext setText:plainString];
                    mserviceHandler.homeService.vidyadata = str;
                }
            } else {
                MHWAlertView *alert = [[MHWAlertView alloc] initWithTitle:@"Alert" message:response[@"msg"] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                [alert show];
            }
            
        } failure:^(NSError *error) {
            [activityIndicatorView stopAnimating];
        }];
    } else {
        [self.view addSubview:activityIndicatorView];
        [activityIndicatorView startAnimating];
        [mserviceHandler.homeService vidya:^(id response) {
            [activityIndicatorView stopAnimating];
            if ([response[@"status"] boolValue]) {
                for (NSDictionary *dict in response[@"page_result"]) {
                    NSString *str = [dict[@"page_content"] stringByReplacingOccurrencesOfString:@"<p>" withString:@""];
                    str = [str stringByReplacingOccurrencesOfString:@"</p>" withString:@""];
                  NSAttributedString *htmlString =
                  [[NSAttributedString alloc] initWithData:[str dataUsingEncoding:NSUTF8StringEncoding] options:@{NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType, NSCharacterEncodingDocumentAttribute: [NSNumber numberWithInt:NSUTF8StringEncoding]} documentAttributes:nil error:nil];
                  NSString* plainString = htmlString.string;
                    [_labeltext setText:plainString];
                    mserviceHandler.homeService.vidyadata = str;
                }
            } else {
                MHWAlertView *alert = [[MHWAlertView alloc] initWithTitle:@"Alert" message:response[@"msg"] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                [alert show];
            }
            
        } failure:^(NSError *error) {
            [activityIndicatorView stopAnimating];
        }];
    }
    
}

- (void)viewWillAppear:(BOOL)animated {
    [self.view setBackgroundColor:kBgImage];
    self.view.layer.contents = (id)[UIImage imageNamed:@"loginBg"].CGImage;
    self.addLeftBarMenuButtonEnabled = YES;
    self.navigationItem.title = kLangualString(titleString);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
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
