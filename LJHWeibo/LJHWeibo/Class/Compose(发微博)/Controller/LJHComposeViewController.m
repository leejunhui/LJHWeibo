//
//  LJHComposeViewController.m
//  LJHWeibo
//
//  Created by LeeJunHui on 15/1/18.
//  Copyright (c) 2015年 Apple. All rights reserved.
//

#import "LJHComposeViewController.h"
#import "LJHTextView.h"
@interface LJHComposeViewController()
@property (weak, nonatomic) UITextView *textView;

@end
@implementation LJHComposeViewController

- (void)viewDidLoad{
    [self setupNav];
    [self setupTextView];
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
    textView.placeholder = @"分享新鲜事...";
    textView.font = [UIFont systemFontOfSize:15];
    textView.frame = self.view.bounds;
//    textView.backgroundColor = [UIColor redColor];
    [self.view addSubview:textView];
    self.textView = textView;
    [LJHNotificationCenter addObserver:self selector:@selector(textChange) name:UITextViewTextDidChangeNotification object:textView];
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
