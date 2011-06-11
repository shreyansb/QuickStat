//
//  QuickStatAppDelegate.h
//  QuickStat
//
//  Created by Shreyans Bhansali on 6/11/11.
//  Copyright 2011 Venmo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface QuickStatAppDelegate : NSObject <UIApplicationDelegate> {

}

@property (nonatomic, retain) IBOutlet UIWindow *window;

@property (nonatomic, retain, readonly) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, retain, readonly) NSManagedObjectModel *managedObjectModel;
@property (nonatomic, retain, readonly) NSPersistentStoreCoordinator *persistentStoreCoordinator;

- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;

@end
