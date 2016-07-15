//
//  AroundTheWorld.m
//  Magazine
//
//  Created by MBPro on 6/28/16.
//  Copyright © 2016 MBPro. All rights reserved.
//

#import "AroundTheWorld.h"
#import "AsyncImageView.h"
#import <libpq/libpq-fe.h>

@interface AroundTheWorld ()

@end

@implementation AroundTheWorld

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setUpScrollview];
    [self setUpNavigationZoomBar];
    [self setUpZoomButtons];
    [self connectToDatabase];
    
    NSLog(@"View X: %f View Y: %f", self.view.frame.size.width, self.view.frame.size.height);
    
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
    _result = PQexec(_connection, "begin");
    if(PQresultStatus(_result) != PGRES_COMMAND_OK) {
        NSLog(@"Begin command failed");
    }
    PQclear(_result);
    
    NSString *tempQuery = [NSString stringWithFormat:@"SELECT * FROM images WHERE filename = 'aroundtheworld'"];
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
    PQclear(_result);
    return resultArray;
}


- (void) setUpNavigationZoomBar {
    UIBarButtonItem *navigationZoomInButton = [[UIBarButtonItem alloc] initWithTitle:@"Zoom In" style:UIBarButtonItemStylePlain target:self action:@selector(zoomIn:)];
    UIBarButtonItem *navigationZoomOutButton = [[UIBarButtonItem alloc] initWithTitle:@"Zoom Out" style:UIBarButtonItemStylePlain target:self action:@selector(zoomOut:)];
    [self.navigationItem setRightBarButtonItems:[NSArray arrayWithObjects:navigationZoomOutButton, navigationZoomInButton, nil]];
}

- (void) setUpScrollview {
    UIImage* image = [UIImage imageNamed:@"aroundTheWorld.jpg"];

    self.imageView.image = image;
    [self.imageView sizeToFit];
    
    self.scrollView.contentSize = image.size;
    self.scrollView.delegate = self;
    self.scrollView.minimumZoomScale = 1.0;
    self.scrollView.maximumZoomScale = 100.0;
}

- (void) setUpZoomButtons {
    UIButton *zoomInButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [zoomInButton setBackgroundImage:[UIImage imageNamed:@"zoom-in.png"] forState:UIControlStateNormal];
    //zoomInButton.frame = CGRectMake(890,  630, 30.0, 46.0);
    
    zoomInButton.frame = CGRectMake(self.view.frame.size.width * 0.87,  self.view.frame.size.height * 0.82, 30.0, 46.0);
    
    //This is the coordinates if we are in portrait
    //zoomInButton.frame = CGRectMake(self.view.frame.size.width * 0.82,  self.view.frame.size.height * 0.87, 30.0, 46.0);
    
    [zoomInButton sizeToFit];
    [zoomInButton addTarget:self action:@selector(zoomIn:)forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview: zoomInButton];
    
    UIButton *zoomOutButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [zoomOutButton setBackgroundImage:[UIImage imageNamed:@"zoom-out.png"] forState:UIControlStateNormal];
    //zoomOutButton.frame = CGRectMake(950,  630, 30.0, 46.0);
    
    zoomOutButton.frame = CGRectMake(self.view.frame.size.width * 0.93,  self.view.frame.size.height * 0.82, 30.0, 46.0);
    
    //This is the coordinates if we are in portrait
    //zoomOutButton.frame = CGRectMake(self.view.frame.size.width * 0.90,  self.view.frame.size.height * 0.87, 30.0, 46.0);
    [zoomOutButton sizeToFit];
    [zoomOutButton addTarget:self action:@selector(zoomOut:)forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview: zoomOutButton];
    self.view.userInteractionEnabled = YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    CGPoint centerPoint = CGPointMake(CGRectGetMidX(self.scrollView.bounds),
                                      CGRectGetMidY(self.scrollView.bounds));
    [self view:self.imageView setCenter:centerPoint];
}

- (void)view:(UIView*)view setCenter:(CGPoint)centerPoint
{
    CGRect vf = view.frame;
    CGPoint co = self.scrollView.contentOffset;
    
    CGFloat x = centerPoint.x - vf.size.width / 2.0;
    CGFloat y = centerPoint.y - vf.size.height / 2.0;
    
    if(x < 0)
    {
        co.x = -x;
        vf.origin.x = 0.0;
    }
    else
    {
        vf.origin.x = x;
    }
    if(y < 0)
    {
        co.y = -y;
        vf.origin.y = 0.0;
    }
    else
    {
        vf.origin.y = y;
    }
    
    view.frame = vf;
    self.scrollView.contentOffset = co;
}

// MARK: - UIScrollViewDelegate
- (UIView*)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    return  self.imageView;
}

- (void)scrollViewDidZoom:(UIScrollView *)sv
{
    UIView* zoomView = [sv.delegate viewForZoomingInScrollView:sv];
    CGRect zvf = zoomView.frame;
    if(zvf.size.width < sv.bounds.size.width)
    {
        zvf.origin.x = (sv.bounds.size.width - zvf.size.width) / 2.0;
    }
    else
    {
        zvf.origin.x = 0.0;
    }
    if(zvf.size.height < sv.bounds.size.height)
    {
        zvf.origin.y = (sv.bounds.size.height - zvf.size.height) / 2.0;
    }
    else
    {
        zvf.origin.y = 0.0;
    }
    zoomView.frame = zvf;
}

- (IBAction)zoomIn:(id)sender {
    if(self.scrollView.zoomScale < self.scrollView.maximumZoomScale) {
        self.scrollView.zoomScale = (self.scrollView.zoomScale + 0.4);
    }
}

- (IBAction)zoomOut:(id)sender {
    if(self.scrollView.zoomScale < self.scrollView.maximumZoomScale) {
        self.scrollView.zoomScale = (self.scrollView.zoomScale - 0.4);
    }
}
@end
