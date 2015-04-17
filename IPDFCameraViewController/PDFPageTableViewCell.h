//
//  PDFPageTableViewCell.h
//  IPDFCameraViewControllerDemo
//
//  Created by Felipe Saint-Jean on 4/16/15.
//  Copyright (c) 2015 Maximilian Mackh. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PDFPageTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *page_thumb;
@property (weak, nonatomic) IBOutlet UILabel *page_label;

@end
