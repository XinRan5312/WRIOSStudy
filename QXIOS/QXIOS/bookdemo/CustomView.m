//
//  CustomView.m
//  QXIOS
//
//  Created by 新然 on 2017/5/4.
//  Copyright © 2017年 com.wrqx. All rights reserved.
//

#import "CustomView.h"

@implementation CustomView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    //截胡 就是说我们可以利用UIApplication拦截点击事件，然后分派给其它的对象处理这个点击事件，本来就是它派发的，所以可以返回更改吗  哈哈
    
//    [[UIApplication sharedApplication]sendAction:<#(nonnull SEL)#> to:<#(nullable id)#> from:<#(nullable id)#> forEvent:<#(nullable UIEvent *)#>];
    
    NSLog(@"CustomView&TouchsBeganX:%zd",[[touches anyObject]locationInView:self].x);
    
    //我要做的事儿做完了给我的上游去响应事件去
    
    [super touchesBegan:touches withEvent:event];//如果自己做完了响应不想上游也响应就别调用这个

}

-(void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    NSLog(@"touchesMoved");
    UITouch *touch=[touches anyObject];
    CGPoint startP=[touch locationInView:self];
    CGPoint  endP=[touch previousLocationInView:self];
   
    self.transform=CGAffineTransformTranslate(self.transform, endP.x-startP.x, endP.y-startP.y);

}


-(void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    NSLog(@"touchesEnded");

}

-(void)touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    NSLog(@"touchesCancelled");

}

//重写hitTest: withEvent:
-(UIView*)hitTest:(CGPoint)point withEvent:(UIEvent *)event{
    
    //    BOOL b=[self pointInside:point withEvent:event];
    //    if(b==NO){
    //        //如果点击的点不在本View的范围内 本View和它的所有布局View都不会接收到事件
    //
    //        return nil;
    //    }
    //    //如果本View是隐藏的或者是不接收用户交互的或者透明度小于0.01几乎就是完全透明了
    //    //本View和它的所有子View都不会接收到事件
    //
    //    if(self.hidden==YES||self.userInteractionEnabled==NO||self.alpha<0.01)return nil;
    //
    //    //遍历所有的子布局View把事件传递给他们 看看他们有没有愿意接受本事件的
    //
    //    int sonLayCount=(int)self.subviews.count;
    //
    //    //从后向前迭代
    //
    //    for(int i=sonLayCount-1;i>=0;i--){
    //
    //        UIView *sonLayView=self.subviews[i];
    //        //坐标系转换 转换成自布局相对于父布局的坐标点
    //        CGPoint sonLayPoint=[self convertPoint:point toView:sonLayView];
    //
    //        if([sonLayView hitTest:sonLayPoint withEvent:event]){
    //
    //            return sonLayView;
    //        }
    //    }
    //    //如果所有的子布局都不接收这个事件 可以返回自己接受，也可以抛给自己父布局直接返回nil
    //    return self;
    //    return nil;
    
    //上面是系统默认的处理方式 我们也可以重写成如下：无论点击那里都把这个事件传递给这个View的第一个子View
    
    
    return [self subviews][0];
}

@end
