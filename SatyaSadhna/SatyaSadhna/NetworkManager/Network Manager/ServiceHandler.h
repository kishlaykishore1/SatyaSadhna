//
//  ServiceHandler.h
//  CreateApp
//
//  Created by Roshan Singh Bisht on 5/14/15.
//  Copyright (c) 2015 ranosys. All rights reserved.
//

#import <Foundation/Foundation.h>

@class LoginService;
@class HomeService;
@class GalleryService;

@interface ServiceHandler : NSObject

@property (nonatomic, strong) LoginService          *loginservice;
@property (nonatomic, strong) HomeService           *homeService;
@property (nonatomic, strong) GalleryService        *galleryService;

+ (instancetype)sharedInstance;

@end
