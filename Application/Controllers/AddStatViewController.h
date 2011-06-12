@class StatTextField;

@interface AddStatViewController : UIViewController {
    
}

@property (nonatomic, retain) StatTextField *categoryName;
@property (nonatomic, retain) StatTextField *statName;
@property (nonatomic, retain) StatTextField *statValue;

@property (nonatomic, retain) NSManagedObjectContext *managedObjectContext;

- (void)saveStat;

@end
