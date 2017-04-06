//
//  CGContextDrawPDFListViewController.h
//  PDFViewAndDownload
//
//  Created by Dustin on 17/4/6.
//  Copyright © 2017年 PicVision. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CGContextDrawPDFListViewController : UIViewController
{
    float view_width, view_height;
    NSArray *titleArray, *fileArray;
    UITableView *pdfTableView;
}
@end
