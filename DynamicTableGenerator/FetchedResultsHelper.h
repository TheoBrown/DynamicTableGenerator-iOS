//
//  FetchedResultsHelper.h
//  CoreDataTest
//
//  Created by Theodore Brown on 11/24/13.
//  Copyright (c) 2013 Theodore Brown. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FetchedResultsHelper : NSObject
@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;
+(FetchedResultsHelper*)getInstance;
-(NSArray *)fetchResultsFromEntity: (NSString *)entityName withPredicate:(NSString*)myPredicate sortByKey:(NSString*)sortkey;
-(NSArray *)fetchResultsFromEntity: (NSString *)entityName withRealPredicate:(NSPredicate*)myPredicate sortByKey:(NSString*)sortkey;
-(NSArray *)fetchResultsFromEntityWithIDs: (NSString *)entityName withPredicate:(NSString*)myPredicate sortByKey:(NSString*)sortkey;
-(NSArray *)fetchResultsFromEntityWithIDs: (NSString *)entityName withRealPredicate:(NSPredicate*)myPredicate sortByKey:(NSString*)sortkey;
-(NSObject *) getObjectFromID:(NSURL*) objectID;
@end
