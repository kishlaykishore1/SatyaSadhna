//
//  Constants.h
//  SatyaSadhna
//
//  Created by Roshan Singh Bisht on 22/04/17.
//  Copyright © 2017 Roshan Singh Bisht. All rights reserved.
//

#ifndef Constants_h
#define Constants_h

#define kBaseURL                @"http://satyasadhna.com/managerarea/api/"
#define RGB(r,g,b)                              [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]

#define MainStoryBoard              [UIStoryboard storyboardWithName:@"Main" bundle:nil]
#define SecondStoryBoard            [UIStoryboard storyboardWithName:@"Second" bundle:nil]
#endif /* Constants_h */

#define kCelllColor             RGB(251, 227, 197)
#define kSelectedCellBGColor    RGB(228,78,107)
#define kBgImage            [UIColor colorWithPatternImage:[UIImage imageNamed:@"loginBg"]]
#define kLangualString(msg)       [NSString stringWithFormat:NSLocalizedStringFromTable(msg,[UserDefaultManager getLanguage],nil)]


#define kNewDonationVC          @"NewDonationVC"
#define kPanVc                  @"panViewVC"
#define HistoryVC               @"HistoryVC"
