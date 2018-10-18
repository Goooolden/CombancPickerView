//
//  PickerSelectView.h
//  ApplyDemo
//
//  Created by Golden on 2018/8/28.
//  Copyright © 2018年 Golden. All rights reserved.
//

#import "BaseView.h"

typedef void(^ResultBlock)(NSArray *selectValue);

@interface PickerSelectView : BaseView

+ (void)showPickerSelecterWithTitle:(NSString *)title selectInfo:(NSArray *)infoArray resultBlock:(ResultBlock)resultBlock;

@end
