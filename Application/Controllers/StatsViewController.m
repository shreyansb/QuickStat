#import "StatsViewController.h"
#import "AddStatViewController.h"
#import "Stat.h"

@implementation StatsViewController

@synthesize fetchedResultsController;
@synthesize managedObjectContext;

#pragma mark NSObject

- (void)dealloc
{
	[fetchedResultsController release];
    [managedObjectContext release];
    [super dealloc];
}

#pragma mark UIViewController

- (void)viewDidUnload
{
	[super viewDidUnload];	
	self.fetchedResultsController = nil;	
}

- (void)viewDidLoad
{
    UIBarButtonItem *button = [[UIBarButtonItem alloc] 
                               initWithBarButtonSystemItem:UIBarButtonSystemItemAdd 
                               target:self action:@selector(addStat)];
    self.navigationItem.rightBarButtonItem = button;
    [button release];
    
    [self fetchStats];
}

#pragma mark StatsViewController

- (void)addStat
{
    // push the add stat view controller
    AddStatViewController *addStat = [[AddStatViewController alloc] init];
    addStat.managedObjectContext = managedObjectContext;
    [self.navigationController pushViewController:addStat animated:YES];
    [addStat release];
}

- (void)fetchStats {
    if (fetchedResultsController) return;
    
    // Fetch 20 latest stats.
	// Create and configure a fetch request.
	NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
	NSEntityDescription *entity =
    [NSEntityDescription entityForName:@"Stat"
                inManagedObjectContext:managedObjectContext];
	fetchRequest.entity = entity;
    
	NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc]
                                        initWithKey:@"name"
//                                        initWithKey:@"values.@max.createdDate"
                                        ascending:NO];
	NSArray *sortDescriptors = [[NSArray alloc] initWithObjects:sortDescriptor, nil];
	[sortDescriptor release];
	fetchRequest.sortDescriptors = sortDescriptors;
	[sortDescriptors release];
	
	// Create and initialize the fetchedResultsController.
	fetchedResultsController =
    [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest
                                        managedObjectContext:managedObjectContext
                                          sectionNameKeyPath:nil // create 1 section
                                                   cacheName:@"Stat"];
	[fetchRequest release];
	fetchedResultsController.delegate = self;
	
	NSError *error;
	if (![fetchedResultsController performFetch:&error]) {
		// TODO: Handle the error appropriately.
		NSLog(@"fetch stats error %@, %@", error, [error userInfo]);
	}
}

// Configure the cell to show the name of user.
- (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath {
    Stat *stat = [fetchedResultsController objectAtIndexPath:indexPath];
    NSString *categoryStat = [[NSString alloc] initWithFormat:@"%@ > %@",
                              stat.category, stat.name];
    cell.textLabel.text = categoryStat;
    [categoryStat release];
//    cell.detailTextLabel.text = @"whatever";
}

#pragma mark UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [[fetchedResultsController fetchedObjects] count];
}

// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"StatsCell";    
    UITableViewCell *cell =
    (UITableViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (!cell) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                       reuseIdentifier:CellIdentifier] autorelease];
	}
	[self configureCell:cell atIndexPath:indexPath];
    return cell;
}

#pragma mark UITableViewDelegate

//- (void)thumbsTableViewCell:(ThumbsTableViewCell *)cell didSelectUser:(User *)user {
//    PhotoViewController *photoViewController = [[PhotoViewController alloc] init];
//    photoViewController.user = user;
//	[self.navigationController pushViewController:photoViewController animated:YES];
//	[photoViewController release];
//}


#pragma mark - NSFetchedResultsControllerDelegate

- (void)controllerWillChangeContent:(NSFetchedResultsController *)controller
{
    [self.tableView beginUpdates];
}


- (void)controller:(NSFetchedResultsController *)controller
  didChangeSection:(id <NSFetchedResultsSectionInfo>)sectionInfo
           atIndex:(NSUInteger)sectionIndex
     forChangeType:(NSFetchedResultsChangeType)type
{
    switch(type)
    {
        case NSFetchedResultsChangeInsert:
            [self.tableView insertSections:[NSIndexSet indexSetWithIndex:sectionIndex]
                          withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        case NSFetchedResultsChangeDelete:
            [self.tableView deleteSections:[NSIndexSet indexSetWithIndex:sectionIndex]
                          withRowAnimation:UITableViewRowAnimationFade];
            break;
    }
}

- (void)controller:(NSFetchedResultsController *)controller
   didChangeObject:(id)anObject
       atIndexPath:(NSIndexPath *)indexPath
     forChangeType:(NSFetchedResultsChangeType)type
      newIndexPath:(NSIndexPath *)newIndexPath
{
    UITableView *tableView = self.tableView;
    
    switch(type)
    {
        case NSFetchedResultsChangeInsert:
            [tableView insertRowsAtIndexPaths:[NSArray arrayWithObject:newIndexPath]
                             withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        case NSFetchedResultsChangeDelete:
            [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath]
                             withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        case NSFetchedResultsChangeUpdate:
            [self configureCell:[tableView cellForRowAtIndexPath:indexPath]
                    atIndexPath:indexPath];
            break;
    }
}

- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller
{
    [self.tableView endUpdates];
}

@end
