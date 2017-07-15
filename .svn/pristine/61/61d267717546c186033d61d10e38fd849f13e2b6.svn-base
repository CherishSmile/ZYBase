//
//  UISearchBar+PlaceholderAlignment.m
//  ZYBase
//
//  Created by MAC on 2017/5/8.
//  Copyright © 2017年 Mzywx. All rights reserved.
//

#import "UISearchBar+PlaceholderAlignment.h"
#import <objc/runtime.h>


static char *align = "alignment";

@implementation UISearchBar (PlaceholderAlignment)

-(void)setIsCenterPlaceholder:(BOOL)isCenterPlaceholder{
    objc_setAssociatedObject(self, &align, @(isCenterPlaceholder), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
    SEL centerSelector = NSSelectorFromString(@"setCenterPlaceholder:");
    if ([self respondsToSelector:centerSelector])
    {
        NSMethodSignature *signature = [[UISearchBar class] instanceMethodSignatureForSelector:centerSelector];
        NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:signature];
        [invocation setTarget:self];
        [invocation setSelector:centerSelector];
        [invocation setArgument:&isCenterPlaceholder atIndex:2];
        [invocation invoke];
    }

}

-(BOOL)isCenterPlaceholder{
    return [objc_getAssociatedObject(self, &align) boolValue];
}


@end
