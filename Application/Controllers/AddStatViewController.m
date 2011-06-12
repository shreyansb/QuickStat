#import "AddStatViewController.h"
#import "StatTextField.h"
#import "NSManagedObject+QuickStat.h"
#import "Category.h"
#import "Stat.h"
#import "Value.h"

@implementation AddStatViewController

@synthesize categoryName;
@synthesize statName;
@synthesize statValue;

@synthesize managedObjectContext;


- (void)dealloc
{
    [categoryName release];
    [statName release];
    [statValue release];
    
    [managedObjectContext release];
    [super dealloc];
}

#pragma mark UIViewController

- (void)viewDidUnload
{
    // Release any retained subviews of the main view.
    self.categoryName = nil;
    self.statName = nil;
    self.statValue = nil;
    [super viewDidUnload];
}

// Implement viewDidLoad to do additional setup after loading the view
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor lightGrayColor];
    
    categoryName = [[StatTextField alloc] initWithFrame:
                    CGRectMake(self.view.center.x-100.0f, 10.0f, 200.0f, 30.0f)
                                            placeholder:@"Category"];
    [categoryName becomeFirstResponder];
    [self.view addSubview:categoryName];
    
    statName = [[StatTextField alloc] initWithFrame:
                    CGRectMake(self.view.center.x-100.0f, 60.0f, 200.0f, 30.0f)
                                            placeholder:@"Stat name"];
    [self.view addSubview:statName];
    
    statValue = [[StatTextField alloc] initWithFrame:
                    CGRectMake(self.view.center.x-100.0f, 110.0f, 200.0f, 30.0f)
                                            placeholder:@"Value"];
    [self.view addSubview:statValue];
    
    // autoreleased
    UIButton *saveButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    saveButton.frame = CGRectMake(self.view.center.x-100.0f, 160.0f, 200.0f, 30.0f);
    [saveButton setTitle:NSLocalizedString(@"Save", nil) forState:UIControlStateNormal];
    [saveButton addTarget:self action:@selector(saveStat) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:saveButton];
}

#pragma mark AddStatViewController

- (void)saveStat
{
    NSDate *now = [[NSDate alloc] init];
    
    // get the category object by name
    Category *category = (Category *)[Category findByAttribute:@"name" value:(id)categoryName.text
              inManagedObjectContext:managedObjectContext];
    // if it doesn't exist, create the category with this name
    if (!category) {
        category = (Category *)[Category insertInToManagedObjectContext:managedObjectContext];
        category.name = categoryName.text;
        category.createdDate = now;
    }
    // get the stat object by name
    Stat *stat = (Stat *)[Stat findByAttribute:@"name" value:(id)statName.text
       inManagedObjectContext:managedObjectContext];
    // if it doesn't exist, create the stat with this name, and connect to category
    if (!stat) {
        stat = (Stat *)[Stat insertInToManagedObjectContext:managedObjectContext];
        stat.name = statName.text;
        stat.category = category;
    }
    // create a new value and connect it to the stat
    Value *value = (Value *)[Value insertInToManagedObjectContext:managedObjectContext];
    value.value = statValue.text;
    value.createdDate = now;
    value.stat = stat;
    
    [now release];

    NSLog(@"Category: %@", category);
    NSLog(@"Stat: %@", stat);
    NSLog(@"Value: %@", value);
    
    NSError *error;
    if (![managedObjectContext save:&error])
    {
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
    } 

}

@end
