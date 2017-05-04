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
    NSLog(@"TouchsBeganX:%zd",[[touches anyObject]locationInView:self].x);

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
@end
