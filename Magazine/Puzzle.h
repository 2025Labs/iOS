//
//  Puzzle.h
//  Magazine
//
//  Created by 2025 Labs on 6/23/16.
//  Copyright @ 2017 2025 Labs LLC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "IGCMenu.h"
#import <libpq/libpq-fe.h>


@interface Puzzle : UIViewController<IGCMenuDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *cipher;
@property (weak, nonatomic) IBOutlet UIImageView *tempDrawingImage;
@property (weak, nonatomic) IBOutlet UIButton *moreButton;

@property CGPoint lastPoint;
@property CGFloat red;
@property CGFloat green;
@property CGFloat blue;
@property CGFloat brush;
@property CGFloat opacity;
@property BOOL mouseSwiped;
@property NSString *filename;

@property NSString *filepath;
@property NSString *currentTopic;

@property BOOL isDrawingEnabled;


@property IGCMenu *menu;
@property BOOL isMenuActive;



@property const char *connectionString;
@property PGresult *result;
@property PGconn *connection;

@end
