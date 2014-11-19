//
//  TPBLayout.m
//  DynamicTableGenerator
//
//  Created by tpb on 11/19/14.
//  Copyright (c) 2014 Theodore Brown. All rights reserved.
//

#import "TPBLayout.h"

@implementation TPBLayout

-(void) horizontalLayout:(NSArray*) views {
    CGFloat y0 = 0;
    CGFloat pad = 10;
    CGFloat x0 = pad;

    CGFloat newX = x0;
    for (UIView* view in views) {
        view.frame = CGRectMake(newX, y0, view.frame.size.width, view.frame.size.height);
        newX = x0+view.frame.size.width +pad;
        
    }
    
}

- (void)listSubviewsOfView:(UIView *)view {
    
    // Get the subviews of the view
    NSArray *subviews = [view subviews];
    
    // Return if there are no subviews
    if ([subviews count] == 0) return;
    
    for (UIView *subview in subviews) {
        
        NSLog(@"%@", subview);
        
        // List the subviews of subview
        [self listSubviewsOfView:subview];
    }
}
@end
