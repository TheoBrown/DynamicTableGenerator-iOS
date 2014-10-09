//
//  XIBBasedTableCell.m
//  XIBTableCells
//
//  Created by Damian on 10/03/2012.
//

#import "XIBBasedTableCell.h"

@implementation XIBBasedTableCell
@synthesize indexPath;
+ (XIBBasedTableCell *)cellFromNibNamed:(NSString *)nibName {
    
    NSArray *nibContents = [[NSBundle mainBundle] loadNibNamed:nibName owner:self options:NULL];
    NSEnumerator *nibEnumerator = [nibContents objectEnumerator];
    XIBBasedTableCell *xibBasedCell = nil;
    NSObject* nibItem = nil;
    
    while ((nibItem = [nibEnumerator nextObject]) != nil) {
        if ([nibItem isKindOfClass:[XIBBasedTableCell class]]) {
            xibBasedCell = (XIBBasedTableCell *)nibItem;
            break; // we have a winner
        }
    }
    
    return xibBasedCell;
}

@end
