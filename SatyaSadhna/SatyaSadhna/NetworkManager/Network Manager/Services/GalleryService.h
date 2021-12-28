//
//  GalleryService.h
//  SatyaSadhna
//
//  Created by Roshan Singh Bisht on 06/05/17.
//  Copyright © 2017 Roshan Singh Bisht. All rights reserved.
//

#import "BaseService.h"



@interface GalleryService : BaseService


@property (nonatomic,strong)NSArray             *galleryImages;
@property (nonatomic,strong)NSMutableArray      *quotionImages;
- (void)gallery:(void (^)(id))success failure:(void (^)(NSError *))failure;
- (void)quotion:(void (^)(id))success failure:(void (^)(NSError *))failure;
- (void)contactQuery:(NSString  *)Username andSubject:(NSString *)subject andmail:(NSString *)mail andMessage:(NSString *)message andUserlink:(NSString *)userLink success:(void (^)(id))success failure:(void (^)(NSError *))failure;
@end
