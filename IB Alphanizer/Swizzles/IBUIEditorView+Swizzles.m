//
//  IBUIEditorView+Swizzles.m
//  IB Alphanizer
//
//  Created by Rayman Rosevear on 2015/12/20.
//  Copyright © 2015 mushroomcloud. All rights reserved.
//

#import <objc/runtime.h>

#import "IBUIEditorView+Swizzles.h"
#import "IBAlphanizerResource.h"

#import "IBAlphanizerPrefs.h"

#define selectorString(x) NSStringFromSelector(@selector(x))

static void * const kAlphanizerActiveKey = (void *)&kAlphanizerActiveKey;
static void * const kAlphanizerOriginalColorKey = (void *)&kAlphanizerOriginalColorKey;

@interface IBUIEditorView (IBAlphanizer_Private)

@property (nonatomic, assign) BOOL alphanizerActive;
@property (nonatomic, strong) NSColor * alphanizerOriginalColor;

- (void)alphanizerPrefEnabledDidChange;

@end

@implementation IBUIEditorView (Swizzles)

- (void)swizzled_dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [self swizzled_dealloc];
}

- (instancetype)swizzled_initWithFrame:(struct CGRect)arg1 targetRuntime:(id)arg2
{
    id instance = [self swizzled_initWithFrame:arg1 targetRuntime:arg2];
    [instance updateAlphanizerBackgroundColor];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(alphanizerPrefEnabledDidChange)
                                                 name:kIBAlphanizerPrefEnabledChangeNotification
                                               object:nil];
    
    return instance;
}

- (void)setAlphanizerActive:(BOOL)alphanizerActive
{
    objc_setAssociatedObject(self, kAlphanizerActiveKey, @(alphanizerActive), OBJC_ASSOCIATION_RETAIN);
}

- (BOOL)alphanizerActive
{
    return [objc_getAssociatedObject(self, kAlphanizerActiveKey) boolValue];
}

- (void)setAlphanizerOriginalColor:(NSColor *)alphanizerOriginalColor
{
    objc_setAssociatedObject(self, kAlphanizerOriginalColorKey, alphanizerOriginalColor, OBJC_ASSOCIATION_RETAIN);
}

- (NSColor *)alphanizerOriginalColor
{
    return objc_getAssociatedObject(self, kAlphanizerOriginalColorKey);
}

- (void)alphanizerPrefEnabledDidChange
{
    [self updateAlphanizerBackgroundColor];
}

- (void)updateAlphanizerBackgroundColor
{
    BOOL active = [IBAlphanizerPrefs isEnabled];
    
    if (active == self.alphanizerActive)
        return;
    
    self.alphanizerActive = active;
    
    if (active)
    {
        NSData *data = [[NSData alloc] initWithBase64EncodedString:kB64ImageAlphaBackground options:0];
        NSColor *color = [NSColor colorWithPatternImage:[[NSImage alloc] initWithData:data]];
        
        self.alphanizerOriginalColor = [self valueForKey:selectorString(backgroundColor)];
        [self setValue:color forKey:selectorString(backgroundColor)];
    }
    else
    {
        [self setValue:self.alphanizerOriginalColor forKey:selectorString(backgroundColor)];
        self.alphanizerOriginalColor = nil;
    }
}

@end
