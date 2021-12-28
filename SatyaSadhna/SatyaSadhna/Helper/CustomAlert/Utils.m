//
//  Utils.m
//  The Butler
//
//  Created by Jogendar on 05/04/16.
//  Copyright © 2016 Ranosys Technologies Pvt Ltd. All rights reserved.
//
#import "MHWAlertView.h"
#import "Utils.h"
#import "Constants.h"
#import <AVFoundation/AVFoundation.h>
#import "ServiceHandler.h"
#import "AppDelegate+Transition.h"
#import "MHWAlertView.h"

#define kAlertTitle          @"Alert"
#define kMessage             @"message"
#define KOK                  @"OK"

#define kAlertYouAreNotConnected        @"You are not connected to Internet, Please try again later."
@implementation Utils
+ (id)changeDataToJson:(id)totalData {
  // Using This method we got json string for dictionary, array and others.
  NSData *jsonData = [NSJSONSerialization dataWithJSONObject:totalData options:0 error:nil];
  return  [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
  
  
  
}
+ (void)displayErrorAlert:(NSError *)error {
  
  //        400 Error
  //        200 Success
  //        401 Token Expire
  //        -1009 Token Expire
  //        410 for redirect to login
  
  //        402 If user try to accept or decline already declined job
  //        403 For Account verification with email link
  //        405 For job doesn’t exists (Job details api)
  //        410 for redirect to login
  
  
  switch (error.code) {
      
    case 400: {
      NSString *errorString = [error.userInfo valueForKey:@"Something wen wrong!"];
      if (errorString.length>0) {
        [self showAlertMessage:errorString withTitle:kAlertTitle];
      } else {
        [self showAlertMessage:error.localizedDescription withTitle:kAlertTitle];
      }
    }
      break;
    case 401: {
      AppDelegate *appdelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
      UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Alert" message:[error.userInfo valueForKey:kMessage] delegate:appdelegate cancelButtonTitle:KOK otherButtonTitles:nil, nil];
      alert.tag = 1;
      [alert show];
    }
      break;
    case -1009: {   // Internet Connection Appers Offline
      [self showAlertMessage:kAlertYouAreNotConnected  withTitle:kAlertTitle];
    }
      break;
    case 14: {
      [self showAlertMessage:error.localizedDescription withTitle:kAlertTitle];
    }
    case 410: {
      AppDelegate *appdelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
      UIAlertView *alert = [[UIAlertView alloc] initWithTitle:kAlertTitle message:[error.userInfo valueForKey:kMessage] delegate:appdelegate cancelButtonTitle:KOK otherButtonTitles:nil, nil];
      alert.tag = 2;
      [alert show];
    }
      break;
    default: {
      MHWAlertView *alertView = [[MHWAlertView alloc] initWithTitle:kAlertTitle message:kMessage delegate:nil cancelButtonTitle:KOK otherButtonTitles:nil, nil];
      [alertView show];
    }
      break;
  }
}
#pragma mark - custom methods
NSString *letters = @"abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789";

+ (NSString *)randomString{
  
  NSMutableString *randomString = [NSMutableString stringWithCapacity:10];
  
  for (int i=0; i<10; i++) {
    [randomString appendFormat: @"%C", [letters characterAtIndex: arc4random_uniform([letters length])]];
  }
  NSString *uuid = [[NSUUID UUID] UUIDString];
  NSString *final = [NSString stringWithFormat:@"%@%@",uuid,randomString];
  return final;
}

+ (NSString *)getRandomFileNameWithExtension:(NSString *)ext {
  NSString *fileName = [NSString stringWithFormat:@"%@.%@",[self randomString],ext];
  return fileName;
}
+ (NSString *)getFileDocumentoryPathForFileName:(NSString *)fileName{
  NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
  NSString* documentsDirectory = [paths firstObject];
  NSString *filePath = [documentsDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"/%@",fileName]];
  return filePath;
}

+ (void)writeData:(NSData *)data toFile:(NSString *)file{
  NSString* folderStructure = [file stringByDeletingLastPathComponent];
  folderStructure = [self getFileDocumentoryPathForFileName:folderStructure];
  [[NSFileManager defaultManager] createDirectoryAtPath:folderStructure withIntermediateDirectories:YES attributes:nil error:nil];        //create directory at path
  [data writeToFile:[self getFileDocumentoryPathForFileName:file] atomically:YES];
}
+ (UIButton *)setButton: (UIButton *) button inRect:(CGRect)frame withTitle:(NSString *)buttonTitle withBgColor:(UIColor *)bgButtonColor {
  
  [button setFrame:frame];
  [button setTitle:buttonTitle forState:UIControlStateNormal];
  [button.titleLabel setFont:[UIFont systemFontOfSize:button.frame.size.height/2.2]];
  [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
  [button setBackgroundColor:bgButtonColor];
  return button;
}
+ (void)saveImageInDirectory:(NSString *)path {
  NSURL *yourURL = [NSURL URLWithString:path];
  NSArray *arr = [path componentsSeparatedByString:@"/"];
  NSURLRequest *request = [NSURLRequest requestWithURL:yourURL];
  NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
  NSURL *documentsURL = [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
  documentsURL = [documentsURL URLByAppendingPathComponent:[arr lastObject]];
  // and finally save the file
  [data writeToURL:documentsURL atomically:YES];
}
+(NSString *)trimString:(NSString *)value {
  return [value stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
}
+ (void)writeDataForAWS:(NSData *)data toFile:(NSString *)file {
  NSString* folderStructure = [file stringByDeletingLastPathComponent];
  folderStructure = [self getFileDocumentoryPathForImageUrl:folderStructure];
  [[NSFileManager defaultManager] createDirectoryAtPath:folderStructure withIntermediateDirectories:YES attributes:nil error:nil];        //create directory at path
  [data writeToFile:[self getFileDocumentoryPathForImageUrl:file] atomically:YES];
}

+ (NSString *)getFileDocumentoryPathForImageUrl:(NSString *)imageUrl {
  NSString* documentsDirectory = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES) lastObject];
  NSString *filePath = [documentsDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"/%@",imageUrl]];
  return filePath;
}
+ (BOOL)checkForCameraAccessPermission {
  AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
  switch (authStatus) {
      
    case AVAuthorizationStatusAuthorized: {
      return YES;
    }
      break;
    case AVAuthorizationStatusNotDetermined: {
      return YES;
    }
      break;
    case AVAuthorizationStatusRestricted: {
      return YES;
    }
      break;
    case AVAuthorizationStatusDenied: {
      return NO;
    }
      break;
      
  }
  return YES;
}
+ (BOOL)isEmpty:(NSString *)strData {
  return ([strData stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]].length == 0) ? YES : NO;
}

+ (BOOL)isNullChecker:(NSString *)val {
  if (!([val isKindOfClass:[NSNull class]] || val == (id)[NSNull null] || val == NULL || [val isEqual:@"<null>"] || [val isEqual:@"(null)"]) && val) {
    return YES;
  } else {
    return NO;
  }
}

+  (UIImage*) blur:(UIImage*)theImage
{
  // ***********If you need re-orienting (e.g. trying to blur a photo taken from the device camera front facing camera in portrait mode)
  // theImage = [self reOrientIfNeeded:theImage];
  
  // create our blurred image
  CIContext *context = [CIContext contextWithOptions:nil];
  CIImage *inputImage = [CIImage imageWithCGImage:theImage.CGImage];
  
  // setting up Gaussian Blur (we could use one of many filters offered by Core Image)
  CIFilter *filter = [CIFilter filterWithName:@"CIGaussianBlur"];
  [filter setValue:inputImage forKey:kCIInputImageKey];
  [filter setValue:[NSNumber numberWithFloat:15.0f] forKey:@"inputRadius"];
  CIImage *result = [filter valueForKey:kCIOutputImageKey];
  
  // CIGaussianBlur has a tendency to shrink the image a little,
  // this ensures it matches up exactly to the bounds of our original image
  CGImageRef cgImage = [context createCGImage:result fromRect:[inputImage extent]];
  
  UIImage *returnImage = [UIImage imageWithCGImage:cgImage];//create a UIImage for this function to "return" so that ARC can manage the memory of the blur... ARC can't manage CGImageRefs so we need to release it before this function "returns" and ends.
  CGImageRelease(cgImage);//release CGImageRef because ARC doesn't manage this on its own.
  
  return returnImage;
  // return [[self class] scaleIfNeeded:cgImage];
}

+ (NSInteger)getTotalPagesFromCount:(NSInteger)totalCount andPrePageDataCount:(NSInteger)perPageCount {
  NSInteger remainderValue = totalCount % perPageCount;
  NSInteger totalPages = totalCount/perPageCount;
  return remainderValue != 0 ? totalPages + 1 : totalPages;
}

+ (CGSize)sizeOfMultiLineLabel:(UILabel *)lbl {
  NSAssert(self, @"UILabel was nil");
  NSString *aLabelTextString = [lbl text];
  UIFont *aLabelFont = [lbl font];
  CGFloat aLabelSizeWidth = lbl.frame.size.width;
  return [aLabelTextString boundingRectWithSize:CGSizeMake(aLabelSizeWidth, MAXFLOAT)
                                        options:NSStringDrawingUsesLineFragmentOrigin
                                     attributes:@{
                                       NSFontAttributeName : aLabelFont
                                     }
                                        context:nil].size;
}

+ (void)showAlertMessage:(NSString *)message withTitle:(NSString *)title {
  MHWAlertView *alertView = [[MHWAlertView alloc] initWithTitle:title message:message delegate:nil cancelButtonTitle:KOK otherButtonTitles:nil, nil];
  [alertView show];
}



@end
