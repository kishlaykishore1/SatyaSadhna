//
//  UserDataModal.h
//  SatyaSadhna
//
//  Created by Roshan Singh Bisht on 22/04/17.
//  Copyright © 2017 Roshan Singh Bisht. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NSDictionary+NullReplacement.h"

@interface UserDataModal : NSObject
@property (nonatomic,strong) NSString               *emailID;
@property (nonatomic,strong) NSString               *password;
@property (nonatomic,strong) NSString               *confirmPassword;
@property (nonatomic,strong) NSString               *phoneNo;
@property (nonatomic,strong) NSString               *userName;


+ (NSDictionary *)parseUserDataFromDict: (NSDictionary *)userData;
@end
