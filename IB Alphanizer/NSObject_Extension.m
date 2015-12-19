//
//  NSObject_Extension.m
//  IB Alphanizer
//
//  Created by Rayman Rosevear on 2015/12/19.
//  Copyright © 2015 mushroomcloud. All rights reserved.
//

#import "NSObject_Extension.h"
#import "IBAlphanizer.h"
#import "IBAlphanizer+Swizzles.h"

@implementation NSObject (Xcode_Plugin_Template_Extension)

+ (void)pluginDidLoad:(NSBundle *)plugin
{
    static dispatch_once_t onceToken;
    NSString *currentApplicationName = [[NSBundle mainBundle] infoDictionary][@"CFBundleName"];
    if ([currentApplicationName isEqual:@"Xcode"])
    {
        dispatch_once(&onceToken, ^
        {
            sharedPlugin = [[IBAlphanizer alloc] initWithBundle:plugin];
            [sharedPlugin applySwizzles];
        });
    }
}
@end
