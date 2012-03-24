//
//  RegistrationViewController.h
//  DanReaderApp
//
//  Created by saurav sinha on 24/03/12.
//  Copyright (c) 2012 sauravsinha007@gmail.com. All rights reserved.
//

#import <UIKit/UIKit.h>
 
@interface RegistrationViewController : UIViewController<UITextFieldDelegate>
{
    IBOutlet UITableView *tableViewRegister;
    NSMutableArray *arrayreg;
    NSMutableArray *arrayTxtFld;
    //UITextField *textFieldRounded;
    UITextField *fieldEdit;
}

@end
