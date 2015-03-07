//
//  TableCellEditableProtocol.h
//  XIBTableCells
//
//  Created by Damian on 10/03/2012.
//

#import <Foundation/Foundation.h>

/**
 *  All Delegate Methods from the DynamicTableViewCells based off `BaseCell`
 * Impemented by `BaseOptionCellInput`
 */
@protocol TableCellEditable <NSObject>

@optional

- (void) cellNumericValueDidChange: (NSIndexPath *) cellIndexPath :(NSNumber *) value;
- (void) cellTextValueDidChange: (NSIndexPath *) cellIndexPath :(NSString *) value;

//- (void) cellSwitchDidChange: (NSIndexPath *) cellIndexPath :(BOOL) value;
- (void) cellSwitchDidChange: (NSIndexPath *) cellIndexPath :(NSNumber*) value;

- (void) cellDateDidChange: (NSIndexPath *) cellIndexPath :(NSDate*) value;

- (void) cellDateSegmentDidChange: (NSIndexPath *) cellIndexPath startDate:(NSDate*) startDate endDate:(NSDate*)endDate;
- (void) cellSegmentDidChange: (NSIndexPath *) cellIndexPath withObject:(NSObject*)segmentResult;
- (void) cellSegmentDidChange: (NSIndexPath *) cellIndexPath withIndex:(NSNumber*)segmentIndex;
- (void) cellSegmentIntClickerDidChange: (NSIndexPath *) cellIndexPath withValue:(NSNumber*) newValue;

//-(void) cellSliderDidChange:(NSIndexPath *) cellIndexPath :(float) value;
-(void) cellSliderDidChange:(NSIndexPath *) cellIndexPath :(NSNumber*) value;
-(void) cellStepperDidChange:(NSIndexPath *) cellIndexPath :(NSNumber*) value;

-(void) cellAbstractActionSheetPickerDidChange:(NSIndexPath *) cellIndexPath withPredicateArray:(NSArray *)predicateArray :(NSObject *)value;
-(void) cellAbstractActionSheetPickerDidChange:(NSIndexPath *) cellIndexPath withPredicateArray:(NSArray *)predicateArray withURL:(NSURL *)value;
-(void) cellButtonresultsUpdated:(NSIndexPath *) cellIndexPath withResults:(NSArray *)resultArray;

//actionSheetCells
-(void) cellSimpleActionSheetDidChange:(NSIndexPath *) cellIndexPath withIndex:(NSInteger)optionIndex;
-(void) cellSimpleActionSheetDidChange:(NSIndexPath *) cellIndexPath withString:(NSString*)optionString;
-(void) cellSimpleActionSheetDidChange:(NSIndexPath *) cellIndexPath withObject:(NSObject*)optionObject;

-(void) cellPurchaseButtonPressed:(NSIndexPath *) indexPath;
-(void) cellButtonPressed:(NSIndexPath *) indexPath;

@end
