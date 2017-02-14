//
//  VAISConfig.m
//  VAIClient
//
//  Created by Tab on Feb.12 2017
//
//  Copyright (C) 2017 ttxy.org All Rights Reserved.
//

#import "VAISConfig.h"
#import "BDVoiceRecognitionClient.h"
#import "BDTheme.h"

@implementation VAISConfig
@synthesize resultContinuousShow;
@synthesize playStartMusicSwitch;
@synthesize playEndMusicSwitch;
@synthesize recognitionLanguage;
@synthesize voiceLevelMeter;
@synthesize uiHintMusicSwitch;
@synthesize isNeedNLU;
@synthesize libVersion = _libVersion;

#pragma mark - init & dealloc

- (id)init 
{
	self = [super init];
	if (self) 
	{
        resultContinuousShow = NO;
        playStartMusicSwitch = NO;
        playEndMusicSwitch = NO;
        _recognitionProperty = [[NSNumber numberWithInt: EVoiceRecognitionPropertyInput] retain];
        recognitionLanguage = EVoiceRecognitionLanguageEnglish;
        voiceLevelMeter = NO;
        uiHintMusicSwitch = NO;
		isNeedNLU = NO;
        
		NSString *tmpString = [[BDVoiceRecognitionClient sharedInstance] libVer];
		_libVersion = [[NSString alloc] initWithString:tmpString];
        _theme = [[BDTheme lightOrangeTheme] retain];
	}
	return self;
}

-(void)dealloc
{
	[_libVersion release];
    [_theme release];
    [super dealloc];
}

+ (VAISConfig *)sharedInstance
{
	static VAISConfig *_sharedInstance = nil;
	if (_sharedInstance == nil)
	{
		_sharedInstance = [[VAISConfig alloc] init];
	}
    
	return _sharedInstance;
}

- (NSString *)composeInputModeResult:(id)aObj
{
    NSMutableString *tmpString = [[NSMutableString alloc] initWithString:@""];
    for (NSArray *result in aObj)
    {
        NSDictionary *dic = [result objectAtIndex:0];
        NSString *candidateWord = [[dic allKeys] objectAtIndex:0];
        [tmpString appendString:candidateWord];
    }
    
    return [tmpString autorelease];
}


@end
