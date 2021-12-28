//
//  UIButton+Layout.m
//  SatyaSadhna
//
//  Created by Roshan Singh Bisht on 22/04/17.
//  Copyright © 2017 Roshan Singh Bisht. All rights reserved.
//

#import "UIButton+Layout.h"

@implementation UIButton (Layout)
- (void)roundButton {
    self.layer.borderWidth = 1;
    self.layer.borderColor = [UIColor whiteColor].CGColor ;
    self.layer.cornerRadius = self.frame.size.height/2; // this value vary as per your desire
    self.clipsToBounds = YES;
}

- (void)cornerradiusforButton {
    self.layer.cornerRadius = 5.0f;
    self.clipsToBounds = YES;
    self.layer.borderWidth = 0.8f;
    self.layer.borderColor = [UIColor whiteColor].CGColor;
}
@end
