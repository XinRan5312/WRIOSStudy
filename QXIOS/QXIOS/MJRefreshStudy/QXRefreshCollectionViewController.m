//
//  QXRefreshCollectionViewController.m
//  QXIOS
//
//  Created by 新然 on 2017/5/19.
//  Copyright © 2017年 com.wrqx. All rights reserved.
//

#import "QXRefreshCollectionViewController.h"
#import "UIViewController+OptionsMethod.h"
#import "QXMJRefreshStudyMainControllerTableViewController.h"
#import "MJRefresh.h"
/**
 * 随机色
 */
#define QXRandomColor [UIColor colorWithRed:arc4random_uniform(255)/255.0 green:arc4random_uniform(255)/255.0 blue:arc4random_uniform(255)/255.0 alpha:1]

@interface QXRefreshCollectionViewController ()
@property(nonatomic,copy)NSMutableArray<UIColor*> *colorsArray;
@end

@implementation QXRefreshCollectionViewController

static NSString * const reuseIdentifier = @"Cell";


-(void)downCollectionNormal{
    
    __weak typeof(self)weakSelf=self;

    self.collectionView.mj_header=[MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakSelf loadNewData];
    }];
    [self.collectionView.mj_header beginRefreshing];

}

-(void)loadNewData{
    for(int i=0;i<5;i++){
        
        [_colorsArray insertObject:QXRandomColor atIndex:0];
    }
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.collectionView reloadData];
        [self.collectionView.mj_header endRefreshing];
    });


}


-(NSMutableArray<UIColor*>*)colors{
    if(!_colorsArray){
        NSMutableArray<UIColor*> *colors=[NSMutableArray array];
        
        for(int i=0;i<15;i++){
        
            [colors addObject:QXRandomColor];
        }
        _colorsArray=colors;
    }
    return _colorsArray;
}
//这个必须重写，主要是为了UICollectionViewFlowLayout这个初始化，要么没办法显示
- (instancetype)init
{
    self = [super init];
    if (self) {
        UICollectionViewFlowLayout *flowLayout=[[UICollectionViewFlowLayout alloc] init];
        
        flowLayout.minimumInteritemSpacing=10;//列最小间距
        flowLayout.minimumLineSpacing=10;//行最小间距
        
        flowLayout.itemSize = CGSizeMake(80, 80);
        flowLayout.sectionInset = UIEdgeInsetsMake(20, 20, 20, 20);
       return  [self initWithCollectionViewLayout:flowLayout];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations
    // self.clearsSelectionOnViewWillAppear = NO;
    
    MJPerformSelectorLeakWarning(
                                 [self performSelector:NSSelectorFromString(self.method) withObject:nil];
                                 );
    
    self.collectionView.backgroundColor = [UIColor whiteColor];
    
    // Register cell classes
    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
#warning Incomplete implementation, return the number of sections
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of items
    return [self colors].count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    cell.backgroundColor=_colorsArray[indexPath.row];
    // Configure the cell
    
    return cell;
}

#pragma mark <UICollectionViewDelegate>

/*
// Uncomment this method to specify if the specified item should be highlighted during tracking
- (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath {
	return YES;
}
*/

/*
// Uncomment this method to specify if the specified item should be selected
- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}
*/

/*
// Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
- (BOOL)collectionView:(UICollectionView *)collectionView shouldShowMenuForItemAtIndexPath:(NSIndexPath *)indexPath {
	return NO;
}

- (BOOL)collectionView:(UICollectionView *)collectionView canPerformAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	return NO;
}

- (void)collectionView:(UICollectionView *)collectionView performAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	
}
*/

@end
