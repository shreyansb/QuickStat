#import "Stat.h"
#import "Value.h"
#import "NSManagedObject+QuickStat.h"

@implementation Stat
@dynamic name;
@dynamic category;
@dynamic values;


+ (Stat *)findStatWithName:(NSString *)name 
                  category:(NSString *)category
    inManagedObjectContext:(NSManagedObjectContext *)context {

    NSPredicate *predicate = [NSPredicate predicateWithFormat:
                              @"name == %@ AND category == %@", name, category];
    return (Stat *)[NSManagedObject firstWithPredicate:predicate 
                        inManagedObjectContext:context];
}

+ (Stat *)addStatWithName:(NSString *)name 
                 category:(NSString *)category
                    value:(NSString *)value 
   inManagedObjectContext:(NSManagedObjectContext *)context {
    NSDate *now = [[NSDate alloc] init];
    
    Stat *stat = [self findStatWithName:name 
                               category:category 
                 inManagedObjectContext:context];
    
    if (!stat) {
        stat = (Stat *)[Stat 
                        insertInToManagedObjectContext:context];
        stat.name = name;
        stat.category = category;
    } 
    
    // create a new value
    Value *newValue = (Value *)[Value 
                                insertInToManagedObjectContext:context];
    newValue.value = value;
    newValue.createdDate = now;
    newValue.stat = stat;
    
    [stat addValuesObject:newValue];
    
    [now release];    
    
    // try to save the context, and show an alert if the save fails
    NSError *error;
    if (![context save:&error])
    {
        NSString *errorString = [[NSString alloc] 
                                 initWithFormat:@"%@, %@", error, error.userInfo];
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Save Error" 
                                                        message:errorString 
                                                       delegate:nil 
                                              cancelButtonTitle:@"OK" 
                                              otherButtonTitles:nil];
        [errorString release];
        [alert show];
        [alert release];
    } 
    
    return stat;
}

- (void)addValuesObject:(Value *)value {    
    NSSet *changedObjects = [[NSSet alloc] initWithObjects:&value count:1];
    [self willChangeValueForKey:@"values" withSetMutation:NSKeyValueUnionSetMutation usingObjects:changedObjects];
    [[self primitiveValueForKey:@"values"] addObject:value];
    [self didChangeValueForKey:@"values" withSetMutation:NSKeyValueUnionSetMutation usingObjects:changedObjects];
    [changedObjects release];
}

- (void)removeValuesObject:(Value *)value {
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
