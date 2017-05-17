//
//  QXMJRefreshStudyMainControllerTableViewController.m
//  QXIOS
//
//  Created by 新然 on 2017/5/12.
//  Copyright © 2017年 com.wrqx. All rights reserved.
//

#import "QXMJRefreshStudyMainControllerTableViewController.h"
#import "QXDataModle.h"
#import "MJRefresh.h"
#import "QXShowTableViewController.h"

static NSString *const DATAMODLEONE=@"UITableView下拉刷新";
static NSString *const DATAMODLETWO=@"UITableView上拉加载更多";

@interface QXMJRefreshStudyMainControllerTableViewController ()

@property(nonatomic,copy)NSArray<QXDataModle*> *dataModle;

@end

@implementation QXMJRefreshStudyMainControllerTableViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    [self.navigationItem setTitle:@"MJRefresh演示Two"];
    self.title=@"MJRefresh演示Three";

    [self initTableView];
    
}
-(void)initTableView{
    __unsafe_unretained UITableView *tableView = self.tableView;
 
    
    tableView.mj_header=[MJRefreshNormalHeader headerWithRefreshingBlock:^{
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            //模拟加载数据2秒然后结束刷新
            
            [tableView.mj_header endRefreshing];
            
        });
    }];
    
    tableView.mj_footer=[MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0*NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            
            //模拟网络2秒时间
            
            [tableView.mj_footer endRefreshing];
        
        });
    }];
    [self.tableView.mj_header beginRefreshing];//开启刷新刷新动作 才回去请求刷新啊
    [self.tableView.mj_footer beginRefreshing];//开启刷新动作
    


}
-(NSArray*)dataModle{
    if(!_dataModle){
    
    QXDataModle *downdataTableView=[[QXDataModle alloc] init];
    
    downdataTableView.header=DATAMODLEONE;
        downdataTableView.vcClass=QXShowTableViewController.class;
    
    downdataTableView.titles=@[@"默认下拉刷新",@"有图片下拉刷新",@"去掉时间下拉刷新",@"去掉状态和时间的下拉刷新",@"自定义控件的下拉刷新"];
    downdataTableView.methods=@[@"downTableNormal",@"downTableGif",@"downTableHideTime",@"downTableHideStatus",@"downTableCustom"];
        
        QXDataModle *upData=[[QXDataModle alloc]init];
        
        upData.header=DATAMODLETWO;
        upData.vcClass=QXShowTableViewController.class;
        
        upData.titles=@[@"默认", @"动画图片", @"隐藏刷新状态的文字", @"全部加载完毕没有数据了", @"禁止自动加载", @"自定义文字", @"加载后隐藏", @"自动回弹的上拉01", @"自动回弹的上拉02", @"自定义刷新控件(自动刷新)", @"自定义刷新控件(自动回弹)"];
        upData.methods=@[@"upTableNormal",@"upTableGif",@"upTableHideText",@"upTableComplete",@"upTableNoAuto",@"upTableCustomText",@"upTableCompleteHidde",@"upTableAutoBack1",@"upTableAutoBack2",@"upTableCustomAutoRefresh",@"upTableCustomAutoBack"];
    
        self.dataModle=@[downdataTableView,upData];
    }
    
    return _dataModle;

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    NSLog(@"section=%zd",_dataModle.count);
#warning Incomplete implementation, return the number of sections
    return [self dataModle].count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of rows
    
    NSLog(@"rows=%zd",_dataModle[section].titles.count);
    return _dataModle[section].titles.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *ID = @"mainCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    
    cell.textLabel.text=_dataModle[indexPath.section].titles[indexPath.row];
    
    cell.detailTextLabel.text=[NSString stringWithFormat:@"%@--%@",@"UITableView",_dataModle[indexPath.section].methods[indexPath.row]];
    
    return cell;
}

-(NSString*)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{

    return _dataModle[section].header;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    QXDataModle *modle=_dataModle[indexPath.section];
    
    UIViewController *controller=[[modle.vcClass alloc] init];
    
    NSString *title=modle.titles[indexPath.row];
    
    NSString *method=modle.methods[indexPath.row];
    
    controller.title=title;
    [controller setValue:method forKey:@"method"];
    
    [self presentViewController:controller animated:YES
                     completion:^{
                         NSLog(@"go to true ok");
                     
                     }];

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
