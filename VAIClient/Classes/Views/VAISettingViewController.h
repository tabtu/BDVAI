//
//  VAISettingViewController.h
//  VAIClient
//
//  Created by Tab on Feb.12 2017
//  Updated by Vain
//
//  Copyright (C) 2017 ttxy.org All Rights Reserved.
//

#import <UIKit/UIKit.h>

@class VAIViewController;

// @class - VAISettingViewController
// @brief - Setting Imp
@interface VAISettingViewController : UITableViewController <UIPickerViewDelegate>
{
    VAIViewController *clientSampleViewController;
}

@property (nonatomic, assign) VAIViewController *clientSampleViewController;

@end // VAISettingViewController
