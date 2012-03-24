//
//  LoginViewController.m
//  DanReaderApp
//
//  Created by saurav sinha on 24/03/12.
//  Copyright (c) 2012 sauravsinha007@gmail.com. All rights reserved.
//

#import "LoginViewController.h"

@implementation LoginViewController

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
-(IBAction)clickToOkBtn:(id)sender
{
    if([txtFldEmail.text length]>0 && [txtFldPswd.text length]>0)
    {
        [txtFldPswd resignFirstResponder];
        [txtFldEmail resignFirstResponder];
        MBProgressHUD *hud=[MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
        hud.labelText=@"Checking...";
        
        [NSTimer scheduledTimerWithTimeInterval:0 target:self selector:@selector(loadDataFromUrl) userInfo:nil repeats:NO];
    }
    else
    {
        UIAlertView *Alert=[[UIAlertView alloc]initWithTitle:@"Info" message:@"Please fill required field." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [Alert show];
    }
}
-(void)loadDataFromUrl
{
    NSURL *url = [NSURL URLWithString:URLLOGIN];
    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url];
    [request setUsername:txtFldEmail.text];
    [request setValidatesSecureCertificate:NO];
    NSLog(@"login url=%@",request);
    [request setDelegate:self];
    [request startSynchronous];
}

-(IBAction)clickToCancelBtn:(id)sender
{
    txtFldPswd.text=nil;
    txtFldEmail.text=nil;
    [self.navigationController popViewControllerAnimated:YES];
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}
#pragma mark-ASIHTTP DELEGATES
- (void)requestFinished:(ASIHTTPRequest *)request
{
    //    // Use when fetching text data
    NSString *responseString = [request responseString];
    NSLog(@"%@",responseString);
    // Use when fetching binary data
    NSData *responseData = [request responseData];
    //NSLog(@"response data=%@",responseData);
    //    NSDictionary *_xmlDictionary=[XMLReader dictionaryForXMLData:responseData error:nil];
    [MBProgressHUD hideHUDForView:self.navigationController.view animated:YES];
    //    arrayRead=[[NSMutableArray alloc]initWithArray:[[_xmlDictionary objectForKey:@"cardinfo"]objectForKey:@"card"]];
    //    NSLog(@"arrayRead=%@",arrayRead);
    //    if([arrayRead count]==0)
    //    {
    //        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:nil message:@"No record found." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
    //        [alert show];
    //    }
    //    else
    //        [tableViewRead reloadData];
}

- (void)requestFailed:(ASIHTTPRequest *)request
{
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    
    NSError *error = [request error];
    NSLog(@"Error %@",error);
}

@end
