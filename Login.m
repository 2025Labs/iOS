//

//  Login.m

//  Magazine

//

//  Created by MBPro on 7/9/16.

//  Copyright © 2016 MBPro. All rights reserved.

//



#import "Login.h"
#import "AESCrypt.h"

@implementation Login



- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    NSString *password = @"top secret message";
    NSString *key = @"p4ssw0rd";
    NSString *salt = [self randomStringWithLength:32];
    NSLog(@"Randomly Generated Salt: %@", key);
    
    NSString *saltedMessage = [NSString stringWithFormat:@"%@%@", password, salt];
    NSLog(@"Salted Message: %@", saltedMessage);
    
    NSString *encryptedData = [AESCrypt encrypt:password password:key];
    NSLog(@"Encrypted: %@", encryptedData);
    
    NSString *message2 = [AESCrypt decrypt:encryptedData password:key];
    
    NSLog(@"Message: %@", message2);
  
}

-(NSString *) randomStringWithLength: (int) len {
    
    NSString *letters = @"abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789";
    
    NSMutableString *randomString = [NSMutableString stringWithCapacity: len];
    
    
    
    for (int i=0; i<len; i++) {
        
        [randomString appendFormat: @"%C", [letters characterAtIndex: arc4random_uniform([letters length])]];
        
    }
    
    
    
    return randomString;
    
}



@end

