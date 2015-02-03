//
//  WebLinkOptionCellInput.h
//  DynamicTableGenerator
//
//  Created by tpb on 2/3/15.
//  Copyright (c) 2015 Theodore Brown. All rights reserved.
//

#import "BaseOptionCellInput.h"

@interface WebLinkOptionCellInput : BaseOptionCellInput

-(id) initWebLinkCellForURL:(NSURL*) linkURL withTitle:(NSString*) cellTitle  inSection:(NSString*) newSectionHeader;
-(id) initWebLinkCellForURL:(NSURL*) linkURL withAuthor:(NSString*) authorName withAsset:(NSString*)assetName andDescription:(NSString*)assetDescription  inSection:(NSString*) newSectionHeader;

@property (strong,nonatomic) NSString* author;
@property (strong,nonatomic) NSString* asset;
@property (strong,nonatomic) NSString* assetDescription;
@property (strong,nonatomic) NSURL* linkURL;

@end
