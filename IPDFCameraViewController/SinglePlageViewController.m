//
//  SinglePlageViewController.m
//  IPDFCameraViewControllerDemo
//
//  Created by Felipe Saint-jean on 4/13/15.
//  Copyright (c) 2015 Maximilian Mackh. All rights reserved.
//

#import "SinglePlageViewController.h"

@interface SinglePlageViewController ()

@end

@implementation SinglePlageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    if (self.page_image)
        self.page_image_view.image = self.page_image;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/


-(void)setPage_image:(UIImage *)page_image{
    if (self.page_image_view)
        self.page_image_view.image = page_image;
    
    _page_image = page_image;
}
@end
