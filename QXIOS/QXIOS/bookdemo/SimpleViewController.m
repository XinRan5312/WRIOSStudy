//
//  SimpleViewController.m
//  QXIOS
//
//  Created by 新然 on 2017/5/3.
//  Copyright © 2017年 com.wrqx. All rights reserved.
//

#import "SimpleViewController.h"

@interface SimpleViewController ()

@end

@implementation SimpleViewController

- (IBAction)hightLing:(id)sender {
    
    if([sender isKindOfClass:[UIButton class]]){
        UIButton *b=sender;
    
        NSLog(@"button的Text是%@",b.titleLabel.text);
    }
    [_btn setShowsTouchWhenHighlighted:YES];//点击按下的时候按钮会发光
    UIStoryboard *storyBord=[UIStoryboard storyboardWithName:@"bookdemo" bundle:nil];
    UIViewController *viewController=[storyBord instantiateViewControllerWithIdentifier:@"simple2"];
    [self presentViewController:viewController animated:YES completion:nil];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
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
