//
//  NSObject+Swizzling.m
//  ZYBase
//
//  Created by MAC on 2017/5/6.
//  Copyright © 2017年 Mzywx. All rights reserved.
//

#import "NSObject+Swizzling.h"
#import <objc/runtime.h>
@implementation NSObject (Swizzling)

+(void)load{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Class class = [self class];
        
        SEL originalSelector = @selector(valueForUndefinedKey:);
        SEL swizzledSelector = @selector(noCrashValueForUndefinedKey:);
        
        Method originalMethod = class_getInstanceMethod(class, originalSelector);
        Method swizzledMethod = class_getInstanceMethod(class, swizzledSelector);

        method_exchangeImplementations(originalMethod, swizzledMethod);
    });
}

#pragma mark - Method Swizzling

/**
 kvc防止崩溃处理
 
 @param key 不存在的key
 @return 错误信息
 */
-(id)noCrashValueForUndefinedKey:(NSString *)key{
    NSLog(@"key不存在");
    return @"The key doesn't exist";
}

@end
