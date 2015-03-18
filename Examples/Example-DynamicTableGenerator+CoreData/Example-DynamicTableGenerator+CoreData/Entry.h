//
//  Entry.h
//  Example-DynamicTableGenerator+CoreData
//
//  Created by tpb on 3/17/15.
//  Copyright (c) 2015 DirectDiagnostics. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Entry : NSManagedObject

@property (nonatomic, retain) NSString * address;
@property (nonatomic, retain) NSNumber * age;
@property (nonatomic, retain) NSDate * birthday__dtd;
@property (nonatomic, retain) NSString * email__e;
@property (nonatomic, retain) NSString * first_name;
@property (nonatomic, retain) NSString * last_name;
@property (nonatomic, retain) NSString * phone_number__p;
@property (nonatomic, retain) NSDate * timeStamp;
@property (nonatomic, retain) NSNumber * vip__b;

@end
