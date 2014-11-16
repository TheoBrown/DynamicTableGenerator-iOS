//
//  MutableDataCellViewControllerTableViewController.h
//  TableViewDataCells
//
//  Created by Theodore Brown on 8/9/14.
//  Copyright (c) 2014 Theodore Brown. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseCell.h"

#import "MutableTableViewCellManager.h"

@protocol OptionsDelegate <NSObject>
-(void)optionsWereUpdated:(NSDictionary*)optionsDictionary;

@end

@interface MutableDataCellViewControllerTableViewController : UITableViewController <TableCellEditable>
{
    __weak id optionsDelegate;
}
@property (nonatomic,weak) id<OptionsDelegate> optionsDelegate;
@property (nonatomic, strong) MutableTableViewCellManager *  cellManager;
@property (nonatomic, strong) NSString *tagCode;
@property (nonatomic) NSInteger tagOffset;

@property (nonatomic, strong) NSMutableDictionary *resultDict;
- (void) setupWithInputArray:(NSArray*) cellInputArray;
- (id) initWithCellInputArray:(NSArray*) cellInputArray;

@end
