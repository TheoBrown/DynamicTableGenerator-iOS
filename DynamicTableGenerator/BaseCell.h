//
//  BaseCell.h
//  DynamicTableGenerator
//
//  Created by tpb on 11/14/14.
//  Copyright (c) 2014 Theodore Brown. All rights reserved.
// These cells are for controlling the view, the paired Input is the controller/model access

#import <UIKit/UIKit.h>
#import "PureLayout.h"
#import "TableCellEditableProtocol.h"
#import "TableViewNavigationDelegate.h"
#import "DynamicTableViewConstants.h"
#import "TPBLayout.h"

//extern NSString * const DTVCCellIdentifier_DateCell;
//extern NSString * const DTVCCellIdentifier_SliderCell;
//extern NSString * const DTVCCellIdentifier_ButtonCell;
//extern NSString * const DTVCCellIdentifier_ActionCell;
//extern NSString * const DTVCCellIdentifier_TextCell;
//extern NSString * const DTVCCellIdentifier_NumberCell;
//extern NSString * const DTVCCellIdentifier_SwitchCell;
//extern NSString * const DTVCCellIdentifier_SegmentCell;

@interface BaseCell : UITableViewCell
{
    id <TableCellEditable> _delegate;
    id <TableViewNavigationDelegate> tvDelegate;
}

#define kLabelHorizontalInsets      15.0f
#define kLabelVerticalInsets        10.0f
#define kLabelHorizontalSpace       5.0f


@property (nonatomic, retain) NSIndexPath * indexPath;

@property (nonatomic, strong) id delegate;
@property (nonatomic, strong) id tvDelegate;

@property (nonatomic) SEL contentSelector;
-(void) showContentFromSelector;
-(void) defineContentSelector:(SEL) contentSelector;

@property (nonatomic, strong) IBOutlet UILabel *title;
@property (nonatomic, strong) IBOutlet UILabel *subTitle;
@property (nonatomic, assign) BOOL didSetupConstraints;
@property (nonatomic, assign) BOOL didSetupAcessoryConstraints;


@property (strong, nonatomic) NSDictionary *cellContentFormatDict;

@property (nonatomic,strong) NSNumber* cellContentFormatType; //stores a value for the content of the cell IE date vs date or Numpad vs text
@property (strong, nonatomic) NSString *cellContentFormatString;
@property (strong, nonatomic) NSString *cellContentTitle;

- (void) contentWasSelected:(id) sender;
@property (nonatomic,strong) NSNumber* cellFormatType; //the global value of the cell type

-(void) defineCellFormatType:(NSNumber*)cellFormatEnumType; //defines cellFormatType

-(void) setCellFormatDict:(NSDictionary *)cellFormatDict;
- (void) cellFormatWasUpdated;
@end
