//
//  PDFSplitViewController.m
//  IPDFCameraViewControllerDemo
//
//  Created by Felipe Saint-Jean on 4/16/15.
//  Copyright (c) 2015 Maximilian Mackh. All rights reserved.
//

#import "PDFSplitViewController.h"
#import "SinglePlageViewController.h"
@interface PDFSplitViewController ()

@end

@implementation PDFSplitViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UINavigationController *navigationController = [self.viewControllers lastObject];
    navigationController.topViewController.navigationItem.leftBarButtonItem = self.displayModeButtonItem;
    
    self.delegate = self;
    //self.preferredDisplayMode = UISplitViewControllerDisplayModePrimaryOverlay;
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

// This will make it work on the iphone
- (BOOL)splitViewController:(UISplitViewController *)splitViewController
collapseSecondaryViewController:(UIViewController *)secondaryViewController
  ontoPrimaryViewController:(UIViewController *)primaryViewController {
    
    if ([secondaryViewController isKindOfClass:[UINavigationController class]]
        && [[(UINavigationController *)secondaryViewController topViewController] isKindOfClass:[SinglePlageViewController class]]
        && ([(SinglePlageViewController *)[(UINavigationController *)secondaryViewController topViewController] page_image] == nil)) {
        
        // Return YES to indicate that we have handled the collapse by doing nothing; the secondary controller will be discarded.
        return YES;
        
    } else {
        
        return NO;
        
    }
}
@end
