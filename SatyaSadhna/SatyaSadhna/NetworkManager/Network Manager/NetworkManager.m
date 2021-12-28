//
//  NetworkManager.m
//  PYM
//
//  Created by Roshan Singh Bisht on 5/14/15.
//  Copyright (c) 2015 ranosys. All rights reserved.
//

#import "NetworkManager.h"
#import "AFHTTPRequestOperationManager.h"
#import "AFHTTPSessionManager.h"
#import "BaseService.h"
#import "Internet.h"
#import "NSDictionary+NullReplacement.h"
#import "MHWAlertView.h"
#import "UserDefaultManager.h"

@interface NetworkManager () {
    AFHTTPRequestOperationManager           *manager;
}

@end

@implementation NetworkManager

- (instancetype)initWithBaseURL:(NSURL *)url {
    self = [super init];
    if (self) {
        manager = [[AFHTTPRequestOperationManager alloc] initWithBaseURL:url];
        manager.responseSerializer.acceptableContentTypes = [manager.responseSerializer.acceptableContentTypes setByAddingObject:@"text/html"];
    }
    return self;
}

- (void)displayErrorAlert:(NSError *)error {
    //    400 Error
    //    200-300 Success
    NSLog(@"Error Code: %ld, message: %@", (long)error.code, error.userInfo);
    
    if (error == nil) {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Alert" message:@"Network connection is slow, please try again after some time." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
        return;
    }
    
    switch (error.code) {
        case 401:
            return;
            break;
            
        case 400: {
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Alert" message:error.userInfo[@"msg"] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
            [alert show];
        }
            break;
            
        default: {
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Alert" message:@"Something went wrong, please try again" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alert show];
        }
            break;
    }
}

- (void)displayErrorAlertForSuccess:(id)response {
    NSString *errorString = [[response allKeys] containsObject:@"msg"] ? [response valueForKey:@"msg"] : @"";
    if (errorString.length > 5) {
       MHWAlertView *alert =  [[MHWAlertView alloc] initWithTitle:@"Alert" message:response[@"msg"] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [alert show];
    }
}

- (void)get:(NSString *)path parameters:(NSDictionary *)parameters success:(void (^)(id))success failure:(void (^)(NSError *))failure {
    path = [path stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSLog(@"path:%@, %@", path, parameters);
    
    if ([Internet checkNetConnection]) {
        [manager.requestSerializer setValue:@"application/json;charset=UTF-8" forHTTPHeaderField:@"content-type"];
        if ( [[UserDefaultManager getLanguage]  isEqual: @"Hindi"]) {
         [manager.requestSerializer setValue:@"hi" forHTTPHeaderField:@"lang_type"];
        } else {
         [manager.requestSerializer setValue:@"en" forHTTPHeaderField:@"lang_type"];
        }
        [manager GET:path parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
            NSLog(@"response: %@",responseObject);
            responseObject = [(NSDictionary *)responseObject dictionaryByReplacingNullsWithBlanks];
            
            success(responseObject);
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            [self displayErrorAlert:error];
            failure(error);
        }];
    } else {
        failure(nil);
    }
}
- (void)get1:(NSString *)path parameters:(NSDictionary *)parameters success:(void (^)(id))success failure:(void (^)(NSError *))failure {
    path = [path stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSLog(@"path:%@, %@", path, parameters);
    
    if ([Internet checkNetConnection]) {
        [manager.requestSerializer setValue:@"application/json;charset=UTF-8" forHTTPHeaderField:@"content-type"];
        if ( [[UserDefaultManager getLanguage]  isEqual: @"Hindi"]) {
         [manager.requestSerializer setValue:@"hi" forHTTPHeaderField:@"lang_type"];
        } else {
         [manager.requestSerializer setValue:@"en" forHTTPHeaderField:@"lang_type"];
        }
        [manager GET:path parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
            NSLog(@"response: %@",responseObject);
            responseObject = [(NSDictionary *)responseObject dictionaryByReplacingNullsWithBlanks];
            
            success(responseObject);
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            [self displayErrorAlert:error];
            failure(error);
        }];
    } else {
        failure(nil);
    }
}




- (void)post:(NSString *)path parameters:(NSDictionary *)parameters success:(void (^)(id))success failure:(void (^)(NSError *))failure {
    path = [path stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSLog(@"path: %@, %@", path, parameters);
    
    if ([Internet checkNetConnection]) {
        [manager.requestSerializer setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
        if ( [[UserDefaultManager getLanguage]  isEqual: @"Hindi"]) {
         [manager.requestSerializer setValue:@"hi" forHTTPHeaderField:@"lang_type"];
        } else {
         [manager.requestSerializer setValue:@"en" forHTTPHeaderField:@"lang_type"];
        }
        [manager POST:path parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
            NSLog(@"response: %@",responseObject);
            responseObject = [(NSDictionary *)responseObject dictionaryByReplacingNullsWithBlanks];
            success(responseObject);
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            [self displayErrorAlert:error];
            failure(error);
        }];
    } else {
        failure(nil);
    }
}


- (void)delet:(NSString *)path parameters:(NSDictionary *)parameters success:(void (^)(id))success failure:(void (^)(NSError *))failure {
    path = [path stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSLog(@"path: %@, %@", path, parameters);
    
    if ([Internet checkNetConnection]) {
        [manager.requestSerializer setValue:@"application/json;charset=UTF-8" forHTTPHeaderField:@"content-type"];
        [manager DELETE:path parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
            NSLog(@"response: %@",responseObject);
            responseObject = [(NSDictionary *)responseObject dictionaryByReplacingNullsWithBlanks];
            success(responseObject);
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            [self displayErrorAlert:error];
            failure(error);
        }];
    } else {
        failure(nil);
    }
}

        


@end
