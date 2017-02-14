//
//  VAISettingViewController.m
//  VAIClientSample
//
//  Created by Tab on Feb.12 2017
//  Updated by Vain
//
//  Copyright (C) 2017 ttxy.org All Rights Reserved.
//

#import "VAISettingViewController.h"
#import "VAISConfig.h"
#import "BDVoiceRecognitionClient.h"
#import "VAIViewController.h"
#import "VAIPickerTableViewCell.h"

@implementation VAISettingViewController
{
    NSArray *_languageArray;
}
@synthesize clientSampleViewController;

#pragma mark -
#pragma mark Initialization

- (id)initWithStyle:(UITableViewStyle)style
{
	// Override initWithStyle: if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
	self = [super initWithStyle:style];
	if (self)
	{
        _languageArray = [@[@"Chinese(Mandarin)", @"Chinese(Cantonese)", @"English", @"Chinese(Sichuan)"] retain];
		// Custom initialization.
	}
	return self;
}



#pragma mark -
#pragma mark View lifecycle

- (void)viewDidLoad
{
	[super viewDidLoad];

	self.tableView.scrollEnabled = YES;
	self.title = NSLocalizedString(@"StringVRSetting", nil);

	UIBarButtonItem *backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:NSLocalizedString(@"StringFinishSetting", nil) style:UIBarButtonItemStyleDone target:self action:@selector(backAction:)];
	self.navigationItem.leftBarButtonItem = backBarButtonItem;
	[backBarButtonItem release];
}

- (void)backAction:(id)sender
{
	[self dismissViewControllerAnimated:YES completion:nil];
}



#pragma mark -
#pragma mark Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
	// Return the number of sections.
	return 4;
}

- (void)setNeedNLU:(UISwitch *)sender
{
    [VAISConfig sharedInstance].isNeedNLU = sender.on;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	// Return the number of rows in the section.
    if (section == 0)
    {
        return 1;
    }
    else if (section == 1)
    {
        return 1;
    }
    else if (section == 2)
    {
        return 2;
    }
    else
    {
        return 1;
    }
}

- (void)resultContinuousShowSwitch:(UISwitch *)sender
{
	[VAISConfig sharedInstance].resultContinuousShow = sender.on;
}

- (void)uiHintMusicSwitch:(UISwitch *)sender
{
	[VAISConfig sharedInstance].uiHintMusicSwitch = sender.on;
}

- (void)playStartMusicSwitch:(UISwitch *)sender
{
	[VAISConfig sharedInstance].playStartMusicSwitch = sender.on;
	if (sender.on)
	{
		[[BDVoiceRecognitionClient sharedInstance] setPlayTone:EVoiceRecognitionPlayTonesRecStart isPlay:YES];
	}
	else 
	{
		[[BDVoiceRecognitionClient sharedInstance] setPlayTone:EVoiceRecognitionPlayTonesRecStart isPlay:NO];
	}
}

- (void)playEndMusicSwitch:(UISwitch *)sender
{
	[VAISConfig sharedInstance].playEndMusicSwitch = sender.on;
	if (sender.on)
	{
		[[BDVoiceRecognitionClient sharedInstance] setPlayTone:EVoiceRecognitionPlayTonesRecEnd isPlay:YES];
	}
	else 
	{
		[[BDVoiceRecognitionClient sharedInstance] setPlayTone:EVoiceRecognitionPlayTonesRecEnd isPlay:NO];
	}
}

- (void)voiceLevelMeterSwitch:(UISwitch *)sender
{
	[VAISConfig sharedInstance].voiceLevelMeter = sender.on;
	if (sender.on)
	{
		[[BDVoiceRecognitionClient sharedInstance] listenCurrentDBLevelMeter];
	}
	else
	{
		[[BDVoiceRecognitionClient sharedInstance] cancelListenCurrentDBLevelMeter];
	}
}

// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	int row = [indexPath row];
    int section = [indexPath section];

    static NSString *CellIdentifier = @"Cell";
    static NSString *PickerCellIdentifier = @"PickerCell";

    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:(indexPath.section == 0 && indexPath.row == 0) || (indexPath.section == 0 && indexPath.row == 2) || (indexPath.section == 2 && indexPath.row == 1) ?
                                                                         PickerCellIdentifier : CellIdentifier];

    if (cell == nil)
    {
        if ((indexPath.section == 0 && indexPath.row == 0) || (indexPath.section == 0 && indexPath.row == 2) || (indexPath.section == 2 && indexPath.row == 1))
        {
            cell = [[[VAIPickerTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:PickerCellIdentifier] autorelease];
            ((VAIPickerTableViewCell *)cell).pickerView.delegate = self;
            ((VAIPickerTableViewCell *)cell).pickerView.tag = section * 10 + row;
        }
        else
        {
            cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier] autorelease];
        }
    } else {
        if ((indexPath.section == 0 && indexPath.row == 0) || (indexPath.section == 0 && indexPath.row == 2) || (indexPath.section == 2 && indexPath.row == 1))
        {
            ((VAIPickerTableViewCell *)cell).pickerView.delegate = self;
            ((VAIPickerTableViewCell *)cell).pickerView.tag = section * 10 + row;
        }
    }


	cell.accessoryType = UITableViewCellAccessoryNone;
	cell.selectionStyle = UITableViewCellSelectionStyleNone;
	cell.textLabel.font = [UIFont boldSystemFontOfSize:14.0f];
	cell.textLabel.textColor = [UIColor blackColor];

    if (section == 0)
    {
        if (row == 0)
        {
            cell.textLabel.text = NSLocalizedString(@"StringLanguage", nil);
            
            UILabel *sampleRateLable = [[UILabel alloc] initWithFrame:CGRectZero];
            sampleRateLable.frame = CGRectMake(-40, 0, 66, 40);
            sampleRateLable.textAlignment = UITextAlignmentCenter;
            sampleRateLable.font = [UIFont boldSystemFontOfSize:14.0];
            sampleRateLable.textColor = [UIColor blackColor];
            sampleRateLable.backgroundColor = [UIColor clearColor];
            sampleRateLable.text = [_languageArray objectAtIndex:[VAISConfig sharedInstance].recognitionLanguage];
            cell.accessoryView = sampleRateLable;
            [sampleRateLable release];
        }
    }
    else if (section == 1)
    {
        if (row == 0)
        {
            cell.textLabel.text = NSLocalizedString(@"StringSaveVoiceLevelMeter", nil);
            UISwitch *tmpSwitch = [[UISwitch alloc] init];
            tmpSwitch.on = [VAISConfig sharedInstance].voiceLevelMeter;
            [tmpSwitch addTarget:self action:@selector(voiceLevelMeterSwitch:) forControlEvents:UIControlEventValueChanged];
            cell.accessoryView = tmpSwitch;
            [tmpSwitch release];
        }
    }
    else if (section == 2)
    {
        if (row == 0)
        {
            cell.textLabel.text = NSLocalizedString(@"StringRecoginitonResultContinuousShow", nil);
            UISwitch *tmpSwitch = [[UISwitch alloc] init];
            tmpSwitch.on = [VAISConfig sharedInstance].resultContinuousShow;
            [tmpSwitch addTarget:self action:@selector(resultContinuousShowSwitch:) forControlEvents:UIControlEventValueChanged];
            cell.accessoryView = tmpSwitch;
            [tmpSwitch release];
        }
        else if (row == 1)
        {
            cell.textLabel.text = NSLocalizedString(@"StringClosedUIHintMusic", nil);
            UISwitch *tmpSwitch = [[UISwitch alloc] init];
            tmpSwitch.on = [VAISConfig sharedInstance].uiHintMusicSwitch;
            [tmpSwitch addTarget:self action:@selector(uiHintMusicSwitch:) forControlEvents:UIControlEventValueChanged];
            cell.accessoryView = tmpSwitch;
            [tmpSwitch release];
        }
    }
    else
    {
        if (row == 0)
        {
            cell.accessoryView = nil;
            cell.textLabel.text = NSLocalizedString(@"StringLibVersion", nil);
            cell.textLabel.text = [cell.textLabel.text stringByAppendingString:[VAISConfig sharedInstance].libVersion];
        }
    }
	return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    NSString *titleString = nil;
    if (section == 0)
    {
        titleString = NSLocalizedString(@"StringSectionTitleCommon", nil);
    }
    else if (section == 1)
    {
        titleString = NSLocalizedString(@"StringSectionTitleNoUI", nil);
    }
    else if (section == 2)
    {
        titleString = NSLocalizedString(@"StringSectionTitleUI", nil);
    }
    else
    {
        titleString = NSLocalizedString(@"StringSectionTitleVersion", nil);
    }
    
    return titleString;
}

#pragma mark -
#pragma mark UIPickerViewDelegate

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    switch (pickerView.tag) {
        case 0:
            [VAISConfig sharedInstance].recognitionLanguage = row;
            break;
        default:
            break;
    }
    [self.tableView reloadData];
}

#pragma mark -
#pragma mark UIPickerViewDataSource

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    NSString *name = @"";
    switch (pickerView.tag) {
        case 0:
            name = [_languageArray objectAtIndex:row];
            break;
        default:
            break;
    }
    return name;
}

- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component
{
    CGFloat componentWidth = 320.0;

    return componentWidth;
}

- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component
{
    return 40.0;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    NSInteger numberOfRows = 0;
    switch (pickerView.tag) {
        case 0:
            numberOfRows = [_languageArray count];
            break;
        default:
            break;
    }
	return numberOfRows;
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}


#pragma mark -
#pragma mark Memory management

- (void)didReceiveMemoryWarning
{
	// Releases the view if it doesn't have a superview.
	[super didReceiveMemoryWarning];

	// Relinquish ownership any cached data, images, etc. that aren't in use.
}

- (void)viewDidUnload
{
	// Relinquish ownership of anything that can be recreated in viewDidLoad or on demand.
	// For example: self.myOutlet = nil;
}


- (void)dealloc
{
    [_languageArray release];
    [super dealloc];
}


@end // VAISettingViewController

