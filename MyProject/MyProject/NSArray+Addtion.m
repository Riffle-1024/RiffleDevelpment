//
//  NSArray+Addtion.m
//  MyProject
//
//  Created by liuyalu on 2021/10/13.
//

#import "NSArray+Addtion.h"

@implementation NSArray (Addtion)

- (id)objectAtIndexCheck:(NSUInteger)index
{
    if (![self isKindOfClass:[NSArray class]]) {
        return nil;
    }
    if (index >= self.count) {
        return nil;
    }
    
    id object = [self objectAtIndex:index];
    if ([object isEqual:[NSNull null]]) {
        return nil;
    }
    return object;
}

@end
