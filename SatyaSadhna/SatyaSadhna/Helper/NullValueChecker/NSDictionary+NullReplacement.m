//
//  NSDictionary+NullReplacement.m
//  RestAPI
//
//  Created by Ranosys Technologies on 13/1/15.
//  Copyright (c) 2015 Shiv Vaishnav. All rights reserved.
//

#import "NSDictionary+NullReplacement.h"
#import "NSArray+NullReplacement.h"


@implementation NSDictionary (NullReplacement)

- (NSDictionary *)dictionaryByReplacingNullsWithBlanks {
    const NSMutableDictionary *replaced = [self mutableCopy];
    const NSString *blank = @"";
    
    for (NSString *key in self) {
        id object = [self objectForKey:key];
        if (kCheckNull(object))
            [replaced setObject:blank forKey:key];
        else if ([object isKindOfClass:[NSDictionary class]])
            [replaced setObject:[object dictionaryByReplacingNullsWithBlanks] forKey:key];
        else if ([object isKindOfClass:[NSArray class]])
            [replaced setObject:[object arrayByReplacingNullsWithBlanks] forKey:key];
    }
    return [NSDictionary dictionaryWithDictionary:[replaced copy]];
}

@end
