//
//  UIView+CommentViewFrame.m
//  Comment-Key-Board-ToolBar
//
//  Created by 紫川秀 on 2017/7/13.
//  Copyright © 2017年 View. All rights reserved.
//

#import "UIView+CommentViewFrame.h"

@implementation UIView (CommentViewFrame)

-(void)setLZB_x:(CGFloat)LZB_x
{
    CGRect rect =self.frame;
    rect.origin.x =LZB_x;
    self.frame =rect;
}

-(void)setLZB_y:(CGFloat)LZB_y
{
    CGRect rect =self.frame;
    rect.origin.y =LZB_y;
    self.frame =rect;
}

- (void)setLZB_width:(CGFloat)LZB_width
{
    CGRect rect =self.frame;
    rect.size.width =LZB_width;
    self.frame =rect;
}

- (void)setLZB_heigth:(CGFloat)LZB_heigth
{
    CGRect rect =self.frame;
    rect.size.height =LZB_heigth;
    self.frame =rect;
}

- (CGFloat)LZB_width
{
    return self.frame.size.width;
}

- (CGFloat)LZB_heigth
{
    return self.frame.size.height;
}

- (CGFloat)LZB_x
{
    return self.frame.origin.x;
}
- (CGFloat)LZB_y
{
    return self.frame.origin.y;
}

- (void)setLZB_centerX:(CGFloat)LZB_centerX
{
    CGPoint center =self.center;
    center.x =LZB_centerX;
    self.center =center;
}

- (void)setLZB_centerY:(CGFloat)LZB_centerY
{
    CGPoint center =self.center;
    center.y =LZB_centerY;
    self.center =center;
}

-(CGFloat)LZB_centerX
{
    return self.center.x;
}

- (CGFloat)LZB_centerY
{
    return self.center.y;
}


#pragma mark - API
// 判断View是否显示在屏幕上
- (BOOL)isDisplayedInScreen
{
    if (self == nil) {
        return FALSE;
    }
    
    CGRect screenRect = [UIScreen mainScreen].bounds;
    
    // 转换view对应window的Rect
    CGRect rect = [self convertRect:self.frame fromView:nil];
    if (CGRectIsEmpty(rect) || CGRectIsNull(rect)) {
        return FALSE;
    }
    
    // 若view 隐藏
    if (self.hidden) {
        return FALSE;
    }
    
    // 若没有superview
    if (self.superview == nil) {
        return FALSE;
    }
    
    // 若size为CGrectZero
    if (CGSizeEqualToSize(rect.size, CGSizeZero)) {
        return  FALSE;
    }
    
    // 获取 该view与window 交叉的 Rect
    CGRect intersectionRect = CGRectIntersection(rect, screenRect);
    if (CGRectIsEmpty(intersectionRect) || CGRectIsNull(intersectionRect)) {
        return FALSE;
    }
    
    return TRUE;
}


@end
