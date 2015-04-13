//
//  ConvertToPDFViewController.m
//  IPDFCameraViewControllerDemo
//
//  Created by Felipe Saint-jean on 4/13/15.
//  Copyright (c) 2015 Maximilian Mackh. All rights reserved.
//
#define PDF_IMAGE_QUALITY 0.7
#import "ConvertToPDFViewController.h"
#import "FinishViewController.h"


@interface ConvertToPDFViewController ()
@property (nonatomic,strong) NSString *output_path;
@end

@implementation ConvertToPDFViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    // start generating PS
    __weak typeof(&*self) weakself = self;
    [self generatePDF:@"a_file.pdf" finishedBlock:^(NSString *pdf_file){
        weakself.output_path = pdf_file;
        [weakself performSegueWithIdentifier:@"finish" sender:weakself];
    } progress:^(NSUInteger index, UIImage *image){
        weakself.progress_image_view.image = image;
    }];
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

-(void)generatePDF:(NSString *)fileName finishedBlock:(void (^)(NSString *filePath))completion progress:(void (^)(NSUInteger page, UIImage *page_image))progress{

    NSArray *arrayPaths =
    NSSearchPathForDirectoriesInDomains(
                                        NSDocumentDirectory,
                                        NSUserDomainMask,
                                        YES);
    NSString *path = [arrayPaths objectAtIndex:0];
    NSString* pdfFileName = fileName ? [path stringByAppendingPathComponent:fileName] : [path stringByAppendingPathComponent:@"file.pdf"];
    if ([[NSFileManager defaultManager] fileExistsAtPath:pdfFileName])
        [[NSFileManager defaultManager] removeItemAtPath:pdfFileName error:nil];
    
    
    
    dispatch_queue_t queue;
    queue = dispatch_queue_create("com.example.MyQueue", NULL);
    
    dispatch_async(queue, ^{
        NSLog(@"Generating PDF into %@",pdfFileName);
        // Create the PDF context using the default page size of 612 x 792.
        UIGraphicsBeginPDFContextToFile(pdfFileName, CGRectZero, nil);
        
        
        [self.pages enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            @autoreleasepool {
                
                UIImage *image = (UIImage *)obj;
                if (progress){
                    dispatch_sync(dispatch_get_main_queue(), ^{
                        progress(idx, image);
                    });
                    
                }
                
                
                
                CGRect page_rect  = CGRectZero;
                page_rect.size = image.size;
                
                NSData *jpegData = UIImageJPEGRepresentation(image, PDF_IMAGE_QUALITY);
                CGDataProviderRef dp = CGDataProviderCreateWithCFData((__bridge CFDataRef)jpegData);
                CGImageRef cgImage = CGImageCreateWithJPEGDataProvider(dp, NULL, true, kCGRenderingIntentDefault);
                
                // Points the pdf converter to the mutable data object and to the UIView to be converted
                UIGraphicsBeginPDFPageWithInfo(page_rect, nil);
                
                CGContextRef pdfContext = UIGraphicsGetCurrentContext();
                
                CGContextTranslateCTM(pdfContext, 0, page_rect.size.height);
                CGContextScaleCTM(pdfContext, 1.0, -1.0);
                
                //this creates pixels within PDF context
                CGContextDrawImage(pdfContext, page_rect, cgImage);
                
                
                CGDataProviderRelease(dp);
                CGImageRelease(cgImage);
            }
        }];
        
        if (completion){
            dispatch_sync(dispatch_get_main_queue(), ^{
                completion(pdfFileName);
            });
            
        }
        UIGraphicsEndPDFContext();

    });
   

    
    

}
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if ([segue.identifier isEqualToString:@"finish"]){
        NSLog(@"Finished");
        FinishViewController *dest = (FinishViewController *) segue.destinationViewController;
        dest.file_path = self.output_path;
        dest.preview_image_view.image = self.pages[0];
        
        
    }
}

@end
