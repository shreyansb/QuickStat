//
//  Stat.h
//  QuickStat
//
//  Created by Shreyans Bhansali on 6/11/11.
//  Copyright (c) 2011 Shreyans Bhansali. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Category;

@interface Stat : NSManagedObject {
@private
}
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) Category * category;
@property (nonatomic, retain) NSSet* values;

@end
