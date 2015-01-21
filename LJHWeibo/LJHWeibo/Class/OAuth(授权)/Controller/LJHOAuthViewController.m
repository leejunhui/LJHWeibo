//
//  LJHOAuthViewController.m
//  LJHWeibo
//
//  Created by LeeJunHui on 15/1/10.
//  Copyright (c) 2015年 Apple. All rights reserved.
//


#import "LJHOAuthViewController.h"
#import "LJHAccountTool.h"
#import "LJHAccount.h"
#import "LJHWeiboTool.h"
#import "LJHOAuthParam.h"
#import "LJHOAuthResult.h"
#import "LJHOAuthTool.h"
@interface LJHOAuthViewController()<UIWebViewDelegate>

@end

@implementation LJHOAuthViewController

- (void)viewDidLoad{
    [super viewDidLoad];
    
    //1.加载webView
    UIWebView *webView = [[UIWebView alloc] init];
    webView.delegate = self;
    webView.frame = self.view.bounds;
    [self.view addSubview:webView];
    
    //2.加载授权页面
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:LoginURLString]];
    [webView loadRequest:request];
}

#pragma mark - UIWebView Delegate
- (void)webViewDidStartLoad:(UIWebView *)webView{
    [MBProgressHUD showMessage:@"加载中..."];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView{
    [MBProgressHUD hideHUD];
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
    [MBProgressHUD hideHUD];
}


- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
    NSString *urlStr = request.URL.absoluteString;
    NSRange range = [urlStr rangeOfString:@"code="];
    
    if (range.length) {
        int loc = (int)range.location + (int)range.length;
        NSString *code = [urlStr substringFromIndex:loc];
        [self accessTokenWithCode:code];
        return NO;
    }
    
    return YES;
}

/*
 
 必选	类型及范围	说明
 client_id	true	string	申请应用时分配的AppKey。
 client_secret	true	string	申请应用时分配的AppSecret。
 grant_type	true	string	请求的类型，填写authorization_code
 
 grant_type为authorization_code时
 必选	类型及范围	说明
 code	true	string	调用authorize获得的code值。
 redirect_uri	true	string	回调地址，需需与注册应用里的回调地址一致。
 */

/**
 *  通过code换取一个accessToken
 */
- (void)accessTokenWithCode:(NSString *)code{
    
    LJHOAuthParam *param = [LJHOAuthParam param];
    param.client_id = OAuthAppID;
    param.client_secret = OAuthAppKey;
    param.code = code;
    param.grant_type = OAuthGrantType;
    param.redirect_uri = OAuthRedirectURL;
    
    [LJHOAuthTool OAuthWithParam:param success:^(LJHOAuthResult *result) {
        [LJHAccountTool saveAccount:result];
        //判断是否需要显示新特性界面
        [LJHWeiboTool chooseRootController];
        [MBProgressHUD hideHUD];
    } failure:^(NSError *error) {
        [MBProgressHUD hideHUD];
    }];
}

@end
