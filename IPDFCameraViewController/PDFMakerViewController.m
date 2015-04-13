//
//  PDFMakerViewController.m
//  IPDFCameraViewControllerDemo
//
//  Created by Felipe Saint-jean on 4/13/15.
//  Copyright (c) 2015 Maximilian Mackh. All rights reserved.
//

#import "PDFMakerViewController.h"

#import "SinglePlageViewController.h"
#import "ConvertToPDFViewController.h"
@interface PDFMakerViewController ()
@property (nonatomic, strong) NSMutableArray *page_list;

@end

@implementation PDFMakerViewController


-(void)pageSnapped:(UIImage *)page_image from:(UIViewController *)controller{
    [self.page_list addObject:page_image];
    [self.tableView reloadData];
    [controller dismissViewControllerAnimated:YES completion:nil];
}
- (IBAction)addPage:(id)sender {
    
    IPDFCameraViewController *camera_controller = [[UIStoryboard storyboardWithName:@"IPDFCamera" bundle:nil] instantiateViewControllerWithIdentifier:@"CameraVC"];
    
    camera_controller.camera_delegate = self;
    [self presentViewController:camera_controller animated:YES completion:^{

    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    self.page_list = [NSMutableArray array];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [_page_list count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CELL" forIndexPath:indexPath];
    
    
    cell.imageView.image = [self.page_list objectAtIndex:indexPath.row];
    cell.textLabel.text = [NSString stringWithFormat:@"Page %d",indexPath.row + 1];
    return cell;
}


// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}


// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [self.page_list removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}



// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}


// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if ([segue.identifier isEqualToString:@"details"]){
        NSIndexPath *selected =  [self.tableView indexPathForSelectedRow];
        SinglePlageViewController *single_page = (SinglePlageViewController *)[(UINavigationController *)segue.destinationViewController topViewController];
        single_page.page_image = [self.page_list objectAtIndex:selected.row];
    }else{
        ConvertToPDFViewController *convert = (ConvertToPDFViewController *)[(UINavigationController *)segue.destinationViewController topViewController];
        convert.pages =  self.page_list;
        
        
    }
}

@end
