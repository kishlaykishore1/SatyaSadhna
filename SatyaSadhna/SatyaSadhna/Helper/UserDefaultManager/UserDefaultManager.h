//
//  UserDefaultManager.h
//  SatyaSadhna
//
//  Created by Roshan Singh Bisht on 23/04/17.
//  Copyright © 2017 Roshan Singh Bisht. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserDefaultManager : NSObject
    //App ID
+ (NSString *)getUserID;
+ (void)setUserID:(NSString *)userID;
    
    
    //Device token
+ (NSString *)getDeviceToken;
+ (void)setDeviceToken:(NSString *)token;
    
    //GoolgeUserID
+ (NSString *)getGoolgeUserID;
+ (void)setGoolgeUserID:(NSString *)userID;
    
    //get User Name
+ (NSString *)getUserName;
+ (void)setUserName:(NSString *)userID;
    
    //get Email
+ (NSString *)getEmailID;
+ (void)setEmailID:(NSString *)userID;

 //get preview true or false
+ (NSString *)getPreview;
+ (void)setPreview:(NSString *)userID;
    
    //get Mobile No
+ (NSString *)getMobileNo;
+ (void)setMobileNo:(NSString *)userID;
    
    
    // Is Old student
+ (NSString *)getIsOldStudent;
+ (void)setIsOldStudent:(NSString *)student;
    
    
+ (NSString *)getIndexPath;
+ (void)setIndexPath:(NSString *)student;
    
    
    // OTP
    
+ (NSString *)getOtp;
+ (void)setOtp:(NSString *)otp;
    
    //Language
+ (NSString *)getLanguage;
+ (void)setLanguage:(NSString *)language;
    
    
+ (NSString *)getCourseID;
+ (void)setCourse:(NSString *)student;
    
    @end
