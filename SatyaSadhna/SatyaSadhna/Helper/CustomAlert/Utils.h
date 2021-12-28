//
//  Utils.h
//  The Butler
//
//  Created by Jogendar on 05/04/16.
//  Copyright © 2016 Ranosys Technologies Pvt Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


@interface Utils : NSObject
+ (id )changeDataToJson:(id)totalData;
+ (void)displayErrorAlert:(NSError *)error;
+ (void)showAlertMessage:(NSString*)message withTitle:(NSString *)title;
+ (UIButton *)setButton: (UIButton *) button inRect:(CGRect)frame withTitle:(NSString *)buttonTitle withBgColor:(UIColor *)bgButtonColor;
+ (void)saveImageInDirectory:(NSString *)path;
+ (void)writeData:(NSData *)data toFile:(NSString *)file;
+ (NSString *)getFileDocumentoryPathForImageUrl:(NSString *)imageUrl;
+ (BOOL)checkForCameraAccessPermission;
+ (BOOL)isEmpty:(NSString *)strData;
+ (BOOL)isNullChecker:(NSString *)val;
+  (UIImage*) blur:(UIImage*)theImage;
+ (NSInteger)getTotalPagesFromCount:(NSInteger)totalCount andPrePageDataCount:(NSInteger)perPageCount;
+ (NSString *)getRandomFileNameWithExtension:(NSString *)ext;
+ (void)writeDataForAWS:(NSData *)data toFile:(NSString *)file;
+ (NSString *)getFileDocumentoryPathForFileName:(NSString *)fileName;
+(NSString *)trimString:(NSString *)value;
+ (CGSize)sizeOfMultiLineLabel:(UILabel *)lbl;
@end

