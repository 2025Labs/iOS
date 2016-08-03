//

//  Login.m

//  Magazine

//

//  Created by MBPro on 7/9/16.

//  Copyright © 2016 MBPro. All rights reserved.

//



#import "Login.h"
#import "AESCrypt.h"
#import <libpq/libpq-fe.h>

@implementation Login
/*


- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [self connectToDatabase];
}

-(void) connectToDatabase {
    _connectionString = "user=rwpham password=richard1 dbname=postgres  port=5432 host=52.9.114.219";
    _connection = PQconnectdb(_connectionString);
    
    if(PQstatus(_connection) != CONNECTION_OK) {
        NSLog(@"Error: Couldn't connect to the database");
        NSLog(@"Error message: %s", PQerrorMessage(_connection));
    }
    
}

-(const char*) queryDatabase: (NSString*)username: (NSString*)attribute  {
    _result = PQexec(_connection, "begin");
    if(PQresultStatus(_result) != PGRES_COMMAND_OK) {
        NSLog(@"Begin command failed");
    }
    PQclear(_result);
    
    NSString *tempQuery = [NSString stringWithFormat:@"SELECT %@ FROM userinformation WHERE username = '%@'", attribute, username];
    const char *query = [tempQuery cStringUsingEncoding:NSASCIIStringEncoding];
    
    NSLog(@"Query: %s", query);
    _result = PQexec(_connection, query);
    if(PQresultStatus(_result) !=PGRES_TUPLES_OK) {
        NSLog(@"Couldn't fetch anything");
    }
    PQclear(_result);
    //If successful, this should be a hashed password
    return PQgetvalue(_result, 0, 0);
}

-(NSString *) randomStringWithLength: (int) len {
    //len = 32 = 32 bytes = 256 bits = AES256
    NSString *letters = @"abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789";
    
    NSMutableString *randomString = [NSMutableString stringWithCapacity: len];
    for (int i=0; i<len; i++) {
        [randomString appendFormat: @"%C", [letters characterAtIndex: arc4random_uniform([letters length])]];
    }
    return randomString;
}

- (IBAction)attemptLogin:(id)sender {
    NSString *username = _username.text;
    NSString *attemptedPassword = _password.text;
    //Query database using the username and return the hashed password
    NSString *salt = [NSString stringWithUTF8String:[self queryDatabase:username:@"salt"]];

    NSString *saltedPassword = [NSString stringWithFormat:@"%@%@",attemptedPassword, salt];
    if([self decrypt:username comparedWith:saltedPassword]) {
        NSLog(@"Succesful login");
    } else {
        NSLog(@"The username or password is invalid");
    }

}

-(BOOL) decrypt:(NSString*)username comparedWith:(NSString*) saltedPassword {
    NSString *passwordDB = [NSString stringWithUTF8String:[self queryDatabase:username:@"password"]];
    NSString *keyDB = [NSString stringWithUTF8String:[self queryDatabase:username:@"key"]];
    
    if([saltedPassword isEqualToString:[AESCrypt decrypt:passwordDB password:keyDB]]) {
        return true;
    }
    return false;
}

- (IBAction)registerNewUser:(id)sender {
    NSString *username = _username.text;
    NSString *password = _password.text;
    NSString *key = [self randomStringWithLength:32];
    NSString *salt = [self randomStringWithLength:32];
    //NSLog(@"Salted Message: %@", saltedPassword);
    //NSLog(@"Randomly Generated Salt: %@", salt);
    //NSLog(@"Randomly Generated Key: %@", key);
    //NSString *encryptedData = [AESCrypt encrypt:saltedPassword password:key];
    //NSLog(@"Encrypted: %@", encryptedData);
    //NSString *message2 = [AESCrypt decrypt:encryptedData password:key];
    //NSLog(@"Message: %@", message2);

}
*/
@end

