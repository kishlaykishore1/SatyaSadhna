//
//  SatyaSadhnaViewController.h
//  SatyaSadhna
//
//  Created by Roshan Singh Bisht on 22/04/17.
//  Copyright © 2017 Roshan Singh Bisht. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "Constants.h"
#import "ServiceHandler.h"
#import <DGActivityIndicatorView.h>
#import "Internet.h"
#import "MHWAlertView.h"
#import "UserDefaultManager.h"
#import "AppDelegate+Transition.h"
#import "Utils.h"
#import "UIView+Loading.h"
#import "SWRevealViewController.h"
#import <GoogleAnalytics/GAIDictionaryBuilder.h>
#import <GoogleAnalytics/GAIFields.h>
#import <GoogleAnalytics/GAI.h>
#import <Google/Analytics.h>
#import <GoogleAnalytics/GAIDictionaryBuilder.h>
#import <GoogleAnalytics/GAIFields.h>

#define  startLoader   [self.view addSubview:activityIndicatorView]; [activityIndicatorView startAnimating];
#define stopLoader      [activityIndicatorView stopAnimating];

@interface SatyaSadhnaViewController : UIViewController {
    AppDelegate     *appdelegate;
    ServiceHandler *mserviceHandler;
    DGActivityIndicatorView  *activityIndicatorView;
    
}
@property (nonatomic) BOOL navigationBarMakeTransparent;
@property (nonatomic) BOOL addLeftBarBarBackButtonEnabled;
@property (nonatomic) BOOL addLeftBarMenuButtonEnabled;

@end
