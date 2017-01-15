//
//  MyController.h
//  APG
//
//  Created by Richard Davis on 11/9/10.
//  Copyright 2012 13Cubed. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface MyController : NSObject {
    NSArray *lines;
    NSString *entireFileInString, *part, *password, *passwordWithSeparator, *passwordWithoutSeparator;
    NSInteger bitsOfEntropy, i, letterCount, lineCount, separatorCount, wordCount, x;
    
    IBOutlet NSPopUpButton *wordsMenu;
    IBOutlet NSButton *separatorCheckbox;
    IBOutlet NSTextField *passwordField;
    IBOutlet NSTextField *lengthLabel;
    IBOutlet NSTextField *entropyBitsLabel;
    IBOutlet NSTextView *passwordHistory;
}

@property (nonatomic, retain) NSArray *lines;
@property (nonatomic, retain) NSString *entireFileInString, *passwordWithSeparator, *passwordWithoutSeparator;

- (IBAction)separatorCheckboxChanged:(id)sender;
- (IBAction)genPassword:(id)sender;
- (IBAction)copyPassword:(id)sender;
- (IBAction)goToWebsite:(id)sender;
- (IBAction)goToWebsiteFeedback:(id)sender;
- (IBAction)clearHistory:(id)sender;

@end