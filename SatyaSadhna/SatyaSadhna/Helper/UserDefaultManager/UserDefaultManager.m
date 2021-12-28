//
//  UserDefaultManager.m
//  SatyaSadhna
//
//  Created by Roshan Singh Bisht on 23/04/17.
//  Copyright © 2017 Roshan Singh Bisht. All rights reserved.
//

#import "UserDefaultManager.h"

#define kUserID             @"user_id"
#define kDeviceToken        @"device_token"
#define kGoolgeUserID       @"google_userid"
#define kUsername           @"username"
#define KmobileNo           @"mobile"
#define kIsOldStudent       @"old_student"
#define kindexPath           @"path"
#define kCourseID           @"ID"
#define KemailID            @"email"
#define kotp                @"otp"
#define kLanguage               @"language"
#define kPreview              @"preview"

@implementation UserDefaultManager
    // APP ID
+ (NSString *)getUserID {
    NSLog(@"appID: %@",[[NSUserDefaults standardUserDefaults] objectForKey:kUserID]);
    return [[NSUserDefaults standardUserDefaults] objectForKey:kUserID];
}
    
+ (void)setUserID:(NSString *)userID {
    if(userID.length > 0) {
        [[NSUserDefaults standardUserDefaults] setObject:userID forKey:kUserID];
    } else {
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:kUserID];
    }
    [[NSUserDefaults standardUserDefaults]synchronize];
}
    
    //Device token
+ (NSString *)getDeviceToken {
    NSLog(@"token: %@",[[NSUserDefaults standardUserDefaults] objectForKey:kDeviceToken]);
    return [[NSUserDefaults standardUserDefaults] objectForKey:kDeviceToken];
}
    
+ (void)setDeviceToken:(NSString *)token {
    if(token.length > 0) {
        [[NSUserDefaults standardUserDefaults] setObject:token forKey:kDeviceToken];
    } else {
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:kDeviceToken];
    }
    [[NSUserDefaults standardUserDefaults]synchronize];
}
    
    //GoolgeUserID
+ (NSString *)getGoolgeUserID {
    NSLog(@"google user id: %@",[[NSUserDefaults standardUserDefaults] objectForKey:kGoolgeUserID]);
    return [[NSUserDefaults standardUserDefaults] objectForKey:kGoolgeUserID];
}
    
+ (void)setGoolgeUserID:(NSString *)userID {
    if(userID.length > 0) {
        [[NSUserDefaults standardUserDefaults] setObject:userID forKey:kGoolgeUserID];
    } else {
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:kGoolgeUserID];
    }
    [[NSUserDefaults standardUserDefaults]synchronize];
}
    
    // User name
+ (NSString *)getUserName {
    NSLog(@"Username: %@",[[NSUserDefaults standardUserDefaults] objectForKey:kUsername]);
    return [[NSUserDefaults standardUserDefaults] objectForKey:kUsername];
}
    
+ (void)setUserName:(NSString *)userID{
    if(userID.length > 0) {
        [[NSUserDefaults standardUserDefaults] setObject:userID forKey:kUsername];
    } else {
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:kUsername];
    }
    [[NSUserDefaults standardUserDefaults]synchronize];
}
    
    
    // Mobile No
+ (NSString *)getMobileNo {
    NSLog(@"Mobile No: %@",[[NSUserDefaults standardUserDefaults] objectForKey:KmobileNo]);
    return [[NSUserDefaults standardUserDefaults] objectForKey:KmobileNo];
}
    
+ (void)setMobileNo:(NSString *)userID{
    if(userID.length > 0) {
        [[NSUserDefaults standardUserDefaults] setObject:userID forKey:KmobileNo];
    } else {
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:KmobileNo];
    }
    [[NSUserDefaults standardUserDefaults]synchronize];
}
    
      // preview
    + (NSString *)getPreview {
        NSLog(@"Preview: %@",[[NSUserDefaults standardUserDefaults] objectForKey:kPreview]);
        return [[NSUserDefaults standardUserDefaults] objectForKey:kPreview];
    }
        
    + (void)setPreview:(NSString *)userID{
        if(userID.length > 0) {
            [[NSUserDefaults standardUserDefaults] setObject:userID forKey:kPreview];
        } else {
            [[NSUserDefaults standardUserDefaults] removeObjectForKey:kPreview];
        }
        [[NSUserDefaults standardUserDefaults]synchronize];
    }
    
    // EmailId
+ (NSString *)getEmailID {
    NSLog(@"Email ID: %@",[[NSUserDefaults standardUserDefaults] objectForKey:KemailID]);
    return [[NSUserDefaults standardUserDefaults] objectForKey:KemailID];
}
    
+ (void)setEmailID:(NSString *)userID {
    if(userID.length > 0) {
        [[NSUserDefaults standardUserDefaults] setObject:userID forKey:KemailID];
    } else {
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:KemailID];
    }
    [[NSUserDefaults standardUserDefaults]synchronize];
}
    
    // Is Old Student No
+ (NSString *)getIsOldStudent {
    NSLog(@"is Old Student No: %@",[[NSUserDefaults standardUserDefaults] objectForKey:kIsOldStudent]);
    return [[NSUserDefaults standardUserDefaults] objectForKey:kIsOldStudent];
}
    
+ (void)setIsOldStudent:(NSString *)student{
    if(student.length > 0) {
        [[NSUserDefaults standardUserDefaults] setObject:student forKey:kIsOldStudent];
    } else {
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:kIsOldStudent];
    }
    [[NSUserDefaults standardUserDefaults]synchronize];
}
    
+ (NSString *)getIndexPath {
    NSLog(@"is index Student No: %@",[[NSUserDefaults standardUserDefaults] objectForKey:kindexPath]);
    return [[NSUserDefaults standardUserDefaults] objectForKey:kindexPath];
}
    
+ (void)setIndexPath:(NSString *)student{
    if(student.length > 0) {
        [[NSUserDefaults standardUserDefaults] setObject:student forKey:kindexPath];
    } else {
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:kindexPath];
    }
    [[NSUserDefaults standardUserDefaults]synchronize];
}
    
    
+ (NSString *)getOtp {
    NSLog(@" OTP No: %@",[[NSUserDefaults standardUserDefaults] objectForKey:kotp]);
    return [[NSUserDefaults standardUserDefaults] objectForKey:kotp];
}
    
+ (void)setOtp:(NSString *)student {
    if(student.length > 0) {
        [[NSUserDefaults standardUserDefaults] setObject:student forKey:kotp];
    } else {
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:kotp];
    }
    [[NSUserDefaults standardUserDefaults]synchronize];
}
    
    // LANGUAGE
+ (NSString *)getLanguage {
    NSLog(@"language: %@",[[NSUserDefaults standardUserDefaults] objectForKey:kLanguage]);
    return [[NSUserDefaults standardUserDefaults] objectForKey:kLanguage];
}
    
+ (void)setLanguage:(NSString *)language {
    if(language.length > 0) {
        [[NSUserDefaults standardUserDefaults] setObject:language forKey:kLanguage];
    } else {
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:kLanguage];
    }
    [[NSUserDefaults standardUserDefaults]synchronize];
}
    
    
    + (NSString *)getCourseID {
        NSLog(@"is index Student No: %@",[[NSUserDefaults standardUserDefaults] objectForKey:kCourseID]);
        return [[NSUserDefaults standardUserDefaults] objectForKey:kCourseID];
    }
    
+ (void)setCourse:(NSString *)student{
    if(student.length > 0) {
        [[NSUserDefaults standardUserDefaults] setObject:student forKey:kCourseID];
    } else {
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:kCourseID];
    }
    [[NSUserDefaults standardUserDefaults]synchronize];
}
    
    @end
