//
//  DMSinglePickerView.h
//  DMPickerView
//
//  Created by 张炯 on 2017/8/8.
//  Copyright © 2017年 张炯. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol DMSinglePickerViewDataSource, DMSinglePickerViewDelegate;


@interface DMSinglePickerView : UIView

@property(nullable,nonatomic,weak) id<DMSinglePickerViewDataSource> dataSource; // default is nil
@property(nullable,nonatomic,weak) id<DMSinglePickerViewDelegate> delegate;     // default is nil
@property(nonatomic,assign) BOOL showSelectionIndicator;   // default is NO
@property(nonatomic,assign) NSInteger selectedIndex;       //set selected index,default is 0

- (instancetype)initWithFrame:(CGRect)frame backgroundColor:(UIColor *)color;


- (void)reloadData;

@end


@protocol DMSinglePickerViewDataSource<NSObject>
@required

// returns the # of rows in each component..
- (NSInteger)dm_numberOfRowsInsinglePickerView:(DMSinglePickerView *)pickerView;

@end


@protocol DMSinglePickerViewDelegate<NSObject>
@optional

// returns width of column and height of row for each component.
//- (CGFloat)dm_singlePickerView:(DMSinglePickerView *)pickerView widthForComponent:(NSInteger)component __TVOS_PROHIBITED;
- (CGFloat)dm_rowHeightForSinglePickerView:(DMSinglePickerView *)pickerView __TVOS_PROHIBITED;

// these methods return either a plain NSString, a NSAttributedString, or a view (e.g UILabel) to display the row for the component.
// for the view versions, we cache any hidden and thus unused views and pass them back for reuse.
// If you return back a different object, the old one will be released. the view will be centered in the row rect
- (nullable NSString *)dm_singlePickerView:(DMSinglePickerView *)pickerView titleForRow:(NSInteger)row __TVOS_PROHIBITED;
//- (nullable NSAttributedString *)dm_singlePickerView:(DMSinglePickerView *)pickerView attributedTitleForRow:(NSInteger)row NS_AVAILABLE_IOS(6_0) __TVOS_PROHIBITED; // attributed title is favored if both methods are implemented
//- (UIView *)dm_singlePickerView:(DMSinglePickerView *)pickerView viewForRow:(NSInteger)row reusingView:(nullable UIView *)view __TVOS_PROHIBITED;

- (void)dm_didSelectRow:(NSInteger)row inSinglePickerView:(DMSinglePickerView *)pickerView  __TVOS_PROHIBITED;

@end

NS_ASSUME_NONNULL_END
