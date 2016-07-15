//
//  ArticleViewing.h
//  Magazine
//
//  Created by MBPro on 6/27/16.
//  Copyright © 2016 MBPro. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <libpq/libpq-fe.h>

@interface ArticleViewing : UIViewController
@property (nonatomic, strong) IBOutlet UIScrollView *scrollView;

@property NSString *fileName;
@property NSInteger numPages;

@property const char *connectionString;
@property PGresult *res;
@property PGconn *connection;
@end
