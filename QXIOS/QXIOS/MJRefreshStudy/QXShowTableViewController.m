//
//  QXShowTableViewController.m
//  QXIOS
//
//  Created by 新然 on 2017/5/15.
//  Copyright © 2017年 com.wrqx. All rights reserved.
//

#import "QXShowTableViewController.h"
#import "UIViewController+OptionsMethod.h"
#import "QXMJRefreshStudyMainControllerTableViewController.h"
#import "MJRefresh.h"
#import "QXRefreshGifHeader.h"
#import "QXCustomRefreshHeader.h"
#import "QXRefreshAutoGifFooter.h"
#import "QXRefreshBackGifFooter.h"
#import "QXCustomAutoFooter.h"
#import "QXCustomBackStateFooter.h"
/**
 * 随机数据
 */
#define QXRandomData [NSString stringWithFormat:@"列表数据---%d", arc4random_uniform(1000000)]
@interface QXShowTableViewController ()

@property(nonatomic,copy)NSMutableArray<NSString*> *data;

@end

@implementation QXShowTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    
    UIButton *buton=[[UIButton alloc]initWithFrame:CGRectMake(100, 100, 100, 60)];
    buton.backgroundColor=[UIColor redColor];
    [buton setTitle:@"点击" forState:UIControlStateNormal];
    [buton addTarget:self action:@selector(toback:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:buton];

    MJPerformSelectorLeakWarning([self performSelector:NSSelectorFromString(self.method) withObject:nil]);
}
-(void)toback:(id)sender{

    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Incomplete implementation, return the number of sections
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of rows
    return [self data].count;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
static NSString* ID=@"cell";
    
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:ID];
    
    if(cell==nil){
    
        cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    
    }
    
    cell.textLabel.text=_data[indexPath.row];
    
    
    return cell;

}

-(void)downTableNormal{
    __weak typeof(self)weakSelf=self;
    
    self.tableView.mj_header=[MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakSelf loadNewData];
    }];
     [self.tableView.mj_header beginRefreshing];//开启刷新动作才会去请求刷新


}

-(void)downTableGif{
    
    __weak typeof(self)weakSelf=self;
    
    self.tableView.mj_header=[QXRefreshGifHeader headerWithRefreshingBlock:^{
        [weakSelf loadNewData];
    }];
    [self.tableView.mj_header beginRefreshing];

}

-(void)downTableHideTime{
    
    QXRefreshGifHeader *header=[QXRefreshGifHeader headerWithRefreshingBlock:^{
        [self loadNewData];
    }];
    // 设置自动切换透明度(在导航栏下面自动隐藏)
    header.automaticallyChangeAlpha = YES;
    
    // 隐藏时间
  
    // 设置自动切换透明度(在导航栏下面自动隐藏)
    header.automaticallyChangeAlpha = YES;
    
//    [header setTitle:@"下拉数据就来了" forState:MJRefreshStateIdle];
//    [header setTitle:@"松开数据就来了" forState:MJRefreshStatePulling];
//    [header setTitle:@"数据正在到来" forState:MJRefreshStateRefreshing];
    
    // 设置文字 直接用状态枚举报错 用序号可以
        [header setTitle:@"下拉数据就来了" forState:1];
        [header setTitle:@"松开数据就来了" forState:2];
        [header setTitle:@"数据正在到来" forState:3];
    // 设置字体
    header.stateLabel.font = [UIFont systemFontOfSize:15];
    header.lastUpdatedTimeLabel.font = [UIFont systemFontOfSize:14];
    
    // 设置颜色
    header.stateLabel.textColor = [UIColor redColor];
    header.lastUpdatedTimeLabel.textColor = [UIColor blueColor];
    
    // 隐藏时间
    
    header.lastUpdatedTimeLabel.hidden=YES;
    
    self.tableView.mj_header=header;
    
    [self.tableView.mj_header beginRefreshing];


}

-(void)downTableHideStatus{

    QXRefreshGifHeader *header=[QXRefreshGifHeader headerWithRefreshingBlock:^{
        [self loadNewData];
    }];
    
    header.automaticallyChangeAlpha=YES;
    header.lastUpdatedTimeLabel.hidden=YES;
    header.stateLabel.hidden=YES;
    
    self.tableView.mj_header=header;
    [self.tableView.mj_header beginRefreshing];


}
-(void)downTableCustom{
    __weak typeof(self)weakSelf=self;
    
    self.tableView.mj_header=[QXCustomRefreshHeader headerWithRefreshingBlock:^{
        [weakSelf loadNewData];
    }];
    [self.tableView.mj_header beginRefreshing];
}

-(void)upTableNormal{
    
    __weak typeof(self)weakSelf=self;
    
    //两个都是normol但是效果是不一样的
// self.tableView.mj_footer=[MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
//     [weakSelf loadMoreData];
// }];//footer显示在数据的正下方，跟屏幕的最下方无关 提示点击footer继续加载更多
    self.tableView.mj_footer=[MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        [weakSelf loadMoreData];
    }];//即使是数据不满屏，footer也是显示在屏幕的最下方，刷新完成后会返回上面数据的显示位置
    [self.tableView.mj_footer beginRefreshing];

}

-(void)upTableGif{
     __weak typeof(self)weakSelf=self;

//    self.tableView.mj_footer=[QXRefreshAutoGifFooter footerWithRefreshingBlock:^{
//        [weakSelf loadMoreData];
//    }];//footer显示在数据的正下方，跟屏幕的最下方无关 提示点击footer继续加载更多
    
    self.tableView.mj_footer=[QXRefreshBackGifFooter footerWithRefreshingBlock:^{
        [weakSelf loadMoreData];
    }];//即使是数据不满屏，footer也是显示在屏幕的最下方，刷新完成后会返回上面数据的显示位置

     [self.tableView.mj_footer beginRefreshing];

}

-(void)upTableHideText{
    
    QXRefreshAutoGifFooter *footer=[QXRefreshAutoGifFooter footerWithRefreshingBlock:^{
        [self loadMoreData];
    }];
    
    
    footer.refreshingTitleHidden=YES;
    
    [footer beginRefreshing];
    self.tableView.mj_footer=footer;

}

-(void)upTableComplete{
    
    QXRefreshAutoGifFooter *footer=[QXRefreshAutoGifFooter footerWithRefreshingBlock:^{
        [self loadNoMoreData];
    }];
    

    
    [footer beginRefreshing];
    self.tableView.mj_footer=footer;
    
}

-(void)upTableNoAuto{
    
    MJRefreshAutoNormalFooter *footer=[MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        [self loadMoreData];
    }];
    
    
    footer.automaticallyRefresh=NO;//不让自动加载
    [footer beginRefreshing];
    self.tableView.mj_footer=footer;
    
}
-(void)upTableCustomText{

    MJRefreshAutoNormalFooter *footer=[MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        [self loadMoreData];
    }];
    
    // 设置文字 直接用状态枚举报错 用序号可以
    [footer setTitle:@"Click or drag up to refresh" forState:1];
    [footer setTitle:@"uping ..." forState:2];
    [footer setTitle:@"Loading more ..." forState:3];
    [footer setTitle:@"No more data" forState:5];
    
    // 设置字体
    footer.stateLabel.font = [UIFont systemFontOfSize:17];
    
    // 设置颜色
    footer.stateLabel.textColor = [UIColor blueColor];

    [footer beginRefreshing];
    self.tableView.mj_footer=footer;
}

-(void)upTableCompleteHidde{
    MJRefreshAutoNormalFooter *footer=[MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        [self loadOnlyOnceData];
    }];
    
    // 设置文字 直接用状态枚举报错 用序号可以
    [footer setTitle:@"Click or drag up to refresh" forState:1];
    [footer setTitle:@"uping ..." forState:2];
    [footer setTitle:@"Loading more ..." forState:3];
    [footer setTitle:@"No more data" forState:5];
    
    // 设置字体
    footer.stateLabel.font = [UIFont systemFontOfSize:17];
    
    // 设置颜色
    footer.stateLabel.textColor = [UIColor blueColor];
    
    [footer beginRefreshing];
    self.tableView.mj_footer=footer;

}

-(void)upTableAutoBack1{
    // 设置回调（一旦进入刷新状态，就调用target的action，也就是调用self的loadMoreData方法）
    self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
    // 设置了底部inset
    self.tableView.contentInset = UIEdgeInsetsMake(0, 0, 30, 0);
//    // 忽略掉底部inset
//    self.tableView.mj_footer.ignoredScrollViewContentInsetBottom = 30;
    
    [self.tableView.mj_footer beginRefreshing];


}
//只加载一次
-(void)upTableAutoBack2{
    self.tableView.mj_footer=[QXRefreshBackGifFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadOnlyOnceData)];
    self.tableView.mj_footer.automaticallyChangeAlpha=YES;
    
    [self.tableView.mj_footer beginRefreshing];

}

-(void)upTableCustomAutoRefresh{

    self.tableView.mj_footer=[QXCustomAutoFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
    self.tableView.mj_footer.automaticallyChangeAlpha=YES;
    
    [self.tableView.mj_footer beginRefreshing];
}

-(void)upTableCustomAutoBack{
    self.tableView.mj_footer=[QXCustomBackStateFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
    self.tableView.mj_footer.automaticallyChangeAlpha=YES;
    
    [self.tableView.mj_footer beginRefreshing];


}
-(NSMutableArray*)data{
  if(_data==nil){
        
        _data=[[NSMutableArray alloc] init];
        
        for(int i=0;i<5;i++){
            
            [ _data addObject:QXRandomData];
        
        }
    
    }
    return _data;

}


-(void)loadNewData{
   
    
//    [self.tableView.mj_header setState:MJRefreshStateRefreshing];
    
    for(int i=0;i<5;i++){
        
        [ _data insertObject:QXRandomData atIndex:0];
        
    }
      __weak UITableView *tableView = self.tableView;
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3.0*NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        //模拟3秒网络加载数据的时间
        [ tableView reloadData];
        
        [tableView.mj_header endRefreshing];
        
    });
    
    

}


-(void)loadMoreData{
    for(int i=0;i<5;i++){
        
        [ _data addObject:QXRandomData];
        
    }
    
    __weak UITableView *tableView = self.tableView;
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3.0*NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        //模拟3秒网络加载数据的时间
        [ tableView reloadData];
        
        [tableView.mj_footer endRefreshing];
        
    });
    
    
}
//最后一次没有别的数据了数据已经加载完毕
-(void)loadNoMoreData{
    
    
    //    [self.tableView.mj_header setState:MJRefreshStateRefreshing];
    
    for(int i=0;i<5;i++){
        
        [ _data addObject:QXRandomData];
        
    }
    __weak UITableView *tableView = self.tableView;
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3.0*NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        //模拟3秒网络加载数据的时间
        [ tableView reloadData];
        
        [tableView.mj_footer endRefreshingWithNoMoreData];;
        
    });
    
}

//只让加载一次更多数据然后就隐藏 不让加载了
-(void)loadOnlyOnceData{
    for(int i=0;i<5;i++){
        
        [ _data addObject:QXRandomData];
        
    }
    
    __weak UITableView *tableView = self.tableView;
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3.0*NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        //模拟3秒网络加载数据的时间
        [ tableView reloadData];
        
        [tableView.mj_footer endRefreshing];
        tableView.mj_footer.hidden=YES;
        
    });
    
    
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
