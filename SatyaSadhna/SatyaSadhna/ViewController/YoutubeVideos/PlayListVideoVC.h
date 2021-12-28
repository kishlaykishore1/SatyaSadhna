//
//  PlayListVideoVC.h
//  SatyaSadhna
//
//  Created by kishlay kishore on 18/12/20.
//  Copyright © 2020 Roshan Singh Bisht. All rights reserved.
//

#import "SatyaSadhnaViewController.h"

@interface PlayListVideoVC : SatyaSadhnaViewController<UITableViewDelegate,UITableViewDataSource> {
    NSArray *videoData;
}
@property (weak, nonatomic) IBOutlet UITableView *videoTableView;
@property (nonatomic,strong)NSMutableArray *videoName;
@property (nonatomic,strong)NSMutableArray *videoCount;
@property (nonatomic,strong)NSMutableArray *videoImage;
@property (nonatomic,strong)NSMutableArray *idArray;
@property (nonatomic,strong)NSMutableArray *channel;
@end
