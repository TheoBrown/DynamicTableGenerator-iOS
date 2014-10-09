//
//  TableCellEditableProtocol.h
//  XIBTableCells
//
//  Created by Damian on 10/03/2012.
//

#import <Foundation/Foundation.h>

@protocol TableCellEditable <NSObject>

@optional
- (void) cellNumericValueDidChange: (NSIndexPath *) cellIndexPath :(NSNumber *) value;
- (void) cellTextValueDidChange: (NSIndexPath *) cellIndexPath :(NSString *) value;
- (void) cellSwitchDidChange: (NSIndexPath *) cellIndexPath :(BOOL) value;
- (void) cellDateDidChange: (NSIndexPath *) cellIndexPath :(NSDate*) value;
- (void) cellDateSegmentDidChange: (NSIndexPath *) cellIndexPath startDate:(NSDate*) startDate endDate:(NSDate*)endDate;
-(void) cellSliderDidChange:(NSIndexPath *) cellIndexPath :(float) value;
-(void) cellAbstractActionSheetPickerDidChange:(NSIndexPath *) cellIndexPath withPredicateArray:(NSArray *)predicateArray :(NSObject *)value;
-(void) cellAbstractActionSheetPickerDidChange:(NSIndexPath *) cellIndexPath withPredicateArray:(NSArray *)predicateArray withURL:(NSURL *)value;
-(void) cellButtonresultsUpdated:(NSIndexPath *) cellIndexPath withResults:(NSArray *)resultArray;
@end
