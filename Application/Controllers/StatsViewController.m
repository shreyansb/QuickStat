#import "StatsViewController.h"
#import "AddStatViewController.h"

@implementation StatsViewController

@synthesize managedObjectContext;

#pragma mark NSObject

- (void)dealloc
{
    [managedObjectContext release];
    [super dealloc];
}

#pragma mark UIViewController

- (void)viewDidLoad
{
    UIBarButtonItem *button = [[UIBarButtonItem alloc] 
                               initWithBarButtonSystemItem:UIBarButtonSystemItemAdd 
                               target:self action:@selector(addStat)];
    self.navigationItem.rightBarButtonItem = button;
    [button release];
}

#pragma mark StatsViewController

- (void)addStat
{
    // push the add stat view controller
    AddStatViewController *addStat = [[AddStatViewController alloc] init];
    [self.navigationController pushViewController:addStat animated:YES];
    [addStat release];
}

@end
