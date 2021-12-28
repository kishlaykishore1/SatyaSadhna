//
//  PostsVC.m
//  SatyaSadhna
//
//  Created by kishlay kishore on 08/05/21.
//  Copyright © 2021 Roshan Singh Bisht. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PostsVC.h"
#import "HomeService.h"
#import <UIKit/UIKit.h>
#import "UIImageView+AFNetworking.h"
#import "PostDisplayVC.h"

@implementation PostsVC

- (void)viewDidLoad {
  [super viewDidLoad];
  [self.view addSubview:activityIndicatorView];
  [self getdata];
}

- (void)viewWillAppear:(BOOL)animated {
  self.addLeftBarBarBackButtonEnabled = YES;
  [self.view setBackgroundColor:kBgImage];
  self.view.layer.contents = (id)[UIImage imageNamed:@"loginBg"].CGImage;
  self.navigationItem.title = kLangualString(@"Post");
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
  return [postData count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
  static NSString *postTableIdentifier = @"PostDataCell";
  
  UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:postTableIdentifier];
  if (cell == nil) {
    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:postTableIdentifier];
  }
  UIView *view = (UIView *)[cell.contentView viewWithTag:4];
  view.layer.cornerRadius = 8.0;
  UIImageView *image = (UIImageView *)[cell.contentView viewWithTag:1];
  image.layer.cornerRadius = image.frame.size.height / 2;
  image.contentMode = UIViewContentModeScaleAspectFit;
 // [image setImageWithURL:[_postImage objectAtIndex:indexPath.row] placeholderImage:[UIImage imageNamed:@"logo"]];
  UILabel *nameLabel = (UILabel *)[cell.contentView viewWithTag:2];
  [nameLabel setText:[_postName objectAtIndex:indexPath.row]];
  UILabel *dateLabel = (UILabel *)[cell.contentView viewWithTag:3];
  [dateLabel setText:[_postDate objectAtIndex:indexPath.row]];
  return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
  return 84;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
  PostDisplayVC *vc = [MainStoryBoard instantiateViewControllerWithIdentifier:@"PostDisplayVC"];
  vc.postListID = [_postId objectAtIndex:indexPath.row];
  vc.isFromView = @"post";
  [self.navigationController pushViewController:vc animated:YES];
}

- (void)getdata{
  [activityIndicatorView  startAnimating];
  [mserviceHandler.homeService postAllData:^(id response) {
    postData = response;
    _postName = [NSMutableArray new];
    _postImage = [NSMutableArray new];
    _postDate = [NSMutableArray new];
    _postId = [NSMutableArray new];
    for (NSDictionary *dict in postData) {
      [_postName addObject:dict[@"title"]];
      [_postImage addObject:dict[@"post_file_hi"]];
      [_postDate addObject:dict[@"createdAt"]];
      [_postId addObject:dict[@"id"]];
    }
    [_postsTableView reloadData];
    [activityIndicatorView  stopAnimating];
  } failure:^(NSError *error) {
    [activityIndicatorView  stopAnimating];
  }];
}



@end

