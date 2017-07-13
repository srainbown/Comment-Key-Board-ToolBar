//
//  UIView+CommentViewFrame.h
//  Comment-Key-Board-ToolBar
//
//  Created by 紫川秀 on 2017/7/13.
//  Copyright © 2017年 View. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (CommentViewFrame)

//只能生成get/Set方法声明
@property (nonatomic,assign) CGFloat LZB_width;

@property (nonatomic,assign) CGFloat LZB_heigth;

@property (nonatomic,assign) CGFloat LZB_x;

@property (nonatomic,assign) CGFloat LZB_y;


@property (nonatomic,assign) CGFloat LZB_centerX;

@property (nonatomic,assign) CGFloat LZB_centerY;

#pragma mark - API
- (BOOL)isDisplayedInScreen;

@end
