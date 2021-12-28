//
//  NetworkManager.h
//  PYM
//
//  Created by Roshan Singh Bisht on 5/14/15.
//  Copyright (c) 2015 ranosys. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NetworkManager : NSObject

- (instancetype)initWithBaseURL:(NSURL *)url;

- (void)get:(NSString *)path parameters:(NSDictionary *)parameters success:(void (^)(id responseObject))success failure:(void (^)(NSError *error))failure;

- (void)get1:(NSString *)path parameters:(NSDictionary *)parameters success:(void (^)(id responseObject))success failure:(void (^)(NSError *error))failure;

- (void)post:(NSString *)path parameters:(NSDictionary *)parameters success:(void (^)(id responseObject))success failure:(void (^)(NSError *error))failure;


- (void)delet:(NSString *)path parameters:(NSDictionary *)parameters success:(void (^)(id))success failure:(void (^)(NSError *))failure;

@end
