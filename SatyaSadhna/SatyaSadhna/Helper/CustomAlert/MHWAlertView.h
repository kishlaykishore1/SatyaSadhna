//
//  MHWAlertView.h
//  MobileHealthWallete
//
//  Created by Jogendar on 18/05/16.
//  Copyright © 2016 Ranosys. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef NS_ENUM(NSInteger, AlertButtonStyle) {
    AlertButtonStyleHalfLeft,
    AlertButtonStyleHalfRight,
    AlertButtonStyleFullWidth
};


@protocol MHWAlertDelegate;

@interface MHWAlertView : UIView
@property (nonatomic, assign) id<MHWAlertDelegate>             alertDelegate;
@property(copy) dispatch_block_t dismissAction;

- (instancetype)initWithTitle:(NSString *)title message:(NSString *)message delegate:(id <MHWAlertDelegate>)delegate cancelButtonTitle:(NSString *)cancelButtonTitle otherButtonTitles:(NSString *)otherButtonTitles, ... NS_REQUIRES_NIL_TERMINATION NS_EXTENSION_UNAVAILABLE_IOS("Use UIAlertController instead.");

// shows popup alert animated.
- (void)show;

- (id) initWithTitle: (NSString*) title message: (NSString*) message delegate:(id)delegate;
- (void) addButtonWithTitle: (NSString*) title block: (dispatch_block_t) block;
@end
@protocol MHWAlertDelegate <NSObject>
@optional

// Called when a button is clicked. The view will be automatically dismissed after this call returns
- (void)MHWAlertView:(MHWAlertView *)mhwAlertView clickedButtonAtIndex:(NSInteger)buttonIndex;

@end