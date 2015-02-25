//
//  WebLinkOptionCellInput.m
//  DynamicTableGenerator
//
//  Created by tpb on 2/3/15.
//  Copyright (c) 2015 Theodore Brown. All rights reserved.
//

#import "WebLinkOptionCellInput.h"

@implementation WebLinkOptionCellInput

-(NSString*) cellType {
    return DTVCCellIdentifier_WebLinkCell;
}
-(id) initWebLinkCellForURL:(NSURL*) linkURL withTitle:(NSString*) cellTitle  inSection:(NSString*) newSectionHeader{
    self = [super init];
    if (self) {
        self.linkURL=linkURL;
        self = [self initType:[self cellType] forReturnKey:nil withTitle:cellTitle inSection:newSectionHeader];
    }
    return self;
}
-(id) initWebLinkCellForURL:(NSURL*) linkURL withAuthor:(NSString*) authorName withAsset:(NSString*)assetName andDescription:(NSString*)assetDescription  inSection:(NSString*) newSectionHeader{
    self = [super init];
    if (self) {
        self.linkURL=linkURL;
        self.author=authorName;
        self.asset=assetName;
        self.assetDescription=assetDescription;
        self = [self initType:[self cellType] forReturnKey:nil withTitle:@"" inSection:newSectionHeader];
    }
    return self;
}


@end
