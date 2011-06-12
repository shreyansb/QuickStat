//
//  Category.m
//  QuickStat
//
//  Created by Shreyans Bhansali on 6/11/11.
//  Copyright (c) 2011 Shreyans Bhansali. All rights reserved.
//

#import "Category.h"


@implementation Category
@dynamic createdDate;
@dynamic name;
@dynamic stats;

- (void)addStatsObject:(NSManagedObject *)value {    
    NSSet *changedObjects = [[NSSet alloc] initWithObjects:&value count:1];
    [self willChangeValueForKey:@"stats" withSetMutation:NSKeyValueUnionSetMutation usingObjects:changedObjects];
    [[self primitiveValueForKey:@"stats"] addObject:value];
    [self didChangeValueForKey:@"stats" withSetMutation:NSKeyValueUnionSetMutation usingObjects:changedObjects];
    [changedObjects release];
}

- (void)removeStatsObject:(NSManagedObject *)value {
    NSSet *changedObjects = [[NSSet alloc] initWithObjects:&value count:1];
    [self willChangeValueForKey:@"stats" withSetMutation:NSKeyValueMinusSetMutation usingObjects:changedObjects];
    [[self primitiveValueForKey:@"stats"] removeObject:value];
    [self didChangeValueForKey:@"stats" withSetMutation:NSKeyValueMinusSetMutation usingObjects:changedObjects];
    [changedObjects release];
}

- (void)addStats:(NSSet *)value {    
    [self willChangeValueForKey:@"stats" withSetMutation:NSKeyValueUnionSetMutation usingObjects:value];
    [[self primitiveValueForKey:@"stats"] unionSet:value];
    [self didChangeValueForKey:@"stats" withSetMutation:NSKeyValueUnionSetMutation usingObjects:value];
}

- (void)removeStats:(NSSet *)value {
    [self willChangeValueForKey:@"stats" withSetMutation:NSKeyValueMinusSetMutation usingObjects:value];
    [[self primitiveValueForKey:@"stats"] minusSet:value];
    [self didChangeValueForKey:@"stats" withSetMutation:NSKeyValueMinusSetMutation usingObjects:value];
}


@end
