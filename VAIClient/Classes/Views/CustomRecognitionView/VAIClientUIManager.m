//
//  VAIClientUIManager.m
//  VAIClient
//
//  Created by Tab on Feb.12 2017
//  Updated by Vain
//
//  Copyright (C) 2017 ttxy.org All Rights Reserved.
//

#import "VAIClientUIManager.h"

@implementation VAIClientUIManager

#pragma mark - init & dealloc
- (id)init 
{
	self = [super init];
 	if (self) 
    {
        //
	}
	return self;
}

+ (VAIClientUIManager *)sharedInstance
{
	static VAIClientUIManager *_sharedInstance = nil;
	if (_sharedInstance == nil)
		_sharedInstance = [[VAIClientUIManager alloc] init];
	return _sharedInstance;
}

#pragma mark - UIManager Methods

- (CGRect)VRBackgroundFrame
{
	return [UIScreen mainScreen].applicationFrame;
}

- (CGRect)VRRecordTintWordFrame
{
	return CGRectMake(0.0f, 0.0f, 260.0f, 42.0f);
}

- (CGRect)VRRecognizeTintWordFrame
{
	return CGRectMake(0.0f, 0.0f, 260.0f, 42.0f);
}

- (CGRect)VRLeftButtonFrame
{
	return CGRectMake(0.0f, 214.0f - 58.0f, 144.0f, 52.0f);
}

- (CGRect)VRRightButtonFrame
{
	return CGRectMake(144.0f, 214.0f - 58.0f, 145.0f, 52.0f);
}

- (CGRect)VRCenterButtonFrame
{
	return CGRectMake(0.0f, 0.0f, 260.0f, 52.0f);
}

#pragma mark center point

- (CGPoint)VRRecordBackgroundCenter
{
    return CGPointMake(145.0f, 56.0f);
}

- (CGPoint)VRRecognizeBackgroundCenter
{
    return CGPointMake(145.0f, 46.0f);
}

- (CGPoint)VRTintWordCenter
{
    return CGPointMake(145.0f, 120.0f);
}

- (CGPoint)VRCenterButtonCenter
{
    return CGPointMake(145.0f, 182.0f);
}

@end // VAIClientUIManager
