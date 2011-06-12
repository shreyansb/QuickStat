@interface StatsViewController : UITableViewController {
    
}

@property (nonatomic, retain) NSManagedObjectContext *managedObjectContext;

- (void)addStat;

@end
