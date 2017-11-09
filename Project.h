//
//  AroundTheWorld.h
//  Magazine
//
//  Created by 2025 Labs on 6/28/16.
//  Copyright @ 2017 2025 Labs LLC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <libpq/libpq-fe.h>

@interface Project : UIViewController <UIScrollViewDelegate>
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UIButton *zoomButton;

-(void)view:(UIView*)view setCenter:(CGPoint) centerPoint;

@property NSString *currentTopic;


@property const char *connectionString;
@property PGresult *result;
@property PGconn *connection;

@end
