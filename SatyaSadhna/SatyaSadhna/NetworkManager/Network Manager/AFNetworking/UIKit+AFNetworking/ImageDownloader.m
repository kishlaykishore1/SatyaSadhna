//
//  ImageDownloader.m
//  CreateApp
//
//  Created by Roshan Singh Bisht on 5/9/16.
//
//

#import "ImageDownloader.h"

#import <objc/runtime.h>

#if defined(__IPHONE_OS_VERSION_MIN_REQUIRED)

#import "AFURLResponseSerialization.h"
#import "AFHTTPRequestOperation.h"

#import "UIImageView+AFNetworking.h"

@implementation ImageDownloader

+ (NSOperationQueue *)af_sharedImageRequestOperationQueue {
    static NSOperationQueue *_af_sharedImageRequestOperationQueue = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _af_sharedImageRequestOperationQueue = [[NSOperationQueue alloc] init];
        _af_sharedImageRequestOperationQueue.maxConcurrentOperationCount = NSOperationQueueDefaultMaxConcurrentOperationCount;
    });
    
    return _af_sharedImageRequestOperationQueue;
}

- (AFHTTPRequestOperation *)af_imageRequestOperation {
    return (AFHTTPRequestOperation *)objc_getAssociatedObject(self, @selector(af_imageRequestOperation));
}

- (void)af_setImageRequestOperation:(AFHTTPRequestOperation *)imageRequestOperation {
    objc_setAssociatedObject(self, @selector(af_imageRequestOperation), imageRequestOperation, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}


+ (id <AFImageCache>)sharedImageCache {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wgnu"
    return objc_getAssociatedObject(self, @selector(sharedImageCache)) ?: [UIImageView sharedImageCache];
#pragma clang diagnostic pop
}

+ (void)setSharedImageCache:(id <AFImageCache>)imageCache {
    objc_setAssociatedObject(self, @selector(sharedImageCache), imageCache, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

#pragma mark -

- (id <AFURLResponseSerialization>)imageResponseSerializer {
    static id <AFURLResponseSerialization> _af_defaultImageResponseSerializer = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _af_defaultImageResponseSerializer = [AFImageResponseSerializer serializer];
    });
    
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wgnu"
    return objc_getAssociatedObject(self, @selector(imageResponseSerializer)) ?: _af_defaultImageResponseSerializer;
#pragma clang diagnostic pop
}

- (void)setImageResponseSerializer:(id <AFURLResponseSerialization>)serializer {
    objc_setAssociatedObject(self, @selector(imageResponseSerializer), serializer, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

#pragma mark -
- (void)setImageWithURLRequest:(NSURLRequest *)urlRequest
                       success:(void (^)(NSURLRequest *, NSHTTPURLResponse *, UIImage *))success
                       failure:(void (^)(NSURLRequest *, NSHTTPURLResponse *, NSError *))failure
{
    [self cancelImageRequestOperation];
    
    UIImage *cachedImage = [[[self class] sharedImageCache] cachedImageForRequest:urlRequest];
    if (cachedImage) {
        if (success) {
            success(nil, nil, cachedImage);
        }
        
        [self af_setImageRequestOperation:nil];
    } else {
        __weak __typeof(self)weakSelf = self;
        AFHTTPRequestOperation *imageRequestOperation = [[AFHTTPRequestOperation alloc] initWithRequest:urlRequest];
        imageRequestOperation.responseSerializer = self.imageResponseSerializer;
        [imageRequestOperation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
            __strong __typeof(weakSelf)strongSelf = weakSelf;
            if ([[urlRequest URL] isEqual:[operation.request URL]]) {
                if (success) {
                    success(operation.request, operation.response, responseObject);
                }
                
                if (operation == strongSelf.af_imageRequestOperation){
                    [strongSelf af_setImageRequestOperation:nil];
                }
            }
            [[[strongSelf class] sharedImageCache] cacheImage:responseObject forRequest:urlRequest];
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            __strong __typeof(weakSelf)strongSelf = weakSelf;
            if ([[urlRequest URL] isEqual:[operation.request URL]]) {
                if (failure) {
                    failure(urlRequest, operation.response, error);
                }
                
                if (operation == strongSelf.af_imageRequestOperation){
                    [strongSelf af_setImageRequestOperation:nil];
                }
            }
        }];
        
        [self af_setImageRequestOperation:imageRequestOperation];
        [[[self class] af_sharedImageRequestOperationQueue] addOperation:imageRequestOperation];
    }
}

- (void)cancelImageRequestOperation {
    [self.af_imageRequestOperation cancel];
    [self af_setImageRequestOperation:nil];
}


@end

#endif
