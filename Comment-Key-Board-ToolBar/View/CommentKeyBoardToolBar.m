//
//  CommentKeyBoardToolBar.m
//  Comment-Key-Board-ToolBar
//
//  Created by 紫川秀 on 2017/7/13.
//  Copyright © 2017年 View. All rights reserved.
//

#import "CommentKeyBoardToolBar.h"
#import "UIView+CommentViewFrame.h"

#define kKeyboardViewToolBarHeight 66  // 默认键盘输入工具条的高度
#define kKeyboardViewToolBar_TextView_Height 35  // 默认键盘输入框的高度
#define kKeyboardViewToolBar_TextView_LimitHeight 60  // 默认键盘输入框的限制高度
#define kKeyboardViewToolBar_Horizontal_DefaultMargin 10  //水平方向默认间距
#define kKeyboardViewToolBar_Vertical_DefaultMargin 16  //垂直方向默认间距

@interface CommentKeyBoardToolBar ()<UITextViewDelegate>

//View
@property (nonatomic, strong) UIView *topLine;      // 顶部分割线
@property (nonatomic, strong) UIView *bottomLine;      // 底部分割线
@property (nonatomic, strong) UIButton *sendBtn;      // 发送按钮
@property (nonatomic, strong) UILabel *numLabel;        //输入字数

//data
@property (nonatomic, copy) void(^sendTextBlock)(NSString *text);  //输入框输入字符串回调Blcok
@property (nonatomic, assign) CGFloat textHeight;   //输入文字高度
@property (nonatomic, assign) CGFloat animationDuration;  //动画时间
@property (nonatomic, strong) NSString *placeHolder;  //占位文字

@end

@implementation CommentKeyBoardToolBar

#pragma mark - API
+ (CommentKeyBoardToolBar *)showKeyBoardWithConfigToolBarHeight:(CGFloat)toolBarHeight sendTextCompletion:(void(^)(NSString *sendText))sendTextBlock
{
    CommentKeyBoardToolBar *toolBar = [[CommentKeyBoardToolBar alloc]init];
    toolBar.backgroundColor = C0;
    if(toolBarHeight < kKeyboardViewToolBarHeight)
        toolBarHeight = kKeyboardViewToolBarHeight;
    toolBar.frame = CGRectMake(0, SCREEN_HEIGHT - toolBarHeight, SCREEN_WIDTH, toolBarHeight);
    toolBar.sendTextBlock = sendTextBlock;
    return toolBar;
    
}
- (void)setInputViewPlaceHolderText:(NSString *)placeText
{
    self.inputTextView.placeholder = placeText;
    self.placeHolder = placeText;
}
- (void)becomeFirstResponder{
    [self.inputTextView becomeFirstResponder];
    self.hidden = NO;
}

- (void)resignFirstResponder{
    [self.inputTextView resignFirstResponder];
}


#pragma mark - private
- (instancetype)initWithFrame:(CGRect)frame
{
    if(self = [super initWithFrame:frame])
    {
        [self setupUI];
    }
    return self;
}

- (void)setupUI
{
    [self addSubview:self.inputTextView];
    [self addSubview:self.topLine];
    [self addSubview:self.bottomLine];
    [self addSubview:self.sendBtn];
    [self addSubview:self.numLabel];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillChangeFrame:) name:UIKeyboardWillChangeFrameNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textDidChange) name:UITextViewTextDidChangeNotification object:self.inputTextView];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    __weak typeof(self) weakSelf = self;
    
    CGFloat height = (self.textHeight + kKeyboardViewToolBar_TextView_Height)> kKeyboardViewToolBarHeight ? (self.textHeight + kKeyboardViewToolBar_TextView_Height) : kKeyboardViewToolBarHeight;
    CGFloat offsetY = self.LZB_heigth - height;
    [UIView animateWithDuration:self.animationDuration animations:^{
        weakSelf.LZB_y  += offsetY;
        weakSelf.LZB_heigth = height;
    }];
    
    self.topLine.LZB_width = self.LZB_width;
    self.bottomLine.LZB_width = self.LZB_width;
    
    CGSize sendButtonSize = self.sendBtn.currentImage.size;
    self.sendBtn.LZB_width = sendButtonSize.width;
    self.sendBtn.LZB_heigth = sendButtonSize.height;
    self.sendBtn.LZB_x = self.LZB_width - sendButtonSize.width - kKeyboardViewToolBar_Horizontal_DefaultMargin - 10 * DBWidthScale;
    
    [self.numLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_sendBtn.bottom).offset(4 * DBHeightScale);
        make.right.mas_equalTo(self.right).offset(- 21 * DBWidthScale);
    }];
    
    self.inputTextView.LZB_width = self.LZB_width - sendButtonSize.width - 3 *kKeyboardViewToolBar_Horizontal_DefaultMargin - 21 * DBWidthScale;
    self.inputTextView.LZB_x = kKeyboardViewToolBar_Horizontal_DefaultMargin;
    
    [UIView animateWithDuration:self.animationDuration animations:^{
        weakSelf.inputTextView.LZB_heigth = weakSelf.LZB_heigth - 2 *kKeyboardViewToolBar_Vertical_DefaultMargin;
        weakSelf.inputTextView.LZB_centerY = weakSelf.LZB_heigth * 0.5;
        weakSelf.sendBtn.LZB_y = weakSelf.LZB_heigth - sendButtonSize.height -kKeyboardViewToolBar_Vertical_DefaultMargin - 10 * DBHeightScale;
        weakSelf.numLabel.LZB_y = weakSelf.LZB_heigth - sendButtonSize.height -kKeyboardViewToolBar_Vertical_DefaultMargin + 14 * DBHeightScale;
        weakSelf.bottomLine.LZB_y = weakSelf.LZB_heigth - weakSelf.bottomLine.LZB_heigth;
    }];
    
    [self.inputTextView setNeedsUpdateConstraints];
}

#pragma mark - handle
- (void)keyboardWillChangeFrame:(NSNotification *)notification
{
    CGRect keyboardFrame = [notification.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    CGFloat keyboardHeight = keyboardFrame.size.height;
    CGFloat keyboardAnimaitonDuration = [notification.userInfo[UIKeyboardAnimationDurationUserInfoKey] floatValue];
    self.animationDuration = keyboardAnimaitonDuration;
    NSInteger option = [notification.userInfo[UIKeyboardAnimationCurveUserInfoKey] integerValue];
    
    //判断键盘是否出现
    BOOL isKeyBoardHidden = SCREEN_HEIGHT == keyboardFrame.origin.y;
    CGFloat offsetMarginY = isKeyBoardHidden ? SCREEN_HEIGHT - self.LZB_heigth :SCREEN_HEIGHT - self.LZB_heigth - keyboardHeight;
    
    [UIView animateKeyframesWithDuration:self.animationDuration delay:0 options:option animations:^{
        self.LZB_y = offsetMarginY;
    } completion:nil];
    
}

- (void)textDidChange
{
    if([self.inputTextView.text containsString:@"\n"])
    {
        [self sendBtnClick];
        return;
    }
    
    CGFloat margin = self.inputTextView.textContainerInset.left + self.inputTextView.textContainerInset.right;
    
    CGFloat height = [self.inputTextView.text boundingRectWithSize:CGSizeMake(self.inputTextView.LZB_width - margin, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : self.inputTextView.font} context:nil].size.height;
    
    if(height == self.textHeight) return;
    
    // 确保输入框不会无限增高，控制在显示3行
    if (height > kKeyboardViewToolBar_TextView_LimitHeight) {
        return;
    }
    self.textHeight = height;
    
    [self setNeedsLayout];
}

- (void)sendBtnClick
{
    if(self.sendTextBlock)
        self.sendTextBlock(self.inputTextView.text);
    self.textHeight = 0;
    [self resetInputView];
}

- (void)resetInputView
{
    self.inputTextView.text = @"";
    [self setInputViewPlaceHolderText:self.placeHolder.length > 0 ? self.placeHolder : @""];
    [self.inputTextView resignFirstResponder];
    self.inputTextView.placeHolderHidden = self.inputTextView.hasText;
}


#pragma mark - lazy
- (UIButton *)sendBtn
{
    if(_sendBtn == nil)
    {
        _sendBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_sendBtn setImage:K_ImageNamed(@"vidoexiangqing_icon_send") forState:UIControlStateNormal];
        [_sendBtn addTarget:self action:@selector(sendBtnClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _sendBtn;
}

-(UILabel *)numLabel{
    
    if (_numLabel == nil) {
        _numLabel = [[UILabel alloc]init];
        [_numLabel setText:@"0/150"];
        _numLabel.font = T9;
        _numLabel.textColor = C6;
    }
    return _numLabel;
}

- (CommentTextView *)inputTextView
{
    if(_inputTextView == nil)
    {
        _inputTextView = [[CommentTextView alloc]init];
        _inputTextView.layer.masksToBounds = YES;
        _inputTextView.layer.cornerRadius = 14;
        _inputTextView.layer.borderWidth = 0.5;
        _inputTextView.layer.borderColor = C6.CGColor;
        _inputTextView.delegate = self;
        _inputTextView.enablesReturnKeyAutomatically = YES;
        _inputTextView.returnKeyType = UIReturnKeySend;
    }
    return _inputTextView;
}

- (UIView *)topLine{
    if (_topLine == nil) {
        _topLine = [[UIView alloc] init];
        _topLine.LZB_heigth = 0.5;
        _topLine.backgroundColor = C6;
    }
    return _topLine;
}

- (UIView *)bottomLine{
    if (_bottomLine == nil) {
        _bottomLine = [[UIView alloc] init];
        _bottomLine.backgroundColor = C6;
        _bottomLine.LZB_heigth = 0.5;
        _bottomLine.hidden = YES;
    }
    return _bottomLine;
}

#pragma mark -- UITextViewDelegate
-(void)textViewDidChange:(UITextView *)textView{
    
    //字数限制
    NSString *textString = textView.text;
    NSLog(@"textString = %lu",textString.length);
    //字数显示
    if (textString.length > 150) {
        _numLabel.text = @"150/150";
    }else{
        _numLabel.text = [NSString stringWithFormat:@"%ld/150",textString.length];
    }
    
    //中文输入
    NSString *language = textView.textInputMode.primaryLanguage;
    if([language isEqualToString:@"zh-Hans"]) {
        UITextRange *selectedRange = [textView markedTextRange];
        
        if(!selectedRange) {
            
            if(textString.length>150-1) {
                self.inputTextView.text = [textString substringToIndex:150];
                NSLog(@"subStringLength = %lu",self.inputTextView.text.length);
            }else{
                if(textString.length>150-1) {
                    self.inputTextView.text = [textString substringToIndex:150];
                }
            }
        }
    }else{//其他语言输入
        if (textString.length > 150 - 1) {
            self.inputTextView.text= [textString substringToIndex:150];
        }
    }
}


@end
