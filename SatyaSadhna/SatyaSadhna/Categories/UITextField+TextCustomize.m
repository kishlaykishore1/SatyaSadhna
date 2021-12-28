//
//  UITextField+TextCustomize.m
//  SatyaSadhna
//
//  Created by Roshan Singh Bisht on 22/04/17.
//  Copyright © 2017 Roshan Singh Bisht. All rights reserved.
//

#import "UITextField+TextCustomize.h"
#import <UIKit/UIKit.h>

@implementation UITextField (TextCustomize)


- (void)drawPaddingWithImage:(UIImage *)image {
    UIView *paddingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 60, 30)];
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(15, 0, 30, 30)];
    imageView.image = image;
    imageView.contentMode =  UIViewContentModeScaleAspectFit;
    [paddingView addSubview:imageView];
    self.leftView = paddingView;
    self.leftViewMode = UITextFieldViewModeAlways;
    self.layer.cornerRadius = self.frame.size.height / 2;
    self.layer.borderWidth = 0.2;
    self.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.clipsToBounds = YES;

}

- (void)drawPadding {
    UIView *paddingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 30)];
    self.leftView = paddingView;
    self.leftViewMode = UITextFieldViewModeAlways;
    self.layer.cornerRadius = 4.0f;
    self.clipsToBounds = YES;
}
- (void)drawPaddingLess {
    UIView *paddingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 15, 30)];
    self.leftView = paddingView;
    self.leftViewMode = UITextFieldViewModeAlways;
    self.layer.cornerRadius = 4.0;
    self.layer.borderWidth = 0.2;
    self.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.clipsToBounds = YES;
    
    
    UIView *paddingView2 = [[UIView alloc] initWithFrame:CGRectMake(0, 5, 20, 10)];
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 9, 9)];
    imageView.image = [UIImage imageNamed:@"star"];
    imageView.contentMode =  UIViewContentModeScaleAspectFit;
    [paddingView2 addSubview:imageView];
    self.rightView = paddingView2;
    self.rightViewMode = UITextFieldViewModeAlways;
}

- (void)drawPaddinWithoutImage {
    UIView *paddingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 15, 30)];
    self.leftView = paddingView;
    self.leftViewMode = UITextFieldViewModeAlways;
    self.layer.cornerRadius = 4.0;
    self.layer.borderWidth = 0.2;
    self.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.clipsToBounds = YES;
}

- (BOOL)isEmailCorrect {
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:self.text];
}


- (BOOL)isCorrectPhoneNo {
    NSString *phone = @"^[0-9]{6,16}$";
    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", phone];
    return [phoneTest evaluateWithObject:self.text];
}

- (BOOL)isCorrectAmount {
    NSString *phone = @"^[0-9]{1,20}$";
    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", phone];
    return [phoneTest evaluateWithObject:self.text];
}

- (void)roundTextField {
    self.layer.cornerRadius = self.frame.size.height / 2;
    self.layer.borderWidth = 0.2;
    self.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.clipsToBounds = YES;
}
@end
