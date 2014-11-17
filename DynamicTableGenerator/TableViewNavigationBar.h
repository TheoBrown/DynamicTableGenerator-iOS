//
//  TableViewNavigationBar.h
//  DynamicTableGenerator
//
//  Created by tpb on 11/16/14.
//  Copyright (c) 2014 Theodore Brown. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PureLayout.h"
#import "TableViewNavigationDelegate.h"


#define kLabelHorizontalInsets      15.0f
#define kLabelVerticalInsets        10.0f
#define kLabelHorizontalSpace       5.0f

@interface TableViewNavigationBar : UIView {
    id <TableViewNavigationDelegate> delegate;

}
@property (nonatomic, strong) id delegate;

@property (nonatomic, assign) BOOL didSetupConstraints;

@property (nonatomic, strong) IBOutlet UIButton *nextButton;
@property (nonatomic, strong) IBOutlet UIButton *previousButton;
@property (nonatomic, strong) IBOutlet UIButton *doneButton;

-(id) initWithDelegate:(id) tvDelegate;

@end
