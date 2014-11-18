//
//  PropertyUtil.m
//  CoreDataTest
//
//  Created by Theodore Brown on 11/23/13.
//  Copyright (c) 2013 Theodore Brown. All rights reserved.
//

#import "PropertyUtil.h"
#import "objc/runtime.h"

@implementation PropertyUtil

static BOOL property_getTypeString( objc_property_t property, char *buffer )
{
    const char * attrs = property_getAttributes( property );
    if ( attrs == NULL )
        return NO;
    
    const char * e = strchr( attrs, ',' );
    if ( e == NULL )
        return NO;
    
    int len = (int)(e - attrs);
    memcpy( buffer, attrs, len );
    buffer[len] = '\0';
    
    return YES;
}



+ (NSDictionary *)classPropsFor:(Class)klass
{
    if (klass == NULL) {
        return nil;
    }
    
    NSMutableDictionary *results = [NSMutableDictionary dictionary];
    
    unsigned int outCount, i;
    objc_property_t *properties = class_copyPropertyList(klass, &outCount);
    for (i = 0; i < outCount; i++) {
        objc_property_t property = properties[i];
        const char *propName = property_getName(property);
        if(propName) {
            //const char *propType = getPropertyType(property);
            char propType[256];
            if (!property_getTypeString(property, propType)) {
                continue;
            }
            NSString *propertyName = [NSString stringWithUTF8String:propName];
            NSString *propertyType = [NSString stringWithUTF8String:propType];
            
            NSRange range = [propertyType rangeOfString:@"T@\""];
            NSRange range2 = [propertyType rangeOfString:@"T"];
            if (range.location != NSNotFound) {
                NSRange subStrRange = NSMakeRange(range.length, propertyType.length - (range.length + 1));
                propertyType = [propertyType substringWithRange:subStrRange];
            }
            else if (range2.location != NSNotFound) {
                NSRange subStrRange = NSMakeRange(range2.length, propertyType.length - (range2.length));
                propertyType = [propertyType substringWithRange:subStrRange];
            }
            
//            NSLog(@"Prop type & name: %@ -- %@", propertyType, propertyName);
            
            [results setObject:propertyType forKey:propertyName];
        }
    }
    free(properties);
    
    // returning a copy here to make sure the dictionary is immutable
    return [NSDictionary dictionaryWithDictionary:results];
}

//- (NSArray*) getForm:(id)form {
//    if (!form) return nil;
//    
//    static void *FXFormPropertiesKey = &FXFormPropertiesKey;
//    NSMutableArray *properties = objc_getAssociatedObject(form, FXFormPropertiesKey);
//    if (!properties)
//    {
//        static NSSet *NSObjectProperties;
//        static dispatch_once_t onceToken;
//        dispatch_once(&onceToken, ^{
//            NSObjectProperties = [NSMutableSet setWithArray:@[@"description", @"debugDescription", @"hash", @"superclass"]];
//            unsigned int propertyCount;
//            objc_property_t *propertyList = class_copyPropertyList([NSObject class], &propertyCount);
//            for (unsigned int i = 0; i < propertyCount; i++)
//            {
//                //get property name
//                objc_property_t property = propertyList[i];
//                const char *propertyName = property_getName(property);
//                [(NSMutableSet *)NSObjectProperties addObject:@(propertyName)];
//            }
//            free(propertyList);
//            NSObjectProperties = [NSObjectProperties copy];
//        });
//        
//        properties = [NSMutableArray array];
//        Class subclass = [form class];
//        while (subclass != [NSObject class])
//        {
//            unsigned int propertyCount;
//            objc_property_t *propertyList = class_copyPropertyList(subclass, &propertyCount);
//            for (unsigned int i = 0; i < propertyCount; i++)
//            {
//                //get property name
//                objc_property_t property = propertyList[i];
//                const char *propertyName = property_getName(property);
//                NSString *key = @(propertyName);
//                
//                //ignore NSObject properties, unless overridden as readwrite
//                char *readonly = property_copyAttributeValue(property, "R");
//                if (readonly)
//                {
//                    free(readonly);
//                    if ([NSObjectProperties containsObject:key])
//                    {
//                        continue;
//                    }
//                }
//                
//                //get property type
//                Class valueClass = nil;
//                NSString *valueType = nil;
//                char *typeEncoding = property_copyAttributeValue(property, "T");
//                switch (typeEncoding[0])
//                {
//                    case '@':
//                    {
//                        if (strlen(typeEncoding) >= 3)
//                        {
//                            char *className = strndup(typeEncoding + 2, strlen(typeEncoding) - 3);
//                            __autoreleasing NSString *name = @(className);
//                            NSRange range = [name rangeOfString:@"<"];
//                            if (range.location != NSNotFound)
//                            {
//                                name = [name substringToIndex:range.location];
//                            }
//                            valueClass = FXFormClassFromString(name) ?: [NSObject class];
//                            free(className);
//                        }
//                        break;
//                    }
//                    case 'c':
//                    case 'B':
//                    {
//                        valueClass = [NSNumber class];
//                        valueType = FXFormFieldTypeBoolean;
//                        break;
//                    }
//                    case 'i':
//                    case 's':
//                    case 'l':
//                    case 'q':
//                    {
//                        valueClass = [NSNumber class];
//                        valueType = FXFormFieldTypeInteger;
//                        break;
//                    }
//                    case 'C':
//                    case 'I':
//                    case 'S':
//                    case 'L':
//                    case 'Q':
//                    {
//                        valueClass = [NSNumber class];
//                        valueType = FXFormFieldTypeUnsigned;
//                        break;
//                    }
//                    case 'f':
//                    case 'd':
//                    {
//                        valueClass = [NSNumber class];
//                        valueType = FXFormFieldTypeFloat;
//                        break;
//                    }
//                    case '{': //struct
//                    case '(': //union
//                    {
//                        valueClass = [NSValue class];
//                        valueType = FXFormFieldTypeLabel;
//                        break;
//                    }
//                    case ':': //selector
//                    case '#': //class
//                    default:
//                    {
//                        valueClass = nil;
//                        valueType = nil;
//                    }
//                }
//                free(typeEncoding);
//                
//                //add to properties
//                NSMutableDictionary *inferred = [NSMutableDictionary dictionaryWithObject:key forKey:FXFormFieldKey];
//                if (valueClass) inferred[FXFormFieldClass] = valueClass;
//                if (valueType) inferred[FXFormFieldType] = valueType;
//                [properties addObject:[inferred copy]];
//            }
//            free(propertyList);
//            subclass = [subclass superclass];
//        }
//        objc_setAssociatedObject(form, FXFormPropertiesKey, properties, OBJC_ASSOCIATION_RETAIN);
//    }
//    return properties;
//}

//static const char * getPropertyType(objc_property_t property) {
//    const char *attributes = property_getAttributes(property);
//    printf("attributes=%s\n", attributes);
//    char buffer[1 + strlen(attributes)];
//    strcpy(buffer, attributes);
//    char *state = buffer, *attribute;
//    while ((attribute = strsep(&state, ",")) != NULL) {
//        if (attribute[0] == 'T' && attribute[1] != '@') {
//            // it's a C primitive type:
//            /*
//             if you want a list of what will be returned for these primitives, search online for
//             "objective-c" "Property Attribute Description Examples"
//             apple docs list plenty of examples of what you get for int "i", long "l", unsigned "I", struct, etc.
//             */
//            return (const char *)[[NSData dataWithBytes:(attribute + 1) length:strlen(attribute) - 1] bytes];
//        }
//        else if (attribute[0] == 'T' && attribute[1] == '@' && strlen(attribute) == 2) {
//            // it's an ObjC id type:
//            return "id";
//        }
//        else if (attribute[0] == 'T' && attribute[1] == '@') {
//            // it's another ObjC object type:
//            printf("ObC type = %s\r\n", (const char *)[[NSData dataWithBytes:(attribute + 3) length:strlen(attribute) - 4] bytes]);
//
//            return (const char *)[[NSData dataWithBytes:(attribute + 3) length:strlen(attribute) - 4] bytes];
//        }
//    }
//    return "";
//}
//
//
//+ (NSDictionary *)classPropsFor:(Class)klass
//{
//    if (klass == NULL) {
//        return nil;
//    }
//    
//    NSMutableDictionary *results = [[[NSMutableDictionary alloc] init] retain];
//    
//    unsigned int outCount, i;
//    objc_property_t *properties = class_copyPropertyList(klass, &outCount);
//    for (i = 0; i < outCount; i++) {
//        objc_property_t property = properties[i];
//        const char *propName = property_getName(property);
//        if(propName) {
//            const char *propType = getPropertyType(property);
//            NSString *propertyName = [NSString stringWithUTF8String:propName];
//            NSString *propertyType = [NSString stringWithUTF8String:propType];
//            NSLog(@"Property type for key %@:::%@",propertyName, propertyType);
//            if (propertyType != NULL){
//                [results setObject:propertyType forKey:propertyName];
//
//            }
//        }
//    }
//    free(properties);
//    
//    // returning a copy here to make sure the dictionary is immutable
//    return [NSDictionary dictionaryWithDictionary:results];
//}




@end