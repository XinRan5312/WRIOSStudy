//
//  SimpleViewController2.m
//  QXIOS
//
//  Created by 新然 on 2017/5/3.
//  Copyright © 2017年 com.wrqx. All rights reserved.
//

#import "SimpleViewController2.h"
#import "SegueViewController.h"

@interface SimpleViewController2 ()

@end

@implementation SimpleViewController2
- (IBAction)跳转:(id)sender {
    
    
}
//在故事版中用Segue链接的跳转，系统跳转的前会调用这个方法
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    
    NSLog(@"Segue的Indity%@",segue.identifier);
    //要跳转过去的ViewController 也可以通过强转得到真正的ViewController
//    UIViewController *viewController=segue.destinationViewController;
    SegueViewController *viewController=(SegueViewController*)segue.destinationViewController;
    
    [viewController setName:segue.identifier];
  
    viewController.lable.backgroundColor=[UIColor redColor];
    if([sender isKindOfClass:[UILabel class]]){
        UILabel *lable=sender;
        NSLog(@"lable的Text is %@",lable.text);
    }
    
     }
//系统跳转的时候会调用这个方法
-(void)performSegueWithIdentifier:(NSString *)identifier sender:(id)sender{
    //identifier 是在故事版建立链接Segue时指明的Segue的名字
    [super performSegueWithIdentifier:identifier sender:sender];
}

- (void)viewDidLoad {
    [super viewDidLoad];
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

@end
