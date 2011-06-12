//
//  Stat.m
//  QuickStat
//
//  Created by Shreyans Bhansali on 6/11/11.
//  Copyright (c) 2011 Shreyans Bhansali. All rights reserved.
//

#import "Stat.h"
#import "Category.h"


@implementation Stat
@dynamic name;
@dynamic category;
@dynamic values;


- (void)addValuesObject:(NSManagedObject *)value {    
    NSSet *changedObjects = [[NSSet alloc] initWithObjects:&value count:1];
    [self willChangeValueForKey:@"values" withSetMutation:NSKeyValueUnionSetMutation usingObjects:changedObjects];
    [[self primitiveValueForKey:@"values"] addObject:value];
    [self didChangeValueForKey:@"values" withSetMutation:NSKeyValueUnionSetMutation usingObjects:changedObjects];
    [changedObjects release];
}

- (void)removeValuesObject:(NSManagedObject *)value {
    NSSet *changedObjects = [[NSSet alloc] initWithObjects:&value count:1];
    [self willChangeValueForKey:@"values" withSetMutation:NSKeyValueMinusSetMutation usingObjects:changedObjects];
    [[self primitiveValueForKey:@"values"] removeObject:value];
    [self didChangeValueForKey:@"values" withSetMutation:NSKeyValueMinusSetMutation usingObjects:changedObjects];
    [changedObjects release];
}

- (void)addValues:(NSSet *)value {    
    [self willChangeValueForKey:@"values" withSetMutation:NSKeyValueUnionSetMutation usingObjects:value];
    [[self primitiveValueForKey:@"values"] unionSet:value];
    [self didChangeValueForKey:@"values" withSetMutation:NSKeyValueUnionSetMutation usingObjects:value];
}

- (void)removeValues:(NSSet *)value {
    [self willChangeValueForKey:@"values" withSetMutation:NSKeyValueMinusSetMutation usingObjects:value];
    [[self primitiveValueForKey:@"values"] minusSet:value];
    [self didChangeValueForKey:@"values" withSetMutation:NSKeyValueMinusSetMutation usingObjects:value];
}


@end
