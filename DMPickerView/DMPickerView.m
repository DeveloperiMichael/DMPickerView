//
//  DMPickerView.m
//  DMPickerView
//
//  Created by 张炯 on 2017/8/8.
//  Copyright © 2017年 张炯. All rights reserved.
//

#import "DMPickerView.h"
#import "DMSinglePickerView.h"

@interface DMPickerView()<DMSinglePickerViewDelegate,DMSinglePickerViewDataSource>

@property(nonatomic,assign) NSInteger componentNumber;
@property(nonatomic,assign) CGFloat viewHeight;
@property(nonatomic,assign) CGFloat viewWidth;
@property(nonatomic,strong) UIColor *viewbgColor;

@end


@implementation DMPickerView

#pragma mark-
#pragma mark- View Life Cycle

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        
    }
    return self;
}

- (void)didMoveToSuperview {
    
}

- (void)layoutSubviews {
    [super layoutSubviews];
    _componentNumber = [_dataSource dm_numberOfComponentsInPickerView:self];
    _viewHeight = self.frame.size.height;
    _viewWidth = self.frame.size.width;
    [self setupSubviewsContraints];
}

#pragma mark-
#pragma mark- <UIScrollViewDelegate>




    

#pragma mark-
#pragma mark- <DMSinglePickerViewDelegate,DMSinglePickerViewDataSource>

- (NSInteger)dm_numberOfRowsInsinglePickerView:(DMSinglePickerView *)pickerView {
    return [_dataSource dm_pickerView:self numberOfRowsInComponent:pickerView.tag-1000];
}

- (nullable NSString *)dm_singlePickerView:(DMSinglePickerView *)pickerView titleForRow:(NSInteger)row {
    return [_delegate dm_pickerView:self titleForRow:row forComponent:pickerView.tag-1000];
}

- (void)dm_didSelectRow:(NSInteger)row inSinglePickerView:(DMSinglePickerView *)pickerView {
    if ([_delegate respondsToSelector:@selector(dm_pickerView:didSelectRow:inComponent:)]) {
        [_delegate dm_pickerView:self didSelectRow:row inComponent:pickerView.tag-1000];
    }
}

#pragma mark-
#pragma mark- Event response




#pragma mark-
#pragma mark- Private Methods




#pragma mark-
#pragma mark- Getters && Setters

- (void)setBackgroundColor:(UIColor *)backgroundColor {
    _viewbgColor = backgroundColor;
}

#pragma mark-
#pragma mark- SetupConstraints

- (void)setupSubviewsContraints{
    
    CGFloat componentWidth = _viewWidth/_componentNumber;
    
    for (int i=0; i<_componentNumber; i++) {
        DMSinglePickerView *pickerView = [[DMSinglePickerView alloc] initWithFrame:CGRectMake(componentWidth*i, 0, componentWidth, _viewHeight) backgroundColor:_viewbgColor];
        pickerView.tag = 1000+i;
        pickerView.delegate = self;
        pickerView.dataSource = self;
        //pickerView.backgroundColor = _viewbgColor;
        [self addSubview:pickerView];
        
    }
}


@end
