@interface AppDelegate : NSObject <UIApplicationDelegate> {

}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet UINavigationController *navigationController;

@property (nonatomic, retain, readonly)
NSManagedObjectContext *managedObjectContext;
@property (nonatomic, retain, readonly)
NSManagedObjectModel *managedObjectModel;
@property (nonatomic, retain, readonly)
NSPersistentStoreCoordinator *persistentStoreCoordinator;

- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;

@end
