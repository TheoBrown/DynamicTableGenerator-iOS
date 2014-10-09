//
//  FetchedResultsHelper.m
//  CoreDataTest
//
//  Created by Theodore Brown on 11/24/13.
//  Copyright (c) 2013 Theodore Brown. All rights reserved.
//

#import "FetchedResultsHelper.h"
#import "AppDelegate.h"
#import "SharedData.h"

@interface FetchedResultsHelper()
-(NSArray *)fetchResultsFromEntity: (NSString *)entityName withPredicate:(NSString*)myPredicate sortByKey:(NSString*)sortkey;
-(NSArray *)fetchResultsFromEntity: (NSString *)entityName withRealPredicate:(NSPredicate*)myPredicate sortByKey:(NSString*)sortkey;
-(NSArray *)fetchResultsFromEntityWithIDs: (NSString *)entityName withPredicate:(NSString*)myPredicate sortByKey:(NSString*)sortkey;
-(NSArray *)fetchResultsFromEntityWithIDs: (NSString *)entityName withRealPredicate:(NSPredicate*)myPredicate sortByKey:(NSString*)sortkey;
-(NSObject *) getObjectFromID:(NSURL*) objectID;
@end


@implementation FetchedResultsHelper
static FetchedResultsHelper *instance =nil;

#pragma mark - Singleton methods
/**
 * Singleton methods
 */
-(FetchedResultsHelper*)init {
    NSLog(@"FetchedResultsHelper init");
    
    //call super init
    self = [super init];
    if (self != nil) {
        //initialize the object
        NSLog(@"This should only happen once: init");
            self.managedObjectContext = [(AppDelegate*)[[UIApplication sharedApplication] delegate] managedObjectContext];
        
    }
    return self;
}

+(FetchedResultsHelper *)getInstance
{
    @synchronized(self)
    {
        if(instance==nil)
        {
            
            instance= [FetchedResultsHelper new];
        }
    }
    return instance;
}

#pragma mark - delegate methods

-(NSObject *) getObjectFromID:(NSURL*) objectID {
    //    NSURL *moIDURL =  [[[SharedData getInstance] settings] URLForKey:@"defaultUserID"];
    NSManagedObjectID *moID = [[(AppDelegate*)[[UIApplication sharedApplication] delegate] persistentStoreCoordinator] managedObjectIDForURIRepresentation:objectID];
    if (moID != nil){
        NSObject * newObject = (NSObject *)[self.managedObjectContext existingObjectWithID:moID error:nil];
        return newObject;
    }
    else {
        return nil;
    }
}

-(NSArray *)fetchResultsFromEntity: (NSString *)entityName withRealPredicate:(NSPredicate*)myPredicate sortByKey:(NSString*)sortkey
{
    NSLog(@"Searching for Predicate %@", myPredicate);
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSLog(@"Context: %@", self.managedObjectContext);
    
    NSEntityDescription *entity = [NSEntityDescription entityForName:entityName inManagedObjectContext:self.managedObjectContext];
    [fetchRequest setEntity:entity];
    [fetchRequest setFetchBatchSize:20];
    
    [fetchRequest setPredicate:myPredicate];
    
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:sortkey ascending:YES];
    [fetchRequest setSortDescriptors:[NSArray arrayWithObject:sortDescriptor]];
    NSError *error = nil;
    NSArray *dataArray = [self.managedObjectContext executeFetchRequest:fetchRequest error:&error];
    return dataArray;
}
-(NSArray *)fetchResultsFromEntity: (NSString *)entityName withPredicate:(NSString*)myPredicate sortByKey:(NSString*)sortkey
{
//    @"(lastname != nil)"
    NSLog(@"Searching for Predicate %@", myPredicate);
    NSPredicate *predicate = [NSPredicate predicateWithFormat:myPredicate];
    
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSLog(@"Context: %@", self.managedObjectContext);
    
    NSEntityDescription *entity = [NSEntityDescription entityForName:entityName inManagedObjectContext:self.managedObjectContext];
    [fetchRequest setEntity:entity];
    [fetchRequest setFetchBatchSize:20];
    
    [fetchRequest setPredicate:predicate];
    
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:sortkey ascending:YES];
    [fetchRequest setSortDescriptors:[NSArray arrayWithObject:sortDescriptor]];
    NSError *error = nil;
    NSArray *dataArray = [self.managedObjectContext executeFetchRequest:fetchRequest error:&error];
    return dataArray;
    
}
-(NSArray *)fetchResultsFromEntityWithIDs: (NSString *)entityName withPredicate:(NSString*)myPredicate sortByKey:(NSString*)sortkey
{
    NSExpressionDescription* objectIdDesc = [NSExpressionDescription new];
    objectIdDesc.name = @"objectID";
    objectIdDesc.expression = [NSExpression expressionForEvaluatedObject];
    objectIdDesc.expressionResultType = NSObjectIDAttributeType;
    

    //    @"(lastname != nil)"
    NSLog(@"Searching for Predicate %@", myPredicate);
    NSPredicate *predicate = [NSPredicate predicateWithFormat:myPredicate];
    
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSLog(@"Context: %@", self.managedObjectContext);
    [fetchRequest setPropertiesToFetch:[NSArray arrayWithObjects:objectIdDesc, nil]];
    NSEntityDescription *entity = [NSEntityDescription entityForName:entityName inManagedObjectContext:self.managedObjectContext];
    [fetchRequest setEntity:entity];
    [fetchRequest setFetchBatchSize:20];
    
    [fetchRequest setPredicate:predicate];
    
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:sortkey ascending:YES];
    [fetchRequest setSortDescriptors:[NSArray arrayWithObject:sortDescriptor]];
    NSError *error = nil;
    NSArray *dataArray = [self.managedObjectContext executeFetchRequest:fetchRequest error:&error];
    return dataArray;
    
}

-(NSArray *)fetchResultsFromEntityWithIDs: (NSString *)entityName withRealPredicate:(NSPredicate*)myPredicate sortByKey:(NSString*)sortkey
{
    NSLog(@"Searching for Predicate %@", myPredicate);
    NSExpressionDescription* objectIdDesc = [NSExpressionDescription new];
    objectIdDesc.name = @"objectID";
    objectIdDesc.expression = [NSExpression expressionForEvaluatedObject];
    objectIdDesc.expressionResultType = NSObjectIDAttributeType;
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSLog(@"Context: %@", self.managedObjectContext);
    
    NSEntityDescription *entity = [NSEntityDescription entityForName:entityName inManagedObjectContext:self.managedObjectContext];
    [fetchRequest setEntity:entity];
    [fetchRequest setFetchBatchSize:20];
    [fetchRequest setPropertiesToFetch:[NSArray arrayWithObjects:objectIdDesc, nil]];
    [fetchRequest setPredicate:myPredicate];
    
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:sortkey ascending:YES];
    [fetchRequest setSortDescriptors:[NSArray arrayWithObject:sortDescriptor]];
    NSError *error = nil;
    NSArray *dataArray = [self.managedObjectContext executeFetchRequest:fetchRequest error:&error];
    return dataArray;
}
@end
