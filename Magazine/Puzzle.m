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
    [self getFilepathFromJSON];
    
    //Make the edge of the view underneath the nav bar
    self.edgesForExtendedLayout = UIRectEdgeNone;

    //Download image with URL
    SDWebImageManager *manager = [SDWebImageManager sharedManager];
    [manager downloadImageWithURL:[NSURL URLWithString:_filepath]
                          options:0
                         progress:^(NSInteger receivedSize, NSInteger expectedSize) {
                             NSLog(@"Received: %ld expected: %ld", (long)receivedSize, (long)expectedSize);
                         }
                        completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished, NSURL *imageURL) {
                            if (image) {
                                NSLog(@"Finished downloading");
                                [_tempDrawingImage setImage:image];
                            }
                        }];
}

-(void) getFilepathFromJSON {
    
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"imagesJSON" ofType:@"json"];
    
    NSString *myJSON = [[NSString alloc] initWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:NULL];
    NSError *error =  nil;
    NSArray *jsonDataArray = [NSJSONSerialization JSONObjectWithData:[myJSON dataUsingEncoding:NSUTF8StringEncoding] options:kNilOptions error:&error];
    
    for(NSDictionary *item in jsonDataArray) {
        if([[item objectForKey:@"filename"] isEqual: _filename]) {
            _filepath = [item objectForKey:@"filepath"];
        }
    }
}

- (void)registerForNotifications {
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(performNotificationAction:)
                                                 name:@"reload"
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(performNotificationAction:)
                                                 name:@"enableDrawing"
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(performNotificationAction:)
                                                 name:@"disableDrawing"
                                               object:nil];
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
    //NSLog(@"i'm being touched (touchesBegan)");

    if(_isDrawingEnabled) {

    _mouseSwiped = NO;
    UITouch *touch = [touches anyObject];
    _lastPoint = [touch locationInView:self.view];
    }
}

-(void) touchesMoved:(NSSet<UITouch*> *)touches withEvent:(UIEvent *)event {
    //NSLog(@"i'm being touched (touchesMoved)");
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

        [self getFilepathFromJSON];
        [self.tempDrawingImage.image drawInRect:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
        SDWebImageManager *manager = [SDWebImageManager sharedManager];
        [manager downloadImageWithURL:[NSURL URLWithString:_filepath]
                              options:0
                             progress:^(NSInteger receivedSize, NSInteger expectedSize) {
                                 NSLog(@"Received: %ld expected: %ld", (long)receivedSize, (long)expectedSize);
                             }
                            completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished, NSURL *imageURL) {
                                if (image) {
                                    NSLog(@"Finished downloading");
                                    [_tempDrawingImage setImage:image];
                                }
                            }];
    } else if([reason isEqualToString:@"enableDrawing"]) {
        NSLog(@"reason isEqualTo: enableDrawing");
        _isDrawingEnabled = true;
        
    } else if([reason isEqualToString:@"disableDrawing"]) {
        NSLog(@"reason isEqualTo: disableDrawing");
        _isDrawingEnabled = false;
    }
}


@end
