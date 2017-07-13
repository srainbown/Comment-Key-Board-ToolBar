//
//  CommentTextView.m
//  Comment-Key-Board-ToolBar
//
//  Created by 紫川秀 on 2017/7/13.
//  Copyright © 2017年 View. All rights reserved.
//

#import "CommentTextView.h"

@interface CommentTextView ()

@property (nonatomic, strong) UILabel *placeholderLabel;

@end

@implementation CommentTextView

- (instancetype)initWithFrame:(CGRect)frame
{
    if(self = [super initWithFrame:frame])
    {
        [self addSubview:self.placeholderLabel];
        self.alwaysBounceVertical = YES;
        self.font = T5;
        self.placeholderColor = C6;
        self.textColor = C1;
        self.placeholderLabel.frame = CGRectMake(13, 10, 0, 0);
        self.textContainerInset = UIEdgeInsetsMake(10, 10, 0, 0);
        
        // 监听文字改变
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textDidChange) name:UITextViewTextDidChangeNotification object:nil];
    }
    return self;
}


#pragma mark - API
- (void)setFont:(UIFont *)font
{
    [super setFont:font];
    self.placeholderLabel.font = font;
    [self computePlaceholderLabelSize];
}

- (void)setPlaceholderColor:(UIColor *)placeholderColor
{
    _placeholderColor = placeholderColor;
    self.placeholderLabel.textColor = placeholderColor;
}

- (void)setPlaceholder:(NSString *)placeholder
{
    _placeholder = [placeholder copy];
    self.placeholderLabel.text = placeholder;
    [self computePlaceholderLabelSize];
}

- (void)setPlaceHolderOffsetX:(CGFloat)placeHolderOffsetX
{
    _placeHolderOffsetX = placeHolderOffsetX;
    [self computePlaceholderLabelSize];
}

- (void)setPlaceHolderOffsetY:(CGFloat)placeHolderOffsetY
{
    _placeHolderOffsetY = placeHolderOffsetY;
    [self computePlaceholderLabelSize];
}

- (void)setCursorOffset:(UIOffset)cursorOffset
{
    _cursorOffset = cursorOffset;
    self.textContainerInset = UIEdgeInsetsMake(cursorOffset.vertical, cursorOffset.horizontal, cursorOffset.vertical,cursorOffset.horizontal);
}

- (void)setPlaceHolderHidden:(BOOL)placeHolderHidden
{
    _placeHolderHidden = placeHolderHidden;
    self.placeholderLabel.hidden = placeHolderHidden;
}

#pragma mark - hanlde
-(void)computePlaceholderLabelSize
{
    CGFloat maxWidth = [UIScreen mainScreen].bounds.size.width - 2 * (self.placeholderLabel.frame.origin.x - self.placeHolderOffsetX);
    CGSize maxSize = CGSizeMake(maxWidth, MAXFLOAT);
    CGSize computeSize = [self.placeholder boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName : self.font} context:nil].size;
    
    CGRect frame = self.placeholderLabel.frame;
    frame.size = computeSize;
    frame.origin.x = self.placeHolderOffsetX + frame.origin.x;
    frame.origin.y = self.placeHolderOffsetY + frame.origin.y;
    self.placeholderLabel.frame = frame;
}

- (void)textDidChange
{
    self.placeHolderHidden = self.hasText;
}

#pragma mark - lazy
- (UILabel *)placeholderLabel
{
    if (!_placeholderLabel) {
        // 添加一个用来显示占位文字的label
        _placeholderLabel = [[UILabel alloc] init];
        _placeholderLabel.numberOfLines = 0;
    }
    return _placeholderLabel;
}
- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


@end
