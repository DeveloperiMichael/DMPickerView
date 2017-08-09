//
//  ViewController.m
//  DMPickerView
//
//  Created by 张炯 on 2017/8/8.
//  Copyright © 2017年 张炯. All rights reserved.
//

#import "ViewController.h"
#import <Masonry/Masonry.h>
#import "DMSinglePickerView.h"
#import "DMPickerView.h"

@interface ViewController ()<DMPickerViewDelegate,DMPickerViewDataSource>

//@property(nonatomic,strong) DMSinglePickerView *pickerView;

@property(nonatomic,strong) DMPickerView *pickerView;
@property(nonatomic,strong) UIButton *reloadButton;
@property(nonatomic,strong) NSMutableArray *dataArray1;
@property(nonatomic,strong) NSMutableArray *dataArray2;
@end

@implementation ViewController

#pragma mark-
#pragma mark- View Life Cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setupSubviewsContraints];
}


#pragma mark-
#pragma mark- Request




#pragma mark-
#pragma mark- Response



#pragma mark-
#pragma mark- SACardViewDataSource




#pragma mark-
#pragma mark- delegate

//- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
//    return 2;
//}
//
//- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
//    return self.dataArray1.count;
//}
//
//
//- (nullable NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
//    return self.dataArray1[row];
//}

//- (NSInteger)dm_numberOfRowsInsinglePickerView:(DMSinglePickerView *)pickerView {
//    return self.dataArray1.count;
//}
//
//- (nullable NSString *)dm_singlePickerView:(DMSinglePickerView *)pickerView titleForRow:(NSInteger)row {
//    return self.dataArray1[row];
//}
//
//- (CGFloat)dm_rowHeightForSinglePickerView:(DMSinglePickerView *)pickerView {
//    return 44;
//}
//
//- (void)dm_didSelectRow:(NSInteger)row inSinglePickerView:(DMSinglePickerView *)pickerView {
//    NSLog(@"%ld",row);
//}


- (NSInteger)dm_numberOfComponentsInPickerView:(DMPickerView *)pickerView {
    return 2;
}

// returns the # of rows in each component..
- (NSInteger)dm_pickerView:(DMPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return self.dataArray1.count;
}

- (nullable NSString *)dm_pickerView:(DMPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    switch (component) {
        case 0:
        {
            return self.dataArray1[row];
        }
            break;
        case 1:
        {
            return self.dataArray2[row];
        }
            break;
        default:
            return @"";
            break;
    }
    
}

- (void)dm_pickerView:(DMPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    NSLog(@"--component:%ld---row:%ld---",component,row);
}

#pragma mark-
#pragma mark- Event response

- (void)reloadButtonAction:(UIButton *)button {
    NSArray *array = [NSArray arrayWithObjects:@"reloadDataInComponent",@"addObjectsFromArray",@"removeAllObjects",@"Private",@"Methods",@"component",@"array",@"row",@"#pragma mark-",@"Getters && Setters", nil];
    [_dataArray1 removeAllObjects];
    [_dataArray1 addObjectsFromArray:array];
    [_pickerView reloadDataInComponent:0];
}

#pragma mark-
#pragma mark- Private Methods




#pragma mark-
#pragma mark- Getters && Setters

//- (DMSinglePickerView *)pickerView {
//    if (!_pickerView) {
//        _pickerView = [[DMSinglePickerView alloc] init];
//        _pickerView.dataSource = self;
//        _pickerView.delegate = self;
//        _pickerView.backgroundColor = [UIColor orangeColor];
//        _pickerView.selectedIndex = 3;
//    }
//    return _pickerView;
//}

- (UIButton *)reloadButton {
    if (!_reloadButton) {
        _reloadButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _reloadButton.backgroundColor = [UIColor blueColor];
        [_reloadButton setTitle:@"reloadData" forState:UIControlStateNormal];
        [_reloadButton addTarget:self action:@selector(reloadButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _reloadButton;
}

- (NSMutableArray *)dataArray1 {
    if (!_dataArray1) {
        _dataArray1 = [NSMutableArray arrayWithObjects:@"UIPickerView",@"dataSource",@"delegate",@"brownColor",@"return",@"SetupConstraints",@"mas_makeConstraints",@"backgroundColor",@"self",@"MASConstraintMaker",@"mas_equalTo",@"Getters",@"alloc", nil];
    }
    return _dataArray1;
}

- (NSMutableArray *)dataArray2 {
    if (!_dataArray2) {
        _dataArray2 = [NSMutableArray arrayWithObjects:@"UIPickerView",@"dataSource",@"delegate",@"brownColor",@"return",@"SetupConstraints",@"mas_makeConstraints",@"backgroundColor",@"self",@"MASConstraintMaker",@"mas_equalTo",@"Getters",@"alloc", nil];
    }
    return _dataArray2;
}


- (DMPickerView *)pickerView {
    if (!_pickerView) {
        _pickerView = [[DMPickerView alloc] init];
        _pickerView.dataSource = self;
        _pickerView.delegate = self;
        _pickerView.backgroundColor = [UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:1.0];
    }
    return _pickerView;
}


#pragma mark-
#pragma mark- SetupConstraints

- (void)setupSubviewsContraints{
    [self.view addSubview:self.pickerView];
    [self.view addSubview:self.reloadButton];
    [_pickerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view);
        make.top.mas_equalTo(self.view).mas_offset(50);
        make.bottom.mas_equalTo(self.view).mas_offset(-50);
        make.left.mas_equalTo(self.view).mas_offset(80);
        make.right.mas_equalTo(self.view).mas_offset(-80);
    }];
    [_reloadButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_pickerView.mas_bottom);
        make.left.right.bottom.mas_equalTo(self.view);
        
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
