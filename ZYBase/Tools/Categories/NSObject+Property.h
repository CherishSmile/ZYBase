//
//  NSObject+Property.h
//  ZYBase
//
//  Created by MAC on 2017/5/8.
//  Copyright © 2017年 Mzywx. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (Property)

/**
 获取某个类里面的全部属性
 
 @param class 传入的类
 @return 属性数组
 */
-(NSArray*)getAllProperty:(Class)class;

/**
 获取某个类中的全部方法
 
 @param class 传入的类
 @return 方法数组
 */
-(NSArray*)getAllFunction:(Class)class;

@end
