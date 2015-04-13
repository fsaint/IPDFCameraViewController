//
//  ViewController.h
//  IPDFCameraViewController
//
//  Created by Maximilian Mackh on 11/01/15.
//  Copyright (c) 2015 Maximilian Mackh. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol IPDFCameraViewControllerDelegate <NSObject>

-(void)pageSnapped:(UIImage *)page_image from:(UIViewController *)controller;

@end

@interface IPDFCameraViewController : UIViewController

@property (weak, nonatomic) id<IPDFCameraViewControllerDelegate> camera_delegate;

@property (weak, nonatomic) IBOutlet UIButton *flash_toggle;

@end

