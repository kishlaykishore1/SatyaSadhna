//
//  UITextView+customize.m
//  SatyaSadhna
//
//  Created by Roshan Singh Bisht on 04/06/17.
//  Copyright © 2017 Roshan Singh Bisht. All rights reserved.
//

#import "UITextView+customize.h"

@implementation UITextView (customize)
- (void)drawPaddingLess {

    self.layer.cornerRadius = 4.0;
    self.layer.borderWidth = 0.2;
    self.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.clipsToBounds = YES;
}

- (void)drawPadding {
    self.layer.cornerRadius = self.frame.size.height /2;
    self.layer.borderWidth = 0.2;
    self.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.clipsToBounds = YES;
}

@end
