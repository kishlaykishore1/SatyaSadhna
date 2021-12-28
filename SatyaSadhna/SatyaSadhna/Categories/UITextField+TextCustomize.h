//
//  UITextField+TextCustomize.h
//  SatyaSadhna
//
//  Created by Roshan Singh Bisht on 22/04/17.
//  Copyright © 2017 Roshan Singh Bisht. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITextField (TextCustomize)

- (void)drawPaddingWithImage:(UIImage *)image;
- (BOOL)isEmailCorrect;
- (BOOL)isCorrectPhoneNo;
- (void)drawPadding;
- (void)drawPaddingLess;
- (void)roundTextField;
- (BOOL)isCorrectAmount;
- (void)drawPaddinWithoutImage;

@end
