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
    // Do any additional setup after loading the view from its nib.
//    Company name (no more than 50 characters)
//    Email (no more than 50 characters and correct email formatting)
//    Address (no more than 50 char)
//    City (no more than 30 chars)
//    State (2 characters)
//    Zip (5 digits e.g. 11111)
//    Password (minimum of 6 chars, max of 20)
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
        NSLog(@"kdfnbkndkfv");
               
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
@end
