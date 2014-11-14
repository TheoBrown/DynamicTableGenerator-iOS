//
//  BaseCell.h
//  DynamicTableGenerator
//
//  Created by tpb on 11/14/14.
//  Copyright (c) 2014 Theodore Brown. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PureLayout.h"

@interface BaseCell : UITableViewCell

#define kLabelHorizontalInsets      15.0f
#define kLabelVerticalInsets        10.0f
#define kLabelHorizontalSpace       5.0f


@property (nonatomic, retain) NSIndexPath * indexPath;

@property (nonatomic, strong) id delegate;
@property (nonatomic, strong) IBOutlet UILabel *title;
@property (nonatomic, strong) IBOutlet UILabel *subTitle;
@property (nonatomic, assign) BOOL didSetupConstraints;
@property (nonatomic, assign) BOOL didSetupAcessoryConstraints;


- (void)updateFonts;

@end