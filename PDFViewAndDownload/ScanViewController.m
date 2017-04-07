//
//  ScanViewController.m
//  PDFViewAndDownload
//
//  Created by Dustin on 17/4/6.
//  Copyright © 2017年 PicVision. All rights reserved.
//

#import "ScanViewController.h"
#import "PDFWebViewViewController.h"
#import "CGContextDrawPDFListViewController.h"
#import <QuickLook/QuickLook.h>
#import "Masonry.h"
#define PDF_URL @"https://www.tutorialspoint.com/ios/ios_tutorial.pdf"
#define PDF_FILE_PATH [[NSBundle mainBundle] pathForResource:@"git-cheatsheet" ofType:@"pdf"]
#import "ReaderViewController.h"

@interface ScanViewController ()<UITableViewDataSource,UITableViewDelegate,QLPreviewControllerDelegate,QLPreviewControllerDataSource,ReaderViewControllerDelegate>

@end

@implementation ScanViewController

- (void)loadView{
    self.view.backgroundColor = [UIColor whiteColor];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //创建UI
    [self creatUI];
}

#pragma mark 创建UI
- (void)creatUI{
    
    //返回button
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [backBtn setTitle:@"返回" forState:UIControlStateNormal];
    [backBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(back:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:backBtn];
    
    //创建UITableview列表
    UITableView *myTV = [[UITableView alloc] initWithFrame:CGRectMake(0, 60, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height - 60) style:UITableViewStylePlain];
    //去除列表下面的多余的分割线
    myTV.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    myTV.delegate = self;
    myTV.dataSource = self;
    [self.view addSubview:myTV];
    
    [backBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(@60);
        make.height.equalTo(@40);
        make.top.offset(20);
        make.left.offset(10);
    }];
}

- (void)back:(UIButton *)sender{
    [self dismissViewControllerAnimated:YES completion:nil];
}


#pragma mark UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"scanCell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"scanCell"];
    }
    
    cell.textLabel.textColor = [UIColor colorWithRed:64/255.0 green:136.0/255.0 blue:164/255.0 alpha:1.0];
    switch (indexPath.row) {
        case 0:
            cell.textLabel.text = @"UIWebView本地浏览";
            break;
        case 1:
            cell.textLabel.text = @"UIWebView在线浏览";
            break;
        case 2:
            cell.textLabel.text = @"QLPreviewController浏览";
            break;
        case 3:
            cell.textLabel.text = @"PDF Reader";
            break;
        case 4:
            cell.textLabel.text = @"CGContext DrawPDFPage";
            break;
            
        default:
            break;
    }
    
    
    
    return cell;
}

#pragma mark UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 44;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    switch (indexPath.row) {
        case 0:{
            //UIWebView加载本地pdf文件
            PDFWebViewViewController *webViewVC = [[PDFWebViewViewController alloc] init];
            webViewVC.urlStr = PDF_FILE_PATH;
            [self presentViewController:webViewVC animated:YES completion:nil];
            break;
        }
        case 1:{
            //UIWebView加载网络pdf文件
            PDFWebViewViewController *webViewVC = [[PDFWebViewViewController alloc] init];
            webViewVC.urlStr = PDF_URL;
            [self presentViewController:webViewVC animated:YES completion:nil];
            break;
        }
        case 2:{
            //QLPreviewController初始化
            QLPreviewController *QLPVC = [[QLPreviewController alloc] init];
            QLPVC.delegate = self;
            QLPVC.dataSource = self;
            [self presentViewController:QLPVC animated:YES completion:nil];
            
            break;
        }
        case 3:{
            //Reader初始化 加载本地pdf文件
            ReaderDocument *doc = [[ReaderDocument alloc] initWithFilePath:PDF_FILE_PATH password:nil];
            ReaderViewController *rederVC = [[ReaderViewController alloc] initWithReaderDocument:doc];
            rederVC.delegate = self;
            [self presentViewController:rederVC animated:YES completion:nil];
            
            break;
        }
        case 4:{
            //跳到CGContextDraw控制器，利用CGContext 画pdf
            UINavigationController *navCtrl = [[UINavigationController alloc] initWithRootViewController: [[CGContextDrawPDFListViewController alloc] init]];
            [self presentViewController:navCtrl animated:YES completion:nil];
            
            break;
        }
        default:
            break;
    }
   
}

#pragma mark QLPreviewControllerDataSource
- (NSInteger)numberOfPreviewItemsInPreviewController:(QLPreviewController *)controller{
    return 1;
}
- (id<QLPreviewItem>)previewController:(QLPreviewController *)controller previewItemAtIndex:(NSInteger)index{

    return [NSURL fileURLWithPath:PDF_FILE_PATH];
}


#pragma mark ReaderViewControllerDelegate
- (void)dismissReaderViewController:(ReaderViewController *)viewController{
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
