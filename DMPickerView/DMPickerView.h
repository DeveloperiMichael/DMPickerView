//
//  DMPickerView.h
//  DMPickerView
//
//  Created by 张炯 on 2017/8/8.
//  Copyright © 2017年 张炯. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol DMPickerViewDataSource, DMPickerViewDelegate;


@interface DMPickerView : UIView

@property(nullable,nonatomic,weak) id<DMPickerViewDataSource> dataSource; // default is nil

@property(nullable,nonatomic,weak) id<DMPickerViewDelegate> delegate;     // default is nil


@property(nonatomic,assign) BOOL showSelectionIndicator;   // default is NO



@end


@protocol DMPickerViewDataSource<NSObject>
@required

// returns the number of 'columns' to display.
- (NSInteger)dm_numberOfComponentsInPickerView:(DMPickerView *)pickerView;

// returns the # of rows in each component..
- (NSInteger)dm_pickerView:(DMPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component;

@end


@protocol DMPickerViewDelegate<NSObject>
@optional

// returns width of column and height of row for each component.
- (CGFloat)dm_pickerView:(DMPickerView *)pickerView widthForComponent:(NSInteger)component __TVOS_PROHIBITED;
- (CGFloat)dm_pickerView:(DMPickerView *)pickerView rowHeightForComponent:(NSInteger)component __TVOS_PROHIBITED;

// these methods return either a plain NSString, a NSAttributedString, or a view (e.g UILabel) to display the row for the component.
// for the view versions, we cache any hidden and thus unused views and pass them back for reuse.
// If you return back a different object, the old one will be released. the view will be centered in the row rect
- (nullable NSString *)dm_pickerView:(DMPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component __TVOS_PROHIBITED;
- (nullable NSAttributedString *)dm_pickerView:(DMPickerView *)pickerView attributedTitleForRow:(NSInteger)row forComponent:(NSInteger)component NS_AVAILABLE_IOS(6_0) __TVOS_PROHIBITED; // attributed title is favored if both methods are implemented
- (UIView *)dm_pickerView:(DMPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(nullable UIView *)view __TVOS_PROHIBITED;

- (void)dm_pickerView:(DMPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component __TVOS_PROHIBITED;

@end

NS_ASSUME_NONNULL_END


