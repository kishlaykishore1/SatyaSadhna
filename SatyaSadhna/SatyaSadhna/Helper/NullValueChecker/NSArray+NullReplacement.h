//
//  NSArray+NullReplacement.h
//  RestAPI
//
//  Created by Ranosys Technologies on 13/1/15.
//  Copyright (c) 2015 Shiv Vaishnav. All rights reserved.
//

#import <Foundation/Foundation.h>

#define kCheckNull(value) [value isKindOfClass:[NSNull class]] || value == (id)[NSNull null] || value == NULL || [value isEqual:@"<null>"] || [value isEqual:@"(null)"] || !value

@interface NSArray (NullReplacement)

- (NSArray *)arrayByReplacingNullsWithBlanks;

@end
