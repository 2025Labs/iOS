//
//  ArticleViewing.m
//  Magazine
//
//  Created by MBPro on 6/27/16.
//  Copyright © 2016 MBPro. All rights reserved.
//

#import "ArticleViewing.h"
#import <libpq/libpq-fe.h>
#import "AsyncImageView.h"
@implementation ArticleViewing

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupScrollview];
    [self connectToDatabase];

    
    NSMutableArray *articleArray = [[NSMutableArray alloc]init];
    articleArray = [self getArticleFiles];
    
    for (int i = 0; i < [articleArray count]; i++) {
        CGFloat xOrigin = i * self.view.frame.size.width;
        
        AsyncImageView *imageView = [[AsyncImageView alloc] initWithFrame:
                              CGRectMake(xOrigin, 0,
                                         self.view.frame.size.width,
                                         self.view.frame.size.height)];
        
        //setting imageURL starts downloading the image in the background
        imageView.imageURL = [NSURL URLWithString:[articleArray objectAtIndex:i]];

        imageView.contentMode = UIViewContentModeScaleAspectFit;
        [self.scrollView addSubview:imageView];
    }
    //set the scroll view content size
    self.scrollView.contentSize = CGSizeMake(self.view.frame.size.width *
                                             [articleArray count],
                                             self.view.frame.size.height);
    //add the scrollview to this view
    [self.view addSubview:self.scrollView];
    
}

-(void) setupScrollview {
    self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0,self.view.frame.size.width, self.view.frame.size.height)];
    self.scrollView.pagingEnabled = YES;
    [self.scrollView setAlwaysBounceVertical:NO];

}
-(void) connectToDatabase {
    _connectionString = "user=rwpham password=richard1 dbname=postgres  port=5432 host=52.9.114.219";
    _connection = PQconnectdb(_connectionString);
    
    if(PQstatus(_connection) != CONNECTION_OK) {
        NSLog(@"Error: Couldn't connect to the database");
        NSLog(@"Error message: %s", PQerrorMessage(_connection));
    }
    
}

-(NSMutableArray*) getArticleFiles {
    _res = PQexec(_connection, "begin");
    if(PQresultStatus(_res) != PGRES_COMMAND_OK) {
        NSLog(@"Begin command failed");
    }
    PQclear(_res);
    
    NSString *tempQuery = [NSString stringWithFormat:@"SELECT * FROM images"];
    const char *query = [tempQuery cStringUsingEncoding:NSASCIIStringEncoding];
    
    NSLog(@"Query: %s", query);
    _res = PQexec(_connection, query);
    if(PQresultStatus(_res) !=PGRES_TUPLES_OK) {
        NSLog(@"Couldn't fetch anything");
    }
    NSMutableArray* resultArray = [[NSMutableArray alloc] init];
    //If successful, this should be a hashed password
    for(int i =0; i < PQntuples(_res); i++) {
    NSLog(@"value: %s ",PQgetvalue(_res, i, 2));
        NSString *temp = [NSString stringWithUTF8String:PQgetvalue(_res, i, 2)];
        [resultArray addObject:temp];
    }
    PQclear(_res);
    return resultArray;
}

@end
