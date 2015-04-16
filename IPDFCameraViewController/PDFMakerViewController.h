//
//  PDFMakerViewController.h
//  IPDFCameraViewControllerDemo
//
//  Created by Felipe Saint-jean on 4/13/15.
//  Copyright (c) 2015 Maximilian Mackh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IPDFCameraViewController.h"

#import "PDFGenerationDelegate.h"
@class PDFMakerViewController;




@interface PDFMakerViewController : UITableViewController <IPDFCameraViewControllerDelegate>
@property (nonatomic,weak)  id<PDFMakerViewControllerDelegate> pdf_delegate;
@end
