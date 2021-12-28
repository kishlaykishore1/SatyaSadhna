//
//  YouTubeLiveModal.m
//  CreateApp
//
//  Created by Roshan on 20/04/17.
//
//

#import "YouTubeLiveModal.h"

@implementation YouTubeLiveModal

- (instancetype)initWithDictionary:(NSDictionary *)aDictionary {
    self = [[YouTubeLiveModal alloc] init];
   
    if (self) {
        self.thumbnailImage = @"";
        self.videoTitle = @"";
        self.videoDescription = @"";
        self.videoTime = @"";
        self.videoId = @"";
        self.videoStatus = @"";
    }
    
    return self;
}

@end
