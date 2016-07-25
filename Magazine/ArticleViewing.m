//
//  ArticleViewing.m
//  Magazine
//
//  Created by MBPro on 6/27/16.
//  Copyright © 2016 MBPro. All rights reserved.
//

#import "ArticleViewing.h"
#import <libpq/libpq-fe.h>
@import WebImage;

@implementation ArticleViewing

- (void)viewDidLoad {
    [super viewDidLoad];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];

    if([defaults objectForKey:@"articleURLArray"] != nil) {
        NSLog(@"Data already loaded from defaults. Don't connect");
        _articleArray = [defaults objectForKey:@"articleURLArray"];
    } else {
        NSLog(@"Connecting to database and retrieve images");
        NSLog(@"Defaults: %@", defaults);
        [self connectToDatabase];
        _articleArray = [self getImageFilesFromDatabase];
        if(defaults == nil) {
            NSLog(@"Default is nil");
        } else {
            NSLog(@"Default is not nil");
        }
    }
    [self setupScrollview];
    

    for (int i = 0; i < [_articleArray count]; i++) {
        CGFloat xOrigin = i * self.view.frame.size.width;
        
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:
                              CGRectMake(xOrigin, 0,
                                         self.view.frame.size.width,
                                         self.view.frame.size.height)];
        
        SDWebImageManager *manager = [SDWebImageManager sharedManager];
        [manager downloadImageWithURL:[NSURL URLWithString:[_articleArray objectAtIndex:i]]
                              options:0
                             progress:^(NSInteger receivedSize, NSInteger expectedSize) {
                                 NSLog(@"Received: %d expected: %d", receivedSize, expectedSize);
                             }
                            completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished, NSURL *imageURL) {
                                if (image) {
                                    [imageView setImage:image];
                                    imageView.contentMode = UIViewContentModeScaleAspectFit;
                                    [self.scrollView addSubview:imageView];

                                }
                            }];
        
    }
    //set the scroll view content size
    self.scrollView.contentSize = CGSizeMake(self.view.frame.size.width *
                                             [_articleArray count],
                                             self.view.frame.size.height);
    //add the scrollview to this view
    [self.view addSubview:self.scrollView];
    
}

-(void) setupScrollview {
    self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0,self.view.frame.size.width, self.view.frame.size.height)];
    self.scrollView.pagingEnabled = YES;
    [self.scrollView setAlwaysBounceVertical:NO];
    _setupDone = true;

}
-(void) connectToDatabase {
    _connectionString = "user=rwpham password=richard1 dbname=postgres  port=5432 host=52.9.114.219";
    _connection = PQconnectdb(_connectionString);
    
    if(PQstatus(_connection) != CONNECTION_OK) {
        NSLog(@"Error: Couldn't connect to the database");
        NSLog(@"Error message: %s", PQerrorMessage(_connection));
    }
    
}

-(NSMutableArray*) getImageFilesFromDatabase {
    _result = PQexec(_connection, "begin");
    if(PQresultStatus(_result) != PGRES_COMMAND_OK) {
        NSLog(@"Begin command failed");
    }
    PQclear(_result);
    
    NSString *tempQuery = [NSString stringWithFormat:@"SELECT * FROM images WHERE filename like 'article_.png' AND topic = '%@'", _currentTopic];
    const char *query = [tempQuery cStringUsingEncoding:NSASCIIStringEncoding];
    
    NSLog(@"Query: %s", query);
    _result = PQexec(_connection, query);
    if(PQresultStatus(_result) !=PGRES_TUPLES_OK) {
        NSLog(@"Couldn't fetch anything");
    }
    NSMutableArray* resultArray = [[NSMutableArray alloc] init];
    //If successful, this should be a hashed password
    for(int i =0; i < PQntuples(_result); i++) {
    NSLog(@"value: %s ",PQgetvalue(_result, i, 2));
        NSString *temp = [NSString stringWithUTF8String:PQgetvalue(_result, i, 2)];
        [resultArray addObject:temp];
    }
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:resultArray forKey:@"articleURLArray"];
    [defaults synchronize];

    PQclear(_result);
    return resultArray;
}

@end
