//
//  SinglePlageViewController.h
//  IPDFCameraViewControllerDemo
//
//  Created by Felipe Saint-jean on 4/13/15.
//  Copyright (c) 2015 Maximilian Mackh. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SinglePlageViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIImageView *page_image_view;
@property (nonatomic, strong) UIImage *page_image;
@end
