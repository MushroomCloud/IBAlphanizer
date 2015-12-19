//
//  IBAlphanizer.m
//  IB Alphanizer
//
//  Created by Rayman Rosevear on 2015/12/19.
//  Copyright © 2015 mushroomcloud. All rights reserved.
//

#import "IBAlphanizer.h"
#import "IBAlphanizerPrefs.h"

@interface IBAlphanizer()

@property (nonatomic, strong, readwrite) NSBundle *bundle;
@end

@implementation IBAlphanizer

+ (instancetype)sharedPlugin
{
    return sharedPlugin;
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (id)initWithBundle:(NSBundle *)plugin
{
    if (self = [super init])
    {
        // reference to plugin's bundle, for resource access
        self.bundle = plugin;
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(didApplicationFinishLaunchingNotification:)
                                                     name:NSApplicationDidFinishLaunchingNotification
                                                   object:nil];
    }
    return self;
}

- (void)didApplicationFinishLaunchingNotification:(NSNotification*)noti
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:NSApplicationDidFinishLaunchingNotification object:nil];
    
    NSMenuItem *menuItem = [[NSApp mainMenu] itemWithTitle:@"Edit"];
    if (menuItem)
    {
        [[menuItem submenu] addItem:[NSMenuItem separatorItem]];
        NSString *title = [IBAlphanizerPrefs isEnabled] ? @"Disable IBAlphanizer" : @"Enable IBAlphanizer";
        NSMenuItem *actionMenuItem = [[NSMenuItem alloc] initWithTitle:title action:@selector(toggleEnabled:) keyEquivalent:@""];
        [actionMenuItem setTarget:self];
        [[menuItem submenu] addItem:actionMenuItem];
    }
}

- (void)toggleEnabled:(NSMenuItem *)menuItem
{
//    NSAlert *alert = [[NSAlert alloc] init];
//    [alert setMessageText:@"Hello, World"];
//    [alert runModal];
    
    [IBAlphanizerPrefs setEnabled:![IBAlphanizerPrefs isEnabled]];
    menuItem.title = [IBAlphanizerPrefs isEnabled] ? @"Disable IBAlphanizer" : @"Enable IBAlphanizer";
}

@end
