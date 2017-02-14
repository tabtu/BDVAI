//
//  Created by Tab on Feb.12 2017
//  Updated by Vain
//
//  Copyright (C) 2017 ttxy.org All Rights Reserved.
//

#import <Foundation/Foundation.h>

// @class - VAIPickerTableViewCell
// @brief - SettingView PicerView Controller
@interface VAIPickerTableViewCell : UITableViewCell <UIPopoverControllerDelegate>
{
    UIPopoverController *_popoverController;
    UIToolbar *_inputAccessoryView;
}

@property (nonatomic, retain) UIPickerView *pickerView;

@end // VAIPickerTableViewCell
