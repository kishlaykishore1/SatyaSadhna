//
//  NSDictionary+NullReplacement.h
//  RestAPI
//
//  Created by Ranosys Technologies on 13/1/15.
//  Copyright (c) 2015 Shiv Vaishnav. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary (NullReplacement)

- (NSDictionary *)dictionaryByReplacingNullsWithBlanks;

@end
