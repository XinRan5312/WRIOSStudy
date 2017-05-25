//
//  AppDelegate.m
//  QXIOS
//
//  Created by 新然 on 2017/4/21.
//  Copyright © 2017年 com.wrqx. All rights reserved.
//

#import "AppDelegate.h"
#import "SimpleViewController.h"
#import "QXWindow.h"
#import "QXWebViewController.h"
@interface AppDelegate ()

//一下下个变量都是为了测试UIWindow而自己创建的
@property(strong,nonatomic)UIWindow *normalWindow;
@property(nonatomic,strong)UIWindow *coverStatusBarWindow;
@property(nonatomic,strong)UIWindow *alertLevelWindow;

@end

@implementation AppDelegate




-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    CGPoint p=[[touches anyObject] locationInView:self.inputView];

    NSLog(@"touchsWindowBegain-X=%zd-Y=%zd",p.x,p.y);
}

-(void)coverWindowOnClick{
   
    [[NSNotificationCenter defaultCenter] postNotificationName:@"ClickCoverWindow" object:self userInfo:nil];
    NSLog(@"onClick coverStatusWindow");

}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {

//    [self testUIWindow];
    
    
    return YES;
}

//练习UIWindow的使用和特点
-(void)testUIWindow{
    
    //一个满屏的normal级别的window我们一般会在启动APP做这个工作。给APPDelegate中的window属性初始化，并且让其可见
    
    self.window=[[UIWindow alloc] initWithFrame:[[UIScreen mainScreen]bounds]];
    
    self.window.backgroundColor=[UIColor yellowColor];
    
    self.window.rootViewController=[[QXWebViewController alloc] init];
    
    [self.window makeKeyAndVisible];
    NSLog(@"self.window-one的WindowLevel=%f", [UIApplication sharedApplication].keyWindow.windowLevel);
    
    
    //自己创建一个全屏的window 并且makeKeyAndVisible
    CGSize size=[[UIScreen mainScreen]bounds].size;
    
    _normalWindow=[[UIWindow alloc] initWithFrame:CGRectMake(0, 100, size.width, size.height-100)];
    
    _normalWindow.backgroundColor=[UIColor grayColor];
    _normalWindow.windowLevel=UIWindowLevelNormal;//级别设置为Normal
    _normalWindow.rootViewController=[[UIViewController alloc] init];
    
    UITextField *textFiled=[[UITextField alloc]initWithFrame:CGRectMake(10, 50, 100, 50)];
    
    textFiled.borderStyle=UITextBorderStyleRoundedRect;
    
    [_normalWindow addSubview:textFiled];//因为UIWindow继承UIView
    
    UITapGestureRecognizer *gestureRecongnizer=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(coverWindowOnClick)];
    
    [_normalWindow addGestureRecognizer:gestureRecongnizer];
    
   // [_normalWindow makeKeyAndVisible];//自己让自己设置为keywindow显示
    
    NSLog(@"self.window-two的WindowLevel=%f", [UIApplication sharedApplication].keyWindow.windowLevel);
    
    //定义一个statusBar级别的window
    _coverStatusBarWindow=[[UIWindow alloc] initWithFrame:CGRectMake(0, 100, size.width, 50)];
    
    _coverStatusBarWindow.windowLevel=UIWindowLevelStatusBar;
    
    _coverStatusBarWindow.backgroundColor=[UIColor blueColor];
    
    _coverStatusBarWindow.rootViewController=[[UIViewController alloc] init];
    
    UITextField *text=[[UITextField alloc] initWithFrame:CGRectMake(150, 0, 150, 30)];
    
    text.borderStyle=UITextBorderStyleBezel;
    
    [_coverStatusBarWindow addSubview:text];
    
    UITapGestureRecognizer *ges=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(coverWindowOnClick)];
    
    [_coverStatusBarWindow addGestureRecognizer:ges];
    
    [_coverStatusBarWindow makeKeyAndVisible];
    
    [_normalWindow makeKeyAndVisible];//挡不住_coverStatusBarWindow因为没有人家级别高，最后显示的只能挡住同级别的
    
    //而且不管是哪个window只要是对用户可见，都会相应点击事件
     NSLog(@"self.window-three的WindowLevel=%f", [UIApplication sharedApplication].keyWindow.windowLevel);
    
     NSLog(@"self.windows的%@",[UIApplication sharedApplication].windows);


}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [QXWindow show];
    });
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    // Saves changes in the application's managed object context before the application terminates.
    [self saveContext];
}


#pragma mark - Core Data stack

@synthesize persistentContainer = _persistentContainer;

- (NSPersistentContainer *)persistentContainer {
    // The persistent container for the application. This implementation creates and returns a container, having loaded the store for the application to it.
    @synchronized (self) {
        if (_persistentContainer == nil) {
            _persistentContainer = [[NSPersistentContainer alloc] initWithName:@"QXIOS"];
            [_persistentContainer loadPersistentStoresWithCompletionHandler:^(NSPersistentStoreDescription *storeDescription, NSError *error) {
                if (error != nil) {
                    // Replace this implementation with code to handle the error appropriately.
                    // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                    
                    /*
                     Typical reasons for an error here include:
                     * The parent directory does not exist, cannot be created, or disallows writing.
                     * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                     * The device is out of space.
                     * The store could not be migrated to the current model version.
                     Check the error message to determine what the actual problem was.
                    */
                    NSLog(@"Unresolved error %@, %@", error, error.userInfo);
                    abort();
                }
            }];
        }
    }
    
    return _persistentContainer;
}

#pragma mark - Core Data Saving support

- (void)saveContext {
    NSManagedObjectContext *context = self.persistentContainer.viewContext;
    NSError *error = nil;
    if ([context hasChanges] && ![context save:&error]) {
        // Replace this implementation with code to handle the error appropriately.
        // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
        NSLog(@"Unresolved error %@, %@", error, error.userInfo);
        abort();
    }
}

@end
