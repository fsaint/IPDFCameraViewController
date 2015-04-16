//
//  PDFGenerationDelegate.h
//  IPDFCameraViewControllerDemo
//
//  Created by Felipe Saint-jean on 4/16/15.
//  Copyright (c) 2015 Maximilian Mackh. All rights reserved.
//

#ifndef IPDFCameraViewControllerDemo_PDFGenerationDelegate_h
#define IPDFCameraViewControllerDemo_PDFGenerationDelegate_h


#endif


@protocol PDFMakerViewControllerDelegate <NSObject>

-(void)generatedDocument:(NSString *)path controller:(UIViewController *)controller;

@end