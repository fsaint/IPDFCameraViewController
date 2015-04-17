//
//  FinishViewController.m
//  IPDFCameraViewControllerDemo
//
//  Created by Felipe Saint-jean on 4/13/15.
//  Copyright (c) 2015 Maximilian Mackh. All rights reserved.
//

#import "FinishViewController.h"
@import MobileCoreServices;

@interface FinishViewController ()
@property (nonatomic,strong) UIDocumentInteractionController *document_popup;
@end

@implementation FinishViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    if (self.preview_image){
        self.preview_image_view.image = self.preview_image;
    }
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
- (IBAction)openInOtherApp:(UIButton *)sender {
    
    NSURL *url = [NSURL fileURLWithPath:self.file_path];
    self.document_popup = [UIDocumentInteractionController interactionControllerWithURL:url];
    self.document_popup.UTI = (__bridge NSString *)UTTypeCreatePreferredIdentifierForTag(kUTTagClassMIMEType, CFSTR("application/pdf"), NULL);
    [self.document_popup setDelegate:self];
    [self.document_popup presentOpenInMenuFromRect:sender.frame inView:self.view animated:YES];
    
}
- (IBAction)close:(id)sender {
    
    [self dismissViewControllerAnimated:YES completion:^{}];
}


- (UIViewController *)documentInteractionControllerViewControllerForPreview:(UIDocumentInteractionController *)controller{
    return self;
}
@end
