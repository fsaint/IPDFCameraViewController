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

@interface ConvertToPDFViewController : UIViewController <UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *spinner;
@property (weak, nonatomic) IBOutlet UILabel *progress_message;
@property (weak, nonatomic) IBOutlet UIImageView *progress_image_view;
@property (nonatomic, strong) IPDFDocument *document;
@property (weak, nonatomic) IBOutlet UITextField *file_name;
@property (nonatomic,weak)  id<PDFMakerViewControllerDelegate> pdf_delegate;
@end
