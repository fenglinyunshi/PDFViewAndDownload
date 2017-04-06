//
//  CGContextDrawPDFReaderController.h
//  PDFViewAndDownload
//
//  Created by Dustin on 17/4/6.
//  Copyright © 2017年 PicVision. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CGContextDrawPDFPageModel.h"

@interface CGContextDrawPDFReaderController : UIViewController
{
     UIPageViewController *pageViewCtrl;
     CGContextDrawPDFPageModel *pdfPageModel;
}
@property(nonatomic,copy)NSString *titleText, *fileName;
@end
