//
//  ServiceHandler.m
//  PYM
//
//  Created by Roshan Singh Bisht on 5/14/15.
//  Copyright (c) 2015 ranosys. All rights reserved.
//

#import "ServiceHandler.h"
#import "Internet.h"
#import "HomeService.h"
#import "LoginService.h"
#import "GalleryService.h"

@interface ServiceHandler ()

@end

@implementation ServiceHandler
@synthesize loginservice,homeService,galleryService;


static ServiceHandler	*instance = nil;

+ (instancetype)sharedInstance {
    static dispatch_once_t predicate = 0;
    dispatch_once(&predicate, ^{
        instance = [[self alloc] init];
        [Internet startMonitiorForNetConnection];
    });
    return instance;
}

- (LoginService *)loginservice {
    if (!loginservice) {
        loginservice = [[LoginService alloc] init];
    }
    return loginservice;
}

- (HomeService *)homeService {
    if (!homeService) {
        homeService = [[HomeService alloc] init];
    }
    return homeService;
}

- (GalleryService *)galleryService {
    if (!galleryService) {
        galleryService = [[GalleryService alloc] init];
    }
    return galleryService;
}
@end
