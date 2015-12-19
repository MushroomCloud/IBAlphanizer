//
//  IBUIEditorView+Swizzles.h
//  IB Alphanizer
//
//  Created by Rayman Rosevear on 2015/12/20.
//  Copyright © 2015 mushroomcloud. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface IBUIEditorView : NSView

- (instancetype)initWithFrame:(struct CGRect)arg1 targetRuntime:(id)arg2;

@end

@interface IBUIEditorView (Swizzles)

- (void)swizzled_dealloc;
- (instancetype)swizzled_initWithFrame:(struct CGRect)arg1 targetRuntime:(id)arg2;

@end
