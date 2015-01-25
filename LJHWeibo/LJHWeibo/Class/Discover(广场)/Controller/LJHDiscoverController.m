//
//  LJHDiscoverController.m
//  LJHWeibo
//
//  Created by LeeJunHui on 15/1/9.
//  Copyright (c) 2015年 Apple. All rights reserved.
//

#import "LJHDiscoverController.h"
#import "LJHSearchBar.h"
@interface LJHDiscoverController()<UITextFieldDelegate>
@end
@implementation LJHDiscoverController

- (void)viewDidLoad{
    [super viewDidLoad];
    [self setupNav];
    [self setupGesture];
}

- (void)setupNav{
    LJHSearchBar *searchBar = [LJHSearchBar searchBar];
    searchBar.delegate = self;
    searchBar.frame = CGRectMake(0, 0, 300, 30);
    self.navigationItem.titleView = searchBar;
}

- (void)setupGesture{
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(txtshouldHide:)];
    [self.view addGestureRecognizer:tap];
}

- (void)txtshouldHide:(UITapGestureRecognizer *)gesture{
    [self.view endEditing:YES];
}

#pragma mark - UITextField Delegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [self.view endEditing:YES];
    return YES;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}

@end
