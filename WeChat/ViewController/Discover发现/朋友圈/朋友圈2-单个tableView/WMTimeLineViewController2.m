//
//  WMTimeLineViewController2.m
//  WeChat
//
//  Created by zhengwenming on 2017/9/21.
//  Copyright © 2017年 zhengwenming. All rights reserved.
//

#import "WMTimeLineViewController2.h"
#import "WMTimeLineHeaderView.h"
#import "CommentCell2.h"
#import "LikeUsersCell2.h"
@interface WMTimeLineViewController2 ()

@end
@implementation WMTimeLineViewController2

-(void)textViewDidSendText:(NSString *)text{
    NSLog(@"%@",text);
}
/**
 键盘的frame改变
 */
- (void)keyboardChangeFrameMinY:(CGFloat)minY{
    
}
#pragma mark
- (void)viewDidLoad {
    [super viewDidLoad];
    [self getTestData2];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableView registerClass:NSClassFromString(@"WMTimeLineHeaderView") forHeaderFooterViewReuseIdentifier:@"WMTimeLineHeaderView"];
    [self registerCellWithClass:@"CommentCell2" tableView:self.tableView];
    [self registerCellWithNib:@"LikeUsersCell2" tableView:self.tableView];
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.dataSource.count;
}
//显示评论的数据
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    MessageInfoModel2 *eachModel = self.dataSource[section];
    return eachModel.commentModelArray.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    MessageInfoModel2 *eachModel = self.dataSource[indexPath.section];
    CommentInfoModel2  *commentModel =  eachModel.commentModelArray[indexPath.row];
    return commentModel.rowHeight;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    MessageInfoModel2 *eachModel = self.dataSource[section];
    return eachModel.headerHeight;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    __weak __typeof(self) weakSelf= self;

    WMTimeLineHeaderView *headerView = (WMTimeLineHeaderView *)[tableView dequeueReusableHeaderFooterViewWithIdentifier:@"WMTimeLineHeaderView"];
    headerView.tapImageBlock = ^(NSInteger index, NSArray *dataSource) {
        WMPhotoBrowser *browser = [WMPhotoBrowser new];
        browser.dataSource = dataSource.mutableCopy;
        browser.currentPhotoIndex = index;
        browser.downLoadNeeded = YES;
        [weakSelf.navigationController pushViewController:browser animated:YES];
//        [weakSelf presentViewController:browser animated:YES completion:^{
//
//        }];
    };
    
    MessageInfoModel2 *eachModel = self.dataSource[section];
    headerView.model = eachModel;
    return headerView;
}
///footer高度
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 10.f;
}
///footerView
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    UIView *footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, 10.f)];
    return footerView;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    MessageInfoModel2 *eachModel = self.dataSource[indexPath.section];
    __weak __typeof(self) weakSelf= self;
    CommentInfoModel2  *commentModel =  eachModel.commentModelArray[indexPath.row];
    if (commentModel.likeUsersArray.count) {
        LikeUsersCell2 *likeUsersCell = (LikeUsersCell2 *)[tableView dequeueReusableCellWithIdentifier:@"LikeUsersCell2"];
        likeUsersCell.model = commentModel;
        return likeUsersCell;
    }else{
        CommentCell2 *cell2 = (CommentCell2 *)[tableView dequeueReusableCellWithIdentifier:@"CommentCell2"];
        cell2.model = commentModel;
        cell2.tapCommentBlock = ^(CommentCell2 *cell, CommentInfoModel2 *model) {
            [weakSelf dealComment];
        };
        return cell2;
    }
}
-(void)dealComment{
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    NSLog(@"%s",__FUNCTION__);
}
-(void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    NSLog(@"%s",__FUNCTION__);
}
@end
