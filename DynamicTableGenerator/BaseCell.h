//
//  BaseCell.h
//  DynamicTableGenerator
//
//  Created by tpb on 11/14/14.
//  Copyright (c) 2014 Theodore Brown. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseCell : UITableViewCell

@property (nonatomic, retain) NSIndexPath * indexPath;

@property (nonatomic, strong) id delegate;
@property (nonatomic, strong) IBOutlet UILabel *title;
@property (nonatomic, strong) IBOutlet UILabel *subTitle;


- (void)updateFonts;

@end
