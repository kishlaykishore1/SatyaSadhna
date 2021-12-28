//
//  UIView+Loading.m
//  SatyaSadhna
//
//  Created by Roshan Singh Bisht on 03/06/17.
//  Copyright © 2017 Roshan Singh Bisht. All rights reserved.
//

#import "UIView+Loading.h"

@implementation UIView (Loading)

- (void)updateViewWithApplicationGlobalFont {
    NSString *fontFamily = @"Avenir-Book";
    for(UIView *view in self.subviews) {
        if ([view isKindOfClass:[UILabel class]]) {
            UILabel *lbl = (UILabel *)view;
            if (lbl.text.length > 0) {
                [lbl setFont:[UIFont fontWithName:fontFamily size:[[lbl font] pointSize]]];
                lbl.minimumScaleFactor = 0.5;
            }
        } else if ([view isKindOfClass:[UIButton class]]) {
            UIButton *lbl = (UIButton *)view;
            [lbl.titleLabel setFont:[UIFont fontWithName:fontFamily size:[[lbl.titleLabel font] pointSize]]];
            lbl.titleLabel.minimumScaleFactor = 0.5;
            
            
        } else if ([view isKindOfClass:[UITextField class]]) {
            UITextField *textF = (UITextField *)view;
            [textF setFont:[UIFont fontWithName:fontFamily size:[[textF font] pointSize]]];
            //            textF.attributedPlaceholder = [[NSAttributedString alloc] initWithString:textF.placeholder
            //                                           attributes: @{ NSFontAttributeName : [UIFont fontWithName:fontFamily size:[[textF font] pointSize]] }];

        } else if ([view isKindOfClass:[UITextView class]]) {
            UITextView *textV = (UITextView *)view;
            [textV setFont:[UIFont fontWithName:fontFamily size:[[textV font] pointSize]]];
        } else {
            [view updateViewWithApplicationGlobalFont];
        }
    }
}

- (void)cornerradius {
    self.layer.cornerRadius = 5.0f;
    self.clipsToBounds = YES;
}


@end
