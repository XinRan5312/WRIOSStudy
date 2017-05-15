//
//  QXDataModle.h
//  QXIOS
//
//  Created by 新然 on 2017/5/12.
//  Copyright © 2017年 com.wrqx. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface QXDataModle : NSObject

@property (copy, nonatomic) NSString *header;
@property (copy, nonatomic) NSArray *titles;
@property (copy, nonatomic) NSArray *methods;
@property (strong, nonatomic) Class vcClass;


@end
