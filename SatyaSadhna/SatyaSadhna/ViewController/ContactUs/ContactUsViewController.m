//
//  ContactUsViewController.m
//  SatyaSadhna
//
//  Created by Roshan Singh Bisht on 14/05/17.
//  Copyright © 2017 Roshan Singh Bisht. All rights reserved.
//

#import <GoogleMaps/GoogleMaps.h>
#import "ContactUsViewController.h"
#import "HomeService.h"

@interface ContactUsViewController ()<UIWebViewDelegate>
@property (strong, nonatomic) IBOutlet GMSMapView *mapView;
@property (weak, nonatomic) IBOutlet UIWebView *webView;

@end

@implementation ContactUsViewController
@synthesize  titleString;

- (void)kolkata {
    {
        if (mserviceHandler.homeService.kolkata.length > 0 && mserviceHandler.homeService.kolkata != nil) {
            [_webView loadHTMLString:[mserviceHandler.homeService.kolkata stringByReplacingOccurrencesOfString:@"\n" withString:@"<br/>"] baseURL:nil];            [mserviceHandler.homeService kolkata:^(id response) {
                if ([response[@"status"] boolValue]) {
                    NSString *str = [response valueForKeyPath:@"page_result.content"];
                    mserviceHandler.homeService.kolkata = str;
                    [_webView loadHTMLString:[mserviceHandler.homeService.kolkata stringByReplacingOccurrencesOfString:@"\n" withString:@"<br/>"] baseURL:nil];
                } else {
                    MHWAlertView *alert = [[MHWAlertView alloc] initWithTitle:@"Alert" message:response[@"msg"] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil  , nil];
                    [alert show];
                }
            } failure:^(NSError *error) {
                [activityIndicatorView startAnimating];
            }];
        } else {
            [self.view addSubview:activityIndicatorView];
            [activityIndicatorView startAnimating];
            [mserviceHandler.homeService kolkata:^(id response) {
                [activityIndicatorView stopAnimating];
                if ([response[@"status"] boolValue]) {
                    NSString *str = [response valueForKeyPath:@"page_result.content"];
                    mserviceHandler.homeService.kolkata = str;
                    [_webView loadHTMLString:[mserviceHandler.homeService.kolkata stringByReplacingOccurrencesOfString:@"\n" withString:@"<br/>"] baseURL:nil];
                } else {
                    
                    MHWAlertView *alert = [[MHWAlertView alloc] initWithTitle:@"Alert" message:response[@"msg"] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil  , nil];
                    [alert show];
                }
            } failure:^(NSError *error) {
                [activityIndicatorView stopAnimating];
            }];
            
        }
    }
    
}

- (void)mehndipur {
    {
        if (mserviceHandler.homeService.mehndipur.length > 0 && mserviceHandler.homeService.mehndipur != nil) {
            [_webView loadHTMLString:[mserviceHandler.homeService.mehndipur stringByReplacingOccurrencesOfString:@"\n" withString:@"<br/>"] baseURL:nil];
            [mserviceHandler.homeService mehndipur:^(id response) {
                if ([response[@"status"] boolValue]) {
                    NSString *str = [response valueForKeyPath:@"page_result.content"];
                    mserviceHandler.homeService.mehndipur = str;
                    [_webView loadHTMLString:[mserviceHandler.homeService.mehndipur stringByReplacingOccurrencesOfString:@"\n" withString:@"<br/>"] baseURL:nil];
                } else {
                    MHWAlertView *alert = [[MHWAlertView alloc] initWithTitle:@"Alert" message:response[@"msg"] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil  , nil];
                    [alert show];
                }
            } failure:^(NSError *error) {
                [activityIndicatorView startAnimating];
            }];
        } else {
            [self.view addSubview:activityIndicatorView];
            [activityIndicatorView startAnimating];
            [mserviceHandler.homeService mehndipur:^(id response) {
                [activityIndicatorView stopAnimating];
                if ([response[@"status"] boolValue]) {
                    NSString *str = [response valueForKeyPath:@"page_result.content"];
                    mserviceHandler.homeService.mehndipur = str;
                    [_webView loadHTMLString:[mserviceHandler.homeService.mehndipur stringByReplacingOccurrencesOfString:@"\n" withString:@"<br/>"] baseURL:nil];
                } else {
                    
                    MHWAlertView *alert = [[MHWAlertView alloc] initWithTitle:@"Alert" message:response[@"msg"] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil  , nil];
                    [alert show];
                }
            } failure:^(NSError *error) {
                [activityIndicatorView stopAnimating];
            }];
            
        }
    }
    
}


- (void)bikaner {
    if (mserviceHandler.homeService.bikaner.length > 0 && mserviceHandler.homeService.bikaner != nil) {
        [_webView loadHTMLString:[mserviceHandler.homeService.bikaner stringByReplacingOccurrencesOfString:@"\n" withString:@"<br/>"] baseURL:nil];
        
        [mserviceHandler.homeService bikaner:^(id response) {
            if ([response[@"status"] boolValue]) {
                NSString *str = [response valueForKeyPath:@"page_result.content"];
                mserviceHandler.homeService.bikaner = str;
                [_webView loadHTMLString:[mserviceHandler.homeService.bikaner stringByReplacingOccurrencesOfString:@"\n" withString:@"<br/>"] baseURL:nil];           } else {
                    MHWAlertView *alert = [[MHWAlertView alloc] initWithTitle:@"Alert" message:response[@"msg"] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil  , nil];
                    [alert show];
                }
        } failure:^(NSError *error) {
            [activityIndicatorView startAnimating];
        }];
    } else {
        [self.view addSubview:activityIndicatorView];
        [activityIndicatorView startAnimating];
        [mserviceHandler.homeService bikaner:^(id response) {
            [activityIndicatorView stopAnimating];
            if ([response[@"status"] boolValue]) {
                NSString *str = [response valueForKeyPath:@"page_result.content"];
                mserviceHandler.homeService.bikaner = str;
                [_webView loadHTMLString:[mserviceHandler.homeService.bikaner stringByReplacingOccurrencesOfString:@"\n" withString:@"<br/>"] baseURL:nil] ;           } else {
                    
                    MHWAlertView *alert = [[MHWAlertView alloc] initWithTitle:@"Alert" message:response[@"msg"] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil  , nil];
                    [alert show];
                }
        } failure:^(NSError *error) {
            [activityIndicatorView stopAnimating];
        }];
        
    }
}

- (void)nal {
    if (mserviceHandler.homeService.nalData.length > 0 && mserviceHandler.homeService.nalData != nil) {
        [_webView loadHTMLString:[mserviceHandler.homeService.nalData stringByReplacingOccurrencesOfString:@"\n" withString:@"<br/>"] baseURL:nil];
        
        
        [mserviceHandler.homeService nal:^(id response) {
            if ([response[@"status"] boolValue]) {
                NSString *str = [response valueForKeyPath:@"page_result.content"];
                mserviceHandler.homeService.nalData = str;
                [_webView loadHTMLString:[mserviceHandler.homeService.nalData stringByReplacingOccurrencesOfString:@"\n" withString:@"<br/>"] baseURL:nil];
            } else {
                MHWAlertView *alert = [[MHWAlertView alloc] initWithTitle:@"Alert" message:response[@"msg"] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil  , nil];
                [alert show];
            }
        } failure:^(NSError *error) {
            [activityIndicatorView startAnimating];
        }];
    } else {
        [self.view addSubview:activityIndicatorView];
        [activityIndicatorView startAnimating];
        [mserviceHandler.homeService nal:^(id response) {
            [activityIndicatorView stopAnimating];
            if ([response[@"status"] boolValue]) {
                NSString *str = [response valueForKeyPath:@"page_result.content"];
                mserviceHandler.homeService.nalData = str;
                [_webView loadHTMLString:[mserviceHandler.homeService.nalData stringByReplacingOccurrencesOfString:@"\n" withString:@"<br/>"] baseURL:nil];
            } else {
                
                MHWAlertView *alert = [[MHWAlertView alloc] initWithTitle:@"Alert" message:response[@"msg"] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil  , nil];
                [alert show];
            }
        } failure:^(NSError *error) {
            [activityIndicatorView stopAnimating];
        }];
        
    }
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setAddRightBarBarBackButtonEnabled:YES];
    self.view.backgroundColor = kBgImage;
    self.view.layer.contents = (id)[UIImage imageNamed:@"loginBg"].CGImage;
    _webView.opaque = NO;
    _webView.backgroundColor = [UIColor clearColor];
    if ([titleString isEqualToString:@"Nal"]) {
        self.navigationItem.title = kLangualString(titleString);
        [self  nal];
        GMSMarker *marker = [[GMSMarker alloc] init];
        marker.position = CLLocationCoordinate2DMake(28.0764,73.1940);
        marker.title = @"Nal";
        marker.snippet = @"Here is Nal";
        marker.map = _mapView;
        
        GMSCameraPosition *cameraPosition = [GMSCameraPosition cameraWithLatitude:28.0764
                                                                        longitude:73.1940
                                                                             zoom:11.0];
        [_mapView animateToCameraPosition:cameraPosition];
    } else if ([titleString isEqualToString:@"Bikaner"]){
        self.navigationItem.title = kLangualString(titleString);
        [self  bikaner];
        GMSMarker *marker = [[GMSMarker alloc] init];
        marker.position = CLLocationCoordinate2DMake(28.0229,73.3119);
        marker.title = @"Bikaner";
        marker.snippet = @"Here is Bikaner";
        marker.map = _mapView;
        
        GMSCameraPosition *cameraPosition = [GMSCameraPosition cameraWithLatitude:28.0229
                                                                        longitude:73.3119
                                                                             zoom:11.0];
        [_mapView animateToCameraPosition:cameraPosition];
    } else if ([titleString isEqualToString:@"Kolkata"]){
        self.navigationItem.title = kLangualString(titleString);
        [self  kolkata];
        GMSMarker *marker = [[GMSMarker alloc] init];
        marker.position = CLLocationCoordinate2DMake(22.5726,88.3639);
        marker.title = titleString;
        marker.snippet = @"Here is Kolkata";
        marker.map = _mapView;
        
        GMSCameraPosition *cameraPosition = [GMSCameraPosition cameraWithLatitude:22.5726
                                                                        longitude:88.3639
                                                                             zoom:11.0];
        [_mapView animateToCameraPosition:cameraPosition];
    }else if ([titleString isEqualToString:@"Mehndipur"]){
        self.navigationItem.title = kLangualString(titleString);
        [self  mehndipur];
        GMSMarker *marker = [[GMSMarker alloc] init];
        marker.position = CLLocationCoordinate2DMake(31.1422,76.1255);
        marker.title = @"Mehndipur";
        marker.snippet = @"Here is Mehndipur";
        marker.map = _mapView;
        
        GMSCameraPosition *cameraPosition = [GMSCameraPosition cameraWithLatitude:31.1422
                                                                        longitude:76.1255
                                                                             zoom:11.0];
        [_mapView animateToCameraPosition:cameraPosition];
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

- (void)viewWillAppear:(BOOL)animated {
    self.addLeftBarMenuButtonEnabled = YES;
    [self.view setBackgroundColor:kBgImage];
    
    id<GAITracker> tracker = [GAI sharedInstance].defaultTracker;
    [tracker set:kGAIScreenName value:@"Contact Us"];
    [tracker send:[[GAIDictionaryBuilder createScreenView] build]];
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
