//
//  NGFinalOrderController.m
//  NGKioskApp
//
//  Created by Andrey Karaban on 13/07/15.
//  Copyright (c) 2015 ACEP. All rights reserved.
//

#import "NGFinalOrderController.h"
#import "NGDataManager.h"
#import <DropboxSDK/DropboxSDK.h>
#import "RTPDFGenerator.h"
#import <MessageUI/MessageUI.h>
#import "NGDataManager.h"

@interface NGFinalOrderController ()<DBRestClientDelegate, MFMailComposeViewControllerDelegate>

@property (nonatomic, strong) DBRestClient *restClient;
@property (nonatomic, strong) RTPDFGenerator *generator;
@property (weak, nonatomic) IBOutlet UILabel *orderNumberLabel;

- (IBAction)homeBtnPressed:(id)sender;
- (IBAction)dropBoxPressed:(id)sender;

@end

@implementation NGFinalOrderController
{
    NSString *documentsDirectory;
    NSString *fileName;
}
@synthesize orderNumberLabel;
@synthesize generator;
@synthesize restClient;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    restClient = [[DBRestClient alloc] initWithSession:[DBSession sharedSession]];
    restClient.delegate = self;
    
    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    orderNumberLabel.text = [NSString stringWithFormat:@"Order number: 4654688784"];
    
    if (![[DBSession sharedSession] isLinked]) {
        [[DBSession sharedSession] linkFromController:self];
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

- (IBAction)homeBtnPressed:(id)sender
{
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (IBAction)dropBoxPressed:(id)sender
{
    [self createPDF:sender];
}

- (void)restClient:(DBRestClient *)client uploadedFile:(NSString *)destPath
              from:(NSString *)srcPath metadata:(DBMetadata *)metadata
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Success!"
                                                    message:@"Your order was successfully uploaded to DropBox"
                                                   delegate:self
                                          cancelButtonTitle:@"OK"
                                          otherButtonTitles: nil];
    [alert show];
}

- (void)restClient:(DBRestClient *)client uploadFileFailedWithError:(NSError *)error
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Fail!"
                                                    message:@"Your order upload failed with error!!"
                                                   delegate:self
                                          cancelButtonTitle:@"OK"
                                          otherButtonTitles: nil];
    [alert show];

    NSLog(@"File upload failed with error: %@", error);
}

#pragma mark - Actions

- (void)createPDF:(UIButton *)sender
{
    NSString *frameName = [[[DATA_MANAGER.currentCart getAllItems] objectAtIndex:0] nameItem];
    NSString *totalPrice = [NSString stringWithFormat:@"$%.2f", [DATA_MANAGER.currentCart getTotalPrice]];
    UIImage *image = [UIImage imageNamed:[[[DATA_MANAGER.currentCart getAllItems] objectAtIndex:0] imageName]];
    
    
    generator = [RTPDFGenerator createPDFWithTemplate:@"index"
                                             pageSize:kPaperSizeA4
                                          contentData:@{ @"frameName" : frameName, @"orderPrice" : totalPrice}
                                           imagesData:@{ @"main" : image }
                                           completion:^(BOOL success, NSData *data) {
                                               
                                               if (success)
                                                   [self sendPDFViaEmail:data];
                                               else
                                                   NSLog(@"Error!");
                                           }];
}

- (void)sendPDFViaEmail:(NSData *)pdf
{
    MFMailComposeViewController *picker = [MFMailComposeViewController new];
    
    picker.mailComposeDelegate = self;
    
    [picker setSubject:NSLocalizedString(@"Message subject", @"")];
    
    if (pdf)
        [picker addAttachmentData:pdf mimeType:@"application" fileName:@"document.pdf"];
    
    @try {
        [self presentViewController:picker animated:YES completion:nil];
    }
    @catch (NSException *exception) {
        //
    }
    @finally {
        //
    }
}

- (void)mailComposeController:(MFMailComposeViewController *)controller
          didFinishWithResult:(MFMailComposeResult)result
                        error:(NSError *)error
{
    switch (result)
    {
        case MFMailComposeResultCancelled:
            break;
        case MFMailComposeResultSaved:
            break;
        case MFMailComposeResultSent:
            [self sendToDropBox];
            break;
        case MFMailComposeResultFailed:
            break;
        default:
            break;
    }
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)sendToDropBox
{
//    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
//    documentsDirectory = [paths objectAtIndex:0];
//
//    fileName = @"document.pdf";
//
//    // Keep the database filename.
//     NSString *localPath = [documentsDirectory stringByAppendingPathComponent:fileName];
//    
//    // Copy the database file into the documents directory if necessary.
//    [self copyDatabaseIntoDocumentsDirectory];
//
//    // Upload file to Dropbox
//    NSString *destDir = @"/";
//    [self.restClient uploadFile: toPath:destDir withParentRev:nil fromPath:localPath];

}

- (void)copyDatabaseIntoDocumentsDirectory
{
    // Check if the database file exists in the documents directory.
    
    NSString *destinationPath = [documentsDirectory stringByAppendingPathComponent:@"document.pdf"];
    
    if (![[NSFileManager defaultManager] fileExistsAtPath:destinationPath])
    {
        // The database file does not exist in the documents directory, so copy it from the main bundle now.
        NSString *sourcePath = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"document.pdf"];
        NSError *error;
        [[NSFileManager defaultManager] copyItemAtPath:sourcePath toPath:destinationPath error:&error];
        NSLog(@"FFFFD was copied!\n\n\n");
    }
}

@end
