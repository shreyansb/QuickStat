#import "AddStatViewController.h"
#import "StatTextField.h"

@implementation AddStatViewController

@synthesize categoryName;
@synthesize statName;
@synthesize statValue;

- (void)dealloc
{
    [categoryName release];
    [statName release];
    [statValue release];
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
    [self.view addSubview:saveButton];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
