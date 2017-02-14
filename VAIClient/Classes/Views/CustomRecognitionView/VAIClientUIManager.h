//
//  VAIClientUIManager.h
//  VAIClientSample
//
//  Created by Tab on Feb.12 2017
//  Updated by Vain
//
//  Copyright (C) 2017 ttxy.org All Rights Reserved.
//

#import <Foundation/Foundation.h>

// @class - VAIClientUIManager
// @brief - VoiceRecognitonViewController UI
@interface VAIClientUIManager : NSObject

+ (VAIClientUIManager *)sharedInstance;

- (CGRect)VRBackgroundFrame;
- (CGRect)VRRecordTintWordFrame;
- (CGRect)VRRecognizeTintWordFrame;
- (CGRect)VRLeftButtonFrame;
- (CGRect)VRRightButtonFrame;
- (CGRect)VRCenterButtonFrame;

- (CGPoint)VRRecordBackgroundCenter;
- (CGPoint)VRRecognizeBackgroundCenter;
- (CGPoint)VRTintWordCenter;
- (CGPoint)VRCenterButtonCenter;

@end // VAIClientUIManager
