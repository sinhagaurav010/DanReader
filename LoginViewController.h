//
//  LoginViewController.h
//  DanReaderApp
//
//  Created by saurav sinha on 24/03/12.
//  Copyright (c) 2012 sauravsinha007@gmail.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ASIHTTPRequest.h"
#import "ASIFormDataRequest.h"
#import "constants.h"
#import "MBProgressHUD.h"
@interface LoginViewController : UIViewController
{
    IBOutlet UITextField *txtFldEmail;
    IBOutlet UITextField *txtFldPswd;

}
-(void)loadDataFromUrl;
-(IBAction)clickToOkBtn:(id)sender;
-(IBAction)clickToCancelBtn:(id)sender;
@end
