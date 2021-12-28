//
//  UITextField+layout.h
//  MobileHealthWallete
//
//  Created by Jogendar on 18/05/16.
//  Copyright © 2016 Ranosys. All rights reserved.
//

#import "UILabel+DynamicHeight.h"
#import <QuartzCore/QuartzCore.h>
#import "Constants.h"

@implementation UILabel (DynamicHeight)

- (CGSize)sizeOfMultiLineLabel {
    NSAssert(self, @"UILabel was nil");
    NSString *aLabelTextString = [self text];
    UIFont *aLabelFont = [self font];
    CGFloat aLabelSizeWidth = self.frame.size.width;
    return [aLabelTextString boundingRectWithSize:CGSizeMake(aLabelSizeWidth, MAXFLOAT)
                                          options:NSStringDrawingUsesLineFragmentOrigin
                                       attributes:@{
                                                    NSFontAttributeName : aLabelFont
                                                    }
                                          context:nil].size;
}

- (CGFloat)dynamicWidthOfLabel {
    NSAssert(self, @"UILabel was nil");
    NSString *aLabelTextString = [self text];
    UIFont *aLabelFont = [self font];
    CGFloat aLabelSizeheight = self.frame.size.height;
    return [aLabelTextString boundingRectWithSize:CGSizeMake(MAXFLOAT, aLabelSizeheight)
                                          options:NSStringDrawingUsesLineFragmentOrigin
                                       attributes:@{
                                                    NSFontAttributeName : aLabelFont
                                                    }
                                          context:nil].size.width+5;
}

- (void)labelBorderGreyColor {
    UIColor *color = RGB(230, 230, 230);
    self.layer.borderColor = color.CGColor;
    self.layer.borderWidth = 1.0;
}

- (void)labelCornerRadius {
    self.layer.borderWidth = 1;
    self.layer.borderColor = [UIColor clearColor].CGColor ;
    self.layer.cornerRadius = self.frame.size.height/2; // this value vary as per your desire
    self.clipsToBounds = YES;
}
@end
