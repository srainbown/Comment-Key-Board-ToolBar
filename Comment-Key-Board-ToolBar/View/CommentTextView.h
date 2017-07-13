//
//  CommentTextView.h
//  Comment-Key-Board-ToolBar
//
//  Created by 紫川秀 on 2017/7/13.
//  Copyright © 2017年 View. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CommentTextView : UITextView

/**
 * 设置占位文字
 */
@property (nonatomic, copy) NSString *placeholder;

/**
 *  设置占位文字颜色
 */
@property (nonatomic, strong) UIColor *placeholderColor;

/**
 *  占位文字的X偏移量
 */
@property (nonatomic, assign) CGFloat placeHolderOffsetX;

/**
 *  占位文字的Y偏移量
 */
@property (nonatomic, assign) CGFloat placeHolderOffsetY;

/**
 *  光标的偏移量
 */
@property (nonatomic, assign) UIOffset  cursorOffset;

/**
 *  是否隐藏
 */
@property (nonatomic, assign)  BOOL placeHolderHidden;

@end
