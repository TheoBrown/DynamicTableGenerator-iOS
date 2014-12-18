//
//  TPBLogger.h
//  DynamicTableGenerator
//
//  Created by tpb on 12/17/14.
//  Copyright (c) 2014 Theodore Brown. All rights reserved.
//

#import <Foundation/Foundation.h>

/* Overrides NSLog for easy deployment
 
 add this to Prefix.pch for global implementation
 #define DEBUG=1 //logging on, dont define for off
 #ifdef __OBJC__
     #import "TPBLogger.h"
 #endif
 
 **/
#ifdef DEBUG
#define NSLog(args...) ExtendNSLog(__FILE__,__LINE__,__PRETTY_FUNCTION__,args);
#else
#define NSLog(x...)
#endif

void ExtendNSLog(const char *file, int lineNumber, const char *functionName, NSString *format, ...);



