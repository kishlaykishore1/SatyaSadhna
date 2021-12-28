//
//  UserDataModal.m
//  SatyaSadhna
//
//  Created by Roshan Singh Bisht on 22/04/17.
//  Copyright © 2017 Roshan Singh Bisht. All rights reserved.
//

#import "NSDictionary+NullReplacement.h"
#import "UserDataModal.h"

@implementation UserDataModal
@synthesize emailID,password;


+ (NSDictionary *)parseUserDataFromDict:(NSDictionary *)userData {
    NSDictionary *dict = [userData dictionaryByReplacingNullsWithBlanks];
    return dict;
}
@end
