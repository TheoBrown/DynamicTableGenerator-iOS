//
//  BaseCell.h
//  DynamicTableGenerator
//
//  Created by tpb on 11/14/14.
//  Copyright (c) 2014 Theodore Brown. All rights reserved.
// These cells are for controlling the view, the paired Input is the controller/model access

#import <UIKit/UIKit.h>
#import "PureLayout.h"

#import "DynamicTableViewConstants.h"

#import "TableCellEditableProtocol.h"
#import "TableViewNavigationDelegate.h"

/**
 *  BaseCell is the root implemntation of `UITableViewCell` all DynamicCells are based off of.
 *  This cell has a title and subtitle but performs no actions
 */
@interface BaseCell : UITableViewCell {
    id <TableCellEditable> _delegate;
    id <TableViewNavigationDelegate> tableViewDelegate;
}

#define kLabelHorizontalInsets      15.0f
#define kLabelVerticalInsets        10.0f
#define kLabelHorizontalSpace       5.0f

@property (nonatomic, retain) NSIndexPath * indexPath;
@property (nonatomic, strong) IBOutlet UILabel *title;
@property (nonatomic, strong) IBOutlet UILabel *subTitle;
@property (nonatomic, assign) BOOL didSetupConstraints;
@property (nonatomic, assign) BOOL didSetupAcessoryConstraints;
//delegates
@property (nonatomic, strong) id delegate;
@property (nonatomic, strong) id tableViewDelegate;
//content selector / action
@property (nonatomic) SEL contentSelector;
//cell content config
@property (strong, nonatomic) NSDictionary *cellContentFormatDict;
@property (strong, nonatomic) NSString *cellContentTitle;//default string used in content: e.g. text box prompt string
@property (nonatomic,strong) NSNumber* cellContentFormatType; //stores a value for the content of the cell IE date vs datetime or Numpad vs text //static value used to define format of data
@property (strong, nonatomic) NSString *cellContentFormatString; //string used to format data for display
@property (nonatomic,strong) NSNumber* cellFormatType; //the global value of the cell type

- (id)initWithStyle:(UITableViewCellStyle)style atIndex:(NSIndexPath*)indexPath withReuseIdentifier:(NSString *)reuseIdentifier;

-(void) showContentFromSelector;
-(void) defineContentSelector:(SEL) contentSelector;
- (void) contentWasSelected:(id) sender;

-(void) defineCellFormatType:(NSNumber*)cellFormatEnumType; //defines cellFormatType
-(void) setCellFormatDict:(NSDictionary *)cellFormatDict;
- (void) cellFormatWasUpdated;

@end
