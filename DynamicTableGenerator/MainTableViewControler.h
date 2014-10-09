//
//  MainTableViewControler.h
//  XIBTableCells
//
//  Created by Damian on 10/03/2012.
//

#import <UIKit/UIKit.h>
#import "TableCellWithNumber.h"
#import "CellWithText.h"
#import "CellWithSwitch.h"
#import "CellWithDate.h"
#import "CellWithSegment.h"
#import "CellWithSlider.h"
#import "CellWithButton.h"
#import "CellWithAbstractActionSheet.h"

//#import "ActionSheetPicker.h"
//@class AbstractActionSheetPicker;

@protocol OptionsDelegate <NSObject>
-(void)optionsWereUpdated:(NSDictionary*)optionsDictionary;

@end
@interface MainTableViewControler : UITableViewController <TableCellEditable>
{
    __weak id optionsDelegate;
}
@property (nonatomic,weak) id<OptionsDelegate> optionsDelegate;
@property (nonatomic, strong) NSArray *optionsArray;
@property (nonatomic, strong) NSArray *fishTankArray;
@property (nonatomic) BOOL *fishtankHidden;

@property (nonatomic, strong) NSMutableDictionary *updatedPredicates;

@property (nonatomic, strong) NSMutableDictionary *resultDict;
@property (nonatomic) NSInteger tagOffset;
@property (nonatomic, strong) NSString *tagCode;

//@property (nonatomic, strong) ActionSheetDatePicker *actionSheetPicker;
//@property (strong, nonatomic) NSDate *selectedDate;
//- (IBAction)selectADate:(UIControl *)sender;
@end
