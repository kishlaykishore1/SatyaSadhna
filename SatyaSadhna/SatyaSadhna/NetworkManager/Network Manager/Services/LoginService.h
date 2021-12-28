//
//  LoginService.h
//  AndyW
//
//  Created by Roshan Singh Bisht on 05/02/17.
//  Copyright © 2017 Roshan Singh Bisht. All rights reserved.
//

#import "BaseService.h"
@class UserDataModal;

@interface LoginService : BaseService
- (void)login:(UserDataModal *)data success:(void (^)(id))success failure:(void (^)(NSError *))failure;
- (void)doRegister:(UserDataModal *)data success:(void (^)(id))success failure:(void (^)(NSError *))failure;
- (void)forgotPasswordsuccess: (NSString *)emailID andSuccess:(void (^)(id))success failure:(void (^)(NSError *))failure;
- (void)updateProfile:(UserDataModal *)data success:(void (^)(id))success failure:(void (^)(NSError *))failure;
- (void)changepassword:(NSString *)old new:(NSString *)newPass con:(NSString *)context success:(void (^)(id))success failure:(void (^)(NSError *))failure;
- (void)password:(NSDictionary *)data success:(void (^)(id))success failure:(void (^)(NSError *))failure;
@end
