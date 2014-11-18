//
//  BaseCell.m
//  DynamicTableGenerator
//
//  Created by tpb on 11/14/14.
//  Copyright (c) 2014 Theodore Brown. All rights reserved.
//

#import "BaseCell.h"


NSString * const DTVCCellIdentifier_DateCell = @"DTVC_DateCell";
NSString * const DTVCCellIdentifier_SliderCell = @"DTVC_SliderCell";
NSString * const DTVCCellIdentifier_ButtonCell = @"DTVC_ButtonCell";
NSString * const DTVCCellIdentifier_ActionCell = @"DTVC_ActionSheetCell";
NSString * const DTVCCellIdentifier_TextCell = @"DTVC_TextCell";
NSString * const DTVCCellIdentifier_NumberCell = @"DTVC_SwitchCell";
NSString * const DTVCCellIdentifier_SwitchCell = @"DTVC_NumberCell";
NSString * const DTVCCellIdentifier_SegmentCell = @"DTVC_SegmentCell";
@interface BaseCell ()


@end

@implementation BaseCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
//    NSLog(@"BAse cell init called");

    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.title = [UILabel newAutoLayoutView];
        [self.title setLineBreakMode:NSLineBreakByTruncatingTail];
        [self.title setNumberOfLines:1];
        [self.title setTextAlignment:NSTextAlignmentLeft];
        [self.title setTextColor:[UIColor blackColor]];
//        self.title.backgroundColor = [UIColor colorWithRed:0 green:0 blue:1 alpha:0.1]; // light blue
        
        self.subTitle = [UILabel newAutoLayoutView];
        [self.subTitle setLineBreakMode:NSLineBreakByTruncatingTail];
        [self.subTitle setNumberOfLines:0];
        [self.subTitle setTextAlignment:NSTextAlignmentLeft];
        [self.subTitle setTextColor:[UIColor darkGrayColor]];
        
        self.title.font = [UIFont preferredFontForTextStyle:UIFontTextStyleHeadline];
        self.subTitle.font = [UIFont preferredFontForTextStyle:UIFontTextStyleCaption2];
//        self.subTitle.backgroundColor = [UIColor colorWithRed:1 green:0 blue:0 alpha:0.1]; // light red
        
//        self.contentView.backgroundColor = [UIColor colorWithRed:0 green:1 blue:0 alpha:0.1]; // light green
        
        [self.contentView addSubview:self.title];
        [self.contentView addSubview:self.subTitle];
        
//        [self updateFonts];
    }
    
    return self;
}

-(void) defineContentSelector:(SEL) contentSelector{
    self.contentSelector = contentSelector;
}
-(void) showContentFromSelector {
    NSLog(@"Show content force called %@",self.title);
    if (self.contentSelector) {
        [self performSelector:self.contentSelector withObject:self];

    }
    [self contentWasSelected:self];
}

- (void)updateConstraints
{
    if (!self.didSetupConstraints) {
        // Note: if the constraints you add below require a larger cell size than the current size (which is likely to be the default size {320, 44}), you'll get an exception.
        // As a fix, you can temporarily increase the size of the cell's contentView so that this does not occur using code similar to the line below.
        //      See here for further discussion: https://github.com/Alex311/TableCellWithAutoLayout/commit/bde387b27e33605eeac3465475d2f2ff9775f163#commitcomment-4633188
        self.contentView.bounds = CGRectMake(0.0f, 0.0f, 99999.0f, 99999.0f);
        
        [UIView autoSetPriority:UILayoutPriorityRequired forConstraints:^{
            [self.title autoSetContentCompressionResistancePriorityForAxis:ALAxisVertical];
        }];
        [self.title autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:kLabelVerticalInsets];
        [self.title autoPinEdgeToSuperviewEdge:ALEdgeLeading withInset:kLabelHorizontalInsets];
        //        [self.title autoPinEdgeToSuperviewEdge:ALEdgeTrailing withInset:kLabelHorizontalInsets];

        
        [self.subTitle autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:self.title withOffset:kLabelVerticalInsets];
        
        [UIView autoSetPriority:UILayoutPriorityRequired forConstraints:^{
            [self.subTitle autoSetContentCompressionResistancePriorityForAxis:ALAxisVertical];
        }];
        [self.subTitle autoPinEdgeToSuperviewEdge:ALEdgeLeading withInset:kLabelHorizontalInsets];
//        [self.subTitle autoPinEdgeToSuperviewEdge:ALEdgeTrailing withInset:kLabelHorizontalInsets];
        [self.subTitle autoPinEdgeToSuperviewEdge:ALEdgeBottom withInset:kLabelVerticalInsets];
        
        self.didSetupConstraints = YES;
    }
    
    [super updateConstraints];
}


-(void) setCellFormatType:(int)formatTypeDef {
    
    self.cellFormatType = formatTypeDef;
    NSNumber *cellFormatTypeDictKey = [NSNumber numberWithInt:self.cellFormatType];
    self.cellContentTitle = [[self.cellContentFormatDict objectForKey:cellFormatTypeDictKey] valueForKey:@"title"];
    self.cellContentFormatString = [[self.cellContentFormatDict objectForKey:cellFormatTypeDictKey] valueForKey:@"format"];;
    self.cellContentFormatType = [[[self.cellContentFormatDict objectForKey:cellFormatTypeDictKey] valueForKey:@"contentType"] intValue];;
    [self cellFormatWasUpdated];
    
}

-(void) setCellFormatDict:(NSDictionary *)cellFormatDict{
    self.cellContentFormatDict = cellFormatDict;
}


#pragma mark - tv delegate methods
- (void) presentContentInput:(id) sender {
   
}
- (void) contentWasSelected:(id) sender {
    [self.tvDelegate contentOfCellWasSelected:self.indexPath];
}

@end
