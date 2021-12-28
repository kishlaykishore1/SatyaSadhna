//
//  PostsVC.h
//  SatyaSadhna
//
//  Created by kishlay kishore on 08/05/21.
//  Copyright © 2021 Roshan Singh Bisht. All rights reserved.
//

#import "SatyaSadhnaViewController.h"

@interface PostsVC: SatyaSadhnaViewController<UITableViewDelegate,UITableViewDataSource> {
    NSArray *postData;
}
@property (weak, nonatomic) IBOutlet UITableView *postsTableView;
@property (nonatomic,strong)NSMutableArray *postName;
@property (nonatomic,strong)NSMutableArray *postDate;
@property (nonatomic,strong)NSMutableArray *postImage;
@property (nonatomic,strong)NSMutableArray *postId;

@end
