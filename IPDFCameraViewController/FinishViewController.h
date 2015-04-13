//
//  FinishViewController.h
//  IPDFCameraViewControllerDemo
//
//  Created by Felipe Saint-jean on 4/13/15.
//  Copyright (c) 2015 Maximilian Mackh. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FinishViewController : UIViewController <UIDocumentInteractionControllerDelegate>
@property (nonatomic,strong) NSString *file_path;
@property (weak, nonatomic) IBOutlet UIImageView *preview_image_view;
@property (nonatomic, strong) UIImage *preview_image;

@end
