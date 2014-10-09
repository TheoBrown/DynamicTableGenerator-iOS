//
//  DummyTestView.h
//  CoreDataTest
//
//  Created by Theodore Brown on 12/11/13.
//  Copyright (c) 2013 Theodore Brown. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MainTableViewControler.h"
@interface DummyTestView : UIViewController <TableCellEditable, OptionsDelegate>
@property (nonatomic, strong) UIImageView *imageView;
//@property (nonatomic, strong) MainTableViewController *optionsView;
@property (nonatomic, strong) UIPopoverController * optionsPopover;
@property (nonatomic, strong) MainTableViewControler * optionsViewController;
@property (nonatomic, strong) UIActionSheet * actionSheet;

@property (weak, nonatomic) IBOutlet UIView *containerView;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *takePhotoButton;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *optionsBarButton;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *actionButton;

- (IBAction) presentOptionsView:(id)sender;

@end
