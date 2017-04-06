//
//  CGContextDrawPDFPageController.m
//  PDFViewAndDownload
//
//  Created by Dustin on 17/4/6.
//  Copyright © 2017年 PicVision. All rights reserved.
//

#import "CGContextDrawPDFPageController.h"
#import "CGContextDrawPDFView.h"

@interface CGContextDrawPDFPageController ()

@end

@implementation CGContextDrawPDFPageController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self creatUI];
}

- (void)creatUI{
    CGRect frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    CGContextDrawPDFView *pdfView = [[CGContextDrawPDFView alloc] initWithFrame:frame atPage:self.pageNO withPDFDoc:self.pdfDocument];
    pdfView.backgroundColor=[UIColor whiteColor];
    [self.view addSubview:pdfView];
}



@end
