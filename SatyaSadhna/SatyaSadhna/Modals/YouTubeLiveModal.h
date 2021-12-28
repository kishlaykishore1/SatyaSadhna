//
//  YouTubeLiveModal.h
//  CreateApp
//
//  Created by Nakul Hindustani on 20/04/17.
//
//

#import <Foundation/Foundation.h>

@interface YouTubeLiveModal : NSObject

@property (nonatomic, strong) NSString      *thumbnailImage;
@property (nonatomic, strong) NSString      *videoTitle;
@property (nonatomic, strong) NSString      *videoDescription;
@property (nonatomic, strong) NSString      *videoTime;
@property (nonatomic, strong) NSString      *videoId;
@property (nonatomic, strong) NSString      *videoStatus;

- (instancetype)initWithDictionary:(NSDictionary *)aDictionary;

@end
