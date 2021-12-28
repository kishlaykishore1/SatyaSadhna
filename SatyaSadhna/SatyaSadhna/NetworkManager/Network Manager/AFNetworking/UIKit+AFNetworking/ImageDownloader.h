//
//  ImageDownloader.h
//  CreateApp
//
//  Created by Roshan Singh Bisht on 5/9/16.
//
//

#import <Foundation/Foundation.h>

#import <Availability.h>

#if defined(__IPHONE_OS_VERSION_MIN_REQUIRED)

#import <UIKit/UIKit.h>

@protocol AFURLResponseSerialization, AFImageCache;

@interface ImageDownloader : NSObject


///----------------------------
/// @name Accessing Image Cache
///----------------------------

/**
 The image cache used to improve image loadiing performance on scroll views. By default, `UIButton` will use the `sharedImageCache` of `UIImageView`.
 */
+ (id <AFImageCache>)sharedImageCache;

/**
 Set the cache used for image loading.
 
 @param imageCache The image cache.
 */
+ (void)setSharedImageCache:(id <AFImageCache>)imageCache;

///------------------------------------
/// @name Accessing Response Serializer
///------------------------------------

/**
 The response serializer used to create an image representation from the server response and response data. By default, this is an instance of `AFImageResponseSerializer`.
 
 @discussion Subclasses of `AFImageResponseSerializer` could be used to perform post-processing, such as color correction, face detection, or other effects. See https://github.com/AFNetworking/AFCoreImageSerializer
 */
@property (nonatomic, strong) id <AFURLResponseSerialization> imageResponseSerializer;

///--------------------
/// @name Setting Image
///--------------------

/**
 Asynchronously downloads an image from the specified URL request, and sets it once the request is finished. Any previous image request for the receiver will be cancelled.
 
 If the image is cached locally, the image is set immediately, otherwise the specified placeholder image will be set immediately, and then the remote image will be set once the request is finished.
 
 If a success block is specified, it is the responsibility of the block to set the image of the image view before returning. If no success block is specified, the default behavior of setting the image with `self.image = image` is applied.
 
 @param urlRequest The URL request used for the image request.
 @param placeholderImage The image to be set initially, until the image request finishes. If `nil`, the image view will not change its image until the image request finishes.
 @param success A block to be executed when the image request operation finishes successfully. This block has no return value and takes three arguments: the request sent from the client, the response received from the server, and the image created from the response data of request. If the image was returned from cache, the request and response parameters will be `nil`.
 @param failure A block object to be executed when the image request operation finishes unsuccessfully, or that finishes successfully. This block has no return value and takes three arguments: the request sent from the client, the response received from the server, and the error object describing the network or parsing error that occurred.
 */
- (void)setImageWithURLRequest:(NSURLRequest *)urlRequest
                       success:(void (^)(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image))success
                       failure:(void (^)(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error))failure;

/**
 Cancels any executing image operation for the receiver, if one exists.
 */
- (void)cancelImageRequestOperation;


@end

#endif
