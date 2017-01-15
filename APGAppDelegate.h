//
//  APGAppDelegate.h
//  APG
//
//  Created by Richard Davis on 11/9/10.
//  Copyright 2012 13Cubed. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface APGAppDelegate : NSObject <NSApplicationDelegate> {
    NSWindow *window;
}

@property (assign) IBOutlet NSWindow *window;

@end