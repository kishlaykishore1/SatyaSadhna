//
//  UITextField+layout.h
//  MobileHealthWallete
//
//  Created by Jogendar on 18/05/16.
//  Copyright © 2016 Ranosys. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UILabel (DynamicHeight)
- (CGSize)sizeOfMultiLineLabel;
- (CGFloat)dynamicWidthOfLabel;
- (void)drawTextInRect:(CGRect)rect;
- (void)labelBorderGreyColor;
- (void)labelCornerRadius;

@end
