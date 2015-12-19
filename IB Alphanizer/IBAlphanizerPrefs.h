//
//  IBAlphanizerPrefs.h
//  IB Alphanizer
//
//  Created by Rayman Rosevear on 2015/12/20.
//  Copyright © 2015 mushroomcloud. All rights reserved.
//

#import <Foundation/Foundation.h>

extern NSString * const kIBAlphanizerPrefEnabledChangeNotification;

@interface IBAlphanizerPrefs : NSObject

+ (BOOL)isEnabled;
+ (void)setEnabled:(BOOL)enabled;

@end
