#import "AddStatViewController.h"
#import "StatTextField.h"
#import "NSManagedObject+QuickStat.h"
#import "Stat.h"
#import "Value.h"

@implementation AddStatViewController

@synthesize categoryInput;
@synthesize nameInput;
@synthesize valueInput;

@synthesize category;
@synthesize name;

@synthesize managedObjectContext;


- (void)dealloc
{
    [categoryInput release];
    [nameInput release];
    [valueInput release];
    
    [managedObjectContext release];
    [super dealloc];
}

#pragma mark UIViewController

- (void)viewDidUnload
{
    // Release any retained subviews of the main view.
    self.categoryInput = nil;
    self.nameInput = nil;
    self.valueInput = nil;
    [super viewDidUnload];
}

// Implement viewDidLoad to do additional setup after loading the view
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor lightGrayColor];
    
    categoryInput = [[StatTextField alloc] initWithFrame:
                    CGRectMake(self.view.center.x-100.0f, 10.0f, 200.0f, 30.0f)
                                            placeholder:@"Category"];
    categoryInput.text = category;
    categoryInput.returnKeyType = UIReturnKeyNext;
    categoryInput.delegate = self;
    [self.view addSubview:categoryInput];
    
    nameInput = [[StatTextField alloc] initWithFrame:
                    CGRectMake(self.view.center.x-100.0f, 60.0f, 200.0f, 30.0f)
                                            placeholder:@"Stat name"];
    nameInput.text = name;
    nameInput.returnKeyType = UIReturnKeyNext;
    nameInput.delegate = self;
    [self.view addSubview:nameInput];
    
    valueInput = [[StatTextField alloc] initWithFrame:
                    CGRectMake(self.view.center.x-100.0f, 110.0f, 200.0f, 30.0f)
                                            placeholder:@"Value"];
    valueInput.returnKeyType = UIReturnKeyDone;
    valueInput.delegate = self;
    [self.view addSubview:valueInput];
    
    if (category && name) {
        [valueInput becomeFirstResponder];
    } else {
        [categoryInput becomeFirstResponder];
    }
//    
//    // autoreleased
//    UIButton *saveButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
//    saveButton.frame = CGRectMake(self.view.center.x-100.0f, 160.0f, 200.0f, 30.0f);
//    [saveButton setTitle:NSLocalizedString(@"Save", nil) 
//                forState:UIControlStateNormal];
//    [saveButton addTarget:self action:@selector(saveStat) 
//         forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:saveButton];
}

#pragma mark AddStatViewController

- (void)saveStat
{
    Stat *stat = [Stat addStatWithName:nameInput.text 
                              category:categoryInput.text 
                                 value:valueInput.text 
                inManagedObjectContext:managedObjectContext];
    
    [self.navigationController popViewControllerAnimated:YES];
    
    stat.name;
    NSLog(@"Stat: %@", stat);
    NSLog(@"Stat name: %@", stat.name);
    NSLog(@"Stat category: %@", stat.category);
    NSLog(@"Stat value any: %@", [stat.values anyObject]);
    NSLog(@"Stat value all: %@", [stat.values allObjects]);
}

#pragma mark UITextFieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField 
{
    if (textField == categoryInput) {
        [categoryInput resignFirstResponder];
        [nameInput becomeFirstResponder];
    } else if (textField == nameInput) {
        [nameInput resignFirstResponder];
        [valueInput becomeFirstResponder];
    } else if (textField == valueInput) {
        [valueInput resignFirstResponder];
        [self saveStat];
    }
}

@end
