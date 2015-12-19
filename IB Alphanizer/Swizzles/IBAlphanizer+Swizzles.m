//
//  IBAlphanizer+Swizzles.m
//  IB Alphanizer
//
//  Created by Rayman Rosevear on 2015/12/20.
//  Copyright © 2015 mushroomcloud. All rights reserved.
//

#import "JRSwizzle.h"
#import "IBAlphanizer+Swizzles.h"
#import "IBUIEditorView+Swizzles.h"

#define selectorString(x) NSStringFromSelector(@selector(x))

@implementation IBAlphanizer (Swizzles)

- (void)applySwizzles
{
    [[self classToBundleIDMap] enumerateKeysAndObjectsUsingBlock:^(NSString *clsName, NSArray *dicts, BOOL * _Nonnull stop)
    {
        for (NSDictionary *dict in dicts)
        {
            NSString *bundleID = dict[@"bundleID"];
            SEL orig = NSSelectorFromString(dict[@"originalSelector"]);
            SEL swiz = NSSelectorFromString(dict[@"swizzledSelector"]);
            
            [[NSBundle bundleWithIdentifier:bundleID] load];
            Class cls = NSClassFromString(clsName);
            
            NSError *error = nil;
            if (![cls jr_swizzleMethod:orig withMethod:swiz error:&error])
            {
                NSLog(@"Unable to swizzle up %@ in this bitch: %@", clsName, error.localizedDescription);
            }
        }
    }];
}

- (NSDictionary<NSString *, NSArray *> *)classToBundleIDMap
{
    return @{
             @"IBUIEditorView" : @[ @{
                                      @"bundleID" : @"com.apple.dt.IDE.IDEInterfaceBuilderCocoaTouchIntegration",
                                      @"originalSelector" : selectorString(initWithFrame:targetRuntime:),
                                      @"swizzledSelector" : selectorString(swizzled_initWithFrame:targetRuntime:)
                                      },
                                    @{
                                      @"bundleID" : @"com.apple.dt.IDE.IDEInterfaceBuilderCocoaTouchIntegration",
                                      @"originalSelector" : @"dealloc",
                                      @"swizzledSelector" : selectorString(swizzled_dealloc)
                                      }
                                    ]
             };
}

@end
