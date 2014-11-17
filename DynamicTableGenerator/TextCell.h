//
//  TextCell.h
//  DynamicTableGenerator
//
//  Created by tpb on 11/14/14.
//  Copyright (c) 2014 Theodore Brown. All rights reserved.
//

#import "BaseCell.h"
#import "TableCellEditableProtocol.h"

@interface TextCell : BaseCell {
    id <TableCellEditable> _delegate;
}

@property (nonatomic, strong) IBOutlet UITextField *cellTextField;

-(IBAction)textFieldValueDidChange:(id)sender;

@property (strong, nonatomic) NSDictionary *textPadFormatDict;
@property (strong, nonatomic) NSString *textFormatString;
@property (strong, nonatomic) NSString *textDefaultString;

@property (nonatomic) NSInteger textPadMode;

@end