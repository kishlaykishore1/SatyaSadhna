//
//  LoginService.m
//  AndyW
//
//  Created by Roshan Singh Bisht on 05/02/17.
//  Copyright © 2017 Roshan Singh Bisht. All rights reserved.
//

#define kLogin          @"user/login"
#define kRegister       @"user/register"
#define kForgotPassword @"app/forgot/password/%@"
#define kUpdateProfile  @"user/edit"
#define kSendOtp        @"get/edit/forgotpass/%@"
#define kPassword       @"user/change/password"

#import "LoginService.h"
#import "UserDataModal.h"
#import "UserDefaultManager.h"
#import "Utils.h"




@implementation LoginService

- (void)login:(UserDataModal *)data success:(void (^)(id))success failure:(void (^)(NSError *))failure {
    
    NSDictionary *param = @{@"mobile_number": data.emailID,
                            @"password": data.password,
                            @"deviceid" : [UserDefaultManager getDeviceToken] ? [UserDefaultManager getDeviceToken] : @"sddsadasdasdasdasdsa"
                            };
    
    [networkManager post:kLogin parameters:param success:^(id responseObject) {
        success(responseObject);
    } failure:^(NSError *error) {
        failure(error);
    }];
}

- (void)doRegister:(UserDataModal *)data success:(void (^)(id))success failure:(void (^)(NSError *))failure {
    NSDictionary *param = @{@"UserName": data.userName,
                            @"userEmail": data.emailID,
                            @"Userpassword" : data.password,
                            @"deviceid": [UserDefaultManager getDeviceToken] ? [UserDefaultManager getDeviceToken] : @"sddsadasdasdasdasdsa",
                            @"UserMobileNumber": data.phoneNo
                            };
    [networkManager post:kRegister parameters:param success:^(id responseObject) {
        success(responseObject);
    } failure:^(NSError *error) {
        failure(error);
    }];
}
- (void)forgotPasswordsuccess: (NSString *)emailID andSuccess:(void (^)(id))success failure:(void (^)(NSError *))failure {
    [networkManager get:[NSString stringWithFormat:kSendOtp,emailID] parameters:nil success:^(id responseObject) {
        success(responseObject);
    } failure:^(NSError *error) {
        failure(error);
    }];
    
}

- (void)updateProfile:(UserDataModal *)data success:(void (^)(id))success failure:(void (^)(NSError *))failure {
    NSDictionary *param = @{@"user_id":[UserDefaultManager getUserID],
                            @"name":data.userName,
                            @"mobilenumber":data.phoneNo,
                            @"emailid":data.emailID
                            };
    [networkManager post:kUpdateProfile parameters:param success:^(id responseObject) {
        success(responseObject);
    } failure:^(NSError *error) {
        failure(error);
    }];
}

- (void)changepassword:(NSString *)old new:(NSString *)newPass con:(NSString *)context success:(void (^)(id))success failure:(void (^)(NSError *))failure {
    NSDictionary *param = @{@"email_address":[UserDefaultManager getEmailID],
                            @"current_password":old,
                            @"password":newPass};
    [networkManager post:kPassword parameters:param success:^(id responseObject) {
        success(responseObject);
    } failure:^(NSError *error) {
        failure(error);
    }];
    
}


- (void)password:(NSDictionary *)data success:(void (^)(id))success failure:(void (^)(NSError *))failure {
    [networkManager post:kPassword parameters:data success:^(id responseObject) {
        success(responseObject);
    } failure:^(NSError *error) {
        failure(error);
    }];
}
@end

