//
//  ForgottenViewController.m
//  DanReaderApp
//
//  Created by saurav sinha on 24/03/12.
//  Copyright (c) 2012 sauravsinha007@gmail.com. All rights reserved.
//

#import "ForgottenViewController.h"

@implementation ForgottenViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
-(IBAction)clickToCancelBtn:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}
-(IBAction)clickToOkBtn:(id)sender
{
    [txtFldEmail resignFirstResponder];
    MBProgressHUD *hud=[MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
    hud.labelText=@"Loading...";
    [NSTimer scheduledTimerWithTimeInterval:0 target:self selector:@selector(loadDataFromUrl) userInfo:nil repeats:NO]; 
}
-(void)loadDataFromUrl
{
    NSURL *url = [NSURL URLWithString:URLFORGOT];
    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url];
    [request setPostValue:txtFldEmail.text forKey:@"email"];
    NSLog(@"forgot url=%@",request);
    [request setDelegate:self];
    [request startSynchronous];
}
#pragma mark-ASIHTTP DELEGATES
- (void)requestFinished:(ASIHTTPRequest *)request
{
    //    // Use when fetching text data
    NSString *responseString = [request responseString];
    NSLog(@"responseString=%@",responseString);
    [MBProgressHUD hideHUDForView:self.navigationController.view animated:YES];
    if([responseString isEqualToString:@"Thank you. If an account exists with that email address, please check your inbox for login instructions"])
    {
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:nil message:responseString delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [alert show];
    }
    else
        [ModalController FuncAlertMsg:responseString inController:nil];

}

- (void)requestFailed:(ASIHTTPRequest *)request
{
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    
    NSError *error = [request error];
    NSLog(@"Error %@",error);
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    [self.navigationController popViewControllerAnimated:YES];
}


@end
