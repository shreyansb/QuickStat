//
//  Value.h
//  QuickStat
//
//  Created by Shreyans Bhansali on 6/11/11.
//  Copyright (c) 2011 Shreyans Bhansali. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Stat;

@interface Value : NSManagedObject {
@private
}
@property (nonatomic, retain) NSDate * createdDate;
@property (nonatomic, retain) NSString * value;
@property (nonatomic, retain) Stat * stat;

@end
