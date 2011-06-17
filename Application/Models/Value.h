@class Stat;

@interface Value : NSManagedObject {
@private
}
@property (nonatomic, retain) NSString * value;
@property (nonatomic, retain) NSDate * createdDate;
@property (nonatomic, retain) Stat * stat;

@end
