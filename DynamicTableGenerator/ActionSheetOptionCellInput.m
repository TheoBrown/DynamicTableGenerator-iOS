//
//  ActionSheetOptionCellInput.m
//  TableViewDataCells
//
//  Created by Theodore Brown on 8/9/14.
//  Copyright (c) 2014 Theodore Brown. All rights reserved.
//

#import "ActionSheetOptionCellInput.h"

@implementation ActionSheetOptionCellInput

-(NSString*) cellType {
    return DTVCCellIdentifier_ActionCell;
}

-(id) initActionSheetInputTitled:(NSString*) cellTitle withEntity:(id) managedObjectEntity andSettings:(NSDictionary*) settingsDictionary inSection:(NSString*) newSectionHeader {
    self = [super init];
    if (self) {
        
        NSDictionary* settingsDictionary = @{@"nopredicateString":@"(last_name != nil)",
                                             @"entity":@"UserInfo",
                                             @"entitySortKey":@"last_name",
                                             @"predicateReference":@[@"selectedTest",@"selectedResults"],
                                             @"predicateString":@"(userinfo == %@)",
                                             @"prePredicates":@[@"selectedUser",@"selectedTest"]};
        

        self.noPredicate = settingsDictionary[@"nopredicateString"];
        self.entity = settingsDictionary[@"entity"];
        self.entitySortKey = settingsDictionary[@"entitySortKey"];
        self.predicateReference = settingsDictionary[@"predicateReference"];
        self.predicateString = settingsDictionary[@"predicateString"];
        self.prePredicates = settingsDictionary[@"prePredicates"];
        

        
        
    }
    return self;
}


#pragma mark - editable table cell delegate methods
//-(void) cellAbstractActionSheetPickerDidChange:(NSIndexPath *) cellIndexPath withPredicateArray:(NSArray *)predicateArray :(NSObject *)value{
//    NSLog(@"MasterView Action SHeet %@ , %@", cellIndexPath, [value description]);
//    NSInteger sec = [cellIndexPath section];
//    NSInteger row = [cellIndexPath row];
//    
//    if (self.optionsArray[sec][1][row][@"settings"][@"predicateReference"] != nil)
//    {
//        NSString *refPred = self.optionsArray[sec][1][row][@"settings"][@"predicateReference"];
//        NSLog(@"Updated Preds set for key %@ : to value:%@",refPred,[value description]);
//        [self.updatedPredicates setValue:value forKey:refPred];
//        NSLog(@"Up prefs: %@", [self.updatedPredicates description]);
//    }
//    [self.resultDict setObject:value forKey:[self.optionsArray[sec][1][row] valueForKey:@"return"]];
//    
//    [[[SharedData getInstance] settings] setObject:value forKey:[self.optionsArray[sec][1][row] valueForKey:@"return"]];
//
//    [self.tableView reloadData];
//
//}
//
//
//
//-(void) cellAbstractActionSheetPickerDidChange:(NSIndexPath *) cellIndexPath withPredicateArray:(NSArray *)predicateArray withURL:(NSURL *)value{
//    NSLog(@"MasterView Action SHeet %d , %@", tag, [value description]);
//NSInteger sec = [cellIndexPath section];
//NSInteger row = [cellIndexPath row];
//
//
//
//    if ([self.optionsArray[sec][1][row][@"settings"][@"predicateReference"] containsObject:@"selectedTank"])
//    {
//
//        NSObject * pObject = [[FetchedResultsHelper getInstance] getObjectFromID:value];
//        if ([pObject valueForKey:@"fishtank"]  == nil)
//        {
//            [self.tableView beginUpdates];
//            NSLog(@"Selected Object does not have fish tank, removing from view");
//            NSIndexPath *indexPath = [NSIndexPath indexPathForRow:row inSection:sec];
//            if( !self.fishtankHidden){
//                NSIndexPath *fishtankpath = self.fishTankArray[2];
//
//                NSMutableArray *temparray = [NSMutableArray arrayWithArray:[self.optionsArray mutableCopy]];
//                NSLog(@"mut arra class %@", [temparray class]);
//                NSLog(@"temp array b4 delete %@", [[[[temparray objectAtIndex:fishtankpath.section] objectAtIndex:1] objectAtIndex:fishtankpath.row] description]);
//                NSMutableArray *fishTankSection = [[[temparray objectAtIndex:fishtankpath.section] objectAtIndex:1] mutableCopy];
//                NSMutableArray *fishTankSectionTitle = [[temparray objectAtIndex:fishtankpath.section] mutableCopy];
//                [fishTankSection removeObjectAtIndex:fishtankpath.row];
//                NSLog(@"array removed from section");
//                [fishTankSectionTitle setObject:fishTankSection atIndexedSubscript:1];
//                NSLog(@"section set into title");
//
//                [temparray setObject:fishTankSectionTitle atIndexedSubscript:fishtankpath.section];
//                NSLog(@"title set into options array");
//
//                NSLog(@"temp array after delete %@",[[[[temparray objectAtIndex:fishtankpath.section] objectAtIndex:1] objectAtIndex:fishtankpath.row]description]);
//                [[[SharedData getInstance] settings] setObject:nil forKey:@"selectedTank"];
//                self.fishtankHidden = TRUE;
//                self.optionsArray = nil;
//                self.optionsArray = [NSArray arrayWithArray:temparray];
//                [self.tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath]  withRowAnimation:UITableViewRowAnimationFade];
//            }
//        }
//        else{
//            if (self.fishtankHidden){
//                NSMutableArray *temparray = [NSMutableArray arrayWithArray:self.optionsArray];
//                [temparray removeObject:self.fishTankArray[0]];
//                NSIndexPath *fishtankpath = self.fishTankArray[2];
//                [temparray[fishtankpath.section][1] insertObject:self.fishTankArray[0] atIndex:fishtankpath.row];
//                self.optionsArray = nil;
//                self.optionsArray = [NSArray arrayWithArray:temparray];
//                [self.tableView insertRowsAtIndexPaths:[NSArray arrayWithObject:fishtankpath]  withRowAnimation:UITableViewRowAnimationFade];
//                self.fishtankHidden = FALSE;
//            }
//        }
//        [self.tableView reloadData];
//
//        [self.tableView endUpdates];
//    }
//
//    if (self.optionsArray[sec][1][row][@"settings"][@"predicateReference"] != nil)
//    {
//        NSString *refPred = self.optionsArray[sec][1][row][@"settings"][@"predicateReference"];
//        //        NSLog(@"Updated Preds set for key %@ : to value:%@",refPred,[value description]);
//        [self.updatedPredicates setValue:value forKey:refPred];
//        //        NSLog(@"Up prefs: %@", [self.updatedPredicates description]);
//    }
//    [self.resultDict setObject:value forKey:[self.optionsArray[sec][1][row] valueForKey:@"return"]];
//    [[[SharedData getInstance] settings] setURL:value forKey:[self.optionsArray[sec][1][row] valueForKey:@"return"]];
//
//    [self.tableView reloadData];
//}
@end
