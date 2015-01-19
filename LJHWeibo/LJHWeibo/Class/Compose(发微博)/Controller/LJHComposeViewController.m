//
//  LJHComposeViewController.m
//  LJHWeibo
//
//  Created by LeeJunHui on 15/1/18.
//  Copyright (c) 2015年 Apple. All rights reserved.
//

#import "LJHComposeViewController.h"
#import "LJHTextView.h"
#import "LJHComposeToolBar.h"
@interface LJHComposeViewController()<UITextViewDelegate,LJHComposeToolbarDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>
@property (weak, nonatomic) UITextView *textView;
@property (nonatomic, weak) LJHComposeToolBar *toolbar;
@end
@implementation LJHComposeViewController

- (void)viewDidLoad{
    [self setupNav];
    [self setupTextView];
    [self setupToolBar];
}

- (void)viewDidAppear:(BOOL)animated{
    [self.textView becomeFirstResponder];
}

- (void)setupNav{
    UIBarButtonItem *leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStyleDone target:self action:@selector(cancel)];
    self.navigationItem.leftBarButtonItem = leftBarButtonItem;
    
    UIBarButtonItem *rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"确定" style:UIBarButtonItemStyleDone target:self action:@selector(send)];
    self.navigationItem.rightBarButtonItem = rightBarButtonItem;
    self.navigationItem.rightBarButtonItem.enabled = NO;
}

- (void)setupTextView{
    LJHTextView *textView = [[LJHTextView alloc] init];
    textView.inputAccessoryView = self.toolbar;
    textView.placeholder = @"分享新鲜事...";
    textView.font = [UIFont systemFontOfSize:15];
    // 垂直方向上永远可以拖拽
    textView.alwaysBounceVertical = YES;
    textView.delegate = self;
    textView.frame = self.view.bounds;
//    textView.backgroundColor = [UIColor redColor];
    [self.view addSubview:textView];
    self.textView = textView;
    
    
    [LJHNotificationCenter addObserver:self selector:@selector(textChange) name:UITextViewTextDidChangeNotification object:textView];
    
    // 3.监听键盘的通知
    [LJHNotificationCenter addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [LJHNotificationCenter addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
}

/**
 *  键盘即将显示的时候调用
 */
- (void)keyboardWillShow:(NSNotification *)note
{
    // 1.取出键盘的frame
    CGRect keyboardF = [note.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    
    // 2.取出键盘弹出的时间
    CGFloat duration = [note.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    
    // 3.执行动画
    [UIView animateWithDuration:duration animations:^{
        self.toolbar.transform = CGAffineTransformMakeTranslation(0, -keyboardF.size.height);
    }];
}

/**
 *  键盘即将退出的时候调用
 */
- (void)keyboardWillHide:(NSNotification *)note
{
    // 1.取出键盘弹出的时间
    CGFloat duration = [note.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    
    // 2.执行动画
    [UIView animateWithDuration:duration animations:^{
        self.toolbar.transform = CGAffineTransformIdentity;
    }];
}


- (void)setupToolBar{
    LJHComposeToolBar *toolbar = [[LJHComposeToolBar alloc] init];
    toolbar.delegate = self;
    CGFloat toolbarH = 44;
    CGFloat toolbarW = self.view.frame.size.width;
    CGFloat toolbarX = 0;
    CGFloat toolbarY = self.view.frame.size.height - toolbarH;
    toolbar.frame = CGRectMake(toolbarX, toolbarY, toolbarW, toolbarH);
    [self.view addSubview:toolbar];
    self.toolbar = toolbar;
}

#pragma mark - toolbar的代理方法
- (void)composeToolbar:(LJHComposeToolBar *)toolbar didClickedButton:(LJHComposeToolbarButtonType)buttonType
{
    switch (buttonType) {
        case LJHComposeToolbarButtonTypeCamera: // 相机
            [self openCamera];
            break;
            
        case LJHComposeToolbarButtonTypePicture: // 相册
            [self openPhotoLibrary];
            break;
            
        default:
            break;
    }
}

/**
 *  打开相机
 */
- (void)openCamera
{
    UIImagePickerController *ipc = [[UIImagePickerController alloc] init];
    ipc.sourceType = UIImagePickerControllerSourceTypeCamera;
    ipc.delegate = self;
    [self presentViewController:ipc animated:YES completion:nil];
}

/**
 *  打开相册
 */
- (void)openPhotoLibrary
{
    UIImagePickerController *ipc = [[UIImagePickerController alloc] init];
    ipc.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    ipc.delegate = self;
    [self presentViewController:ipc animated:YES completion:nil];
}

- (void)textChange{
//    NSLog(@"change! %@",self.textView.text);
    self.navigationItem.rightBarButtonItem.enabled = !(self.textView.text.length == 0);
}

- (void)dealloc{
    [LJHNotificationCenter removeObserver:self];
}

- (void)cancel{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)send{
    
}

@end
