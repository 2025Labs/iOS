//
//  Puzzle.m
//  Magazine
//
//  Created by MBPro on 6/23/16.
//  Copyright © 2016 MBPro. All rights reserved.
//

#import "Puzzle.h"
#import "IGCMenu.h"
#import <libpq/libpq-fe.h>
@import WebImage;

@implementation Puzzle

- (void)viewDidLoad {
    [super viewDidLoad];
    [self preparePencil];
    [self prepareMenu];
    _isDrawingEnabled = true;
    [self registerForNotifications];
    [[NSUserDefaults standardUserDefaults] setPersistentDomain:[NSDictionary dictionary] forName:[[NSBundle mainBundle] bundleIdentifier]];
    
    
    NSLog(@"Loading View. filename: %@ topic: %@", _fileName, _currentTopic);
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    
    
    NSString *userDefaultKey = [NSString stringWithFormat:@"%@,%@", _fileName, _currentTopic];
    
    if([defaults objectForKey:userDefaultKey] != nil) {
        NSLog(@"Data already loaded from defaults with key: %@. Don't connect", _fileName);
        _fileArray = [defaults objectForKey:userDefaultKey];
    } else {
        NSLog(@"Connecting to database and retrieve images");
        NSLog(@"Defaults: %@", defaults);
        [self connectToDatabase];
        NSLog(@"hi");
        
        _fileArray = [self getImageFilesFromDatabase];
        NSLog(@"Hello");
    }
    
    // Do any additional setup after loading the view, typically from a nib.
    
    //Make the edge of the view underneath the nav bar
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    SDWebImageManager *manager = [SDWebImageManager sharedManager];
    [manager downloadImageWithURL:[NSURL URLWithString:[_fileArray objectAtIndex:0]]
                          options:0
                         progress:^(NSInteger receivedSize, NSInteger expectedSize) {
                             NSLog(@"Received: %d expected: %d", receivedSize, expectedSize);
                         }
                        completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished, NSURL *imageURL) {
                            if (image) {
                                NSLog(@"Finished downloading");
                                [_tempDrawingImage setImage:image];
                            }
                        }];
    
    NSLog(@"Cipher: %@", _cipher);
    NSLog(@"Temp: %@", _tempDrawingImage);
}

- (void)registerForNotifications {
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(performNotificationAction:)
                                                 name:@"reload"
                                               object:nil];
    
    /*[[NSNotificationCenter defaultCenter] addObserver:self
     selector:@selector(performNotificationAction:)
     name:@"enableDrawing"
     object:nil];
     */
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(performNotificationAction:)
                                                 name:@"disableDrawing"
                                               object:nil];
}

-(void) connectToDatabase {
    _connectionString = "user=labs2025 password=engrRgr8 dbname=iOSDatabase  port=5432 host=labs2025ios.clygqyctjtg6.us-west-2.rds.amazonaws.com";
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
    
    NSString *tempQuery = [NSString stringWithFormat:@"SELECT * FROM images WHERE filename = '%@' AND topic = '%@'", _fileName, _currentTopic];
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
    NSString *userDefaultKey = [NSString stringWithFormat:@"%@,%@", _fileName, _currentTopic];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:resultArray forKey:userDefaultKey];
    [defaults synchronize];
    
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
    if(_menu == nil) {
        _menu = [[IGCMenu alloc] init];
    }
    _menu.menuButton = self.moreButton;
    _menu.menuSuperView = self.view;
    _menu.disableBackground = YES;
    _menu.numberOfMenuItem = 4;
    _menu.menuRadius = 175; //How far apart the menu displays
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
    if(_isDrawingEnabled) {
        
        _mouseSwiped = NO;
        UITouch *touch = [touches anyObject];
        _lastPoint = [touch locationInView:self.view];
    }
}

-(void) touchesMoved:(NSSet<UITouch*> *)touches withEvent:(UIEvent *)event {
    if(_isDrawingEnabled) {
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
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    if(_isDrawingEnabled) {
        
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

-(void)enableDisableScrolling:(NSNotification *)notification {
    
}

-(void)performNotificationAction:(NSNotification *)notification {
    
    NSString *reason = [notification name];
    NSLog(@"I am in performNotificationAction located in Puzzle.m The notification reason: %@", reason);
    
    if([reason isEqualToString:@"reload"]) {
        NSLog(@"Loading View. filename: %@ topic: %@", _fileName, _currentTopic);
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        
        
        NSString *userDefaultKey = [NSString stringWithFormat:@"%@,%@", _fileName, _currentTopic];
        
        if([defaults objectForKey:userDefaultKey] != nil) {
            NSLog(@"Data already loaded from defaults with key: %@. Don't connect", _fileName);
            _fileArray = [defaults objectForKey:userDefaultKey];
        } else {
            NSLog(@"Connecting to database and retrieve images");
            [self connectToDatabase];
            
            _fileArray = [self getImageFilesFromDatabase];
        }
        
        // Do any additional setup after loading the view, typically from a nib.
        
        //Make the edge of the view underneath the nav bar
        self.edgesForExtendedLayout = UIRectEdgeNone;
        
        SDWebImageManager *manager = [SDWebImageManager sharedManager];
        [manager downloadImageWithURL:[NSURL URLWithString:[_fileArray objectAtIndex:0]]
                              options:0
                             progress:^(NSInteger receivedSize, NSInteger expectedSize) {
                                 //NSLog(@"Received: %d expected: %d", receivedSize, expectedSize);
                             }
                            completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished, NSURL *imageURL) {
                                if (image) {
                                    NSLog(@"Finished downloading");
                                    [_tempDrawingImage setImage:image];
                                }
                            }];
        NSLog(@"end of reload function");
    } else if([reason isEqualToString:@"enableDrawing"]) {
        NSLog(@"reason isEqualTo: enableDrawing");
        _isDrawingEnabled = true;
        
    } else if([reason isEqualToString:@"disableDrawing"]) {
        NSLog(@"reason isEqualTo: disableDrawing");
        
        _isDrawingEnabled = false;
    }
}


@end
