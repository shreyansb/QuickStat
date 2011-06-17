@interface NSManagedObject(QuickStat)

+ (NSString *)entityName;
+ (NSEntityDescription *)entityInManagedObjectContext:(NSManagedObjectContext *)context;
+ (NSManagedObject *)insertInToManagedObjectContext:(NSManagedObjectContext *)context;
+ (NSManagedObject *)firstInManagedObjectContext:(NSManagedObjectContext *)context;
+ (NSManagedObject *)findByAttribute:(NSString *)attribute value:(NSString *)value
			  inManagedObjectContext:(NSManagedObjectContext *)context;
+ (NSManagedObject *)firstWithPredicate:(NSPredicate *)predicate 
                 inManagedObjectContext:(NSManagedObjectContext *)context;

@end
