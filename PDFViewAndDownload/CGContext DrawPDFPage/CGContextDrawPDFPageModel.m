//
//  CGContextDrawPDFPageModel.m
//  PDFViewAndDownload
//
//  Created by Dustin on 17/4/6.
//  Copyright © 2017年 PicVision. All rights reserved.
//

#import "CGContextDrawPDFPageModel.h"
#import "CGContextDrawPDFPageController.h"
#import "BackViewController.h"

@interface CGContextDrawPDFPageModel ()
@property (nonatomic, strong) UIViewController *currentViewController;
@end

@implementation CGContextDrawPDFPageModel

-(id) initWithPDFDocument:(CGPDFDocumentRef) pdfDoc {
    self = [super init];
    if (self) {
        pdfDocument = pdfDoc;
    }
    return self;
}

- (CGContextDrawPDFPageController *)viewControllerAtIndex:(NSUInteger)pageNO {
    // Return the data view controller for the given index.
    long pageSum = CGPDFDocumentGetNumberOfPages(pdfDocument);
    if (pageSum== 0 || pageNO >= pageSum+1) {
        return nil;
    }
    // Create a new view controller and pass suitable data.
    CGContextDrawPDFPageController *pageController = [[CGContextDrawPDFPageController alloc] init];
    pageController.pdfDocument = pdfDocument;
    pageController.pageNO  = pageNO;
    return pageController;
}

- (NSUInteger)indexOfViewController:(CGContextDrawPDFPageController *)viewController {
    return viewController.pageNO;
}

#pragma mark如果要每页的背面显示与正面相同的风格，而不是默认的白，需要设置pageController的doubleSide属性为YES，同时在下面的两个代理方法中设置BackViewController
- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController {
    
    if([viewController isKindOfClass:[CGContextDrawPDFPageController class]]) {
        self.currentViewController = viewController;
        
        BackViewController *backViewController = [[BackViewController alloc] init];
        [backViewController updateWithViewController:viewController];
        return backViewController;
    }
    
    NSUInteger index = [self indexOfViewController: (CGContextDrawPDFPageController *)self.currentViewController];
    if ((index == 1) || (index == NSNotFound)) {
        return nil;
    }
    index--;
    return [self viewControllerAtIndex:index];
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController {
    
    if([viewController isKindOfClass:[CGContextDrawPDFPageController class]]) {
        self.currentViewController = viewController;
        
        BackViewController *backViewController = [[BackViewController alloc] init];
        [backViewController updateWithViewController:viewController];
        return backViewController;
    }
    
    NSUInteger index = [self indexOfViewController: (CGContextDrawPDFPageController *)self.currentViewController];
    if (index == NSNotFound) {
        return nil;
    }
    index++;
    long pageSum = CGPDFDocumentGetNumberOfPages(pdfDocument);
    if (index >= pageSum+1) {
        return nil;
    }
    return [self viewControllerAtIndex:index];
}

@end
