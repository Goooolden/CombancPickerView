//
//  PickerSelectView.m
//  ApplyDemo
//
//  Created by Golden on 2018/8/28.
//  Copyright © 2018年 Golden. All rights reserved.
//

#import "PickerSelectView.h"
#import "PickerDefine.h"

@interface PickerSelectView()<UIPickerViewDelegate,UIPickerViewDataSource>

@property (nonatomic, strong) UIPickerView *picker;
@property (nonatomic, copy  ) NSString *title;
@property (nonatomic, copy  ) NSArray *infoArray;
@property (nonatomic, copy  ) ResultBlock resultBlock;
@property (nonatomic, strong) NSMutableArray *selectValueArray;

@end

@implementation PickerSelectView

+ (void)showPickerSelecterWithTitle:(NSString *)title selectInfo:(NSArray *)infoArray resultBlock:(ResultBlock)resultBlock {
    
    PickerSelectView *pickerSelect = [[PickerSelectView alloc]initWithTitle:title selectInfo:infoArray resultBlock:resultBlock];
    [pickerSelect showWithAnimation:YES];
}

- (instancetype)initWithTitle:(NSString *)title selectInfo:(NSArray *)infoArray resultBlock:(ResultBlock)resultBlock {
    if (self = [super init]) {
        _title = title;
        _infoArray = infoArray;
        _resultBlock = resultBlock;
        [self initUI];
    }
    return self;
}

//UI布局，主要就是在弹出视图上添加选择器
- (void)initUI {
    [super initUI];
    self.titleLabel.text = _title;
    [self.alertView addSubview:self.picker];
}

#pragma mark - 初始化数据
- (NSMutableArray *)selectValueArray {
    if (!_selectValueArray) {
        _selectValueArray = [[NSMutableArray alloc]init];
        for (int i = 0; i < _infoArray.count; i++) {
            NSLog(@"--%lu",(unsigned long)[_infoArray[i] count]);
            if ([_infoArray[i] count] == 0) continue;
            [_selectValueArray addObject:_infoArray[i][0]];
            NSLog(@"---%@",_infoArray[i][0]);
        }
    }
    return _selectValueArray;
}

//选择器的初始化和布局
-(UIPickerView *)picker {
    if (!_picker) {
        _picker = [[UIPickerView alloc]initWithFrame:CGRectMake(0, KTopViewHeight + 0.5, SCREEN_WIDTH, kPicHeight)];
        _picker.showsSelectionIndicator = YES;
        //设置代理
        _picker.delegate = self;
        _picker.dataSource = self;
    }
    return _picker;
}

#pragma mark - UIPickerView数据布局
//返回多少列
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return self.infoArray.count;
}

//返回多少行
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return [self.infoArray[component] count];
}

//每一行的数据
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    return self.infoArray[component][row];
}

//选中时的效果
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    for (int i = 0; i < self.infoArray.count; i++) {
        if (i == component) {
            [self.selectValueArray replaceObjectAtIndex:i withObject:self.infoArray[component][row]];
        }
    }
}

//返回高度
- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component {
    return 35.0f;
}

//返回宽度
- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component {
    return SCREEN_WIDTH/self.infoArray.count;
}

#pragma mark - 背景视图的点击事件
- (void)didTapBackgroundView:(UITapGestureRecognizer *)sender {
    [self dismissWithAnimation:YES];
}

#pragma mark - 弹出视图方法
- (void)showWithAnimation:(BOOL)animation {
    //获取当前应用的主窗口
    UIWindow *keyWindow = [[UIApplication sharedApplication] keyWindow];
    [keyWindow addSubview:self];
    if (animation) {
        //动画前初始位置
        CGRect rect = self.alertView.frame;
        rect.origin.y = SCREEN_HEIGHT;
        self.alertView.frame = rect;
        //浮现动画
        [UIView animateWithDuration:0.3 animations:^{
            CGRect rect = self.alertView.frame;
            rect.origin.y -= kPicHeight + KTopViewHeight;
            self.alertView.frame = rect;
        }];
    }
}

#pragma mark - 关闭视图方法
- (void)dismissWithAnimation:(BOOL)animation {
    //关闭动画
    [UIView animateWithDuration:0.2 animations:^{
        CGRect rect = self.alertView.frame;
        rect.origin.y += kPicHeight + KTopViewHeight;
        self.alertView.frame = rect;
        self.backgroundView.alpha = 0;
    } completion:^(BOOL finished) {
        [self.leftBtn removeFromSuperview];
        [self.rightBtn removeFromSuperview];
        [self.titleLabel removeFromSuperview];
        [self.lineView removeFromSuperview];
        [self.topView removeFromSuperview];
        [self.picker removeFromSuperview];
        [self.alertView removeFromSuperview];
        [self.backgroundView removeFromSuperview];
        [self removeFromSuperview];
        
        self.leftBtn = nil;
        self.rightBtn = nil;
        self.titleLabel = nil;
        self.lineView = nil;
        self.topView = nil;
        self.picker = nil;
        self.alertView = nil;
        self.backgroundView = nil;
    }];
}

#pragma mark - 取消按钮点击事件
- (void)clickLeftBtn {
    [self dismissWithAnimation:YES];
}

#pragma mark - 确定按钮的点击事件
- (void)clickRightBtn {
    NSArray *selectedArray = [NSArray arrayWithArray:self.selectValueArray];
    if(_resultBlock) {
        _resultBlock(selectedArray);
    }
    [self dismissWithAnimation:YES];
}

@end
