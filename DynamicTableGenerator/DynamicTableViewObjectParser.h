//
//  MutableTableViewSetupHelper.h
//  TableViewDataCells
//
//  Created by Theodore Brown on 8/10/14.
//  Copyright (c) 2014 Theodore Brown. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

#import "ActionSheetOptionCellInput.h"
/**
DTV_ObjectParser takes a NSObject or NSManagedObject and builds an array of BaseOptionCellInput instances to fill in the data in the object
 
 The parsed array must be passed to DTV_CellManager
 
 */

@interface DynamicTableViewObjectParser : NSObject

@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, retain) NSArray *pListPropertyArray;

@property (nonatomic, retain) NSDictionary *attributeNameMapDict;
@property (nonatomic, retain) NSArray *targetAttributeNameList;

@property (nonatomic, retain) NSArray *cellsArray; //main array of input info for each attriute int he given object

@property (nonatomic, retain) NSManagedObject *NewFormClass;
@property (weak, nonatomic) id mutableFormObject; // this is the object that is managed and updated

- (id) initWithObject:(id)newFormObject;
- (id) initWithObject:(id)newFormObject andSettingsPlist:(NSString*)settingsPlistPath;

- (id) initWithManagedObject:(id)newFormObject;
- (id) initWithDict:(id)newFormObject;

@end

