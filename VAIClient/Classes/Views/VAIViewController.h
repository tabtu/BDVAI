//
//  VAIViewController.h
//  VAIClientSample
//
//  Created by Tab on Feb.12 2017
//  Updated by Vain
//
//  Copyright (C) 2017 ttxy.org All Rights Reserved.
//

#import <UIKit/UIKit.h>
#import "BDRecognizerViewController.h"
#import "BDRecognizerViewDelegate.h"
#import "BDVRFileRecognizer.h"
#import "BDVRDataUploader.h"

enum TButtonType
{
	EButtonTypeSetting = 0,
	EButtonTypeVoiceRecognition,
    EButtonTypeSDKUI
};

@class VAICustomRecognitonViewController;

// @class - VAIViewController
// @brief - Main View Implementation
@interface VAIViewController : UIViewController<BDRecognizerViewDelegate, MVoiceRecognitionClientDelegate, BDVRDataUploaderDelegate>
{
    IBOutlet UIButton *connectButton;
	IBOutlet UIButton *settingButton;
	IBOutlet UIButton *voiceRecognitionButton;
}

@property (nonatomic, assign) IBOutlet UITextView *logCatView;
@property (nonatomic, assign) IBOutlet UITextView *resultView;
@property (nonatomic, retain) VAICustomRecognitonViewController *audioViewController;
@property (nonatomic, retain) BDRecognizerViewController *recognizerViewController;

// --UI Actions
- (IBAction)connectAction;
- (IBAction)settingAction;
- (IBAction)voiceRecognitionAction;

// --log & result
- (void)logOutToContinusManualResut:(NSString *)aResult;
- (void)logOutToManualResut:(NSString *)aResult;
- (void)logOutToLogView:(NSString *)aLog;

@end
