//
//  PickerDefine.h
//  ApplyDemo
//
//  Created by Golden on 2018/8/28.
//  Copyright © 2018年 Golden. All rights reserved.
//

#ifndef PickerDefine_h
#define PickerDefine_h

#define kPicHeight 200     //选择器的高度
#define KTopViewHeight 44  //取消 标题 确定 行高

#define KCalendarItemWH (SCREEN_WIDTH - 20 - 6 * 8) / 7  //日历宽度
#define KDataHeight (6 * KCalendarItemWH + 6 * 8 + 35)   //日期选择器高度

#define SCREEN_BOUNDS [UIScreen mainScreen].bounds
#define SCREEN_WIDTH  [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height

#define kGrayFontColor [UIColor darkGrayColor]
#define kBlueFontColor [UIColor blueColor]
#define kBlackFontColor [UIColor blackColor]

#endif /* PickerDefine_h */
