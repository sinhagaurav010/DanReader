//
//  ForgottenViewController.h
//  DanReaderApp
//
//  Created by saurav sinha on 24/03/12.
//  Copyright (c) 2012 sauravsinha007@gmail.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "constants.h"
#import "MBProgressHUD.h"
#import "ModalController.h"
#import "XMLReader.h"
#import "ASIHTTPRequest.h"
#import "ASIFormDataRequest.h"
@interface ForgottenViewController : UIViewController<UITextFieldDelegate>
{
    IBOutlet UITextField *txtFldEmail;
}
-(void)loadDataFromUrl;
-(IBAction)clickToOkBtn:(id)sender;
-(IBAction)clickToCancelBtn:(id)sender;

@end
