//
//  MutableTableViewCellManager.h
//  TableViewDataCells
//
//  Created by Theodore Brown on 8/9/14.
//  Copyright (c) 2014 Theodore Brown. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

//#import "TableCellWithNumber.h"
//#import "CellWithText.h"
//#import "CellWithSwitch.h"
//#import "CellWithDate.h"
//#import "CellWithSegment.h"
//#import "CellWithSlider.h"
//#import "CellWithButton.h"
//#import "CellWithAbstractActionSheet.h"

@interface MutableTableViewCellManager : NSObject


@property (nonatomic, strong) NSMutableDictionary *resultDict;
@property (nonatomic) NSInteger tagOffset;
@property (nonatomic, strong) NSString *tagCode;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray *sectionHeaderArray;
@property (nonatomic, strong) NSDictionary *sectionDescription;

@property (nonatomic, strong) UIToolbar* keyboardToolbar;
@property (nonatomic, strong) UIBarButtonItem* btnDone;
@property (nonatomic, strong) UIBarButtonItem* btnNext;
@property (nonatomic, strong) UIBarButtonItem* btnPrev;
@property (nonatomic, strong) NSIndexPath *currentSelection;

- (id) initWithTagCode:(NSString*) tagString andOffset:(NSInteger) newtagOffset andtableView:(UITableView*) newTableView withAcessoryKeys:(UIToolbar*) acessoryKeyBoard andCellInputs:(NSArray*) cellInputArray;
- (UITableViewCell*)  getCellatIndexPath:(NSIndexPath *)indexPath andDelegate:(id) delegateToAssign;
- (NSInteger) rowsInSection:(NSInteger) section;
-(UIToolbar *)createInputAccessoryView;

- (void) saveAllChanges;

@end
