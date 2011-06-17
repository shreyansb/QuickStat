#import "NSManagedObject+QuickStat.h"

@implementation NSManagedObject (QuickStat)

+ (NSString *)entityName {
    return NSStringFromClass([self class]);
}

+ (NSEntityDescription *)entityInManagedObjectContext:(NSManagedObjectContext *)context {
    return [NSEntityDescription entityForName:self.entityName inManagedObjectContext:context];
}

+ (NSManagedObject *)insertInToManagedObjectContext:(NSManagedObjectContext *)context {
    return [NSEntityDescription insertNewObjectForEntityForName:self.entityName
                                         inManagedObjectContext:context];
}

+ (NSManagedObject *)firstWithPredicate:(NSPredicate *)predicate 
                 inManagedObjectContext:(NSManagedObjectContext *)context {
	NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
	[fetchRequest setEntity:[NSEntityDescription entityForName:@"Stat"
                                        inManagedObjectContext:context]];
    [fetchRequest setFetchLimit:1];
	[fetchRequest setPredicate:predicate];
    
    NSError *error;
	NSArray *fetchedObjects = [context executeFetchRequest:fetchRequest error:&error];
	[fetchRequest release];
	if (fetchedObjects == nil) {
		NSLog(@"Fetch sender error %@, %@", error, [error userInfo]);
		return nil;
	} else if ([fetchedObjects count] > 0) {
		return [fetchedObjects objectAtIndex:0];
	}
	return nil;
}

+ (NSManagedObject *)firstInManagedObjectContext:(NSManagedObjectContext *)context {
	NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
	[fetchRequest setEntity:[self entityInManagedObjectContext:context]];
    [fetchRequest setFetchLimit:1];
    
    NSError *error;
	NSArray *fetchedObjects = [context executeFetchRequest:fetchRequest error:&error];
	[fetchRequest release];
	if (fetchedObjects == nil) {
		NSLog(@"Fetch sender error %@, %@", error, [error userInfo]);
		return nil;
	} else if ([fetchedObjects count] > 0) {
		return [fetchedObjects objectAtIndex:0];
	}
	return nil;
}

+ (NSManagedObject *)findByAttribute:(NSString *)attribute value:(id)value
              inManagedObjectContext:(NSManagedObjectContext *)context {
	NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
	[fetchRequest setEntity:[self entityInManagedObjectContext:context]];
    
	NSPredicate *predicate = [NSPredicate predicateWithFormat:@"%K == %@", attribute, value];
	[fetchRequest setPredicate:predicate];
    
	NSError *error;
	NSArray *fetchedObjects = [context executeFetchRequest:fetchRequest error:&error];
	[fetchRequest release];
	if (fetchedObjects == nil) {
		NSLog(@"Fetch sender error %@, %@", error, [error userInfo]);
		return nil;
	} else if ([fetchedObjects count] > 0) {
		return [fetchedObjects objectAtIndex:0];
	}
	return nil;	
}

@end
