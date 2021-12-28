//
//  BaseService.m
//  PYM
//
//  Created by Roshan Singh Bisht on 5/14/15.
//  Copyright (c) 2015 ranosys. All rights reserved.
//

#import "BaseService.h"

@interface BaseService ()

@end

@implementation BaseService

- (instancetype)init{
    self = [super init];
    if(self) {
        networkManager = [[NetworkManager alloc] initWithBaseURL:[NSURL URLWithString:kBaseURL]];
    }
    return self;
}


- (BOOL)isStatusOK:(id)responseObject {
    if (responseObject && [responseObject[@"status"] integerValue] == 1) {
        return YES;
    } else {
        return NO;
    }
}

- (id)parseForInfo:(id)responseObject {
    if (responseObject && [responseObject[@"status"] integerValue] == 1) {
        return responseObject[@"info"];
    } else {
        return [NSMutableArray new];
    }
}



- (void)clearCache {

}

@end
