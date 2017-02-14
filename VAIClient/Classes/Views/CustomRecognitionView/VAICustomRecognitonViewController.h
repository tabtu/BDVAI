//
//  VAICustomRecognitonViewController.h
//  VAIClient
//
//  Created by Tab on Feb.12 2017
//  Updated by Vain
//
//  Copyright (C) 2017 ttxy.org All Rights Reserved.
//

#import <UIKit/UIKit.h>
#import "BDVoiceRecognitionClient.h"

@class VAIViewController;

// @class - VAIustomRecognitonViewController
// @brief - Voice Search Imp
@interface VAICustomRecognitonViewController : UIViewController<MVoiceRecognitionClientDelegate>
{
	UIImageView *_dialog;
    VAIViewController *clientSampleViewController;
    
    NSTimer *_voiceLevelMeterTimer; // the sound level number timer
}

@property (nonatomic, retain) UIImageView *dialog;
@property (nonatomic, assign) VAIViewController *clientSampleViewController;
@property (nonatomic, retain) NSTimer *voiceLevelMeterTimer;

- (void)cancel:(id)sender;

@end // VAICustomRecognitonViewController
