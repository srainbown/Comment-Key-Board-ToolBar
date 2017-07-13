//
//  UIViewController+KeyBoardObserver.h
//  Comment-Key-Board-ToolBar
//
//  Created by 紫川秀 on 2017/7/13.
//  Copyright © 2017年 View. All rights reserved.
//

#import <UIKit/UIKit.h>

//设置键盘和第一响应者的间距
#define lzb_settingKeyBoard_DefaultMargin 10

@interface UIViewController (KeyBoardObserver)

/**
 增加点击任意地方消除键盘
 */
- (void)lzb_addKeyBoardTapAnyAutoDismissKeyBoard;

/**
 增加键盘监听观察者
 */
- (void)lzb_addKeyBoardObserverAutoAdjustHeight;

/**
 移除键盘监听观察者，必须实现
 */
- (void)lzb_removeKeyBoardObserver;

@end
