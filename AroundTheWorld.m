//
//  AroundTheWorld.m
//  Magazine
//
//  Created by MBPro on 6/28/16.
//  Copyright © 2016 MBPro. All rights reserved.
//

#import "AroundTheWorld.h"

@interface AroundTheWorld ()

@end

@implementation AroundTheWorld

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NSAssert(self.scrollView, @"self.scrollView must not be nil."
             "Check your IBOutlet connections.");
    NSAssert(self.imageView, @"self.imageView must not be nil."
             "Check your IBOutlet connections.");
    
    UIImage* image = [UIImage imageNamed:@"aroundTheWorld.jpg"];
    
    NSAssert(image, @"image must not be nil."
             "Check that you added the image to your bundle and that "
             "the filename above matches the name of your image.");
    
    self.imageView.image = image;
    [self.imageView sizeToFit];
    
    self.scrollView.contentSize = image.size;
    self.scrollView.delegate = self;
    self.scrollView.minimumZoomScale = 1.0;
    self.scrollView.maximumZoomScale = 100.0;
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
        self.scrollView.zoomScale = (self.scrollView.zoomScale + 0.1);
    }
}

@end
