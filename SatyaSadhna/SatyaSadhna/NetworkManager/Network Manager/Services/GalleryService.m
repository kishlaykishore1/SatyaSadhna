//
//  GalleryService.m
//  SatyaSadhna
//
//  Created by Roshan Singh Bisht on 06/05/17.
//  Copyright © 2017 Roshan Singh Bisht. All rights reserved.
//

#import "GalleryService.h"
#define kGallery            @"get/all/Singlegallery"
#define kquotion            @"get/all/quotation"
#define kquery              @"user/enquiry"

@implementation GalleryService
@synthesize quotionImages;

- (void)gallery:(void (^)(id))success failure:(void (^)(NSError *))failure {
    [networkManager get:kGallery parameters:nil success:^(id responseObject) {
        _galleryImages = responseObject[@"plan_result"];
        success(responseObject);
    } failure:^(NSError *error) {
        failure(error);
    }];
}

- (void)quotion:(void (^)(id))success failure:(void (^)(NSError *))failure {
    [networkManager get:kquotion parameters:nil success:^(id responseObject) {
        quotionImages = [NSMutableArray new];
        if ([responseObject[@"status"] boolValue]) {
            for (NSDictionary *dict in responseObject[@"quotation_result"]) {
                [quotionImages addObject:dict[@"image"]];
            }
            success(quotionImages);
            
        }
    } failure:^(NSError *error) {
        failure(error);
        
    }];
}

- (void)contactQuery:(NSString  *)Username andSubject:(NSString *)subject andmail:(NSString *)mail andMessage:(NSString *)message andUserlink:(NSString *)userLink success:(void (^)(id))success failure:(void (^)(NSError *))failure {
    NSDictionary *param  = @{@"Username":Username,
                             @"subject":subject,
                             @"UserEmail":mail,
                             @"Massage":message,
                             @"UserEmailUnik":userLink
                             };
    [networkManager get:kquery parameters:param success:^(id responseObject) {
        if ([responseObject[@"status"] boolValue]) {
            success(responseObject);
        }
    } failure:^(NSError *error) {
        failure(error);
        
    }];
}

@end
