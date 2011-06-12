//
//  Category.h
//  QuickStat
//
//  Created by Shreyans Bhansali on 6/11/11.
//  Copyright (c) 2011 Shreyans Bhansali. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Category : NSManagedObject {
@private
}
@property (nonatomic, retain) NSDate * createdDate;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSSet* stats;

@end
