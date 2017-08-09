//
//  DMSinglePickerView.m
//  DMSinglePickerView
//
//  Created by 张炯 on 2017/8/8.
//  Copyright © 2017年 张炯. All rights reserved.
//

#import "DMSinglePickerView.h"
#import <Masonry/Masonry.h>



static NSInteger const kSelectTableViewTag = 100;
static NSInteger const kBackTableViewTag = 200;
static NSString *const kSelectTableViewCellIdentifier = @"selectTableView.cellIdentifier";
static NSString *const kDisplayTableViewCellIdentifier = @"backTableView.cellIdentifier";


@interface DMSinglePickerView()<UITableViewDelegate,UITableViewDataSource,UIScrollViewDelegate>

@property(nonatomic,strong) UITableView *selectTableView;
@property(nonatomic,strong) UITableView *backTableView;

/**
 行高
 */
@property(nonatomic,assign) CGFloat rowHeight;

/**
 总共多少行数据
 */
@property(nonatomic,assign) NSInteger rowNumber;

/**
 展示多少行收据（界面能看到的）
 */
@property(nonatomic,assign) NSInteger displayNumber;

/**
 展示数据的tableView高度
 */
@property(nonatomic,assign) CGFloat tableHeight;

/**
 选中颜色
 */
@property (nonatomic, strong) UIColor *selectedColor;

/**
 非选中颜色
 */
@property (nonatomic, strong) UIColor *unselectedColor;

/**
 选中字体大小
 */
@property (nonatomic, strong) UIFont *selectedFont;

/**
 非选中字体大小
 */
@property (nonatomic, strong) UIFont *unselectedFont;

@property(nonatomic,strong) UIColor *viewbgColor;

@end


@implementation DMSinglePickerView

#pragma mark-
#pragma mark- View Life Cycle

- (instancetype)initWithFrame:(CGRect)frame backgroundColor:(UIColor *)color {
    self = [super initWithFrame:frame];
    if (self) {
        _viewbgColor = color;
        _unselectedColor = [UIColor grayColor];
        _selectedColor = [UIColor redColor];
        _selectedFont = [UIFont systemFontOfSize:18.0];
        _unselectedFont = [UIFont systemFontOfSize:14.0];
        _selectedIndex = 0;
                
        if ([_delegate respondsToSelector:@selector(dm_didSelectRow:inSinglePickerView:)]) {
            [_delegate dm_didSelectRow:_selectedIndex inSinglePickerView:self];
        }
        
        if ([_delegate respondsToSelector:@selector(dm_rowHeightForSinglePickerView:)]) {
            _rowHeight = [_delegate dm_rowHeightForSinglePickerView:self];
        }else{
            _rowHeight = 50;
        }
        
        NSInteger count = self.frame.size.height/_rowHeight;
        if (count%2 == 1) {
            _displayNumber = count;
        }else{
            _displayNumber = count-1;
        }
        _tableHeight = _displayNumber*_rowHeight;
        [self setupSubviewsContraints];
        
        [self setScrollView:_selectTableView atIndex:_selectedIndex animated:YES];
        [self setScrollView:_backTableView atIndex:_selectedIndex animated:YES];
        
    }
    return self;
}




#pragma mark-
#pragma mark- <UIScrollViewDelegate>

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (scrollView.tag == kBackTableViewTag) {
        _selectTableView.contentOffset = scrollView.contentOffset;
    }
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    _selectedIndex = [self getIndexForScrollViewPosition:scrollView];
    if (scrollView.tag == kBackTableViewTag) {
        _selectTableView.contentOffset = scrollView.contentOffset;
    }
    [self setScrollView:scrollView atIndex:_selectedIndex animated:YES];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    _selectedIndex = [self getIndexForScrollViewPosition:scrollView];
    if (scrollView.tag == kSelectTableViewTag) {
        _backTableView.contentOffset = scrollView.contentOffset;
    }
    [self setScrollView:scrollView atIndex:_selectedIndex animated:YES];
}


- (NSInteger)getIndexForScrollViewPosition:(UIScrollView *)scrollView {
    
    CGFloat offsetContentScrollView = (scrollView.frame.size.height - _rowHeight) / 2.0;
    CGFloat offetY = scrollView.contentOffset.y;
    CGFloat exactIndex = (offetY + offsetContentScrollView) / _rowHeight;
    NSInteger intIndex = floorf((offetY + offsetContentScrollView) / _rowHeight);
    NSInteger index;
    if (intIndex+0.5>exactIndex) {
        index = intIndex;
    }else{
        index = intIndex+1;
    }
    index = index-(_displayNumber-1)/2;
    return index;
}

- (void)setScrollView:(UIScrollView*)scrollView atIndex:(NSInteger)index animated:(BOOL)animated {
    
    if (!scrollView) return;
    
    if (animated) {
        [UIView beginAnimations:@"ScrollViewAnimation" context:nil];
        [UIView setAnimationDuration:0.25];
        [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    }
    
    scrollView.contentOffset = CGPointMake(0.0, (index * _rowHeight));
    
    if (animated) {
        [UIView commitAnimations];
    }
    
    if (_selectedIndex>=0&&_selectedIndex<_rowNumber) {
        if ([_delegate respondsToSelector:@selector(dm_didSelectRow:inSinglePickerView:)]) {
            [_delegate dm_didSelectRow:_selectedIndex inSinglePickerView:self];
        }
    }
    
}

#pragma mark-
#pragma mark- <UITableViewDelegate,UITableViewDataSource>

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    _rowNumber = [_dataSource dm_numberOfRowsInsinglePickerView:self];
    if (tableView == _backTableView) {
        return _rowNumber+(_displayNumber-1);
    }else{
        return _rowNumber;
    }
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (tableView == _selectTableView) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kSelectTableViewCellIdentifier];
        cell.textLabel.font = _selectedFont;
        cell.textLabel.textAlignment = NSTextAlignmentCenter;
        cell.textLabel.textColor = _selectedColor;
        cell.textLabel.text = [_delegate dm_singlePickerView:self titleForRow:indexPath.row];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.backgroundColor = [UIColor clearColor];
        return cell;
        
    }else if (tableView == _backTableView){
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kDisplayTableViewCellIdentifier];
        cell.textLabel.font = _unselectedFont;
        cell.textLabel.textAlignment = NSTextAlignmentCenter;
        cell.textLabel.textColor = _unselectedColor;
        if (indexPath.row>(_displayNumber-1)/2-1&&indexPath.row<_rowNumber+(_displayNumber-1)/2) {
            cell.textLabel.text = [_delegate dm_singlePickerView:self titleForRow:indexPath.row-(_displayNumber-1)/2];
        }else{
            cell.textLabel.text = @"";
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.backgroundColor = [UIColor clearColor];
        return cell;
    }
    
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return _rowHeight;
}




#pragma mark-
#pragma mark- Event response




#pragma mark-
#pragma mark- Private Methods




#pragma mark-
#pragma mark- Getters && Setters

- (UITableView *)selectTableView {
    if (!_selectTableView) {
        _selectTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _selectTableView.delegate = self;
        _selectTableView.dataSource = self;
        _selectTableView.userInteractionEnabled = NO;
        _selectTableView.tag = kSelectTableViewTag;
        _selectTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _selectTableView.showsVerticalScrollIndicator = NO;
//        _selectTableView.bounces = NO;
        _selectTableView.backgroundColor = _viewbgColor?_viewbgColor:[UIColor whiteColor];
        [_selectTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:kSelectTableViewCellIdentifier];
    }
    
    return _selectTableView;
}

- (UITableView *)backTableView {
    if (!_backTableView) {
        _backTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _backTableView.delegate = self;
        _backTableView.dataSource = self;
        _backTableView.tag = kBackTableViewTag;
        _backTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _backTableView.showsVerticalScrollIndicator = NO;
//        _backTableView.bounces = NO;
        _backTableView.backgroundColor = _viewbgColor?_viewbgColor:[UIColor whiteColor];
        [_backTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:kDisplayTableViewCellIdentifier];
    }
    
    return _backTableView;
    
}

- (void)setSelectedIndex:(NSInteger)selectedIndex {
    _selectedIndex = selectedIndex;
}

#pragma mark-
#pragma mark- SetupConstraints

- (void)setupSubviewsContraints{
    [self addSubview:self.backTableView];
    [self addSubview:self.selectTableView];
    [_backTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(self);
        make.height.mas_equalTo(_tableHeight);
        make.left.right.mas_equalTo(self);
    }];
    [_selectTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(self);
        make.height.mas_equalTo(_rowHeight);
        make.left.right.mas_equalTo(self);
    }];
}


@end
