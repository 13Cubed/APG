//
//  MyController.m
//  APG
//
//  Created by Richard Davis on 11/9/10.
//  Copyright 2012 13Cubed. All rights reserved.
//

#import "MyController.h"
#include <math.h>

@implementation MyController

@synthesize lines;
@synthesize entireFileInString, passwordWithSeparator, passwordWithoutSeparator;

- (id)init
{
    self = [super init];
    if (self != nil) {
        self.entireFileInString = [NSString stringWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"Words" ofType:@"txt"] encoding:NSUTF8StringEncoding error:nil];
        self.lines = [entireFileInString componentsSeparatedByString:@"\n"];
        lineCount = ([lines count] - 1);
    }
    return self;
}

- (void)displayPassword
{
    if ([separatorCheckbox state] == NSOnState) {
        password = self.passwordWithSeparator;
        separatorCount = 1;
    }
    
    else {
        password = self.passwordWithoutSeparator;
        separatorCount = 0;
    }
    
    [passwordField setStringValue:password];
    
    letterCount = [password length];
    bitsOfEntropy = (round((log2(lineCount) * wordCount)) + separatorCount);
    
    [lengthLabel setStringValue:[NSString stringWithFormat:@"%d", (int)letterCount]];
    [entropyBitsLabel setStringValue:[NSString stringWithFormat:@"~%d", (int)bitsOfEntropy]];
    
    if (passwordHistory.textStorage.length > 0) { // If history isn't empty ...
        [passwordHistory moveToEndOfDocument:(nil)]; // ... move to the end of the NSTextView ...
        [passwordHistory insertText:@"\n"]; // ... and insert a new line
    }
    
    [passwordHistory insertText:password];
}

- (IBAction)genPassword:(id)sender
{
    wordCount = [wordsMenu.titleOfSelectedItem integerValue];
    
    for (x=0; x<wordCount; x++) {
        i = arc4random() % lineCount;
        part = [lines objectAtIndex:i];
        
        if (x == 0) {
            self.passwordWithSeparator = part;
            self.passwordWithoutSeparator = part;
        }
        
        else {
            self.passwordWithSeparator = [[self.passwordWithSeparator stringByAppendingString:@"-"] stringByAppendingString:part];
            self.passwordWithoutSeparator = [self.passwordWithoutSeparator stringByAppendingString:part];
        }
    }
    
    [self displayPassword];
}

- (IBAction)copyPassword:(id)sender
{
    NSPasteboard *pasteBoard = [NSPasteboard generalPasteboard];
    [pasteBoard declareTypes:[NSArray arrayWithObjects:NSStringPboardType, nil] owner:nil];
    [pasteBoard setString: [passwordField stringValue] forType:NSStringPboardType];
}

- (IBAction)separatorCheckboxChanged:(id)sender
{
    if (self.passwordWithSeparator || self.passwordWithoutSeparator) { // If a password has already been generated ...
        [self displayPassword]; // ... handoff to displayPassword to update results
    }
}

- (IBAction)goToWebsite:(id)sender
{
    [[NSWorkspace sharedWorkspace] openURL:[NSURL URLWithString:@"https://13cubed.com"]];
}

- (IBAction)goToWebsiteFeedback:(id)sender
{
    [[NSWorkspace sharedWorkspace] openURL:[NSURL URLWithString:@"https://13cubed.com/contact"]];
}

- (IBAction)clearHistory:(id)sender
{
    [passwordHistory setString:@""];
}

@end