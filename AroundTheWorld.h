//
//  AroundTheWorld.h
//  Magazine
//
//  Created by MBPro on 6/28/16.
//  Copyright © 2016 MBPro. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AroundTheWorld : UIViewController <UIScrollViewDelegate>
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UIButton *zoomButton;

-(void)view:(UIView*)view setCenter:(CGPoint) centerPoint;

@end
