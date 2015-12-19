//
//  IBAlphanizer.h
//  IB Alphanizer
//
//  Created by Rayman Rosevear on 2015/12/19.
//  Copyright © 2015 mushroomcloud. All rights reserved.
//

#import <AppKit/AppKit.h>

@class IBAlphanizer;

static IBAlphanizer *sharedPlugin;

@interface IBAlphanizer : NSObject

+ (instancetype)sharedPlugin;
- (id)initWithBundle:(NSBundle *)plugin;

@property (nonatomic, strong, readonly) NSBundle* bundle;
@end