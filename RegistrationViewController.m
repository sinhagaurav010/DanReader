//
//  RegistrationViewController.m
//  DanReaderApp
//
//  Created by saurav sinha on 24/03/12.
//  Copyright (c) 2012 sauravsinha007@gmail.com. All rights reserved.
//

#import "RegistrationViewController.h"

@implementation RegistrationViewController

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
    self.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc]initWithTitle:@"Save" style:UIBarButtonItemStyleBordered target:self action:@selector(clickToSaveBtn:)];
    
    arrayreg=[[NSMutableArray alloc]initWithObjects:@"Company name",@"Email",@"Address",@"City",@"State",@"Zip",@"Password", nil];
    arrayTxtFld=[[NSMutableArray alloc]init];
    for(int i=0;i<[arrayreg count];i++)
    {
        UITextField * textFieldRounded = [[UITextField alloc] init];
        textFieldRounded.tag = i;
        textFieldRounded.borderStyle = UITextBorderStyleNone;
		textFieldRounded.textColor = [UIColor blackColor]; //text color
		textFieldRounded.font = [UIFont systemFontOfSize:17.0];  //font size
        [textFieldRounded addTarget:self action:@selector(backpad) forControlEvents:UIControlEventEditingDidEndOnExit];
		textFieldRounded.backgroundColor = [UIColor clearColor]; //background color
		textFieldRounded.autocorrectionType = UITextAutocorrectionTypeNo;	// no auto correction support
        
        if(i == [arrayreg count]-1)
            textFieldRounded.secureTextEntry = YES;
        
        textFieldRounded.delegate = self;
		
		textFieldRounded.returnKeyType = UIReturnKeyDone;  // type of the return key
		
        
        [arrayTxtFld addObject:textFieldRounded];
    }

    
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
#pragma mark -code tableviewdelegate-
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{

        return 5;

}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *MyIdentifier = @"MyIdentifier";
    MyIdentifier = @"tblCellView";
	
	UITableViewCell *cell = (UITableViewCell *)[tableView dequeueReusableCellWithIdentifier:nil];
	if(cell == nil) 
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
        UITextField *field = [arrayTxtFld objectAtIndex:indexPath.section];
        field.frame = CGRectMake(15, 
                                 10, 
                                 280,
                                 44);
        [cell addSubview:field];

    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
               
    return cell;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return  [arrayreg   count];
}
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return [arrayreg  objectAtIndex:section];
}
#pragma mark- User Defined functions
-(IBAction)clickToSaveBtn:(id)sender
{
    
    for(int i=0;i<[arrayTxtFld count];i++)
    {
        if([[[arrayTxtFld objectAtIndex:i] text] length]==0)
        {
            [ModalController FuncAlertMsg:@"Each Field is mandatory!" inController:nil];
            return;
        }
    }
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"; 
    
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex]; 
    
   
    if([[[arrayTxtFld objectAtIndex:0]text] length]>50)
    {
        [ModalController FuncAlertMsg:@"Company name not more 50 characters." inController:nil];
        return; 
    }
    if(![emailTest evaluateWithObject:[[arrayTxtFld objectAtIndex:1]text]])
    {
        [ModalController FuncAlertMsg:@"Please Correct the Email Address!" inController:nil];
        return;
    }
    if([[[arrayTxtFld objectAtIndex:2]text] length]>50)
    {
        [ModalController FuncAlertMsg:@"Company name not more 50 characters." inController:nil];
        return; 
    }
    if([[[arrayTxtFld objectAtIndex:3]text] length]>30)
    {
        [ModalController FuncAlertMsg:@"City name not more 30 characters." inController:nil];
        return; 
    }
    if([[[arrayTxtFld objectAtIndex:4]text] length]!=2)
    {
        [ModalController FuncAlertMsg:@"State name should be 2 characters." inController:nil];
        return; 
    }
    if([[[arrayTxtFld objectAtIndex:5]text] length]!=5)
    {
        [ModalController FuncAlertMsg:@"Zip code should be 5 digits." inController:nil];
        return; 
    }
    if([[[arrayTxtFld objectAtIndex:6]text] length]<6 || [[[arrayTxtFld objectAtIndex:6]text] length]>20)
    {
        [ModalController FuncAlertMsg:@"Password should be 6(min.) to 20(max.)." inController:nil];
        return; 
    }
    MBProgressHUD *hud=[MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
    hud.labelText=@"Loading...";
    [NSTimer scheduledTimerWithTimeInterval:0 target:self selector:@selector(loadDataFromUrl) userInfo:nil repeats:NO]; 
}
-(void)loadDataFromUrl
{
    //Name, email, address, city, state, zip, pass
    [fieldEdit resignFirstResponder];
    NSURL *url = [NSURL URLWithString:URLREGISTRATION];
    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url];
    [request setPostValue:[[arrayTxtFld objectAtIndex:0]text] forKey:@"Name"];
    [request setPostValue:[[arrayTxtFld objectAtIndex:1]text] forKey:@"email"];
    [request setPostValue:[[arrayTxtFld objectAtIndex:2]text] forKey:@"address"];
    [request setPostValue:[[arrayTxtFld objectAtIndex:3]text] forKey:@"city"];
    [request setPostValue:[[arrayTxtFld objectAtIndex:4]text] forKey:@"state"];
    [request setPostValue:[[arrayTxtFld objectAtIndex:5]text] forKey:@"zip"];
    [request setPostValue:[[arrayTxtFld objectAtIndex:6]text] forKey:@"pass"];
    NSLog(@"login url=%@",request);
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
    if([responseString isEqualToString:@"Thank you. Please check your email for account validation"])
    {
          
       // [ModalController FuncAlertMsg:responseString inController:self];
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:nil message:responseString delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
            [alert show];
        [fieldEdit setText:nil];
    }
    else
        [ModalController FuncAlertMsg:responseString inController:nil];
    
       //NSLog(@"response data=%@",responseData);
    //    NSDictionary *_xmlDictionary=[XMLReader dictionaryForXMLData:responseData error:nil];
   
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


#pragma mark -UITextField Delegates
- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    fieldEdit = textField;
    
   // if(![textField isEqual:[arrayTxtFld objectAtIndex:2]])
        [tableViewRegister setContentOffset:CGPointMake(0, textField.tag*90) animated:YES];
    
    }

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    [tableViewRegister setContentOffset:CGPointMake(0, 0) animated:YES];

    return YES;
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    [self.navigationController popViewControllerAnimated:YES];
}

@end
