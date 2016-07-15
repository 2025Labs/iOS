//
//  Puzzle.m
//  Magazine
//
//  Created by MBPro on 6/23/16.
//  Copyright © 2016 MBPro. All rights reserved.
//

#import "Puzzle.h"
#import "IGCMenu.h"
#import "AsyncImageView.h"
#import <libpq/libpq-fe.h>

@implementation Puzzle

- (void)viewDidLoad {
    [super viewDidLoad];
    [self preparePencil];
    [self prepareMenu];
    [self connectToDatabase];
    NSMutableArray *fileArray = [self getArticleFiles:_fileName];
    // Do any additional setup after loading the view, typically from a nib.
    
    //Make the edge of the view underneath the nav bar
    self.edgesForExtendedLayout = UIRectEdgeNone;
    //Get the fileName, which was passed by whichever segue brought us here
    //UIImage *image = [UIImage imageNamed: self.fileName];
    
    //setting imageURL starts downloading the image in the background
    _tempDrawingImage.imageURL = [NSURL URLWithString:[fileArray objectAtIndex:0]];
    
    //[self.tempDrawingImage setImage:image];
    NSLog(@"tempDrawingImage has been set to %@", [fileArray objectAtIndex:0]);
}

-(void) connectToDatabase {
    _connectionString = "user=rwpham password=richard1 dbname=postgres  port=5432 host=52.9.114.219";
    _connection = PQconnectdb(_connectionString);
    
    if(PQstatus(_connection) != CONNECTION_OK) {
        NSLog(@"Error: Couldn't connect to the database");
        NSLog(@"Error message: %s", PQerrorMessage(_connection));
    }
    
}

-(NSMutableArray*) getArticleFiles: (NSString*) filename{
    _result = PQexec(_connection, "begin");
    if(PQresultStatus(_result) != PGRES_COMMAND_OK) {
        NSLog(@"Begin command failed");
    }
    PQclear(_result);
    
    NSString *tempQuery = [NSString stringWithFormat:@"SELECT * FROM images WHERE filename = '%@'", filename];
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

-(void) preparePencil {
    _red = 0.0;
    _green = 0.0;
    _blue = 0.0;
    _brush = 3.0;
    _opacity = 1.0;
}

-(void) prepareMenu {
    //_moreButton.clipsToBounds = YES;
    //_moreButton.layer.cornerRadius = self.moreButton.frame.size.width / 2;
    //[_moreButton setImage:[UIImage imageNamed:@"plus.png"] forState:UIControlStateNormal];
    
    if(_menu == nil) {
        _menu = [[IGCMenu alloc] init];
    }
    _menu.menuButton = self.moreButton;
    _menu.menuSuperView = self.view;
    _menu.disableBackground = YES;
    _menu.numberOfMenuItem = 4;
    _menu.menuRadius = 150; //How far apart the menu displays
    _menu.menuHeight = 90; //Size of the circles
    _menu.menuItemsNameArray = [NSArray arrayWithObjects:@"Fill in the Blanks", @"Material Time", @"Word Search", @"Cipher", nil];
    _isMenuActive = false;
    _menu.delegate = self;
    
}

- (IBAction)menuPressed:(id)sender {
    if(_isMenuActive) {
        [_menu hideCircularMenu];
        _isMenuActive = false;
    } else {
        [_menu showCircularMenu];
        _isMenuActive = true;
    }
}

- (void)igcMenuSelected:(NSString *)selectedMenuName atIndex:(NSInteger)index{
    
    switch (index) {
        case 0:
            NSLog(@"Transition to Computing");
            break;
        case 1:
            NSLog(@"Transition to Energy");
            
            break;
        case 2:
            NSLog(@"Transition to Materials");
            
            break;
        default:
            break;
    }
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
    _mouseSwiped = NO;
    UITouch *touch = [touches anyObject];
    _lastPoint = [touch locationInView:self.view];
}

-(void) touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    _mouseSwiped = YES;
    UITouch *touch = [touches anyObject];
    CGPoint currentPoint = [touch locationInView:self.view];
    
    UIGraphicsBeginImageContext(self.view.frame.size);
    [self.tempDrawingImage.image drawInRect:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    CGContextMoveToPoint(UIGraphicsGetCurrentContext(), _lastPoint.x, _lastPoint.y);
    CGContextAddLineToPoint(UIGraphicsGetCurrentContext(), currentPoint.x, currentPoint.y);
    CGContextSetLineCap(UIGraphicsGetCurrentContext(), kCGLineCapRound);
    CGContextSetLineWidth(UIGraphicsGetCurrentContext(), _brush );
    CGContextSetRGBStrokeColor(UIGraphicsGetCurrentContext(), _red, _green, _blue, 1.0);
    CGContextSetBlendMode(UIGraphicsGetCurrentContext(),kCGBlendModeNormal);
    
    CGContextStrokePath(UIGraphicsGetCurrentContext());
    self.tempDrawingImage.image = UIGraphicsGetImageFromCurrentImageContext();
    [self.tempDrawingImage setAlpha:_opacity];
    _tempDrawingImage.contentMode = UIViewContentModeScaleAspectFit;
    
    UIGraphicsEndImageContext();
    
    _lastPoint = currentPoint;
    
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    
    if(!_mouseSwiped) {
        UIGraphicsBeginImageContext(self.view.frame.size);
        [self.tempDrawingImage.image drawInRect:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
        CGContextSetLineCap(UIGraphicsGetCurrentContext(), kCGLineCapRound);
        CGContextSetLineWidth(UIGraphicsGetCurrentContext(), _brush);
        CGContextSetRGBStrokeColor(UIGraphicsGetCurrentContext(), _red, _green, _blue, _opacity);
        CGContextMoveToPoint(UIGraphicsGetCurrentContext(), _lastPoint.x, _lastPoint.y);
        CGContextAddLineToPoint(UIGraphicsGetCurrentContext(), _lastPoint.x, _lastPoint.y);
        CGContextStrokePath(UIGraphicsGetCurrentContext());
        CGContextFlush(UIGraphicsGetCurrentContext());
        self.tempDrawingImage.image = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
    }
    
    UIGraphicsBeginImageContext(self.cipher.frame.size);
    [self.cipher.image drawInRect:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) blendMode:kCGBlendModeNormal alpha:1.0];
    [self.tempDrawingImage.image drawInRect:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) blendMode:kCGBlendModeNormal alpha:_opacity];
    self.cipher.image = UIGraphicsGetImageFromCurrentImageContext();
    self.tempDrawingImage.image = nil;
    UIGraphicsEndImageContext();
    
}

-(IBAction)buttonPressed:(id)sender {
    UIButton *toolSelection = (UIButton*)sender;
    
    switch(toolSelection.tag) {
        case 0:
            _red = 0;
            _green = 0;
            _blue = 0;
            _opacity = 1;
            _brush = 10;
            break;
        case 1:
            _red = 1;
            _green = 1;
            _blue = 0;
            _opacity = .6;
            _brush = 18;
            break;
        case 2:
            _red = 0;
            _green = 0;
            _blue = 0;
            _opacity = 1;
            _brush = 10;
            UIImage *image = [UIImage imageNamed:@"WordSearchFull.png"];
            [self.cipher setImage:image];
    }
}


@end
