//
//  NSObject+Property.m
//  ZYBase
//
//  Created by MAC on 2017/5/8.
//  Copyright © 2017年 Mzywx. All rights reserved.
//

#import "NSObject+Property.h"
#import <objc/runtime.h>

@implementation NSObject (Property)


/**
 获取某个类里面的全部属性

 @param class 传入的类
 @return 属性数组
 */
-(NSArray*)getAllProperty:(Class)class{
    unsigned int count;
    objc_property_t *properties = class_copyPropertyList(class, &count);
    NSMutableArray *propertyArr = [NSMutableArray array];
    for (int i=0; i<count; i++) {
        objc_property_t property = properties[i];
        const char *cName = property_getName(property);
        NSString *name = [NSString stringWithCString:cName encoding:NSUTF8StringEncoding];
        [propertyArr addObject:name];
    }
    return [propertyArr copy];
}

/**
 获取某个类中的全部方法
 
 @param class 传入的类
 @return 方法数组
 */
-(NSArray*)getAllFunction:(Class)class{
    unsigned int count;
    Method *methods = class_copyMethodList(class, &count);
    NSMutableArray *methodArr = [NSMutableArray array];
    for (int i=0; i<count; i++) {
        Method method = methods[i];
        SEL selector = method_getName(method);
        NSString *name = NSStringFromSelector(selector);
        [methodArr addObject:name];
    }
    return [methodArr copy];
}


@end
