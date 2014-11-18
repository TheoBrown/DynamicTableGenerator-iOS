//
//  MutableTableViewCellManager.h
//  TableViewDataCells
//
//  Created by Theodore Brown on 8/9/14.
//  Copyright (c) 2014 Theodore Brown. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "DynamicTableViewConstants.h"

//extern NSString * const DTVCCellType_DateCell;
//extern NSString * const DTVCCellType_SliderCell;
//extern NSString * const DTVCCellType_ButtonCell;
//extern NSString * const DTVCCellType_ActionCell;
//extern NSString * const DTVCCellType_TextCell;
//extern NSString * const DTVCCellType_NumberCell;
//extern NSString * const DTVCCellType_SwitchCell;
//extern NSString * const DTVCCellType_SegmentCell;


@interface DynamicTableViewCellManager : NSObject


@property (nonatomic, strong) NSMutableDictionary *resultDict;
@property (nonatomic) NSInteger tagOffset;
@property (nonatomic, strong) NSString *tagCode;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray *sectionHeaderArray;
@property (nonatomic, strong) NSDictionary *sectionDescription;

@property (nonatomic, strong) UIView* keyboardToolbar;
@property (nonatomic, strong) UIBarButtonItem* btnDone;
@property (nonatomic, strong) UIBarButtonItem* btnNext;
@property (nonatomic, strong) UIBarButtonItem* btnPrev;
@property (nonatomic, strong) NSIndexPath *currentSelection;

- (id) initWithTagCode:(NSString*) tagString andOffset:(NSInteger) newtagOffset andtableView:(UITableView*) newTableView  andCellInputs:(NSArray*) cellInputArray;
- (id) initWithTagCode:(NSString*) tagString andOffset:(NSInteger) newtagOffset andtableView:(UITableView*) newTableView withAcessoryKeys:(UIView*) acessoryKeyBoard andCellInputs:(NSArray*) cellInputArray;

- (UITableViewCell*)  getCellatIndexPath:(NSIndexPath *)indexPath andDelegate:(id) delegateToAssign;
- (NSInteger) rowsInSection:(NSInteger) section;


- (void) saveAllChanges;

@end
