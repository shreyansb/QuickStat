@class Value;

@interface Stat : NSManagedObject {
@private
}
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * category;
@property (nonatomic, retain) NSSet* values;
@property (nonatomic, retain) NSDate* updatedDate;
@property (nonatomic, retain) NSString* latestValue;

+ (Stat *)findStatWithName:(NSString *)name 
                  category:(NSString *)category
    inManagedObjectContext:(NSManagedObjectContext *)context;

+ (Stat *)addStatWithName:(NSString *)name 
                 category:(NSString *)category
                    value:(NSString *)value 
   inManagedObjectContext:(NSManagedObjectContext *)context;

- (void)addValuesObject:(Value *)value;

@end
