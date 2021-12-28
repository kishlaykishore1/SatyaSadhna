//
//  RegisterPageOneViewController.h
//  SatyaSadhna
//
//  Created by Roshan Singh Bisht on 21/05/17.
//  Copyright © 2017 Roshan Singh Bisht. All rights reserved.
//

#import "SatyaSadhnaViewController.h"

@interface RegisterPageOneViewController : SatyaSadhnaViewController
@property (weak, nonatomic) IBOutlet UITextField *nameTextField;
@property (weak, nonatomic) IBOutlet UITextField *fathertextField;
@property (nonatomic, strong) NSDictionary *dict;
@property (strong, nonatomic)NSDictionary   *allDataDict;
@end
