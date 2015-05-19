//
//  IPDFDocument.h
//  IPDFCameraViewControllerDemo
//
//  Created by Felipe Saint-jean on 4/16/15.
//  Copyright (c) 2015 Maximilian Mackh. All rights reserved.
//

#import <Foundation/Foundation.h>
@import UIKit;

@interface IPDFDocument : NSObject
@property (nonatomic,strong) NSMutableArray *page_images;
/*
-(void)addPage:(UIImage *)page_image;
-(NSInteger)numberOfPages;
-(UIImage *)page:(int)page;
-(UIImage *)thumb:(int)page;
*/
@end
