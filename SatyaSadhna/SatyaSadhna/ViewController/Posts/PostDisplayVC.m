//
//  PostDisplayVC.m
//  SatyaSadhna
//
//  Created by kishlay kishore on 09/05/21.
//  Copyright © 2021 Roshan Singh Bisht. All rights reserved.
//

#import "HomeService.h"
#import <UIKit/UIKit.h>
#import "UIImageView+AFNetworking.h"
#import "PostDisplayVC.h"

@interface PostDisplayVC ()<UIWebViewDelegate> {
  NSString *dataReceived;
  NSString *title;
  NSString *description;
  NSString *imageURL;
}

@property (weak, nonatomic) IBOutlet UIWebView *webView;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIView *viewContainingImage;
@property (weak, nonatomic) IBOutlet UIImageView *imgProvided;
@property (weak, nonatomic) IBOutlet UILabel *lblDescription;

@end

@implementation PostDisplayVC
@synthesize isFromView,currentView;

- (void)postDisplay {
  NSDictionary *param = @{@"post_id":_postListID };
  [mserviceHandler.homeService postDisplayData:param success:^(id response) {
    if ([response[@"status"] boolValue]) {
      NSDateFormatter *dateFormatter = [NSDateFormatter new];
      dateFormatter.dateFormat = @"dd-MM-yyyy";
      NSDictionary *dict = response[@"page_result"];
      
      if ([dict[@"file_type"] isEqual: @"pdf"]) {
        [_webView setHidden: NO];
        [activityIndicatorView  startAnimating];
        [_webView addSubview: activityIndicatorView];
        dataReceived = dict[@"post_file_hi"];
        title = dict[@"title"];
        self.navigationItem.title = title;
        dataReceived = [dataReceived stringByReplacingOccurrencesOfString:@" " withString:@"%20"];
        [_webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:dataReceived]]];
        
      } else {
        
        [_scrollView setHidden: NO];
        description = dict[@"description"];
        title = dict[@"title"];
        imageURL = dict[@"post_file_hi"];
        NSURL *url = [NSURL URLWithString:imageURL];
        [_imgProvided setImageWithURL:url placeholderImage:[UIImage imageNamed:@"LaunchImage"]];
        NSAttributedString *htmlString =
        [[NSAttributedString alloc] initWithData:[description dataUsingEncoding:NSUTF8StringEncoding] options:@{NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType, NSCharacterEncodingDocumentAttribute: [NSNumber numberWithInt:NSUTF8StringEncoding]} documentAttributes:nil error:nil];
        NSString* plainString = htmlString.string;
        [_lblDescription setText: plainString];
        self.navigationItem.title = title;
        
      }
    }
  } failure:^(NSError * error) {
    [activityIndicatorView stopAnimating];
  }];
}

- (void)viewDidLoad {
  [super viewDidLoad];
  [self postDisplay];
  [self setAddRightBarBarBackButtonEnabled:YES];
  //_imgProvided.contentMode = 
  _webView.backgroundColor = [UIColor clearColor];
  _webView.delegate  = self;
  _webView.opaque = NO;
  [self.view setBackgroundColor:kBgImage];
  self.view.layer.contents = (id)[UIImage imageNamed:@"loginBg"].CGImage;
  self.addLeftBarBarBackButtonEnabled = YES;
  
}

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}

- (void)webViewDidStartLoad:(UIWebView *)webView {
  dispatch_async(dispatch_get_main_queue(), ^(void){
    [activityIndicatorView startAnimating];
  });
  
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
  dispatch_async(dispatch_get_main_queue(), ^(void){
    [activityIndicatorView stopAnimating];
  });
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
  [activityIndicatorView stopAnimating];
  UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Alert" message:error.localizedDescription delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
  [alert show];
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
