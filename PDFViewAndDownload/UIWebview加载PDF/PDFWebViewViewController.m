//
//  PDFWebViewViewController.m
//  PDFViewAndDownload
//
//  Created by Dustin on 17/4/6.
//  Copyright © 2017年 PicVision. All rights reserved.
//

#import "PDFWebViewViewController.h"
#import "MBProgressHUD.h"
#import "Masonry.h"

@interface PDFWebViewViewController ()<UIWebViewDelegate>

@property (nonatomic,strong)UIWebView *myWebView;

@end

@implementation PDFWebViewViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self creatUI];
}

- (void)creatUI{
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    backBtn.frame = CGRectMake(10, 20, 60, 40);
    [backBtn setTitle:@"返回" forState:UIControlStateNormal];
    [backBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(back:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:backBtn];
    
    [self.view addSubview:self.myWebView];
    
    [self.myWebView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.offset(60);
        make.left.right.bottom.offset(0);
    }];
    
    NSURL *pathUrl = [NSURL URLWithString:self.urlStr];
    NSURLRequest *request = [NSURLRequest requestWithURL:pathUrl];
    
    [self.myWebView loadRequest:request];
    [self.myWebView setScalesPageToFit:YES];
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.label.text = @"正在加载中...";
    
}

- (void)back:(UIButton *)sender{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (UIWebView *)myWebView{
    if (!_myWebView) {
        _myWebView = [[UIWebView alloc] init];
        _myWebView.backgroundColor = [UIColor whiteColor];
        _myWebView.delegate = self;
    }
    return _myWebView;
}

- (void)webViewDidFinishLoad:(UIWebView *)webView{
    [MBProgressHUD hideHUDForView:self.view animated:YES];
}

@end
