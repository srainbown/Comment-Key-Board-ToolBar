//
//  CommentKeyBoardToolBar.h
//  Comment-Key-Board-ToolBar
//
//  Created by 紫川秀 on 2017/7/13.
//  Copyright © 2017年 View. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CommentTextView.h"

@interface CommentKeyBoardToolBar : UIView

@property (nonatomic, strong) CommentTextView *inputTextView;  //输入框

/**
 弹出自定义键盘和输入框工具条--无表情键盘  注意：一定是要在viewDidLayout中增加控件
 
 @param toolBarHeight 工具条的高度
 @param sendTextBlock 返回输入框输入的文字
 @return  返回LZBKeyBoardToolBar
 */
+ (CommentKeyBoardToolBar *)showKeyBoardWithConfigToolBarHeight:(CGFloat)toolBarHeight sendTextCompletion:(void(^)(NSString *sendText))sendTextBlock;

/**
 设置输入框占位文字
 @param placeText 占位文字
 */
- (void)setInputViewPlaceHolderText:(NSString *)placeText;

- (void)becomeFirstResponder;

- (void)resignFirstResponder;


@end
