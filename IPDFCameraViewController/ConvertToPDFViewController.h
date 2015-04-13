//
//  ConvertToPDFViewController.h
//  IPDFCameraViewControllerDemo
//
//  Created by Felipe Saint-jean on 4/13/15.
//  Copyright (c) 2015 Maximilian Mackh. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ConvertToPDFViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIImageView *progress_image_view;
@property (nonatomic, strong) NSArray *pages;
@end
