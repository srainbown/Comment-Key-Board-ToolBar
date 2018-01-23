//
//  MainViewController.m
//  Comment-Key-Board-ToolBar
//
//  Created by 紫川秀 on 2017/7/13.
//  Copyright © 2017年 View. All rights reserved.
//

#import "MainViewController.h"
#import "CommentKeyBoardToolBar.h"

@interface MainViewController ()

@property (nonatomic, strong) UIButton *commentBtn;

@property (nonatomic, strong) UIView *keyboardBgView;//键盘背景视图
@property (nonatomic, strong) CommentKeyBoardToolBar *keyboardView;//键盘输入框

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = C2;
    self.navigationItem.title = @"主页";
    
    _commentBtn = [[UIButton alloc]init];
    [self.view addSubview:_commentBtn];
    [_commentBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(self.view);
        make.height.with.mas_equalTo(70);
    }];
    [_commentBtn setTitle:@"发表评论" forState:UIControlStateNormal];
    [_commentBtn setTitleColor:C2 forState:UIControlStateNormal];
    _commentBtn.backgroundColor = C7;
    _commentBtn.layer.masksToBounds = YES;
    _commentBtn.layer.cornerRadius = 8;
    _commentBtn.layer.borderWidth = 1;
    _commentBtn.layer.backgroundColor = C1.CGColor;
    [_commentBtn addTarget:self action:@selector(commentBtnClick) forControlEvents:UIControlEventTouchUpInside];

}

-(void)commentBtnClick{
    
    K_WeakSelf;
    [SVProgressHUD dismiss];
    _commentBtn.hidden = YES;
    
    //输入框背景
    _keyboardBgView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    [self.view addSubview:_keyboardBgView];
    _keyboardBgView.backgroundColor = [C1 colorWithAlphaComponent:0.5f];
    [self.view bringSubviewToFront:_keyboardBgView];
    _keyboardView = [CommentKeyBoardToolBar showKeyBoardWithConfigToolBarHeight:100 sendTextCompletion:^(NSString *sendText) {
        //上传评论内容
        [weakSelf issueBtnClick:sendText];
    }];
    
    _keyboardView.inputTextView.text = @"";
    [_keyboardView setInputViewPlaceHolderText:@"说点啥子呢..."];
    //输入框
    [_keyboardBgView addSubview:self.keyboardView];
    //自动弹出键盘
    [_keyboardView becomeFirstResponder];
}

//上传评论内容
-(void)issueBtnClick:(NSString *)commentStr{
    
    NSLog(@"%@",commentStr);
    [SVProgressHUD showSuccessWithStatus:@"评论成功"];
    [_keyboardBgView removeFromSuperview];
    _commentBtn.hidden = NO;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
    [_keyboardBgView removeFromSuperview];
    _commentBtn.hidden = NO;
}


@end
