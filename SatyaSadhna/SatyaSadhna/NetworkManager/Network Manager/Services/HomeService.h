//
//  HomeService.h
//  SatyaSadhna
//
//  Created by Roshan Singh Bisht on 23/04/17.
//  Copyright © 2017 Roshan Singh Bisht. All rights reserved.
//
@class UserDataModal;
#import "BaseService.h"

@interface HomeService : BaseService
@property (nonatomic,strong)       NSArray *achrayjiData;
@property (nonatomic,strong)       NSArray *pravachanData;
@property (nonatomic,strong)       NSArray *songsData;
@property (nonatomic,strong)       NSArray *videoYoutubeData;
@property (nonatomic,strong)       NSArray *videoDataList;
@property (nonatomic,strong)       NSArray *getAllPostData;
@property (nonatomic,strong)       NSString *visionData;
@property (nonatomic,strong)       NSString *vidyadata;
@property (nonatomic,strong)       NSString *aushData;
@property (nonatomic,strong)       NSString *nalData;
@property (nonatomic,strong)       NSString *bikaner;
@property (nonatomic,strong)       NSString *kolkata;
@property (nonatomic,strong)       NSString *mehndipur;
@property (nonatomic,strong)       NSArray  *cdArrayData;
@property (nonatomic,strong)       NSString *introData;
@property (nonatomic,strong)       NSString *guidelinedata;
@property (nonatomic,strong)       NSString *bankdetaildata;
@property (nonatomic,strong)       NSString *afterthecourseData;
@property (nonatomic,strong)       NSString *brochureData;
@property (nonatomic,strong)       NSMutableArray  *youtubeArray;
@property (nonatomic,strong)       NSMutableArray  *expData;
@property (nonatomic,strong)       NSMutableArray  *trackData;
@property (nonatomic,strong)       NSMutableArray  *courseData;
@property (nonatomic,strong)       NSMutableArray  *liveEventsData;
@property (nonatomic,strong)       NSMutableArray  *donationData;
@property (nonatomic,strong)       NSArray         *faqData;
@property (nonatomic,strong)       NSMutableArray  *booksData;
@property (nonatomic,strong)       NSMutableArray  *getOldUserData;

- (void)acharyaji:(void (^)(id))success failure:(void (^)(NSError *))failure;
- (void)pravachan:(void (^)(id))success failure:(void (^)(NSError *))failure;
- (void)songs:(void (^)(id))success failure:(void (^)(NSError *))failure;
- (void)newPlaylist:(void (^)(id))success failure:(void (^)(NSError *))failure;
- (void)videoList:(NSDictionary *)param success:(void (^)(id))success failure:(void (^)(NSError *))failure;
- (void)postAllData:(void (^)(id))success failure:(void (^)(NSError *))failure;
- (void)postDisplayData:(NSDictionary *)param success:(void (^)(id))success failure:(void (^)(NSError *))failure;
- (void)vision:(void (^)(id))success failure:(void (^)(NSError *))failure;
- (void)vidya:(void (^)(id))success failure:(void (^)(NSError *))failure;
- (void)aush:(void (^)(id))success failure:(void (^)(NSError *))failure;
- (void)nal:(void (^)(id))success failure:(void (^)(NSError *))failure;
- (void)bikaner:(void (^)(id))success failure:(void (^)(NSError *))failure;
- (void)kolkata:(void (^)(id))success failure:(void (^)(NSError *))failure;
- (void)mehndipur:(void (^)(id))success failure:(void (^)(NSError *))failure;
- (void)query:(UserDataModal *)data success:(void (^)(id))success failure:(void (^)(NSError *))failure;
- (void)latestNewsletter:(void (^)(id))success failure:(void (^)(NSError *))failure;
- (void)newsletterYear:(void (^)(id))success failure:(void (^)(NSError *))failure;
- (void)newsletterMonth:(NSNumber *)year success:(void (^)(id))success failure:(void (^)(NSError *))failure;
- (void)newsletterList:(NSString *)year :(NSString *)month success:(void (^)(id))success failure:(void (^)(NSError *))failure;
- (void)cd:(void (^)(id))success failure:(void (^)(NSError *))failure;
- (void)introduction:(void (^)(id))success failure:(void (^)(NSError *))failure;
- (void)guideline:(void (^)(id))success failure:(void (^)(NSError *))failure;
- (void)bankDetailHindi:(void (^)(id))success failure:(void (^)(NSError *))failure;
- (void)afterTheCourse:(void (^)(id))success failure:(void (^)(NSError *))failure;
- (void)brochureApi:(void (^)(id))success failure:(void (^)(NSError *))failure;
- (void)getYoutubeListing:(void (^)(id))success failure:(void (^)(NSError *error))failure;
- (void)getExp:(void (^)(id))success failure:(void (^)(NSError *error))failure;
- (void)getTrack:(void (^)(id))success failure:(void (^)(NSError *error))failure;
- (void)getCourse:(void (^)(id))success failure:(void (^)(NSError *error))failure;
- (void)faq:(void (^)(id))success failure:(void (^)(NSError *error))failure;
- (void)appointment:(UserDataModal *)data success:(void (^)(id))success failure:(void (^)(NSError *))failure;
- (void)liveEvents:(void (^)(id))success failure:(void (^)(NSError *error))failure;
- (void)donation:(void (^)(id))success failure:(void (^)(NSError *error))failure;
- (void)donationForm:(NSDictionary *)data success:(void (^)(id))success failure:(void (^)(NSError *))failure;
- (void)termsCondition:(void (^)(id))success failure:(void (^)(NSError *error))failure;
- (void)form:(NSDictionary *)data success:(void (^)(id))success failure:(void (^)(NSError *))failure;
- (void)askQuestion:(NSDictionary *)param success:(void (^)(id))success failure:(void (^)(NSError *))failure;
- (void)books:(void (^)(id))success failure:(void (^)(NSError *error))failure;
- (void)bookingHistory:(void (^)(id))success failure:(void (^)(NSError *))failure;
- (void)getOldUserData:(NSDictionary *)param success:(void (^)(id))success failure:(void (^)(NSError *))failure;
- (void)getBankForm:(void (^)(id))success failure:(void (^)(NSError *error))failure;
- (void)sendPanCardNumber:(NSDictionary *)param success:(void (^)(id))success failure:(void (^)(NSError *))failure;
@end
