//
//  VideoListVC.h
//  SatyaSadhna
//
//  Created by kishlay kishore on 22/12/20.
//  Copyright © 2020 Roshan Singh Bisht. All rights reserved.
//

#import "SatyaSadhnaViewController.h"

@interface VideoListVC : SatyaSadhnaViewController<UITableViewDelegate,UITableViewDataSource>{
    NSArray *listData;
}
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic,strong)NSMutableArray *videoNameList;
@property (nonatomic,strong)NSMutableArray *videoID;
@property (nonatomic,strong)NSMutableArray *videoImage;
@property (nonatomic,assign) NSNumber *chanelId;
@property (nonatomic,assign) NSString *playListID;

@end
