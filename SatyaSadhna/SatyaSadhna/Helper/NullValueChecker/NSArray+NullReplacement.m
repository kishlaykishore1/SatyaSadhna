//
//  NSArray+NullReplacement.m
//  RestAPI
//
//  Created by Ranosys Technologies on 13/1/15.
//  Copyright (c) 2015 Shiv Vaishnav. All rights reserved.
//

#import "NSArray+NullReplacement.h"
#import "NSDictionary+NullReplacement.h"

@implementation NSArray (NullReplacement)
- (NSArray *)arrayByReplacingNullsWithBlanks  {
    const NSMutableArray *replaced = [self mutableCopy];
    const NSString *blank = @"";
   
    for (int idx = 0; idx < [replaced count]; idx++) {
        id object = [replaced objectAtIndex:idx];
        if (kCheckNull(object))
            [replaced replaceObjectAtIndex:idx withObject:blank];
        else if ([object isKindOfClass:[NSDictionary class]])
            [replaced replaceObjectAtIndex:idx withObject:[object dictionaryByReplacingNullsWithBlanks]];
        else if ([object isKindOfClass:[NSArray class]])
            [replaced replaceObjectAtIndex:idx withObject:[object arrayByReplacingNullsWithBlanks]];
    }
    return [replaced copy];
}

@end
