//
//  Login.h
//  Magazine
//
//  Created by MBPro on 7/9/16.
//  Copyright © 2016 MBPro. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <libpq/libpq-fe.h>
@interface Login : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *username;
@property (weak, nonatomic) IBOutlet UITextField *password;
@property (weak, nonatomic) IBOutlet UIButton *loginButton;

@property const char *connectionString;
@property PGresult *result;
@property PGconn *connection;
@end
