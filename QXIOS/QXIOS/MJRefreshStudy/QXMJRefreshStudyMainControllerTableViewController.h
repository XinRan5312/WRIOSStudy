//
//  QXMJRefreshStudyMainControllerTableViewController.h
//  QXIOS
//
//  Created by 新然 on 2017/5/12.
//  Copyright © 2017年 com.wrqx. All rights reserved.
//

#import <UIKit/UIKit.h>

#define MJPerformSelectorLeakWarning(Stuff) \
do { \
_Pragma("clang diagnostic push") \
_Pragma("clang diagnostic ignored \"-Warc-performSelector-leaks\"") \
Stuff; \
_Pragma("clang diagnostic pop") \
} while (0)

@interface QXMJRefreshStudyMainControllerTableViewController : UITableViewController

@end
