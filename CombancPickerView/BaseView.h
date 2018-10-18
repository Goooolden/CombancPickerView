//
//  BaseView.h
//  ApplyDemo
//
//  Created by Golden on 2018/8/27.
//  Copyright © 2018年 Golden. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseView : UIView
//背景蒙层视图
@property (nonatomic, strong) UIView *backgroundView;
//弹出视图
@property (nonatomic, strong) UIView *alertView;
//标题顶部视图
@property (nonatomic, strong) UIView *topView;
//左边取消按钮
@property (nonatomic, strong) UIButton *leftBtn;
//右边确定按钮
@property (nonatomic, strong) UIButton *rightBtn;
//中间标题
@property (nonatomic, strong) UILabel *titleLabel;
//分割线视图
@property (nonatomic, strong) UIView *lineView;

//初始化子视图，整体布局
- (void)initUI;

/** 点击背景遮罩图层事件 */
- (void)didTapBackgroundView:(UITapGestureRecognizer *)sender;

/** 取消按钮的点击事件 */
- (void)clickLeftBtn;

/** 确定按钮的点击事件 */
- (void)clickRightBtn;

@end
