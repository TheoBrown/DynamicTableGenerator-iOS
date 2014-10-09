//
//  XIBBasedTableCell.h
//  XIBTableCells
//
//  Created by Damian on 10/03/2012.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

@interface XIBBasedTableCell : UITableViewCell
@property (nonatomic, retain) NSIndexPath * indexPath;
+(UITableViewCell *) cellFromNibNamed:(NSString *)nibName;

@end
