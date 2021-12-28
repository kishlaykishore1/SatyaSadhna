//
//  HomeService.m
//  SatyaSadhna
//
//  Created by Roshan Singh Bisht on 23/04/17.
//  Copyright © 2017 Roshan Singh Bisht. All rights reserved.
//

#import "HomeService.h"
#import "Utils.h"
#import "UserDataModal.h"
#import "UserDefaultManager.h"
#import "YouTubeLiveModal.h"

#define kAcharyaji          @"get/all/acharyaji"
#define kPravachan          @"get/all/videos"
#define kSongs              @"get/all/song"
#define kVideoPlaylist      @"playlist.php"
#define kVideosList         @"videolist.php"
#define kPosts              @"posts.php"
#define kPostsList          @"post_view.php"
#define Kvidion             @"get/edit/page/11"
#define kVidya              @"get/edit/page/12"
#define KAush               @"get/edit/page/13"
#define kNal                @"get/edit/location/3"
#define kBikaner            @"get/edit/location/4"
#define kKolkata            @"get/edit/location/5"
#define kMenhdipur          @"get/edit/location/6"
#define kQiery              @"user/enquiry"
#define knewsletteryear     @"get/all/newsLettersYear"
#define knewsletteryearwise @"get/all/newsLettersYearWise"
#define knewslettermonth    @"get/all/newsLettersYearMonthWise/%@"
#define knewsletterlist     @"get/all/newsLettersYearMonthList/%@/%@"
#define kCD                 @"get/all/cd"
#define kIntroduction       @"get/edit/page/4"
#define kGuideline          @"get/edit/page/5"
#define AfterTheCourese     @"get/edit/page/6"
#define kBrochure           @"get/all/brochure"
//#define kyoutubeVidoe       @"https://www.googleapis.com/youtube/v3/playlistItems?part=snippet&playlistId=PLLcaiOxY6mqy4eVGzLMVGu50bacry6zuV&key=AIzaSyCApY8NbKa8asDTitNWYu2XfISwm8P9WWw&maxResults=50"
#define kyoutubeVidoe       @"https://www.googleapis.com/youtube/v3/playlistItems?part=snippet&playlistId=PLLcaiOxY6mqy4eVGzLMVGu50bacry6zuV&key=AIzaSyDayDiPdaDrLV7lprbU4hdVoZp3VCBPvtg&maxResults=50"



#define kexp                @"get/Experience"

#define kTrack              @"get/all/track"
#define kCourse             @"get/all/cources"
#define kbook               @"get/all/book"
#define kfaq                @"get/Single/Answer/%@"
#define kappointment        @"add/appointment/%@"
#define kLiveEvents         @"get/all/Events"
#define kDonation           @"get/all/Bankdetails"
#define kDonate             @"ADD/DonationForm/%@"
#define kTerms              @"get/edit/page/39"
#define kform               @"Booking_event/add"
#define kOldUserData        @"Booking_event/get"
#define kAskQuestion        @"ADD/Question"
#define kBooks              @"get/all/book"
#define myCourseHistory     @"get/all/bookingevent/%@"
#define kNewBankDetails     @"add/getbankdetail"
#define kPanCard            @"ADD/DonationForm/%@"


@implementation HomeService
@synthesize achrayjiData,pravachanData,videoYoutubeData,videoDataList,songsData,cdArrayData,introData,guidelinedata,bankdetaildata,afterthecourseData,brochureData,trackData,courseData,liveEventsData,donationData,faqData,getOldUserData,getAllPostData;

- (void)acharyaji:(void (^)(id))success failure:(void (^)(NSError *))failure{
    [networkManager get:kAcharyaji parameters:nil success:^(id responseObject) {
        if ([responseObject[@"status"] boolValue]) {
            responseObject = [responseObject dictionaryByReplacingNullsWithBlanks];
            achrayjiData = responseObject[@"page_result"];
            success(responseObject[@"page_result"]);
        } else {
            failure(responseObject);
        }
        NSLog(@"response %@",responseObject);
    } failure:^(NSError *error) {
        failure(error);
    }];
}

- (void)pravachan:(void (^)(id))success failure:(void (^)(NSError *))failure {
    [networkManager get:kPravachan parameters:nil success:^(id responseObject) {
        NSLog(@"response %@",responseObject);
        if ([responseObject[@"status"] boolValue]) {
            pravachanData = responseObject[@"page_result"];
        }
        success(responseObject);
    } failure:^(NSError *error) {
        failure(error);
    }];
    
}

- (void)newPlaylist:(void (^)(id))success failure:(void (^)(NSError *))failure {
   // videoYoutubeData = [NSMutableArray new];
    [networkManager get:kVideoPlaylist parameters:nil success:^(id responseObject) {
        if ([responseObject[@"status"] boolValue]) {
            videoYoutubeData =  responseObject[@"data"];
            success(responseObject[@"data"]);
        }
    } failure:^(NSError *error) {
        failure(error);
    }];
}

- (void)videoList:(NSDictionary *)param success:(void (^)(id))success failure:(void (^)(NSError *))failure {
    videoDataList = [NSMutableArray new];
    [networkManager post:kVideosList parameters:param success:^(id responseObject) {
        NSLog(@"response %@",responseObject);
        if ([responseObject[@"status"] boolValue]) {
            videoDataList = responseObject[@"data"];
        }
        success(responseObject[@"data"]);
    } failure:^(NSError *error) {
        failure(error);
    }];
}


- (void)postAllData:(void (^)(id))success failure:(void (^)(NSError *))failure {
    [networkManager get:kPosts parameters:nil success:^(id responseObject) {
        if ([responseObject[@"status"] boolValue]) {
            getAllPostData =  responseObject[@"page_result"];
            success(responseObject[@"page_result"]);
        }
    } failure:^(NSError *error) {
        failure(error);
    }];
}
  
- (void)postDisplayData:(NSDictionary *)param success:(void (^)(id))success failure:(void (^)(NSError *))failure {
    [networkManager get:kPostsList parameters:param success:^(id responseObject) {
        success(responseObject);
    } failure:^(NSError *error) {
        failure(error);
    }];
}
  

- (void)songs:(void (^)(id))success failure:(void (^)(NSError *))failure {
    [networkManager get:kSongs parameters:nil success:^(id responseObject) {
        if ([responseObject[@"status"] boolValue]) {
            songsData = responseObject[@"page_result"];
            success(responseObject[@"page_result"]);
        } else {
            [Utils showAlertMessage:@"Something went wrong. Please try again later" withTitle:@"Alert"];
            failure(nil);
        }
    } failure:^(NSError *error) {
        failure(error);
    }];
}

- (void)vision:(void (^)(id))success failure:(void (^)(NSError *))failure {
    [networkManager get:Kvidion parameters:nil success:^(id responseObject) {
        success(responseObject);
    } failure:^(NSError *error) {
        failure(error);
    }];
}

- (void)vidya:(void (^)(id))success failure:(void (^)(NSError *))failure {
    [networkManager get:kVidya parameters:nil success:^(id responseObject) {
        success(responseObject);
    } failure:^(NSError *error) {
        failure(error);
    }];
}

- (void)aush:(void (^)(id))success failure:(void (^)(NSError *))failure {
    [networkManager get:KAush parameters:nil success:^(id responseObject) {
        success(responseObject);
    } failure:^(NSError *error) {
        failure(error);
    }];
}

- (void)nal:(void (^)(id))success failure:(void (^)(NSError *))failure {
    [networkManager get:kNal parameters:nil success:^(id responseObject) {
        success(responseObject);
    } failure:^(NSError *error) {
        failure(error);
    }];
}

- (void)bikaner:(void (^)(id))success failure:(void (^)(NSError *))failure {
    [networkManager get:kBikaner parameters:nil success:^(id responseObject) {
        success(responseObject);
    } failure:^(NSError *error) {
        failure(error);
    }];
}

- (void)kolkata:(void (^)(id))success failure:(void (^)(NSError *))failure {
    [networkManager get:kKolkata parameters:nil success:^(id responseObject) {
        success(responseObject);
    } failure:^(NSError *error) {
        failure(error);
    }];
}

- (void)mehndipur:(void (^)(id))success failure:(void (^)(NSError *))failure {
    [networkManager get:kMenhdipur parameters:nil success:^(id responseObject) {
        success(responseObject);
    } failure:^(NSError *error) {
        failure(error);
    }];
}

- (void)query:(UserDataModal *)data success:(void (^)(id))success failure:(void (^)(NSError *))failure {
    NSDictionary *param = @{@"Username":data.userName,
                            @"Subject":data.password,
                            @"Massage":data.confirmPassword,
                            @"UserEmailUnik":data.emailID,
                            @"UserEmail":data.emailID
                            };
    [networkManager post:kQiery parameters:param success:^(id responseObject) {
        if ([responseObject[@"success"] boolValue]) {
            success(responseObject);
        } else {
            [Utils showAlertMessage:@"Something went wrong, Please try again later." withTitle:@"Alert"];
        }
    } failure:^(NSError *error) {
        failure(error);
    }];
}
- (void)latestNewsletter:(void (^)(id))success failure:(void (^)(NSError *))failure {
    [networkManager get:knewsletteryear parameters:nil success:^(id responseObject) {
        success(responseObject);
    } failure:^(NSError *error) {
        failure(error);
    }];
}

- (void)newsletterYear:(void (^)(id))success failure:(void (^)(NSError *))failure {
    [networkManager get:knewsletteryearwise parameters:nil success:^(id responseObject) {
        success(responseObject);
    } failure:^(NSError *error) {
        failure(error);
    }];
}

- (void)newsletterMonth:(NSNumber *)year success:(void (^)(id))success failure:(void (^)(NSError *))failure {
   NSString *myString = [year stringValue];
    [networkManager get:[NSString stringWithFormat:knewslettermonth,myString] parameters:nil success:^(id responseObject) {
        success(responseObject);
    } failure:^(NSError *error) {
        failure(error);
    }];
}

- (void)newsletterList:(NSString *)year :(NSString *)month success:(void (^)(id))success failure:(void (^)(NSError *))failure {
    [networkManager get:[NSString stringWithFormat:knewsletterlist,year,month] parameters:nil success:^(id responseObject) {
        success(responseObject);
    } failure:^(NSError *error) {
        failure(error);
    }];
}

- (void)cd:(void (^)(id))success failure:(void (^)(NSError *))failure {
    [networkManager get:kCD parameters:nil success:^(id responseObject) {
        if ([responseObject[@"status"] boolValue]) {
            cdArrayData =  responseObject[@"page_result"];
            success(responseObject[@"page_result"]);
        }
        
    } failure:^(NSError *error) {
        failure(error);
    }];
    
}

- (void)introduction:(void (^)(id))success failure:(void (^)(NSError *))failure {
    [networkManager get:kIntroduction parameters:nil success:^(id responseObject) {
        if ([responseObject[@"status"] boolValue]) {
            for (NSDictionary *temp in responseObject[@"page_result"]) {
                introData =  temp[@"page_content"];
            }
            success(introData);
        }
        
    } failure:^(NSError *error) {
        failure(error);
    }];


}

- (void)guideline:(void (^)(id))success failure:(void (^)(NSError *))failure {
    [networkManager get:kGuideline parameters:nil success:^(id responseObject) {
        if ([responseObject[@"status"] boolValue]) {
            for (NSDictionary *temp in responseObject[@"page_result"]) {
                guidelinedata =  temp[@"page_content"];
            }
            success(guidelinedata);
        }
        
    } failure:^(NSError *error) {
        failure(error);
    }];
    
    
}

- (void)bankDetailHindi:(void (^)(id))success failure:(void (^)(NSError *))failure {
  NSString *api = @"";
  if ( [[UserDefaultManager getLanguage]  isEqual: @"Hindi"]) {
    api = @"https://satyasadhna.com/bank_details.php?lng=hi";
  } else {
    api = @"https://satyasadhna.com/bank_details.php";
  }
    [networkManager get: api parameters:nil success:^(id responseObject) {
        if ([responseObject[@"status"] boolValue]) {
            bankdetaildata =  responseObject[@"page_result"];
            success(bankdetaildata);
        }
        
    } failure:^(NSError *error) {
        failure(error);
    }];
}

- (void)afterTheCourse:(void (^)(id))success failure:(void (^)(NSError *))failure {
    [networkManager get:AfterTheCourese parameters:nil success:^(id responseObject) {
        if ([responseObject[@"status"] boolValue]) {
            for (NSDictionary *temp in responseObject[@"page_result"]) {
                afterthecourseData =  temp[@"page_content"];
            }
            success(afterthecourseData);
        }
    } failure:^(NSError *error) {
        failure(error);
    }];
}

- (void)brochureApi:(void (^)(id))success failure:(void (^)(NSError *))failure {
    [networkManager get:kBrochure parameters:nil success:^(id responseObject) {
        if ([responseObject[@"status"] boolValue]) {
            //for (NSDictionary *temp in responseObject[@"page_result"]) {
                brochureData =  responseObject[@"page_result"];
           // }
            success(brochureData);
        }
    } failure:^(NSError *error) {
        failure(error);
    }];
}

- (void)getYoutubeListing:(void (^)(id))success failure:(void (^)(NSError *error))failure {
    [networkManager get:kyoutubeVidoe parameters:nil success:^(id responseObject) {
        NSLog(@"Roshan");
        if (!_youtubeArray) {
            _youtubeArray = [NSMutableArray new];
        }
        [_youtubeArray addObjectsFromArray:[self updateLiveAndCompletedYoutubeArray:responseObject[@"items"]]];
        success(_youtubeArray);
    } failure:^(NSError *error) {
        failure(error);
    }];
}

- (void)getExp:(void (^)(id))success failure:(void (^)(NSError *error))failure {
    [networkManager get:kexp parameters:nil success:^(id responseObject) {
        NSLog(@"Roshan");
        success(responseObject);
    } failure:^(NSError *error) {
        failure(error);
    }];
}

- (void)getTrack:(void (^)(id))success failure:(void (^)(NSError *error))failure {
    [networkManager get:kTrack parameters:nil success:^(id responseObject) {
        if (!trackData) {
            trackData = [NSMutableArray new];
        }
        if ([responseObject[@"status"] boolValue]) {
            trackData = responseObject[@"page_result"];
            success (trackData);
        }
        
    } failure:^(NSError *error) {
        failure(error);
    }];
}



- (NSArray *)updateLiveAndCompletedYoutubeArray:(NSArray *)response {
    //Fetch detail for all videos
    NSMutableArray *videoIdList = [[NSMutableArray alloc] init];
    NSUInteger i = 0;
    while (i < response.count) {
        YouTubeLiveModal *liveModal = [YouTubeLiveModal new];
        NSDictionary *itemInDict = response[i];
        
        //fetch image
        liveModal.thumbnailImage = [itemInDict valueForKeyPath:@"snippet.thumbnails.medium.url"];
        
        //fetch title
        liveModal.videoTitle = [itemInDict valueForKeyPath:@"snippet.title"];
        liveModal.videoDescription = [itemInDict valueForKeyPath:@"snippet.description"];
        
        liveModal.videoTime = [itemInDict valueForKeyPath:@"snippet.publishedAt"];
        
        //fetch video id
        liveModal.videoId = [itemInDict valueForKeyPath:@"snippet.resourceId.videoId"];
        [videoIdList addObject:liveModal];
        i++;
    }
    return videoIdList;
}

- (void)getCourse:(void (^)(id))success failure:(void (^)(NSError *error))failure {
    courseData = [NSMutableArray new];
    [networkManager get:kCourse parameters:nil success:^(id responseObject) {
        courseData = responseObject[@"page_result"];
        success(courseData);
    } failure:^(NSError *error) {
        failure(error);
    }];
}

- (void)faq:(void (^)(id))success failure:(void (^)(NSError *error))failure {
    [networkManager get:[NSString stringWithFormat:kfaq,[UserDefaultManager getUserID]] parameters:nil success:^(id responseObject) {
        if ([responseObject[@"success"] boolValue]) {
            faqData = responseObject[@"user_array"];
            success(faqData);
        } else {
            [Utils showAlertMessage:@"Something went wrong, Please try again later." withTitle:@"Alert"];
            failure(nil);
        }
    } failure:^(NSError *error) {
        failure(error);
    }];
}

- (void)appointment:(UserDataModal *)data success:(void (^)(id))success failure:(void (^)(NSError *))failure {

    NSDictionary *param = @{@"name":data.userName,
                            @"mobile_nu":data.phoneNo,
                            @"resson":data.password,
                            @"appointment_with":data.confirmPassword
                            };
    [networkManager post:[NSString stringWithFormat:kappointment,[UserDefaultManager getUserID]] parameters:param success:^(id responseObject) {
        success(responseObject);
    } failure:^(NSError *error) {
        failure(error);
    }];

}

- (void)liveEvents:(void (^)(id))success failure:(void (^)(NSError *error))failure {
    [networkManager get:kLiveEvents parameters:nil success:^(id responseObject) {
        if ([responseObject[@"success"] boolValue]) {
            liveEventsData = responseObject[@"user_array"];
        } else {
            
        }
        success(responseObject);
    } failure:^(NSError *error) {
        failure(error);
    }];
}

- (void)donation:(void (^)(id))success failure:(void (^)(NSError *error))failure {
    [networkManager get:kDonation parameters:nil success:^(id responseObject) {
        donationData = responseObject[@"user_array"];
        success(responseObject);
    } failure:^(NSError *error) {
        failure(error);
    }];
}

- (void)donationForm:(NSDictionary *)data success:(void (^)(id))success failure:(void (^)(NSError *))failure {
    [networkManager post:[NSString stringWithFormat:kDonate,[UserDefaultManager getUserID]] parameters:data success:^(id responseObject) {
        success(responseObject);
    } failure:^(NSError *error) {
        failure(error);
    }];
}

- (void)termsCondition:(void (^)(id))success failure:(void (^)(NSError *error))failure {
    [networkManager get:kTerms parameters:nil success:^(id responseObject) {
        if ([responseObject[@"status"] boolValue]) {
            faqData = responseObject[@"page_result"];
            success(responseObject);
        } else {
            [Utils showAlertMessage:@"Something went wrong, Please try again later." withTitle:@"Alert"];
            failure(nil);
        }
    } failure:^(NSError *error) {
        failure(error);
    }];
}

- (void)form:(NSDictionary *)data success:(void (^)(id))success failure:(void (^)(NSError *))failure {
    [networkManager post:kform parameters:data success:^(id responseObject) {
        success(responseObject);
    } failure:^(NSError *error) {
        failure(error);
    }];
}

- (void)askQuestion:(NSDictionary *)param success:(void (^)(id))success failure:(void (^)(NSError *))failure {
    [networkManager post:kAskQuestion parameters:param success:^(id responseObject) {
        success(responseObject);
    } failure:^(NSError *error) {
        failure(error);
    }];
}

- (void)books:(void (^)(id))success failure:(void (^)(NSError *error))failure {
    [networkManager get:kBooks parameters:nil success:^(id responseObject) {
        _booksData =[NSMutableArray new];
        if ([responseObject[@"status"] boolValue]) {
            _booksData  = responseObject[@"page_result"];
        } else {
          [Utils showAlertMessage:kLangualString(@"No Books Available") withTitle:kLangualString(@"Alert")];
          failure(nil);
        }
        success(_booksData);
        
    } failure:^(NSError *error) {
        failure(error);
    }];
}

- (void)bookingHistory:(void (^)(id))success failure:(void (^)(NSError *))failure {
    [networkManager get:[NSString stringWithFormat:myCourseHistory,[UserDefaultManager getUserID]] parameters:nil success:^(id responseObject) {
        success(responseObject);
    } failure:^(NSError *error) {
        failure(error);
    }];
}


- (void)getOldUserData:(NSDictionary *)param success:(void (^)(id))success failure:(void (^)(NSError *))failure {
    
    [networkManager post:kOldUserData parameters:param success:^(id responseObject) {
        success(responseObject);
    } failure:^(NSError *error) {
        failure(error);
    }];
}
    
    - (void)getBankForm:(void (^)(id))success failure:(void (^)(NSError *error))failure {
        [networkManager get:kNewBankDetails parameters:nil success:^(id responseObject) {
            success(responseObject);
        } failure:^(NSError *error) {
            failure(error);
        }];
    }

- (void)sendPanCardNumber:(NSDictionary *)param success:(void (^)(id))success failure:(void (^)(NSError *))failure {
    [networkManager post:[NSString stringWithFormat:kPanCard,[UserDefaultManager getUserID]] parameters:param success:^(id responseObject) {
        success(responseObject);
    } failure:^(NSError *error) {
        failure(error);
    }];
}

- (void)payment:(NSDictionary *)param success:(void (^)(id))success failure:(void (^)(NSError *))failure {
    [networkManager post:[NSString stringWithFormat:kPanCard,[UserDefaultManager getUserID]] parameters:param success:^(id responseObject) {
        success(responseObject);
    } failure:^(NSError *error) {
        failure(error);
    }];
}



@end
