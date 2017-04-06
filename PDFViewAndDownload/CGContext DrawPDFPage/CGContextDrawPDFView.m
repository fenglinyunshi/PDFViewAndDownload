//
//  CGContextDrawPDFView.m
//  PDFViewAndDownload
//
//  Created by Dustin on 17/4/6.
//  Copyright © 2017年 PicVision. All rights reserved.
//

#import "CGContextDrawPDFView.h"

@implementation CGContextDrawPDFView

-(id)initWithFrame:(CGRect)frame atPage:(int)index withPDFDoc:(CGPDFDocumentRef) pdfDoc{
    self = [super initWithFrame:frame];

    pageNO = index;
    pdfDocument = pdfDoc;
    return self;
}

-(void)drawInContext:(CGContextRef)context atPageNo:(int)page_no{
    //Quartz坐标系和UIView坐标系不一样所致，调整坐标系，使pdf正立
    CGContextTranslateCTM(context, 0.0, self.bounds.size.height);
    CGContextScaleCTM(context, 1.0, -1.0);

    if (pageNO == 0) {
        pageNO = 1;
    }
    CGPDFPageRef page = CGPDFDocumentGetPage(pdfDocument, pageNO);
//    CGContextSaveGState(context);
    CGAffineTransform pdfTransform = CGPDFPageGetDrawingTransform(page, kCGPDFCropBox, self.bounds, 0, true);
    CGContextConcatCTM(context, pdfTransform);
    CGContextDrawPDFPage(context, page);
//    CGContextRestoreGState(context);
}

- (void)drawRect:(CGRect)rect {
    [self drawInContext:UIGraphicsGetCurrentContext() atPageNo:pageNO];
}

@end
