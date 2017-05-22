//
//  QXCollectionViewController.m
//  QXIOS
//
//  Created by 新然 on 2017/5/19.
//  Copyright © 2017年 com.wrqx. All rights reserved.
//

#import "QXCollectionViewController.h"
#import "QXCollectionViewCell.h"
#define WIDTH ([[UIScreen mainScreen] bounds].size.width)
#define HEIGHT ([[UIScreen mainScreen] bounds].size.height)

@interface QXCollectionViewController ()<UICollectionViewDataSource,UICollectionViewDelegate>

@property(nonatomic,strong)UICollectionView *collectionView;

@end

@implementation QXCollectionViewController

- (void)viewDidLoad {

   
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    

    
    UICollectionViewFlowLayout *flowLayout=[[UICollectionViewFlowLayout alloc] init];
    
    flowLayout.minimumInteritemSpacing=8;//两列之间的最小距离
    
    flowLayout.minimumLineSpacing=8;//两行之间的最小距离
    
    _collectionView=[[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, WIDTH*4, 100)collectionViewLayout:flowLayout];
    
    _collectionView.backgroundColor=[UIColor grayColor];
    
    _collectionView.delegate=self;
    
    _collectionView.dataSource=self;
    
    _collectionView.scrollEnabled=YES;
    
    flowLayout.scrollDirection=UICollectionViewScrollDirectionHorizontal;//设置左右滑动
    
    [self.view addSubview:_collectionView];
    
    //注册UICollectionViewCell
    
//    UINib *cellNib=[UINib nibWithNibName:@"CollectionViewCell" bundle:nil];
//    
//    [_collectionView registerNib:cellNib forCellWithReuseIdentifier:@"QXCollectionViewCell"];
    
    [_collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
    
    //注册头部和脚部
    
//    UINib *reusableViewNib=[UINib nibWithNibName:@"CollectionReusableView" bundle:nil];
//    
//    [_collectionView registerNib:reusableViewNib forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"CollectionReusableView"];
//    
//    [_collectionView registerNib:reusableViewNib forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"CollectionReusableView"];
    
    
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{

    return 15;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{

  UICollectionViewCell * cell=  [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    
    UILabel *lable=[[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 60)];
    
    lable.text=[NSString stringWithFormat:@"%zd-%zd",[indexPath section],[indexPath row]];

     [cell addSubview:lable];
        if([indexPath row]%2==0){
        cell.backgroundColor=[UIColor blueColor];
    }else{
        cell.backgroundColor=[UIColor redColor];
    }
    
    return cell;

}

//头部和脚部的加载
-(UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    UICollectionReusableView *view=[collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"CollectionReusableView" forIndexPath:indexPath];
    UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake(110, 20, 100, 30)];
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        label.text=@"头";
    }else{
        label.text=@"脚";
    }
    [view addSubview:label];
    return view;
}
//每一个分组的上左下右间距
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(5, 5, 5, 5);
}
//头部试图的大小
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    return CGSizeMake(50, 60);
}
//脚部试图的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section
{
    return CGSizeMake(50, 60);
}
//定义每一个cell的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(115, 100);
}

//cell的点击事件
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    //cell被电击后移动的动画
    [collectionView selectItemAtIndexPath:indexPath animated:YES scrollPosition:UICollectionViewScrollPositionTop];
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

@end
