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

@property(nonatomic,strong) NSArray *dataArray;

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
//    return self.dataArray.count;
//}
//
//
//- (nullable NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
//    return self.dataArray[row];
//}

//- (NSInteger)dm_numberOfRowsInsinglePickerView:(DMSinglePickerView *)pickerView {
//    return self.dataArray.count;
//}
//
//- (nullable NSString *)dm_singlePickerView:(DMSinglePickerView *)pickerView titleForRow:(NSInteger)row {
//    return self.dataArray[row];
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
    return self.dataArray.count;
}

- (nullable NSString *)dm_pickerView:(DMPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    return self.dataArray[row];
}

- (void)dm_pickerView:(DMPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    NSLog(@"--component:%ld---row:%ld---",component,row);
}

#pragma mark-
#pragma mark- Event response



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

- (NSArray *)dataArray {
    if (!_dataArray) {
        _dataArray = [NSArray arrayWithObjects:@"UIPickerView",@"dataSource",@"delegate",@"brownColor",@"return",@"SetupConstraints",@"mas_makeConstraints",@"backgroundColor",@"self",@"MASConstraintMaker",@"mas_equalTo",@"Getters",@"alloc", nil];
    }
    return _dataArray;
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
    [_pickerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view);
        make.top.mas_equalTo(self.view).mas_offset(50);
        make.bottom.mas_equalTo(self.view).mas_offset(-50);
        make.left.mas_equalTo(self.view).mas_offset(80);
        make.right.mas_equalTo(self.view).mas_offset(-80);
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
