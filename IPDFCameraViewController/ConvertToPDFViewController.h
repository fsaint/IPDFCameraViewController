//
//  ConvertToPDFViewController.h
//  IPDFCameraViewControllerDemo
//
//  Created by Felipe Saint-jean on 4/13/15.
//  Copyright (c) 2015 Maximilian Mackh. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "IPDFDocument.h"
#import "PDFGenerationDelegate.h"

@interface ConvertToPDFViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIImageView *progress_image_view;
@property (nonatomic, strong) IPDFDocument *document;
@property (nonatomic,weak)  id<PDFMakerViewControllerDelegate> pdf_delegate;
@end
