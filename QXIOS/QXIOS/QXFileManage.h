//
//  QXFileManage.h
//  QXIOS
//
//  Created by 新然 on 2017/4/21.
//  Copyright © 2017年 com.wrqx. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface QXFileManage : NSObject
//MD5加密

+(NSString*)creatMD5Str:(NSString*) origenStr;


//MD5加密后的文件拼接名字

+(NSString*)createNewFileName:(NSString*) fileName;


//获取缓存文件目录
+(NSString*)createCacheFile;


//拼接文件路径和文件名字
+(NSString*)contacFileDir:(NSString*) fileDir name:(NSString*) name;

//获取文件大小
+(long long) fileSizeAtDir:(NSString*) filePath;

//创建输出流
+(NSOutputStream*) creatOutputStreamAtPath:(NSString*)filePath;

//NSUserDomainMask代表在用户下寻找，Yes表示路径展开显示，如果是No路径就不展开显示，而是显示~
+(NSString*)documentDir;

+(NSString*)homeDir;

+(NSString*)libraryDir;

+(NSString*)cachesDir;

+(NSString*)temperyDir;

//plist保存数据
+(void) writeDictionaryToPlist:(NSDictionary*)dic;

+(NSDictionary*)dictionaryFromPlist;

+(void)writeArrayToFile:(NSArray*) array filePath:(NSString*) file;

+(NSArray*)arrayFromFile:(NSString*)file;

//偏好设置，比如用户登录密码，账号，登录状态等用户全局性的变量属性，一般都是保存在偏好设置里
//保存数据
+(void)putUserValue:(id _Nonnull) value forKey:(NSString* _Nonnull)key;

//获取数据
+(nonnull id)userValueForKey:(NSString * _Nonnull)key;

//如果需要直接保存自定义的对象到Document就需要用到NSKeydeArchiver和NSKeydeUnarvhiver这对类，
//而且自定义的类要实现NSCoding协议，并实现它的方法
//保存对象
+(BOOL)keydeArchiverObject:(id _Nonnull) obj fileName:(NSString* _Nonnull) name;

//读取对象

+(nonnull id)unKeydeArchiverObjFromFileName:(NSString* _Nonnull)fileName;

@end
