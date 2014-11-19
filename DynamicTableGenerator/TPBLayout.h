//
//  TPBLayout.h
//  DynamicTableGenerator
//
//  Created by tpb on 11/19/14.
//  Copyright (c) 2014 Theodore Brown. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface TPBLayout : NSObject
- (void)listSubviewsOfView:(UIView *)view;
-(void) horizontalLayout:(NSArray*) views;

@end
