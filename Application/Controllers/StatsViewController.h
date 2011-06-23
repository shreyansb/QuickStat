@interface StatsViewController : UITableViewController
<NSFetchedResultsControllerDelegate> {

}

@property (nonatomic, retain) NSFetchedResultsController *fetchedResultsController;
@property (nonatomic, retain) NSManagedObjectContext *managedObjectContext;

- (void)addStat;
- (void)addStatWithCategory:(NSString *)category name:(NSString *)name;
- (void)fetchStats;
- (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath;

@end
