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
#import "TPBLayout.h"


#define kLabelHorizontalInsets      15.0f
#define kLabelVerticalInsets        10.0f
#define kLabelHorizontalSpace       5.0f

@interface TableViewNavigationBar: NSObject {
    id <TableViewNavigationDelegate> delegate;

}
@property (nonatomic, strong) id delegate;

@property (nonatomic, assign) BOOL didSetupConstraints;

@property (nonatomic, strong) UIView * view;

@property (nonatomic, strong)  UIButton *nextButton;
@property (nonatomic, strong)  UIButton *previousButton;
@property (nonatomic, strong)  UIButton *doneButton;

-(id) initWithDelegate:(id) tvDelegate andFrame:(CGRect)viewFrame;

@end
