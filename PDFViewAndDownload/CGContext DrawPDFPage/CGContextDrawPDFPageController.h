//
//  CGContextDrawPDFPageController.h
//  PDFViewAndDownload
//
//  Created by Dustin on 17/4/6.
//  Copyright © 2017年 PicVision. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CGContextDrawPDFPageController : UIViewController
// CGPDFDocumentRef pdfDocument;
@property (assign, nonatomic) CGPDFDocumentRef pdfDocument;
@property (assign, nonatomic) long pageNO;

@end
