//
//  AppDelegate.m
//  SatyaSadhna
//
//  Created by Roshan Singh Bisht on 22/04/17.
//  Copyright © 2017 Roshan Singh Bisht. All rights reserved.
//

#import "AppDelegate.h"
#import "AppDelegate+Transition.h"
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import "Constants.h"
#import "UserDefaultManager.h"
#import "MHWAlertView.h"
#import "LoginService.h"
#import "UserDataModal.h"
#import <GoogleMaps/GoogleMaps.h>
#import <GooglePlaces/GooglePlaces.h>
#import "SatyaSadhnaViewController.h"
#import <AVFoundation/AVFoundation.h>
#import <GoogleAnalytics/GAI.h>
#import <Google/Analytics.h>
#import <GoogleAnalytics/GAIDictionaryBuilder.h>




@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [[UIApplication sharedApplication] setApplicationIconBadgeNumber: 1];
    [[UIApplication sharedApplication] setApplicationIconBadgeNumber: 0];
    [self registerForPushNotification];
    [[AVAudioSession sharedInstance] setActive:YES error:nil];
    [[AVAudioSession sharedInstance] setCategory:AVAudioSessionCategoryPlayback error:nil];
    
    
    
    [GMSServices provideAPIKey:@"AIzaSyCeznv8rE2y0kuDx9l0buz_0FPnsLB5HlU"];
    [GMSPlacesClient provideAPIKey:@"AIzaSyDlyqVHUdGmK-x0cOjCZHSj9Cuw9whLDYc"];
    
    [[FBSDKApplicationDelegate sharedInstance] application:application
                             didFinishLaunchingWithOptions:launchOptions];
    
    NSError* configureError;
    [[GGLContext sharedInstance] configureWithError: &configureError];
    NSAssert(!configureError, @"Error configuring Google services: %@", configureError);
    
    [GIDSignIn sharedInstance].delegate = self;
    // Add any custom logic here.
    if ([FBSDKAccessToken currentAccessToken] || [UserDefaultManager getUserID]  || [UserDefaultManager getGoolgeUserID]) {
        [self transitionToSlideMenu];
    } else {
        UIViewController *loginVC = [MainStoryBoard instantiateViewControllerWithIdentifier:@"loginVC"];
        UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:loginVC];
        self.window.rootViewController = nav;
    }
    
    GAI *gai = [GAI sharedInstance];
    [gai trackerWithTrackingId:@"UA-121620569-1"];
    
    // Optional: automatically report uncaught exceptions.
    gai.trackUncaughtExceptions = YES;
    
    // Optional: set Logger to VERBOSE for debug information.
    // Remove before app release.
    gai.logger.logLevel = kGAILogLevelVerbose;
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    [[AVAudioSession sharedInstance] setActive:YES error:nil];
    [[AVAudioSession sharedInstance] setCategory:AVAudioSessionCategoryPlayback error:nil];
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url
  sourceApplication:(NSString *)sourceApplication annotation:(id)annotation {
    
    BOOL fb = [[FBSDKApplicationDelegate sharedInstance] application:application
                                                             openURL:url
                                                   sourceApplication:sourceApplication
                                                          annotation:annotation
               ];
    
    BOOL google = [[GIDSignIn sharedInstance] handleURL:url
                                      sourceApplication:sourceApplication
                                             annotation:annotation];
    
    
    
    return fb || google;
    
}

- (void)signIn:(GIDSignIn *)signIn
didSignInForUser:(GIDGoogleUser *)user
     withError:(NSError *)error {
    // Perform any operations on signed in user here.
    //    NSString *userId = user.userID;                  // For client-side use only!
    //    NSString *idToken = user.authentication.idToken; // Safe to send to the server
    //    NSString *fullName = user.profile.name;
    //    NSString *givenName = user.profile.givenName;
    //    NSString *familyName = user.profile.familyName;
    //    NSString *email = user.profile.email;
    [UserDefaultManager setGoolgeUserID:user.userID];
    UserDataModal *data = [UserDataModal new];
    data.emailID = user.profile.email;
    data.password = @"password";
    data.userName = user.profile.name;
    data.phoneNo = @"1234567890";
    
    [[ServiceHandler sharedInstance].loginservice doRegister:data success:^(id response) {
        if ([response[@"success"] boolValue]) {
            [UserDefaultManager setUserID:[response valueForKeyPath:@"user_array.user_id"]];
            AppDelegate *app = (AppDelegate *)[UIApplication sharedApplication].delegate;
            [app transitionToSlideMenu];
        } else if ([response[@"msg"] isEqualToString:@"Email Exit"]) {
            
                [[ServiceHandler sharedInstance].loginservice login:data success:^(id response) {
                    if ([response[@"success"] boolValue]) {
                        AppDelegate *app = (AppDelegate *)[UIApplication sharedApplication].delegate;
                        [app transitionToSlideMenu];
                    } else {
                        [Utils showAlertMessage:response[@"msg"] withTitle:@"Alert"];
                        [UserDefaultManager setUserID:@""];
                    }
                    
                } failure:^(NSError *error) {
                    [Utils showAlertMessage:@"Something went wrong, please try again." withTitle:@"Alert"];
                }];
        }
    } failure:^(NSError *error) {
        [Utils showAlertMessage:error.localizedDescription withTitle:@"Error"];
    }];

    
    
    
}

- (void)signIn:(GIDSignIn *)signIn
didDisconnectWithUser:(GIDGoogleUser *)user
     withError:(NSError *)error {
    // Perform any operations when the user disconnects from app here.
    // ...
}

#pragma mark - 
#pragma mark - Push Notification Implementation

- (void)registerForPushNotification {
    //This code will work in iOS 8.0 xcode 6.0 or later
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0) {
        [[UIApplication sharedApplication] registerUserNotificationSettings:[UIUserNotificationSettings settingsForTypes:(UIUserNotificationTypeSound | UIUserNotificationTypeAlert | UIUserNotificationTypeBadge) categories:nil]];
        
        [[UIApplication sharedApplication] registerForRemoteNotifications];
    } else {
        [[UIApplication sharedApplication] registerForRemoteNotificationTypes: (UIRemoteNotificationTypeNewsstandContentAvailability| UIRemoteNotificationTypeBadge | UIRemoteNotificationTypeSound | UIRemoteNotificationTypeAlert)];
    }
}


-(void)application:(UIApplication *)application didRegisterUserNotificationSettings:(UIUserNotificationSettings *)notificationSettings // available in iOS8
{
    [application registerForRemoteNotifications];
}
-(void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken
{
  NSUInteger dataLength = deviceToken.length;
    if (dataLength == 0) {
      return;
    }
    const unsigned char *dataBuffer = (const unsigned char *)deviceToken.bytes;
    NSMutableString *hexString  = [NSMutableString stringWithCapacity:(dataLength * 2)];
    for (int i = 0; i < dataLength; ++i) {
      [hexString appendFormat:@"%02x", dataBuffer[i]];
    }
    NSLog(@"APN token:%@", hexString);
    [UserDefaultManager setDeviceToken:hexString];
}
-(void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo {
    
    // Handle your remote RemoteNotification
    NSString *jsonString = userInfo[@"aps"][@"alert"];
    NSData *data = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    id json = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
    MHWAlertView *alertView = [[MHWAlertView alloc] initWithTitle:kLangualString(@"Message") message:userInfo[@"aps"][@"alert"] delegate:nil cancelButtonTitle:kLangualString(@"Cancel") otherButtonTitles:kLangualString(@"OK"), nil];
    [alertView show];
    
}


@end
