//
//  CellWithAbstractActionSheet.m
//  CoreDataTest
//
//  Created by Theodore Brown on 12/11/13.
//  Copyright (c) 2013 Theodore Brown. All rights reserved.
//

#import "CellWithAbstractActionSheet.h"
#import "FetchedResultsHelper.h"
#import "ActionSheetStringPicker.h"
//#import "UserInfo.h"
//#import "TestInfo.h"
//#import "FishTank.h"
@implementation CellWithAbstractActionSheet


@synthesize delegate = _delegate;
@synthesize objectIDarray;
@synthesize title = _title;
@synthesize subTitle = _subTitle;
@synthesize actionButon = _actionButon;
@synthesize actionSheetPicker = _actionSheetPicker;
@synthesize selectedIndex, fetchedResults;
@synthesize actionSheetView;
@synthesize actionSheetArray, actionSheetPredicate;
@synthesize arrayEntity, arrayEntitySortValue;
@synthesize predicateObject, predicateString, compoundPredicateArray;
-(NSString *) reuseIdentifier {
    return @"ActionSheetCellID";
}


- (IBAction)selectItem:(UIControl *)sender {
    [self getUserData];
    if ([self.actionSheetArray count] != 0){
        [ActionSheetStringPicker showPickerWithTitle:@"Select Default User" rows:self.actionSheetArray initialSelection:self.selectedIndex target:self successAction:@selector(itemWasSelected:element:) cancelAction:@selector(actionPickerCancelled:) origin:sender];
    }
    self.actionSheetPicker.hideCancel = NO;
    [self.actionSheetPicker  setPickerView:self.actionSheetView];
    NSLog(@"Picker View set");
    [self.actionSheetPicker showActionSheetPicker];
}

- (void)itemWasSelected:(NSNumber *)selectedIndex1 element:(id)element {
    NSLog(@"Object was selected at index: %@", [selectedIndex1 description]);

    self.selectedIndex = [selectedIndex1 intValue];
    
    NSObject * pickedObject = [self.fetchedResults objectAtIndex:self.selectedIndex];
    NSLog(@"Picked Object Descrioption %@", [pickedObject description]);

    NSURL *pickedObjectIDURL = [[self.objectIDarray objectAtIndex:self.selectedIndex] URIRepresentation];
    NSArray *predicateArray = [NSArray arrayWithObject:self.actionSheetPredicate];
    [self.actionButon setTitle:[pickedObject valueForKey:self.arrayEntitySortValue] forState:UIControlStateNormal];
    [self.delegate cellAbstractActionSheetPickerDidChange:self.indexPath withPredicateArray:predicateArray withURL:pickedObjectIDURL];
//    [self.delegate cellAbstractActionSheetPickerDidChange:self.actionButon.tag withPredicateArray:predicateArray :pickedObject];
}
-(void) setCompoundPredicate:(NSArray*) predicateArray{
    NSPredicate *compoundPredicate
    = [NSCompoundPredicate andPredicateWithSubpredicates:predicateArray];
    self.actionSheetPredicate = compoundPredicate;
}
-(void) setRealPredicate:(NSString*) pString withObject:(NSObject*)pObject{
    self.actionSheetPredicate = [NSPredicate predicateWithFormat:pString, pObject];
}

-(void) setTitleFromID:(NSURL*)objectURL{
    NSObject * pObject = [[FetchedResultsHelper getInstance] getObjectFromID:objectURL];
    [self.actionButon setTitle:[pObject valueForKey:self.arrayEntitySortValue] forState:UIControlStateNormal];

}
-(void) addCompoundPredicateFromString:(NSString*) pString withObjectURL:(NSURL*)objectURL{
    NSObject * pObject = [[FetchedResultsHelper getInstance] getObjectFromID:objectURL];
    NSPredicate *newPredicate;
    if ([pString  isEqual: @"selectedTest"]){
        NSString *testType = [pObject valueForKey:@"testType"];
        newPredicate =  [NSPredicate predicateWithFormat:pString, testType];
    }
    else{
       newPredicate =  [NSPredicate predicateWithFormat:pString, pObject];

    };
    [self.compoundPredicateArray addObject:newPredicate];
}
-(void)setPredicateFromCompoundArray{
    NSPredicate *compoundPredicate
    = [NSCompoundPredicate andPredicateWithSubpredicates:[NSArray arrayWithArray:self.compoundPredicateArray]];
    self.actionSheetPredicate = compoundPredicate;
}

-(void) setRealPredicate:(NSString*) pString withObjectID:(NSURL*)objectURL{
    NSObject * pObject = [[FetchedResultsHelper getInstance] getObjectFromID:objectURL];
    self.actionSheetPredicate = [NSPredicate predicateWithFormat:pString, pObject];
}
-(void) getUserData{
    self.fetchedResults = [[FetchedResultsHelper getInstance] fetchResultsFromEntityWithIDs:[self.arrayEntity description] withRealPredicate:self.actionSheetPredicate sortByKey:self.arrayEntitySortValue];
    NSLog(@"Fetched results returned as %@" , [self.fetchedResults description]);
    NSMutableArray  *tempArray = [[NSMutableArray alloc] init ];
    NSMutableArray  *tempIDS = [[NSMutableArray alloc] init ];

    for (NSObject * U in self.fetchedResults)
    {
        NSManagedObjectID *newID =[U valueForKey:@"objectID"];
        //NSLog(@"ObjectID found as %@", [U valueForKey:@"objectID"]);
        NSString *sortKey = [U valueForKey:self.arrayEntitySortValue];
        if (![tempArray containsObject:sortKey]) {
            [tempArray addObject:sortKey];
            [tempIDS addObject:newID];
            NSLog(@"Object found description found as %@", [U description]);

        }
    }
    self.actionSheetArray = [[[NSArray alloc] initWithArray:tempArray] copy ];
    self.objectIDarray = [[[NSArray alloc] initWithArray:tempIDS] copy ];
    NSLog(@"Returnd from search: %@" , self.actionSheetArray);
}

-(void) setActionSheetView: (UIView*) newview
{
    NSLog(@"actionSheetView View called with %@" ,[newview description]);
    NSLog(@" View changed from   %@" ,[self.actionSheetView description]);
    
    if (self.actionSheetView == nil){
        NSLog(@"actionSheetView does not exist yet");
        
        self.actionSheetView = newview;
        NSLog(@"actionSheetView View set");
    }
    
    
}

- (void)actionPickerCancelled:(id)sender {
    NSLog(@"Delegate has been informed that ActionSheetPicker was cancelled");
}
@end







