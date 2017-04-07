//
//  CGContextDrawPDFListViewController.m
//  PDFViewAndDownload
//
//  Created by Dustin on 17/4/6.
//  Copyright © 2017年 PicVision. All rights reserved.
//

#import "CGContextDrawPDFListViewController.h"
#import "CGContextDrawPDFReaderController.h"
#import "Masonry.h"

@interface CGContextDrawPDFListViewController ()<UITableViewDataSource, UITableViewDelegate>

@end

@implementation CGContextDrawPDFListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"CGContext DrawPDFPage";
    
    [self creatUI];
    
}

- (void)creatUI{
    
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [backBtn setTitle:@"返回" forState:UIControlStateNormal];
    [backBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(back:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:backBtn];
    
    [backBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(@60);
        make.height.equalTo(@40);
        make.bottom.offset(-20);
        make.right.offset(-20);
    }];
    
    view_width = self.view.frame.size.width;
    view_height = self.view.frame.size.height;
    NSLog(@"self.view.frame = %@",NSStringFromCGRect(self.view.frame));
    titleArray = @[@"iOS 开发笔记——PDF的显示和浏览",@"Objective-C和CoreFoundation对象相互转换的内存管理总结",@"HTML5从入门到精通"];
    fileArray = @[@"001.pdf", @"002.pdf",  @"003.pdf"];
    CGRect frame = CGRectMake(10, 64, view_width-20, view_height-150);
    pdfTableView = [[UITableView alloc] initWithFrame:frame style:UITableViewStylePlain];
    pdfTableView.dataSource = self;
    pdfTableView.delegate = self;
    pdfTableView.tableHeaderView = [[UIView alloc] init];
    pdfTableView.tableFooterView = [[UIView alloc] init];
    [self.view addSubview:pdfTableView];
}

- (void)back:(UIButton *)sender{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return titleArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellIdentifier = @"pdfTableView_cell";
    UITableViewCell *cell =  [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellIdentifier];
    }
    NSString *titleText = [titleArray objectAtIndex:indexPath.row];
    cell.textLabel.text = titleText;
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSLog(@"didSelectRowAtIndexPath >>>> ");
    
    CGContextDrawPDFReaderController *targetViewCtrl = [[CGContextDrawPDFReaderController alloc] init];
    targetViewCtrl.hidesBottomBarWhenPushed = YES;//从第一个页面跳到第二个页面时隐藏tabBar的设置方法
    targetViewCtrl.titleText = [titleArray objectAtIndex:indexPath.row];
    targetViewCtrl.fileName =  [fileArray objectAtIndex:indexPath.row];
    [self.navigationController pushViewController:targetViewCtrl animated:YES];
}



@end
