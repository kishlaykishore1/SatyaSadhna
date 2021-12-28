//
//  MHWAlertView.m
//  MobileHealthWallete
//
//  Created by Jogendar on 18/05/16.
//  Copyright © 2016 Ranosys. All rights reserved.
//

#import "MHWAlertView.h"
#import "UILabel+DynamicHeight.h"
#import "Constants.h"
#import "Utils.h"


@interface MHWAlertView () {
    UIView          *viewPopup;
    NSInteger       index;
    NSInteger       totalbuttoncount;
    UILabel         *labelTitle;
    UILabel         *labelMessage;
}
@property(strong) NSMutableArray *blocks;
@property(strong) id keepInMemory;
@end
@implementation MHWAlertView
@synthesize blocks, dismissAction, keepInMemory;
- (id) initWithTitle: (NSString*) title message: (NSString*) message delegate:(id)delegate
{
    self = [super init];
    if (self) {
        // Code here for initial setup
        CGSize size             = [UIScreen mainScreen].bounds.size;
        index                   = 0;
        totalbuttoncount        = 0;
        _alertDelegate          = delegate;
        
        self.frame              = CGRectMake(0, 0, size.width, size.height);
        self.backgroundColor    = [UIColor colorWithWhite:0.098 alpha:0.640];
        
        viewPopup = [[UIView alloc] initWithFrame:CGRectMake(30, self.frame.size.height, 300, 200)];
        [viewPopup setBackgroundColor:RGB(244, 180, 101)];
        [viewPopup.layer setCornerRadius:5.0];
        [self addSubview:viewPopup];
        
        int y = 15;
        labelTitle = [[UILabel alloc] initWithFrame:CGRectMake(0, y, viewPopup.frame.size.width, 30)];
        [labelTitle setTextAlignment:NSTextAlignmentCenter];
        labelTitle.textColor = [UIColor whiteColor];
        labelTitle.font = [UIFont fontWithName:@"Helvetica-Bold" size:16];
        [labelTitle setText:title];
        [labelTitle setText:title];
        [labelTitle setFont:[UIFont systemFontOfSize:16]];
        [viewPopup addSubview:[self updateLabelWithContent:labelTitle]];
        y += labelTitle.frame.size.height+5;
        
        labelMessage = [[UILabel alloc] initWithFrame:CGRectMake(20, y, viewPopup.frame.size.width-40, 50)];
        [labelMessage setTextAlignment:NSTextAlignmentCenter];
        [labelMessage setTextColor:[UIColor whiteColor]];
        [labelMessage setNumberOfLines:2];
        [labelMessage setText:message];
        [labelMessage setFont:[UIFont systemFontOfSize:15]];
        [viewPopup addSubview:[self updateLabelWithContent:labelMessage]];
        y += labelMessage.frame.size.height+15;
        
        // Add alert indicatoe image, reframe view and animation to popup
        //     [self addAlertIndicatorImage];
        
        y += 10;
        CGRect frame        = viewPopup.frame;
        frame.size.height   = y;
        viewPopup.frame     = frame;
        viewPopup.center    = self.center;
        
        //    _border.path        = [UIBezierPath bezierPathWithRoundedRect:viewPopup.bounds cornerRadius:0.0f].CGPath; //Setting path for border color
        
        [self presentPopUpWithAnimation];
    }
    blocks = [[NSMutableArray alloc] init];
    return self;
}


- (instancetype)initWithTitle:(NSString *)title message:(NSString *)message delegate:(id)delegate cancelButtonTitle:(NSString *)cancelButtonTitle otherButtonTitles:(NSString *)otherButtonTitles, ... {
    
    self = [super init];
    if (self) {
        // Code here for initial setup
        CGSize size             = [UIScreen mainScreen].bounds.size;
        index                   = 0;
        totalbuttoncount        = 0;
        
        self.frame              = CGRectMake(0, 0, size.width, size.height);
        self.backgroundColor    = [UIColor colorWithWhite:0.098 alpha:0.640];
        _alertDelegate          = delegate;
        
        viewPopup = [[UIView alloc] initWithFrame:CGRectMake(30, self.frame.size.height, 300, 200)];
        [viewPopup setBackgroundColor:RGB(244, 180, 101)];
        [viewPopup.layer setCornerRadius:5.0];
        [self addSubview:viewPopup];
        
        int y = 15;
        labelTitle = [[UILabel alloc] initWithFrame:CGRectMake(0, y, viewPopup.frame.size.width, 30)];
        [labelTitle setTextAlignment:NSTextAlignmentCenter];
        labelTitle.textColor = [UIColor whiteColor];
        labelTitle.font = [UIFont boldSystemFontOfSize:16];
        [labelTitle setText:title];
        [viewPopup addSubview:[self updateLabelWithContent:labelTitle]];
        y += labelTitle.frame.size.height+15;
        
        labelMessage = [[UILabel alloc] initWithFrame:CGRectMake(20, y, viewPopup.frame.size.width-40, 50)];
        [labelMessage setTextAlignment:NSTextAlignmentCenter];
        [labelMessage setTextColor:[UIColor whiteColor]];
        [labelMessage setNumberOfLines:3];
        [labelMessage setText:message];
        [labelMessage setFont:[UIFont systemFontOfSize:15]];
        [viewPopup addSubview:[self updateLabelWithContent:labelMessage]];
        y += labelMessage.frame.size.height+15;
        UILabel *separator = [[UILabel alloc] initWithFrame:CGRectMake(0, y, viewPopup.frame.size.width, .5)];
        separator.backgroundColor = RGB(244, 180, 101);
        y += separator.frame.size.height+1;
        [viewPopup addSubview:separator];
        // Other button count, to set view for less than 2 buttons and more than 2 buttons
        if ( otherButtonTitles ) {
            totalbuttoncount++;
            
            va_list args;
            va_start(args, otherButtonTitles);
            while (va_arg(args, NSString*)) {
                totalbuttoncount++;
            }
            va_end(args);
        }
        
        
        if ( cancelButtonTitle ) {
            totalbuttoncount++;
            
            UIButton *buttonOK = [[UIButton alloc]init];
            if (totalbuttoncount != 2) {
                [Utils setButton:buttonOK inRect:CGRectMake(0, y, viewPopup.frame.size.width, 45) withTitle:cancelButtonTitle withBgColor:RGB(233, 84, 53)];
                y += buttonOK.frame.size.height;
            } else {
                [Utils setButton:buttonOK inRect:CGRectMake(10, y, viewPopup.frame.size.width/2-15, 38) withTitle:cancelButtonTitle withBgColor:RGB(233, 84, 53)];
                
            }
            
            [buttonOK setTag:index];
            [buttonOK addTarget:self action:@selector(actionClickedButtonAtIndexMethode:) forControlEvents:UIControlEventTouchUpInside];
            [viewPopup addSubview:buttonOK];
            index++;
        }
        
        
        
        // create view for other button titles
        if ( otherButtonTitles ) {
            va_list args;
            va_start(args, otherButtonTitles);
            NSString *buttonTitle = otherButtonTitles;
            BOOL flag = YES;
            
            while (buttonTitle) {
                UIButton *button = [[UIButton alloc]init];
                // retain previous yOrigin in case of 2 buttons, so that they will horizonatally at same y-origin
                if (totalbuttoncount == 2) {
                    if ( cancelButtonTitle ) {
                        button = [self addButtons:buttonTitle withStyle:AlertButtonStyleHalfRight atYOrigin:y];
                        y += button.frame.size.height+5;
                    } else if (flag){
                        button = [self addButtons:buttonTitle withStyle:AlertButtonStyleHalfLeft atYOrigin:y];
                        flag = NO;
                    } else {
                        button = [self addButtons:buttonTitle withStyle:AlertButtonStyleHalfRight atYOrigin:y];
                        y += button.frame.size.height+5;
                    }
                    UILabel *labelSeparetor = [[UILabel alloc]initWithFrame:CGRectMake(viewPopup.frame.size.width/2-.2,separator.frame.origin.y+.5, .5, 46)];
                    flag = NO;
                    labelSeparetor.backgroundColor = RGB(244, 180, 101);
                    [viewPopup addSubview:labelSeparetor];
                    [viewPopup addSubview:button];
                    index++;
                    
                } else {
                    // Add button to popup, increment y-origin and index
                    button = [self addButtons:buttonTitle withStyle:AlertButtonStyleFullWidth atYOrigin:y];
                    [viewPopup addSubview:button];
                    index++;
                    y += button.frame.size.height+5;
                }
                // increment var-arg list
                buttonTitle = va_arg(args, NSString*);
            }
            va_end(args);
        }
        
        
        // Add alert indicatoe image, reframe view and animation to popup
        //     [self addAlertIndicatorImage];
        
        y += 2;
        CGRect frame        = viewPopup.frame;
        frame.size.height   = y;
        viewPopup.frame     = frame;
        viewPopup.center    = self.center;
        
        //    _border.path        = [UIBezierPath bezierPathWithRoundedRect:viewPopup.bounds cornerRadius:0.0f].CGPath; //Setting path for border color
        
        [self presentPopUpWithAnimation];
    }
    return self;
}

- (void)presentPopUpWithAnimation {
    // ViwePopUp will Animate to appear
    // Animation as like UIAlertView
    
    viewPopup.alpha = 0;
    [UIView animateWithDuration:0.1 animations:^{viewPopup.alpha = 1.0;}];
    CAKeyframeAnimation *bounceAnimation = [CAKeyframeAnimation animationWithKeyPath:@"transform.scale"];
    bounceAnimation.values = @[@0.01f, @1.1f, @1.0f];
    bounceAnimation.keyTimes = @[@0.0f, @0.5f, @1.0f];
    bounceAnimation.duration = 0.3;
    [viewPopup.layer addAnimation:bounceAnimation forKey:@"bounce"];
}

- (UILabel *)updateLabelWithContent:(UILabel *)dynamicContentLabel {
    [dynamicContentLabel setNumberOfLines:0];
    
    CGSize dynamicLabelSize = [dynamicContentLabel sizeOfMultiLineLabel];
    CGRect frame =  dynamicContentLabel.frame;
    frame.size.height = dynamicLabelSize.height+5;
    dynamicContentLabel.frame = frame;
    
    return dynamicContentLabel;
}

// shows popup alert animated.
- (void)show {
    [[[[UIApplication sharedApplication] delegate] window] addSubview:self];
}

- (UIButton *)addButtons:(NSString *)buttonTitle withStyle:(AlertButtonStyle)style atYOrigin:(int)y {
    
    UIButton *button = [[UIButton alloc]init];
    if (totalbuttoncount == 2) {
        if (style == AlertButtonStyleHalfLeft) {
            [button setFrame:CGRectMake(10, y, viewPopup.frame.size.width/2-15, 38)];
        } else {
            [button setFrame:CGRectMake(viewPopup.frame.size.width/2+5, y, viewPopup.frame.size.width/2-15, 38)];
        }
        
    } else {
        [button setFrame:CGRectMake(viewPopup.frame.size.width/2-80, y, 160, 38)];
    }
    
    //    [button setBackgroundImage:kImageVisitAsGuestButton forState:UIControlStateNormal];
    [button setTitle:buttonTitle forState:UIControlStateNormal];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [button.titleLabel setFont:[UIFont boldSystemFontOfSize:16.0]];
    [button setBackgroundColor:RGB(233, 84, 53)];
    [button setTag:index];
    [button addTarget:self action:@selector(actionClickedButtonAtIndexMethode:) forControlEvents:UIControlEventTouchUpInside];
    return button;
}

// Call deleagte method from subsequent class
- (void)actionClickedButtonAtIndexMethode:(UIButton *)button {
    if ([_alertDelegate respondsToSelector:@selector(MHWAlertView:clickedButtonAtIndex:)]) {
        [_alertDelegate MHWAlertView:self clickedButtonAtIndex:button.tag];
    }
    
    if (blocks.count >= button.tag) {
        dispatch_block_t block = [blocks objectAtIndex:button.tag];
        if (block) {
            block();
        }
    }
    if (dismissAction != NULL) {
        dismissAction();
    }
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [self setKeepInMemory:nil];
    
    [self removeFromSuperview];
    
}

#pragma mark - ccalert work
//#TODO: we are supporting it only for 2 button, more buttons will break its UI
- (void) addButtonWithTitle: (NSString*) title block: (dispatch_block_t) block
{
    totalbuttoncount = 2;
    if (!block) block = ^{};
    
    NSInteger count = 0;
    for (UIButton *button in [viewPopup subviews]) {
        if ([button isKindOfClass:[UIButton class]]) {
            count+=1;
        }
    }
    
    NSAssert(count < 2, @"this functionality does not support more than 2 buttons");
    
    UIButton *button = [[UIButton alloc]init];
    int y = 0;
    if (count < 2) {
        //button already exists
        y = labelMessage.frame.origin.y+labelMessage.frame.size.height+15;
    }
    if (count == 0) {
        button = [self addButtons:title withStyle:AlertButtonStyleHalfLeft atYOrigin:y];
        button.tag = 0;
    }
    else{
        button = [self addButtons:title withStyle:AlertButtonStyleHalfRight atYOrigin:y];
        button.tag = 1;
    }
    [viewPopup addSubview:button];
    [blocks addObject:[block copy]];
    
    y += button.frame.size.height+10;
    CGRect frame        = viewPopup.frame;
    frame.size.height   = y;
    viewPopup.frame     = frame;
    viewPopup.center    = self.center;
}

@end
