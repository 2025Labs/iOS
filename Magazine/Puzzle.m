//
//  Puzzle.m
//  Magazine
//
//  Created by MBPro on 6/23/16.
//  Copyright © 2016 MBPro. All rights reserved.
//

#import "Puzzle.h"

@implementation Puzzle

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    _red = 0.0;
    _green = 0.0;
    _blue = 0.0;
    _brush = 3.0;
    _opacity = 1.0;
    //Make the edge of the view underneath the nav bar
    self.edgesForExtendedLayout = UIRectEdgeNone;
    //Get the fileName, which was passed by whichever segue brought us here
    UIImage *image = [UIImage imageNamed: self.fileName];
    [self.tempDrawingImage setImage:image];
    NSLog(@"tempDrawingImage has been set to %@", self.fileName);
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
