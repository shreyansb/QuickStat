@class StatTextField;

@interface AddStatViewController : UIViewController {
    
}

@property (nonatomic, retain) StatTextField *categoryName;
@property (nonatomic, retain) StatTextField *statName;
@property (nonatomic, retain) StatTextField *statValue;

@property (nonatomic, copy) NSString *category;
@property (nonatomic, copy) NSString *name;

@property (nonatomic, retain) NSManagedObjectContext *managedObjectContext;

- (void)saveStat;

@end
