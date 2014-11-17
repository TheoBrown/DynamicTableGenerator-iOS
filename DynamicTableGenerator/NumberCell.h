//
//  NumberCell.h
//  DynamicTableGenerator
//
//  Created by tpb on 11/14/14.
//  Copyright (c) 2014 Theodore Brown. All rights reserved.
//

#import "BaseCell.h"

@interface NumberCell : BaseCell <UITextFieldDelegate>

@property (nonatomic, strong) IBOutlet UITextField *numericTextField;

-(IBAction)textFieldValueDidChange:(id)sender;

@property (strong, nonatomic) NSDictionary *numberPadFormatDict;
@property (strong, nonatomic) NSString *numberFormatString;
@property (strong, nonatomic) NSString *numberDefaultString;

@property (nonatomic) NSInteger numberPadMode;

-(NSString*)stringFromNumber:(NSNumber*)number;

@end