//
//  BaseService.h
//  CreateApp
//
//  Created by Roshan Singh Bisht on 5/14/15.
//  Copyright (c) 2015 ranosys. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NetworkManager.h"
#import "Constants.h"
#import "NSDictionary+NullReplacement.h"
#import "NSArray+NullReplacement.h"

@interface BaseService : NSObject {
    NetworkManager  *networkManager;
}


- (id)parseForInfo:(id)responseObject;
- (BOOL)isStatusOK:(id)responseObject;
- (void)clearCache;

@end
