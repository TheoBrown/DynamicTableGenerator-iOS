//
//  ResultSelectionController.h
//  CoreDataTest
//
//  Created by Theodore Brown on 10/14/13.
//  Copyright (c) 2013 Theodore Brown. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol resultArrayDelegate <NSObject>
-(void)resultsUpdated:(NSArray *)resultArray;
@end

@interface DynamicTableViewCellOptionsPickerViewController : UITableViewController
{
    __weak id resultDelegate;
}
@property (nonatomic,weak) id<resultArrayDelegate> resultDelegate;
@property (nonatomic) BOOL pickMany;
@property (nonatomic, retain) NSArray *optionsArray;

@property (nonatomic, retain) NSMutableArray *selectedOptionsArray;
@property (nonatomic, retain) NSString *selectedTestType;

-(void) setTestType:(NSString*)testType;
-(void) parseDefaultSelection:(NSArray*) selectedOptions;
@end