//
//  Internet.m
//  RKPharma
//
//  Created by shiv vaishnav on 16/05/13.
//  Copyright (c) 2013 shivendra@ranosys.com. All rights reserved.
//

#import "Internet.h"

@implementation Internet

+ (void)startMonitiorForNetConnection {
    [[AFNetworkReachabilityManager sharedManager] startMonitoring];
}

+ (BOOL)checkNetConnection {
    BOOL isNetConnected = YES;
    
    [[AFNetworkReachabilityManager sharedManager] startMonitoring];
    AFNetworkReachabilityStatus internetStatus = [[AFNetworkReachabilityManager sharedManager] isReachable];
    
    if (internetStatus != AFNetworkReachabilityStatusReachableViaWiFi && internetStatus != AFNetworkReachabilityStatusReachableViaWWAN) {
        // Create an alert if connection doesn't work
        [[[UIAlertView alloc] initWithTitle:[NSString stringWithFormat:NSLocalizedStringFromTable(@"Network Connection Unavailable",[[NSUserDefaults standardUserDefaults]valueForKey:@"language"],nil)]
                                    message:[NSString stringWithFormat:NSLocalizedStringFromTable(@"You require an internet connection via WiFi or cellular network to use this application.",[[NSUserDefaults standardUserDefaults]valueForKey:@"language"],nil)]
                                   delegate:nil
                          cancelButtonTitle:@"OK"
                          otherButtonTitles:nil] show];
        
        isNetConnected = NO;
    }
    
    return isNetConnected;
}

@end


