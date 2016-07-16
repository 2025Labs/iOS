//
//  AroundTheWorld.h
//  Magazine
//
//  Created by MBPro on 6/28/16.
//  Copyright © 2016 MBPro. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AsyncImageView.h"
#import <libpq/libpq-fe.h>

@interface AroundTheWorld : UIViewController <UIScrollViewDelegate>
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet AsyncImageView *imageView;
@property (weak, nonatomic) IBOutlet UIButton *zoomButton;

-(void)view:(UIView*)view setCenter:(CGPoint) centerPoint;

@property NSString *currentTopic;


@property const char *connectionString;
@property PGresult *result;
@property PGconn *connection;

@end
