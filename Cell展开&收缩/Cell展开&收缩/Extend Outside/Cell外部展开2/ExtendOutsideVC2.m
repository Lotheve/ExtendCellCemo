//
//  ExtendOutsideVC2.m
//  Cell展开&收缩
//
//  Created by 卢旭峰 on 16/3/28.
//  Copyright © 2016年 卢旭峰. All rights reserved.
//

#import "ExtendOutsideVC2.h"
#import "OriginalCell.h"
#import "ExtendCell.h"
#import "NewsModel.h"
#import "UITableView+FDTemplateLayoutCell.h"

@interface ExtendOutsideVC2 ()

@property (weak, nonatomic) IBOutlet UITableView *tableMain;
@property (nonatomic, strong) NSMutableArray *dataSource;

@end

@implementation ExtendOutsideVC2

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.dataSource = [NSMutableArray array];
    NewsModel *new1 = [[NewsModel alloc]init];
    NewsModel *new2 = [[NewsModel alloc]init];
    NewsModel *new3 = [[NewsModel alloc]init];
    new1.title = @"86年硬币值12万 分币也已达上千身价";
    new1.content = @"86年硬币值12万，分币也已达上千身价。日前，一条关于硬币身价暴涨的微博在网络热传，该微博提到硬分币界的“五大天王”和“四小龙”，它们身价暴涨，主要是因为发行规模小，主要是作为收藏品馈赠外宾，所以国内基本没有。而86年的1元硬币则已经升值到12万元，但也是有钱也难买到。";
    new2.title = @"iPhone4/5s获救 苹果火速推iOS 9.3修正";
    new2.content = @"　在iPhone SE发布的当天，苹果推送了新版的iOS 9.3系统，新增加的一些功能像Night Shift等都让很多人在第一时间升级。不过随之而来的却是坏消息，很多人表示通过OTA升级后，系统无法激活，反映该问题的主要集中在iPad 2、iPad Air、iPhone 4S、5等用户上。";
    new3.title = @"路由器被蹭网后，我有被黑的风险吗？";
    new3.content = @"最近路由安全沸沸扬扬，可以翻阅我微信公众号历史文章查看关于路由安全的文章以及央视当时的采访。鉴于天时地利人和，最后我成功的在现实生活中上演了这样一场精彩好戏，为了满足众人的欲望，我就写成故事。大家好好琢磨琢磨蹭网之后，我们还能做些什么？";
    [self.dataSource addObject:new1];
    [self.dataSource addObject:new2];
    [self.dataSource addObject:new3];
    
    self.tableMain.tableFooterView = [[UIView alloc]init];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableViewDelegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.dataSource.count;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NewsModel *model = self.dataSource[indexPath.section];
    if (indexPath.row == 0) {
        return [tableView fd_heightForCellWithIdentifier:@"identiferidOriginalCell" configuration:^(id cell) {
            OriginalCell *originalCell = (OriginalCell *)cell;
            originalCell.labelTitle.text = model.title;
        }];
    }else{
        if (model.isExtend) {
            return [tableView fd_heightForCellWithIdentifier:@"identiferidExtendCell" configuration:^(id cell) {
                ExtendCell *extendCell = (ExtendCell *)cell;
                extendCell.labelContent.text = model.content;
            }];
        }else{
            return 0;
        }
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NewsModel *model = self.dataSource[indexPath.section];
    if (indexPath.row == 0) {
        static  NSString  *identiferidOriginalCell = @"identiferidOriginalCell";
        OriginalCell *cell = [tableView dequeueReusableCellWithIdentifier:identiferidOriginalCell];
        cell.labelTitle.text = model.title;
        return cell;
    }else{
        static  NSString  *identiferidExtendCell = @"identiferidExtendCell";
        ExtendCell *cell = [tableView dequeueReusableCellWithIdentifier:identiferidExtendCell];
        cell.labelContent.text = model.content;
        return cell;
    }
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    //点击效果取消
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    if (indexPath.row == 0) {
        NewsModel *model = self.dataSource[indexPath.section];
        model.isExtend = !model.isExtend;
        [self.tableMain beginUpdates];
        [self.tableMain endUpdates];
    }
}

@end
