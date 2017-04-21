//
//  QXFileManage.m
//  QXIOS
//
//  Created by 新然 on 2017/4/21.
//  Copyright © 2017年 com.wrqx. All rights reserved.
//

#import "QXFileManage.h"
#import <CommonCrypto/CommonDigest.h>//MD5加密系统自带包

@interface Student : NSObject<NSCoding>//对象实现了NSCoding实现下面两个方法，就可以用NSKeydeArchiver和NSKeydeUnarchiver这对类持久化到Document里了

@property(nonatomic,copy)NSString *name;
@property(nonatomic,assign)NSInteger age;

@end

@implementation Student
//当一个对象被写入文件时
-(void)encodeWithCoder:(NSCoder *)aCoder{
    [aCoder encodeObject:self.name forKey:@"name"];
    [aCoder encodeInteger:self.age forKey:@"age"];
    
}
//当一个对象从文件中被读取时

-(nullable instancetype)initWithCoder:(NSCoder *)aDecoder{
    if([super init]){
        self.name=[aDecoder decodeObjectForKey:@"name"];
        self.age=[aDecoder decodeIntegerForKey:@"age"];
    }
    return self;
}

@end


@implementation QXFileManage

static NSString *plistName=@"wr.plist";

//MD5加密

+(NSString*)creatMD5Str:(NSString*) origenStr{
    if(origenStr==nil||origenStr.length==0)return nil;
    const char *cstr=origenStr.UTF8String;
    unsigned char bytes[CC_MD5_DIGEST_LENGTH];
    CC_MD5(cstr, (CC_LONG)strlen(cstr), bytes);
    
    NSMutableString *md5Str=[NSMutableString string];
    
    for(int i=0;i<CC_MD5_DIGEST_LENGTH;i++){
        
        [md5Str appendFormat:@"%02x",bytes[i]];
        
    }
    return md5Str;
}

//MD5加密后的文件拼接名字

+(NSString*)createNewFileName:(NSString*) fileName{
    if(fileName==nil||fileName.length==0)return nil;
    
    NSString* extensionStr=fileName.pathExtension;
    if(extensionStr.length){
        return [NSString stringWithFormat:@"%@.%@",[self creatMD5Str:fileName],extensionStr];
    }else{
        
        return [self creatMD5Str:fileName];
    }
    
}
//获取缓存文件目录
+(NSString*)createCacheFile{
    
    NSFileManager *fileManager=[NSFileManager defaultManager];
    __block NSString *cacheFile;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if(!cacheFile){
            NSString *cacheDir=NSHomeDirectory();
            cacheFile=[cacheDir stringByAppendingPathComponent:@"WRCacheFile"];
        }
        BOOL b=[fileManager createDirectoryAtPath:cacheFile withIntermediateDirectories:YES attributes:nil error:nil];
        if(!b){
            NSLog(@"创建文件目录%@失败",cacheFile);
            cacheFile=nil;
        }
    });
    
    return cacheFile;
    
}

//拼接文件路径和文件名字
+(NSString*)contacFileDir:(NSString*) fileDir name:(NSString*) name{
    if(fileDir&&name){
        NSString *filePath=[fileDir stringByAppendingPathComponent:name];
        if(filePath&&![[NSFileManager defaultManager] fileExistsAtPath:filePath isDirectory:true]){
            [[NSFileManager defaultManager] createDirectoryAtPath:filePath withIntermediateDirectories:YES attributes:nil error:nil];
            
        }
        return filePath;
        
    }
    
    return nil;
}

//获取文件大小
+(long long) fileSizeAtDir:(NSString*) filePath{
    unsigned long long fileSize=0;
    if(filePath&&[[NSFileManager defaultManager] fileExistsAtPath:filePath isDirectory:true]){
        
        NSError *error=nil;
        NSDictionary *fileDic=[[NSFileManager defaultManager] attributesOfItemAtPath:filePath error:&error];
        if(!error&&fileDic){
            fileSize=[fileDic fileSize];
        }
    }
    
    return fileSize;
}

//创建输出流
+(NSOutputStream*) creatOutputStreamAtPath:(NSString*)filePath{
    
    NSOutputStream *outPutStream=nil;
    if(filePath){
        outPutStream=[NSOutputStream outputStreamToFileAtPath:filePath append:YES];
        
    }
    
    return outPutStream;
}

+(NSString*)homeDir{
    return NSHomeDirectory();
}
//NSUserDomainMask代表在用户下寻找，Yes表示路径展开显示，如果是No路径就不展开显示，而是显示~
+(NSString*)documentDir{
    NSArray *pathArray=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    return pathArray[0];
}

+(NSString*)libraryDir{
    NSArray *array=NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES);
    return array[0];
}

+(NSString*)cachesDir{
    NSArray *array=NSSearchPathForDirectoriesInDomains(NSCachesDirectory,NSUserDomainMask,YES);
    return array[0];
}
+(NSString*)temperyDir{
    return NSTemporaryDirectory();
}
//plist保存数据
+(void) writeDictionaryToPlist:(NSDictionary*) dic{
    if(dic){
        [dic writeToFile:[[self homeDir] stringByAppendingPathComponent:plistName] atomically:YES];
    }
}

+(NSDictionary*)dictionaryFromPlist{
    return [NSDictionary dictionaryWithContentsOfFile:[[self homeDir]stringByAppendingPathComponent:plistName]];
}

+(void)writeArrayToFile:(NSArray*) array filePath:(NSString*) file{
    if(array){
        [array writeToFile:file atomically:YES];
    }
}

+(NSArray*)arrayFromFile:(NSString*)file{
    return [NSArray arrayWithContentsOfFile:file];
}

//偏好设置，比如用户登录密码，账号，登录状态等用户全局性的变量属性，一般都是保存在偏好设置里
//保存数据
+(void)putUserValue:(id _Nonnull) value forKey:(NSString* _Nonnull)key{
    NSUserDefaults *userDefaults=[NSUserDefaults standardUserDefaults];
    [userDefaults setObject:value forKey:key];
}
//获取数据
+(nonnull id)userValueForKey:(NSString * _Nonnull)key{
    return [[NSUserDefaults standardUserDefaults] objectForKey:key];
}

//如果需要直接保存自定义的对象到Document就需要用到NSKeydeArchiver和NSKeydeUnarvhiver这对类，
//而且自定义的类要实现NSCoding协议，并实现它的方法
//保存对象
+(BOOL)keydeArchiverObject:(id _Nonnull) obj fileName:(NSString* _Nonnull) name{
    return  [NSKeyedArchiver archiveRootObject:obj toFile:[[self homeDir] stringByAppendingPathComponent:name]];
}

//读取对象

+(nonnull id)unKeydeArchiverObjFromFileName:(NSString* _Nonnull)fileName{
    return [NSKeyedUnarchiver unarchiveObjectWithFile:[[self homeDir] stringByAppendingPathComponent:fileName]];
}
@end
