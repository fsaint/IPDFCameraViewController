//
//  IPDFDocument.m
//  IPDFCameraViewControllerDemo
//
//  Created by Felipe Saint-jean on 4/16/15.
//  Copyright (c) 2015 Maximilian Mackh. All rights reserved.
//

#import "IPDFDocument.h"

@implementation IPDFDocument
-(instancetype)init{
    self = [super init];
    
    if (self){
        self.page_images = [NSMutableArray array];
    }
    return self;
}
@end
