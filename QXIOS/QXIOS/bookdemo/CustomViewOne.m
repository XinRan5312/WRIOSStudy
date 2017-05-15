//
//  CustomViewOne.m
//  QXIOS
//
//  Created by 新然 on 2017/5/5.
//  Copyright © 2017年 com.wrqx. All rights reserved.
//

#import "CustomViewOne.h"

@implementation CustomViewOne

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
     NSLog(@"CustomViewOne&touchesBegan");
    
    //我要做的事儿做完了给我的上游去响应事件去
    
    [super touchesBegan:touches withEvent:event];

}

-(void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    NSLog(@"CustomViewOne&touchesMoved");
    UITouch *touch=[touches anyObject];
    CGPoint startP=[touch locationInView:self];
    CGPoint  endP=[touch previousLocationInView:self];
    
    self.transform=CGAffineTransformTranslate(self.transform, endP.x-startP.x, endP.y-startP.y);
    
}


@end
