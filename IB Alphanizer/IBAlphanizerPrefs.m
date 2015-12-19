//
//  IBAlphanizerPrefs.m
//  IB Alphanizer
//
//  Created by Rayman Rosevear on 2015/12/20.
//  Copyright © 2015 mushroomcloud. All rights reserved.
//

#import "IBAlphanizerPrefs.h"

NSString * const kIBAlphanizerPrefEnabledChangeNotification = @"IBAlphanizerPrefEnabledChangeNotification";

@implementation IBAlphanizerPrefs

+ (BOOL)isEnabled
{
    return [[NSUserDefaults standardUserDefaults] boolForKey:@"com.mushroomcloud.IBAlphanizer.enabled"];
}

+ (void)setEnabled:(BOOL)enabled
{
    [[NSUserDefaults standardUserDefaults] setBool:enabled forKey:@"com.mushroomcloud.IBAlphanizer.enabled"];
    [[NSNotificationCenter defaultCenter] postNotificationName:kIBAlphanizerPrefEnabledChangeNotification object:nil];
}

@end
