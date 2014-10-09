//
//  TableCellWithNumber.h
//  XIBTableCells
//
//  Created by Damian on 10/03/2012.
//

#import "XIBBasedTableCell.h"
#import "TableCellEditableProtocol.h"

@interface TableCellWithNumber : XIBBasedTableCell {
    id <TableCellEditable> _delegate;
}

@property (nonatomic, strong) id delegate;

@property (nonatomic, weak) IBOutlet UILabel *title;
@property (nonatomic, weak) IBOutlet UILabel *subTitle;
@property (nonatomic, weak) IBOutlet UITextField *numericTextField;

-(IBAction)textFieldValueDidChange:(id)sender;

@end
