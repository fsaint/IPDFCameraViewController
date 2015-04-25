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
@property (nonatomic,assign) BOOL finished;
@end

@implementation ConvertToPDFViewController


- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    if ([string isEqualToString:@"\n"])
        [textField resignFirstResponder];
    return YES;
}
- (void)textFieldDidEndEditing:(UITextField *)textField{
    
    if (self.finished){
        self.output_path = [self renameOutputFile:self.output_path];
        if (self.pdf_delegate)
            [self.pdf_delegate generatedDocument:self.output_path controller:self];
        [self performSegueWithIdentifier:@"finish" sender:self];

    }
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    // start generating PS
    
    self.file_name.text = @"new file";
    self.file_name.delegate = self;
    
    
    
    
}

-(void)viewDidAppear:(BOOL)animated{
    __weak typeof(&*self) weakself = self;
    [self generatePDF:self.file_name.text finishedBlock:^(NSString *pdf_file){
        weakself.output_path = pdf_file;
        [weakself.spinner stopAnimating];
        weakself.spinner.hidden = YES;
        weakself.progress_message.text = @"Done";
        weakself.finished = YES;
        if (![weakself.file_name isFirstResponder]){
            // User changing the name?
            if (weakself.pdf_delegate)
                [weakself.pdf_delegate generatedDocument:pdf_file controller:self];
            [weakself performSegueWithIdentifier:@"finish" sender:weakself];
        }
        
    } progress:^(NSUInteger index, UIImage *image){
        weakself.progress_image_view.image = image;
    }];
    
    [self.file_name becomeFirstResponder];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSString *)documentsDirectory {
    NSArray *arrayPaths =
    NSSearchPathForDirectoriesInDomains(
                                        NSDocumentDirectory,
                                        NSUserDomainMask,
                                        YES);
    NSString *path = [arrayPaths objectAtIndex:0];
    return path;
}

- (NSString *)renameOutputFile:(NSString *)pdfFileName {
    NSString *final_name = pdfFileName;
    if ([self.file_name.text length] > 0){
        NSFileManager * man = [NSFileManager defaultManager];
        final_name = [[self documentsDirectory] stringByAppendingPathComponent:self.file_name.text];
        
        if (![final_name isEqualToString:pdfFileName] && [man fileExistsAtPath:final_name])
            [man removeItemAtPath:final_name error:nil];
        
        [man moveItemAtPath:pdfFileName toPath:final_name error:nil];
        
    }
    return final_name;
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

    NSString *path;
    path = [self documentsDirectory];
    NSString* pdfFileName = fileName ? [path stringByAppendingPathComponent:fileName] : [path stringByAppendingPathComponent:@"temp_file_name.pdf"];
    
    
    if ([[NSFileManager defaultManager] fileExistsAtPath:pdfFileName])
        [[NSFileManager defaultManager] removeItemAtPath:pdfFileName error:nil];
    
    
    
    dispatch_queue_t queue;
    queue = dispatch_queue_create("com.example.MyQueue", NULL);
    
    dispatch_async(queue, ^{
        NSLog(@"Generating PDF into %@",pdfFileName);
        // Create the PDF context using the default page size of 612 x 792.
        UIGraphicsBeginPDFContextToFile(pdfFileName, CGRectZero, nil);
        
        
        [self.document.page_images enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
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
                NSString *final_name;
                final_name = [self renameOutputFile:pdfFileName];
                completion(final_name);
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
        dest.preview_image = self.document.page_images[0];
    }
}

@end
