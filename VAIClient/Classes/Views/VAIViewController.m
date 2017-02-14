//
//  VAIViewController.m
//  VAIClient
//
//  Created by Tab on Feb.12 2017
//  Updated by Vain
//
//  Copyright (C) 2017 ttxy.org All Rights Reserved.
//

#import "VAIViewController.h"
#import "BDVoiceRecognitionClient.h"
#import "VAISettingViewController.h"
#import "VAISConfig.h"
#import "VAICustomRecognitonViewController.h"
#import "BDVRUIPromptTextCustom.h"

//#error API_KEY and SECRET_KEY
#define API_KEY @"9WbsX3spxgw1xCoDEwVmiklM"
#define SECRET_KEY @"bf237ccb30fa790505ce9728277503c0"

//#error APP ID
#define APPID @"9269352"

@implementation VAIViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return NO;
}

- (void)dealloc
{
    [_recognizerViewController release];
	[super dealloc];
}


#pragma mark - Button Action

- (void)setButtonUnenabledWithType:(int)type
{
    connectButton.enabled = NO;
	settingButton.enabled = NO;
	voiceRecognitionButton.enabled = NO;
	
	switch (type)
	{
		case EButtonTypeSetting:
		{
			settingButton.enabled = YES;
			break;
		}
		case EButtonTypeVoiceRecognition:
		{
			voiceRecognitionButton.enabled = YES;
			break;
		}
		default:
			break;
	}
	
}

- (void)setAllButtonEnabled
{
    connectButton.enabled = YES;
	settingButton.enabled = YES;
	voiceRecognitionButton.enabled = YES;
}

- (IBAction)connectAction
{
    
}

- (IBAction)settingAction
{
    // 进入设置界面，配置相应的功能开关
	VAISettingViewController *tmpVRSettingViewController = [[VAISettingViewController alloc] initWithStyle:UITableViewStyleGrouped];
	UINavigationController *tmpNavController = [[UINavigationController alloc] initWithRootViewController:tmpVRSettingViewController];
	[self presentViewController:tmpNavController animated:YES completion:nil];
	[tmpVRSettingViewController release];
	[tmpNavController release];
}

- (IBAction)voiceRecognitionAction
{
    [self clean];
    
    // 设置开发者信息
    [[BDVoiceRecognitionClient sharedInstance] setApiKey:API_KEY withSecretKey:SECRET_KEY];

    // 设置语音识别模式，默认是输入模式
    [[BDVoiceRecognitionClient sharedInstance] setPropertyList:@[[VAISConfig sharedInstance].recognitionProperty]];
    
    // 设置城市ID，当识别属性包含EVoiceRecognitionPropertyMap时有效
    [[BDVoiceRecognitionClient sharedInstance] setCityID: 1];
    
    // 设置是否需要语义理解，只在搜索模式有效
    [[BDVoiceRecognitionClient sharedInstance] setConfig:@"nlu" withFlag:[VAISConfig sharedInstance].isNeedNLU];

    // 设置识别语言
    [[BDVoiceRecognitionClient sharedInstance] setLanguage:[VAISConfig sharedInstance].recognitionLanguage];
    
    // 是否打开语音音量监听功能，可选
    if ([VAISConfig sharedInstance].voiceLevelMeter)
    {
        BOOL res = [[BDVoiceRecognitionClient sharedInstance] listenCurrentDBLevelMeter];
        
        if (res == NO)  // 如果监听失败，则恢复开关值
        {
            [VAISConfig sharedInstance].voiceLevelMeter = NO;
        }
    }
    else
    {
        [[BDVoiceRecognitionClient sharedInstance] cancelListenCurrentDBLevelMeter];
    }
    
    // 设置播放开始说话提示音开关，可选
    [[BDVoiceRecognitionClient sharedInstance] setPlayTone:EVoiceRecognitionPlayTonesRecStart isPlay:[VAISConfig sharedInstance].playStartMusicSwitch];
    // 设置播放结束说话提示音开关，可选
    [[BDVoiceRecognitionClient sharedInstance] setPlayTone:EVoiceRecognitionPlayTonesRecEnd isPlay:[VAISConfig sharedInstance].playEndMusicSwitch];
    
    // 创建语音识别界面，在其viewdidload方法中启动语音识别
    VAICustomRecognitonViewController *tmpAudioViewController = [[VAICustomRecognitonViewController alloc] initWithNibName:nil bundle:nil];
    tmpAudioViewController.clientSampleViewController = self;
    self.audioViewController = tmpAudioViewController;
    [tmpAudioViewController release];
    
    [[UIApplication sharedApplication].keyWindow addSubview:_audioViewController.view];

}

#pragma mark - BDRecognizerViewDelegate

- (void)onEndWithViews:(BDRecognizerViewController *)aBDRecognizerView withResults:(NSArray *)aResults
{
    _resultView.text = nil;
    
    if ([[BDVoiceRecognitionClient sharedInstance] getRecognitionProperty] != EVoiceRecognitionPropertyInput)
    {
        NSMutableArray *audioResultData = (NSMutableArray *)aResults;
        NSMutableString *tmpString = [[NSMutableString alloc] initWithString:@""];
        
        for (int i=0; i < [audioResultData count]; i++)
        {
            [tmpString appendFormat:@"%@\r\n",[audioResultData objectAtIndex:i]];
        }
        
        _resultView.text = [_resultView.text stringByAppendingString:tmpString];
        _resultView.text = [_resultView.text stringByAppendingString:@"\n"];
        
        [tmpString release];
    }
    else
    {
        NSString *tmpString = [[VAISConfig sharedInstance] composeInputModeResult:aResults];
        
        _resultView.text = [_resultView.text stringByAppendingString:tmpString];
        _resultView.text = [_resultView.text stringByAppendingString:@"\n"];
    }
}

#pragma mark - clean

- (void)clean
{
    _logCatView.text = nil;
    _resultView.text = nil;
}

- (void)cleanResultViewAfter:(int)length
{
    _resultView.text = [_resultView.text substringToIndex:length];
}

#pragma mark - log & result
	
- (void)logOutToContinusManualResut:(NSString *)aResult
{
    _resultView.text = aResult;
}

- (void)logOutToManualResut:(NSString *)aResult
{
    NSString *tmpString = _resultView.text;
    
    if (tmpString == nil || [tmpString isEqualToString:@""])
    {
        _resultView.text = aResult;
    }
    else
    {
        _resultView.text = [_resultView.text stringByAppendingString:aResult];
    }
}

- (void)logOutToLogView:(NSString *)aLog
{
    NSString *tmpString = _logCatView.text;
    
    if (tmpString == nil || [tmpString isEqualToString:@""])
    {
        _logCatView.text = aLog;
    }
    else
    {
        _logCatView.text = [_logCatView.text stringByAppendingFormat:@"\r\n%@", aLog];
    }
}

@end
