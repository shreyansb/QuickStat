@class StatTextField;

@interface AddStatViewController : UIViewController <UITextFieldDelegate> {
    
}

@property (nonatomic, retain) StatTextField *categoryInput;
@property (nonatomic, retain) StatTextField *nameInput;
@property (nonatomic, retain) StatTextField *valueInput;

@property (nonatomic, copy) NSString *category;
@property (nonatomic, copy) NSString *name;

@property (nonatomic, retain) NSManagedObjectContext *managedObjectContext;

- (void)saveStat;

@end
