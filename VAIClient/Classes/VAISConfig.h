//
//  VAISConfig.h
//  VAIClient
//
//  Created by Tab on Feb.12 2017
//
//  Copyright (C) 2017 ttxy.org All Rights Reserved.
//

#import <Foundation/Foundation.h>

@class BDTheme;
// @class - VAISConfig
// @brief - Public interface and data access.

@interface VAISConfig : NSObject
{
	BOOL playStartMusicSwitch;
	BOOL playEndMusicSwitch;
    int recognitionLanguage;
    BOOL resultContinuousShow;
	BOOL voiceLevelMeter;
    BOOL uiHintMusicSwitch;
	
	NSString *_libVersion;
}

@property (nonatomic) BOOL playStartMusicSwitch;
@property (nonatomic) BOOL playEndMusicSwitch;
@property (nonatomic, retain) NSNumber *recognitionProperty;
@property (nonatomic) int recognitionLanguage;
@property (nonatomic) BOOL resultContinuousShow;
@property (nonatomic) BOOL voiceLevelMeter;
@property (nonatomic) BOOL uiHintMusicSwitch;
@property (nonatomic) BOOL isNeedNLU;
@property (nonatomic, retain) NSString *libVersion;
@property (nonatomic, retain) BDTheme *theme;

+ (VAISConfig *)sharedInstance;

- (NSString *)composeInputModeResult:(id)aObj;

@end
