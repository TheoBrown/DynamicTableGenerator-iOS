//
//  TestObject.h
//  DynamicTableGenerator
//
//  Created by Theodore Brown on 10/9/14.
//  Copyright (c) 2014 Theodore Brown. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TestObject : NSObject

@property (strong, nonatomic) NSDate *selectedDate;
@property (nonatomic, retain) NSString *titleObject;

@property (nonatomic, retain) NSDate * birthDate;
@property (nonatomic, retain) NSString * firstName;
@property (nonatomic, retain) NSString * lastName;
@property (nonatomic, retain) NSString * address;
@property (nonatomic, retain) NSDate * arriveTime;
@property (nonatomic, retain) NSDate * departureTime;
@property (nonatomic, retain) NSNumber * age;
@property (nonatomic, retain) NSNumber * organizer;
@property (nonatomic, retain) NSNumber * isGroupMember;
@property (nonatomic, retain) NSNumber * isGroupLeader;
@property (nonatomic, retain) NSSet *groupMembers;
@end
