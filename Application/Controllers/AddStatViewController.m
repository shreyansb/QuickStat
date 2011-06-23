#import "AddStatViewController.h"
#import "StatTextField.h"
#import "NSManagedObject+QuickStat.h"
#import "Stat.h"
#import "Value.h"

@implementation AddStatViewController

@synthesize categoryName;
@synthesize statName;
@synthesize statValue;

@synthesize category;
@synthesize name;

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
    categoryName.text = category;
    [self.view addSubview:categoryName];
    
    statName = [[StatTextField alloc] initWithFrame:
                    CGRectMake(self.view.center.x-100.0f, 60.0f, 200.0f, 30.0f)
                                            placeholder:@"Stat name"];
    statName.text = name;
    [self.view addSubview:statName];
    
    statValue = [[StatTextField alloc] initWithFrame:
                    CGRectMake(self.view.center.x-100.0f, 110.0f, 200.0f, 30.0f)
                                            placeholder:@"Value"];
    [self.view addSubview:statValue];
    
    if (category && name) {
        [statValue becomeFirstResponder];
    } else {
        [categoryName becomeFirstResponder];
    }
    
    // autoreleased
    UIButton *saveButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    saveButton.frame = CGRectMake(self.view.center.x-100.0f, 160.0f, 200.0f, 30.0f);
    [saveButton setTitle:NSLocalizedString(@"Save", nil) 
                forState:UIControlStateNormal];
    [saveButton addTarget:self action:@selector(saveStat) 
         forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:saveButton];
}

#pragma mark AddStatViewController

- (void)saveStat
{
    Stat *stat = [Stat addStatWithName:statName.text 
                              category:categoryName.text 
                                 value:statValue.text 
                inManagedObjectContext:managedObjectContext];
    
    [self.navigationController popViewControllerAnimated:YES];
    
    stat.name;
    NSLog(@"Stat: %@", stat);
    
    NSLog(@"Stat name: %@", stat.name);
    NSLog(@"Stat category: %@", stat.category);
    NSLog(@"Stat value any: %@", [stat.values anyObject]);
    NSLog(@"Stat value all: %@", [stat.values allObjects]);
}

@end
